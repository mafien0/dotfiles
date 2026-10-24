{pkgs, ...}: {
  # Hyprland is needed as system-level package so setup some services
  programs.hyprland = {
    enable = true;
  };
  xdg.portal = {
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config.hyprland.default = ["hyprland" "gtk"];
  };
}
