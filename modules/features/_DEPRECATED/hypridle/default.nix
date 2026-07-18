# DEPRECATED: Will be removed. Idle management is handled by noctalia.
{moduleWithSystem, ...}: {
	flake.nixosModules.hypridle =
		moduleWithSystem (
			{config, ...}: {pkgs, ...}: {
				environment.systemPackages = [
					config.packages.myHypridle
					pkgs.hyprlock
					pkgs.wlopm
				];
			}
		);

	perSystem = {
		pkgs,
		lib,
		...
	}: let
		wlopm = lib.getExe pkgs.wlopm;
		gawk = lib.getExe' pkgs.gawk "awk";
		dim =
			pkgs.writeShellScript "hypridle-dim" ''
				${wlopm} | ${gawk} '{print $1}' | while read -r out; do
				  ${wlopm} --off "$out"
				done
			'';

		undim =
			pkgs.writeShellScript "hypridle-undim" ''
				${wlopm} | ${gawk} '{print $1}' | while read -r out; do
				  ${wlopm} --on "$out"
				done
			'';

		hypridleConfig =
			pkgs.writeText "hypridle.conf" ''
				general {
				    lock_cmd = ${lib.getExe pkgs.hyprlock}
				    before_sleep_cmd = ${lib.getExe' pkgs.systemd "loginctl"} lock-session
				    after_sleep_cmd = ${undim}
				}

				listener {
				    timeout = 300
				    on-timeout = ${dim}
				    on-resume = ${undim}
				}

				listener {
				    timeout = 600
				    on-timeout = ${lib.getExe' pkgs.systemd "loginctl"} lock-session
				}

				listener {
				    timeout = 900
				    on-timeout = ${lib.getExe' pkgs.systemd "systemctl"} suspend
				}
			'';
	in {
		packages.myHypridle =
			pkgs.writeShellScriptBin "hypridle" ''
				exec ${lib.getExe pkgs.hypridle} --config ${hypridleConfig}
			'';
	};
}
