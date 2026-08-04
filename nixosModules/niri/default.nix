{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.niri-flake.nixosModules.niri
  ];

  # Niri is needed as system-level package so setup some services
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.niri.default = ["gtk" "gnome"];
  };
}
