# MADE BY CLANKER
{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.programs.noctalia-shell;

  shellCmd = lib.getExe' cfg.package "noctalia-shell";

  watchdog = pkgs.writeShellScriptBin "noctalia-watchdog" ''
    export PATH=${lib.makeBinPath [pkgs.coreutils pkgs.procps pkgs.util-linux]}:$PATH

    shellCmd=${shellCmd}
    shellComm=.quickshell-wra
    marker=/run/noctalia-resume-guard
    interval=20
    fails=0

    # The shell only answers an IPC call while its event loop runs, so a process
    # wedged in the graphics driver reads as unhealthy here too.
    responsive() {
      timeout 5 "$shellCmd" ipc --any-display call notifications getHistory >/dev/null 2>&1
    }

    recover() {
      echo "shell is down or unresponsive, restarting"
      pkill -x "$shellComm"
      sleep 2
      pkill -9 -x "$shellComm"
      sleep 1
      setsid "$shellCmd" >/dev/null 2>&1 &
      for _ in 1 2 3 4 5 6 7 8 9 10; do
        sleep 2
        responsive && break
      done
      # A resume in the last few minutes means the session was locked when the
      # shell broke, so the fresh shell has to take the lock back.
      if [ -f "$marker" ] && [ "$(( $(date +%s) - $(stat -c %Y "$marker") ))" -lt 180 ]; then
        "$shellCmd" ipc --any-display call lockScreen lock >/dev/null 2>&1
        echo "re-locked after recent resume"
      fi
    }

    sleep 30
    while true; do
      if pgrep -x "$shellComm" >/dev/null 2>&1 && responsive; then
        fails=0
      else
        fails=$((fails + 1))
        echo "health check failed ($fails/2)"
        if [ "$fails" -ge 2 ]; then
          recover
          fails=0
        fi
      fi
      sleep "$interval"
    done
  '';
in
  lib.mkIf (cfg.enable && cfg.package != null) {
    systemd.user.services.noctalia-watchdog = {
      Unit = {
        Description = "Restart noctalia-shell when it dies or stops answering";
        After = ["graphical-session.target"];
        PartOf = ["graphical-session.target"];
        ConditionEnvironment = "WAYLAND_DISPLAY";
      };
      Service = {
        ExecStart = "${watchdog}/bin/noctalia-watchdog";
        Restart = "always";
        RestartSec = 5;
      };
      Install.WantedBy = ["graphical-session.target"];
    };
  }
