{
  pkgs,
  lib,
  noctaliaPkg,
}:
{
  settings = {
    spawn-sh-at-startup = [
      (lib.getExe noctaliaPkg)
      "${lib.getExe pkgs.wl-clip-persist} --clipboard regular --primary"
      "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch ${lib.getExe pkgs.cliphist} store"
      "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch ${lib.getExe pkgs.cliphist} store"
      (lib.getExe' pkgs.polkit_gnome "polkit-gnome-authentication-agent-1")
      "tailscale systray"
      "${lib.getExe pkgs.xrdb} -merge <<< 'Xcursor.theme: Bibata-Modern-Classic\nXcursor.size: 20'"
    ];

    # xwayland-satellite = {
    #   path = lib.getExe pkgs.xwayland-satellite;
    # };

    outputs = {
      "HDMI-A-1" = {
        mode = "1920x1080@74.986";
      };
    };
  };
}
