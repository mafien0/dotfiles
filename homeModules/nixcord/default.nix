{
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.nixcord.homeModules.nixcord
  ];

  stylix.targets.nixcord.enable = true;

  programs.nixcord = {
    enable = true;
    user = "mafien0";
    discord.enable = false;
    vesktop = {
      enable = true;
      settings = {
        splashBackground = "#${config.lib.stylix.colors.base00}";
        enableSplashScreen = false;
      };
    };

    quickCss = ''
      @import url("https://codeberg.org/ridge/Discord-Adblock/raw/branch/main/discord-adblock.css");
    '';

    config = {
      useQuickCss = true;
      frameless = true;

      plugins = {
        permissionFreeWill.enable = true;
        showHiddenChannels.enable = true;
        showHiddenThings.enable = true;
        serverInfo.enable = true;
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
