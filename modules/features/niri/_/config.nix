{ pkgs, lib }:
{
  settings = {
    spawn-sh-at-startup = [
      (lib.getExe pkgs.noctalia-shell)
      "hypridle"
      "wl-paste --watch cliphist store"
      "wl-clip-persist --clipboard regular"
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
