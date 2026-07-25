{
	pkgs,
	lib,
	...
}: {
	programs.nvf.enable = true;
	stylix.targets.nvf.enable = true;

	home.sessionVariables.EDITOR = "nvim";

	home.shellAliases = {
		v = "nvim";
		vim = "nvim";
		view = "nvim -R";
		edit = "nvim";
		nano = "nvim";
	};

	programs.nvf.settings.vim =
		lib.mkMerge [
			(import ./options.nix)
			(import ./keybinds.nix)
			(import ./autocmds.nix {inherit lib;})
			(import ./languages.nix {inherit pkgs;})
			(import ./cmp.nix)
			(import ./snacks.nix)
			(import ./mini.nix)
			(import ./flash.nix)
			(import ./git.nix)
			(import ./diffview.nix)
			(import ./aerial.nix)
			(import ./whichkey.nix)
			(import ./markdown.nix {inherit pkgs;})
			(import ./tpipeline.nix {inherit pkgs;})
		];
}
