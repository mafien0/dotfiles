{
	utility.snacks-nvim = {
		enable = true;
		setupOpts = {
			bigfile = {
				enabled = true;
			};
			indent = {
				enabled = true;
			};
			notifier = {
				enabled = true;
			};
			quickfile = {
				enabled = true;
			};
			scope = {
				enabled = true;
			};
			words = {
				enabled = true;
			};
			terminal = {
				enabled = true;
			};
			scratch = {
				enabled = true;
			};
			explorer = {
				enabled = true;
				show_hidden = true;
			};
			picker = {
				enabled = true;
				hidden = true;
				ignored = true;
				sources = {
					files = {
						hidden = true;
						ignored = true;
					};
					grep = {
						hidden = true;
						ignored = true;
					};
					explorer = {
						hidden = true;
						ignored = true;
					};
				};
			};
			dashboard = {
				enabled = true;
				sections = [
					{
						section = "header";
					}
					{
						section = "keys";
						gap = 1;
						padding = 1;
					}
					{
						section = "recent_files";
						limit = 5;
						title = "Recent Files";
					}
				];
				preset = {
					header = ''
						███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓
						██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒
						▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░
						▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██
						▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒
						░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░
						░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░
						░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░
						░    ░  ░    ░ ░        ░   ░         ░
						░
					'';
					keys = [
						{
							icon = " ";
							key = "f";
							desc = "Find File";
							action = ":lua require('snacks').picker.files({ hidden = true, no_ignore = true })";
						}
						{
							icon = " ";
							key = "e";
							desc = "Explorer";
							action = ":lua require('snacks').explorer()";
						}
						{
							icon = " ";
							key = "g";
							desc = "Live Grep";
							action = ":lua require('snacks').picker.grep()";
						}
						{
							icon = " ";
							key = "r";
							desc = "Recent Files";
							action = ":lua require('snacks').picker.recent()";
						}
						{
							icon = " ";
							key = "q";
							desc = "Quit";
							action = ":qa";
						}
					];
				};
			};
		};
	};

	keymaps = [
		{
			mode = "n";
			key = "<leader><leader>";
			lua = true;
			desc = "Find Files";
			action = "function() require('snacks').picker.files({ hidden = true, no_ignore = true }) end";
		}
		{
			mode = "n";
			key = "<leader>fg";
			lua = true;
			desc = "Live Grep";
			action = "function() require('snacks').picker.grep() end";
		}
		{
			mode = "n";
			key = "<leader>fb";
			lua = true;
			desc = "Buffers";
			action = "function() require('snacks').picker.buffers() end";
		}
		{
			mode = "n";
			key = "<leader>fr";
			lua = true;
			desc = "Resume Picker";
			action = "function() require('snacks').picker.resume() end";
		}
		{
			mode = "n";
			key = "<leader>fh";
			lua = true;
			desc = "Help Tags";
			action = "function() require('snacks').picker.help() end";
		}
		{
			mode = "n";
			key = "<leader>e";
			lua = true;
			desc = "File Explorer";
			action = "function() require('snacks').explorer() end";
		}
		{
			mode = [
				"n"
				"t"
			];
			key = "<C-t>";
			lua = true;
			desc = "Terminal";
			action = "function() require('snacks').terminal.toggle() end";
		}
		{
			mode = "n";
			key = "<leader>b";
			lua = true;
			desc = "Select Scratch Buffer";
			action = "function() require('snacks').scratch() end";
		}
		{
			mode = "n";
			key = "<leader>fw";
			lua = true;
			desc = "Search Symbols (workspace)";
			action = "require('snacks').picker.lsp_workspace_symbols";
		}
	];
}
