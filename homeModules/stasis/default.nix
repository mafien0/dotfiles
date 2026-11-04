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
in {
  home.packages = [inputs.stasis.packages.${system}.stasis];

  # Launched from hyprland (nix.stasis via hl.exec_cmd), not a systemd service.
  # Sequential steps: 5 min -> monitors off, +5 min -> DMS lock, +5 min -> sleep.
  xdg.configFile."stasis/stasis.rune".text = ''
    default:
      enable_loginctl_integration true
      enable_dbus_inhibit true
      monitor_gamepad true
      monitor_games true
      monitor_media true
      ignore_remote_media true
      debounce_seconds 5

      dpms:
        timeout 300
        command "hyprctl dispatch dpms off"
        resume_command "hyprctl dispatch dpms on"
      end

      lock_screen:
        timeout 300
        command "${dmsShell} ipc call lock lock"
      end

      suspend:
        timeout 300
        command "${systemctl} suspend"
      end
    end
  '';
}
