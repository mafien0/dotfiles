{
  config,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./config.nix
    ./idle.nix
    inputs.dms.homeModules.dank-material-shell
  ];

  stylix.targets.dank-material-shell.enable = true;

  programs.dank-material-shell = {
    enable = true;
    systemd.enable = lib.mkForce false;

    enableSystemMonitoring = true;
    enableVPN = true;
    enableAudioWavelength = true;
    enableDynamicTheming = false;
    enableCalendarEvents = false;

    settings = {
      theme = "dark";
      dynamicTheming = false;
      cursorSettings = {
        theme = config.common.cursor.name;
        size = config.common.cursor.size;
      };
    };

    session = {
      isLightMode = false;
    };
  };
}
