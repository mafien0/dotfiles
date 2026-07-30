{inputs, ...}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  # stylix.targets.discord.enable = true;

  programs.nixcord = {
    enable = true;
    user = "mafien0";
    vesktop.enable = true;
    vesktop.settings = {
      splashBackground = "#121214";
      enableSplashScreen = false;
    };
    discord.enable = false;

    quickCss = ''
      @import url("https://codeberg.org/ridge/Discord-Adblock/raw/branch/main/discord-adblock.css");
    '';

    config = {
      useQuickCss = true;
      frameless = true;

      plugins = {
        hideMedia.enable = true;
        callTimer.enable = true;
        fakeNitro.enable = true;
        keepCurrentChannel.enable = true;
        mentionAvatars.enable = true;
        noF1.enable = true;
      };
    };
  };
}
