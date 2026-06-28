{ moduleWithSystem, ... }: {
  flake.nixosModules.sync = moduleWithSystem (
    { ... }: { pkgs, lib, ... }: {
      systemd.services.auto-git-sync = {
        description = "Auto-sync nix config to git remote";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        serviceConfig = {
          Type = "oneshot";
          User = "mafien0";
          WorkingDirectory = "/home/mafien0/nix";
        };
        environment = {
          GIT_SSH_COMMAND = "${lib.getExe pkgs.openssh} -i /home/mafien0/.ssh/id_ed25519 -o StrictHostKeyChecking=accept-new";
        };
        script = ''
          set -euo pipefail
          ${lib.getExe pkgs.git} add -A
          ${lib.getExe pkgs.git} diff --cached --quiet || (
            ${lib.getExe pkgs.git} commit -m "auto: daily sync $(date +%Y-%m-%d)"
            ${lib.getExe pkgs.git} push
          )
        '';
      };

      systemd.timers.auto-git-sync = {
        description = "Daily git sync at 12:00";
        wantedBy = [ "timers.target" ];
        timerConfig = {
          OnCalendar = "*-*-* 12:00:00";
          Persistent = true;
          RandomizedDelaySec = "5min";
        };
      };
    }
  );
}
