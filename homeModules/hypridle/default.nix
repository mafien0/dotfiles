# MADE BY CLANKER
{
  lib,
  inputs,
  system,
  pkgs,
  ...
}: let
  dmsShell = lib.getExe inputs.dms.packages.${system}.dms-shell;
  systemctl = lib.getExe' pkgs.systemd "systemctl";
  lock = "${dmsShell} ipc call lock lock";
in {
  # Launched from hyprland (nix.hypridle via hl.exec_cmd), not a systemd service.
  # Sequential steps: 5 min -> monitors off, +5 min -> DMS lock, +5 min -> sleep.
  services.hypridle = {
    enable = true;
    package = null; # hyprland launches it

    settings = {
      general = {
        before_sleep_cmd = lock;
        after_sleep_cmd = "hyprctl dispatch dpms on";
        ignore_dbus_inhibit = false;
      };

      listener = [
        {
          timeout = 300;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
        {
          timeout = 600;
          on-timeout = lock;
        }
        {
          timeout = 900;
          on-timeout = "${systemctl} suspend";
        }
      ];
    };
  };
}
