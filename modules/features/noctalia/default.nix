{
	inputs,
	moduleWithSystem,
	...
}: {
	flake.nixosModules.noctalia =
		moduleWithSystem (
			{
				pkgs,
				config,
				...
			}: _: {
				environment.systemPackages = [
					config.packages.myNoctalia
					pkgs.kdePackages.qtwebsockets
				];
			}
		);

	perSystem = {pkgs, ...}: {
		packages.myNoctalia =
			inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
				inherit pkgs;

				outOfStoreConfig = "/home/mafien0/.config/noctalia";

				inherit ((builtins.fromJSON (builtins.readFile ./noctalia.json))) settings;

				plugins = {
					sources = [
						{
							enabled = true;
							name = "Noctalia Plugins";
							url = "https://github.com/noctalia-dev/noctalia-plugins";
						}
					];
					states = {
						obs-control = {
							enabled = true;
							sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
						};
						privacy-indicator = {
							enabled = true;
							sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
						};
					};
					version = 2;
				};

				preInstalledPlugins = {
					obs-control = {
						src = "${inputs.noctalia-plugins}/obs-control";
					};
					privacy-indicator = {
						src = "${inputs.noctalia-plugins}/privacy-indicator";
					};
				};

				runtimePkgs = with pkgs; [
					cliphist
					wl-clipboard
					kdePackages.qtwebsockets
				];

				user-templates = {
					templates = {
						neovim = {
							input_path = "/home/mafien0/nix/modules/features/nvf/_templates/matugen.lua";
							output_path = "/home/mafien0/nix/modules/features/nvf/_generated/lua/matugen.lua";
							post_hook = "pkill -SIGUSR1 nvim";
						};
					};
				};
			};
	};
}
