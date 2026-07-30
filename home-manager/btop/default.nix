{lib, ...}: {
  stylix.targets.btop.enable = true;

  programs.btop = {
    enable = true;
    settings = {
      color_theme = lib.mkDefault "TTY";
      theme_background = false;
      truecolor = false;
      vim_keys = true;
    };
  };
}
