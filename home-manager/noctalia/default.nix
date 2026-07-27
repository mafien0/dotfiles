{
	noctaliaPackage,
	pkgs,
	lib,
	inputs,
	...
}: {
	imports = [
		inputs.noctalia-shell.homeModules.default
	];

	stylix.targets.noctalia-shell.enable = true;

	programs.noctalia-shell = let
		pluginURL = "https://github.com/noctalia-dev/noctalia-plugins";
	in {
		enable = true;
		package = noctaliaPackage;
		settings = lib.mkForce (builtins.fromJSON (builtins.readFile ./settings.json));
		plugins = {
			sources = [
				{
					enabled = true;
					name = "Noctalia Plugins";
					url = pluginURL;
				}
			];
			states = {
				obs-control = {
					enabled = true;
					sourceUrl = pluginURL;
				};
				privacy-indicator = {
					enabled = true;
					sourceUrl = pluginURL;
				};
			};
			version = 2;
		};
	};

	home.packages = with pkgs; [
		cliphist
		wl-clipboard
		kdePackages.qtwebsockets
	];
}
