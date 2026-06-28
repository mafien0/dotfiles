{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.nixcord = moduleWithSystem (
    { ... }: { config, ... }: {
      imports = [ inputs.nixcord.nixosModules.nixcord ];

      programs.nixcord = {
        enable = true;
        user = "mafien0"; # Idk nixcord desc said that i need to hardcode that one
        vesktop.enable = true;
        discord.vencord.enable = false;

        quickCss = ''
          @import url("https://croissantdunord.github.io/discord-adblock/adblock.css");
        '';

        config = {
          frameless = true;

          plugins = {
            hideMedia.enable = true;
            callTimer.enable = true;
            fakeNitro.enable = true;
            friendsSince.enable = true;
            keepCurrentChannel.enable = true;
            mentionAvatars.enable = true;
            noF1.enable = true;
          };
        };
      };

      system.activationScripts.nixcord-fix-vesktop-perms =
        let
          user = config.programs.nixcord.user;
          home = "/home/${user}";
        in
        {
          text = ''
            chown -R ${user}:users ${home}/.config/vesktop 2>/dev/null || true
          '';
          deps = [ "nixcord-writeFiles" ];
        };
    }
  );
}
