{pkgs, ...}: {
  programs.thunar = {
    enable = true;
    plugins = [pkgs.thunar-volman];
  };
}
