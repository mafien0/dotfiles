{pkgs}: {
	extraPlugins = {
		checkmate-nvim = {
			package = pkgs.vimPlugins.checkmate-nvim;
			setup = "require('checkmate').setup {}";
		};
		render-markdown-nvim = {
			package = pkgs.vimPlugins.render-markdown-nvim;
			setup = "require('render-markdown').setup {}";
		};
	};

	keymaps = [
		{
			mode = [
				"n"
				"v"
			];
			key = "<leader>tt";
			action = "<cmd>Checkmate toggle<CR>";
			desc = "Toggle todo";
		}
	];
}
