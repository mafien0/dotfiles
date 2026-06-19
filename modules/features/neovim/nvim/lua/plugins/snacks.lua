return {
	"folke/snacks.nvim",
	version = "*",
	priority = 1000,
	lazy = false,
	keys = {
		{ "<leader>f", group = "Find" },
		{
			"<leader> ",
			function()
				require("snacks").picker.files({ hidden = true, no_ignore = true })
			end,
			desc = "Find files",
		},
		{
			"<leader>fg",
			function()
				require("snacks").picker.grep()
			end,
			desc = "Live grep",
		},
		{
			"<leader>fb",
			function()
				require("snacks").picker.buffers()
			end,
			desc = "Buffers",
		},
		{
			"<leader>fr",
			function()
				require("snacks").picker.resume()
			end,
			desc = "Resume picker",
		},
		{
			"<leader>fh",
			function()
				require("snacks").picker.help()
			end,
			desc = "Help tags",
		},
		{
			"<leader>e",
			function()
				require("snacks").explorer()
			end,
			desc = "File explorer",
		},
		{
			"<C-t>",
			function()
				require("snacks").terminal.toggle()
			end,
			desc = "Terminal",
			mode = { "n", "t" },
		},
		{
			"<leader>b",
			function()
				require("snacks").scratch()
			end,
			desc = "Select scratch buffer",
		},
	},
	opts = {
		explorer = {
			enabled = true,
			show_hidden = true,
		},
		picker = {
			enabled = true,

			hidden = true,
			ignored = true,

			sources = {
				files = {
					hidden = true,
					ignored = true,
				},

				grep = {
					hidden = true,
					ignored = true,
				},

				explorer = {
					hidden = true,
					ignored = true,
				},
			},
		},

		dashboard = {
			enabled = true,
			preset = {
				header = [[
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
				]],
			},
		},
		bigfile = { enabled = true },
		indent = { enabled = true },
		notifier = { enabled = true },
		quickfile = { enabled = true },
		scope = { enabled = true },
		words = { enabled = true },
		terminal = { enabled = true },
		scratch = { enabled = true },
	},
}
