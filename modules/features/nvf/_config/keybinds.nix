{
	keymaps = [
		{
			mode = "n";
			key = "<Esc>";
			action = "<cmd>noh<CR>";
		}
		{
			mode = "v";
			key = "<leader>y";
			desc = "Yank to system clipboard";
			action = ''"+y'';
		}
		{
			mode = "n";
			key = "<leader>yy";
			desc = "Yank line to system clipboard";
			action = ''"+yy'';
		}
		{
			mode = [
				"n"
				"v"
			];
			key = "<leader>p";
			desc = "Paste from system clipboard";
			action = ''"+p'';
		}
		{
			mode = "n";
			key = "<leader>c";
			desc = "Open commands buffer";
			action = "q:";
		}
		{
			mode = [
				"n"
				"i"
				"v"
				"s"
				"t"
				"c"
				"x"
				"o"
			];
			key = "<C-s>";
			desc = "Save file";
			action = "<cmd>write<CR>";
		}
		{
			mode = "n";
			key = "<C-h>";
			action = "<C-w>h";
		}
		{
			mode = "n";
			key = "<C-j>";
			action = "<C-w>j";
		}
		{
			mode = "n";
			key = "<C-k>";
			action = "<C-w>k";
		}
		{
			mode = "n";
			key = "<C-l>";
			action = "<C-w>l";
		}
	];
}
