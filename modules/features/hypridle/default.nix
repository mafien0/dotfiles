{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.hypridle = moduleWithSystem (
    { config, ... }: { pkgs, ... }: {
      environment.systemPackages = [
        config.packages.myHypridle
        pkgs.hyprlock
        pkgs.wlopm
      ];
    }
  );

  perSystem =
    { pkgs, ... }:
    let
      dim = pkgs.writeShellScript "hypridle-dim" ''
        ${pkgs.wlopm}/bin/wlopm | ${pkgs.gawk}/bin/awk '{print $1}' | while read -r out; do
          ${pkgs.wlopm}/bin/wlopm --off "$out"
        done
      '';

      undim = pkgs.writeShellScript "hypridle-undim" ''
        ${pkgs.wlopm}/bin/wlopm | ${pkgs.gawk}/bin/awk '{print $1}' | while read -r out; do
          ${pkgs.wlopm}/bin/wlopm --on "$out"
        done
      '';

      hypridleConfig = pkgs.writeText "hypridle.conf" ''
        general {
            lock_cmd = ${pkgs.hyprlock}/bin/hyprlock
            before_sleep_cmd = ${pkgs.systemd}/bin/loginctl lock-session
            after_sleep_cmd = ${undim}
        }

        listener {
            timeout = 300
            on-timeout = ${dim}
            on-resume = ${undim}
        }

        listener {
            timeout = 600
            on-timeout = ${pkgs.systemd}/bin/loginctl lock-session
        }

        listener {
            timeout = 900
            on-timeout = ${pkgs.systemd}/bin/systemctl suspend
        }
      '';
    in
    {
      packages.myHypridle = pkgs.writeShellScriptBin "hypridle" ''
        exec ${pkgs.hypridle}/bin/hypridle --config ${hypridleConfig}
      '';
    };
}
