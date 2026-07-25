{
	extraPlugins.flash-nvim = {
		package = "flash-nvim";
		setup = "require('flash').setup {}";
	};

	keymaps = [
		{
			mode = [
				"n"
				"x"
				"o"
			];
			key = "z";
			lua = true;
			desc = "Flash";
			action = "require('flash').jump";
		}
		{
			mode = [
				"n"
				"x"
				"o"
			];
			key = "Z";
			lua = true;
			desc = "Flash Treesitter";
			action = "require('flash').treesitter";
		}
		{
			mode = "o";
			key = "r";
			lua = true;
			desc = "Remote Flash";
			action = "require('flash').remote";
		}
		{
			mode = [
				"o"
				"x"
			];
			key = "R";
			lua = true;
			desc = "Treesitter Search";
			action = "require('flash').treesitter_search";
		}
		{
			mode = "c";
			key = "zt";
			lua = true;
			desc = "Toggle Flash Search";
			action = "require('flash').toggle";
		}
	];
}
