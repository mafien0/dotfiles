{
	inputs,
	moduleWithSystem,
	...
}: {
	flake.nixosModules.foot =
		moduleWithSystem (
			{config, ...}: _: {
				environment.systemPackages = [config.packages.myFeet];

				xdg.mime.defaultApplications = {
					"x-scheme-handler/terminal" = "foot.desktop";
				};

				xdg.terminal-exec = {
					enable = true;
					settings.default = ["foot.desktop"];
				};

				home-manager.users.mafien0.xdg.configFile."xfce4/helpers.rc".text = ''
					TerminalEmulator=foot
					FileManager=Thunar
				'';
			}
		);

	perSystem = {pkgs, ...}: {
		# I will keep it as myFeet
		packages.myFeet =
			inputs.wrapper-modules.wrappers.foot.wrap {
				inherit pkgs;
				settings = {
					main = {
						font = "JetBrainsMono Nerd Font:style=Medium:size=11";
						pad = "5x5";
						include = "~/.config/foot/themes/noctalia";
					};
					cursor = {
						style = "beam";
						blink = false;
					};
				};
			};
	};
}
