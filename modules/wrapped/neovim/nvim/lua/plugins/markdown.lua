return {

	{ -- Live preview
		"brianhuster/live-preview.nvim",
		dependencies = {
			"folke/snacks.nvim",
		},
	},

	{ -- Checkmate
		"bngarren/checkmate.nvim",
		ft = "markdown",
		opts = {
			todo_states = {
				unchecked = {
					marker = "[ ]",
				},

				checked = {
					marker = "[x]",
				},
			},
		},
		keys = {
			{
				"<leader>tt",
				"<cmd>Checkmate toggle<CR>",
				desc = "Toggle todo",
				mode = { "n", "v" },
			},
		},
	},
}
