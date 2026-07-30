{
  pkgs,
  lib,
  noctaliaPackage,
  ...
}: {
  programs.niri.settings = {
    spawn-at-startup = [
      {argv = [(lib.getExe noctaliaPackage)];}
      {
        argv = [
          (lib.getExe pkgs.wl-clip-persist)
          "--clipboard"
          "regular"
          "--primary"
        ];
      }
      {sh = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch ${lib.getExe pkgs.cliphist} store";}
      {sh = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch ${lib.getExe pkgs.cliphist} store";}
      {argv = [(lib.getExe' pkgs.polkit_gnome "polkit-gnome-authentication-agent-1")];}
      {argv = [(lib.getExe' pkgs.tailscale "systray")];}
    ];

    xwayland-satellite = {
      path = lib.getExe pkgs.xwayland-satellite;
    };

    outputs."HDMI-A-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 74.986;
      };
    };
  };
}
