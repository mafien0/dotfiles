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
