{
	inputs,
	moduleWithSystem,
	...
}: {
	flake.nixosModules.nvf =
		moduleWithSystem (
			_: {
				pkgs,
				lib,
				...
			}: {
				imports = [inputs.nvf.nixosModules.nvf];

				environment.sessionVariables.EDITOR = "nvim";

				environment.shellAliases = {
					v = "nvim";
					vim = "nvim";
					view = "nvim -R";
					edit = "nvim";
					nano = "nvim";
				};

				programs.nvf = {
					enable = true;
					settings.vim =
						lib.mkMerge [
							# Config
							(import ./_config/options.nix)
							(import ./_config/keybinds.nix)
							(import ./_config/autocmds.nix {inherit lib;})
							(import ./_config/theme.nix)

							# Plugins
							(import ./_plugins/languages.nix {inherit pkgs lib;})
							(import ./_plugins/cmp.nix)
							(import ./_plugins/snacks.nix)
							(import ./_plugins/mini.nix)
							(import ./_plugins/flash.nix)
							(import ./_plugins/git.nix)
							(import ./_plugins/diffview.nix)
							(import ./_plugins/aerial.nix)
							(import ./_plugins/whichkey.nix)
							(import ./_plugins/markdown.nix {inherit pkgs;})
							(import ./_plugins/opencode.nix {inherit pkgs;})
							(import ./_plugins/tpipeline.nix {inherit pkgs;})

							# Themes
							(import ./_plugins/_themes/base16.nix {inherit pkgs;})
							(import ./_plugins/_themes/rosepine.nix {inherit pkgs;})
						];
				};
			}
		);
}
