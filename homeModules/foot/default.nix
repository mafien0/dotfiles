{
  stylix.targets.foot.enable = true;

  xdg = {
    terminal-exec = {
      enable = true;
      settings = {
        default = ["foot.desktop"];
      };
    };
  };

  home.file.".config/xfce4/helpers.rc".text = ''
    TerminalEmulator=foot-xfce
  '';

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
