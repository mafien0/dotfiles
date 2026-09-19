{
  pkgs,
  lib,
  inputs,
  system,
  ...
}: {
  programs.niri.settings = {
    spawn-at-startup = [
      {argv = [(lib.getExe inputs.noctalia-shell.packages.${system}.default)];}
      {
        argv = [
          (lib.getExe pkgs.wl-clip-persist)
          "--clipboard"
          "regular"
        ];
      }
      {sh = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type text --watch ${lib.getExe pkgs.cliphist} store";}
      {sh = "${lib.getExe' pkgs.wl-clipboard "wl-paste"} --type image --watch ${lib.getExe pkgs.cliphist} store";}
      {argv = ["${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1"];}
    ];

    clipboard.disable-primary = true;

    outputs."HDMI-A-1" = {
      mode = {
        width = 1920;
        height = 1080;
        refresh = 74.986;
      };
    };
  };
}
