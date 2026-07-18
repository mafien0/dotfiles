{
	inputs,
	moduleWithSystem,
	...
}: {
	flake.nixosModules.nixcord =
		moduleWithSystem (
			_: {config, ...}: {
				imports = [inputs.nixcord.nixosModules.nixcord];

				programs.nixcord = {
					enable = true;
					user = "mafien0";
					vesktop.enable = true;
					vesktop.settings = {
						splashBackground = "#121214";
						enableSplashScreen = false;
					};
					discord.enable = false;

					quickCss = ''
						@import url("https://codeberg.org/ridge/Discord-Adblock/raw/branch/main/discord-adblock.css");
					'';

					config = {
						useQuickCss = true;
						frameless = true;

						plugins = {
							hideMedia.enable = true;
							callTimer.enable = true;
							fakeNitro.enable = true;
							keepCurrentChannel.enable = true;
							mentionAvatars.enable = true;
							noF1.enable = true;
						};
					};
				};

				system.activationScripts.nixcord-fix-vesktop-perms = let
					user = config.programs.nixcord.user;
					home = "/home/${user}";
				in {
					text = ''
						chown -R ${user}:users ${home}/.config/vesktop 2>/dev/null || true
					'';
					deps = ["nixcord-writeFiles"];
				};
			}
		);
}
