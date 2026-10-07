{
  pkgs,
  lib,
  ...
}: {
  stylix.targets.foot.enable = true;

  home.sessionVariables.TERMINAL = lib.getExe pkgs.foot;

  xdg = {
    terminal-exec = {
      enable = true;
      settings = {
        default = ["foot.desktop"];
      };
    };
  };

  programs.foot = {
    enable = true;

    settings = {
      main = {
        pad = "5x5";
      };
      cursor = {
        style = "beam";
        blink = false;
      };
    };
  };
}
