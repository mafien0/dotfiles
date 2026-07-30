{
  imports = [
    ./stylix.nix
    ./icons.nix
  ];

  home.pointerCursor.enable = true;

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };

  stylix.targets.gtk.enable = true;
  stylix.targets.qt = {
    enable = true;
    platform = "qtct";
  };
}
