{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian
    gnome-keyring
    git-crypt
  ];
  stylix.targets.obsidian.enable = true;
}
