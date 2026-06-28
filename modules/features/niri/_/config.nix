{ pkgs, lib, hypridlePkg }:
{
  settings = {
    spawn-sh-at-startup = [
      (lib.getExe pkgs.noctalia-shell)
      (lib.getExe hypridlePkg)
      "${lib.getExe pkgs.wl-clip-persist} --clipboard regular --primary"
      (lib.getExe' pkgs.polkit_gnome "polkit-gnome-authentication-agent-1")
      "tailscale systray"
    ];

    xwayland-satellite = {
      path = lib.getExe pkgs.xwayland-satellite;
    };

    outputs = {
      "HDMI-A-1" = {
        mode = "1920x1080@74.986";
      };
    };
  };
}
