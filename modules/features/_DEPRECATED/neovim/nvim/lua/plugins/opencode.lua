return {

	{ -- Render markdown for opencode output
		"MeanderingProgrammer/render-markdown.nvim",
		opts = {
			anti_conceal = { enabled = false },
			file_types = { "markdown", "opencode_output" },
		},
		ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
	},

	{ -- Opencode AI assistant
		"sudo-tee/opencode.nvim",
		dependencies = {
			"MeanderingProgrammer/render-markdown.nvim",
			"saghen/blink.cmp",
			"folke/snacks.nvim",
		},
		config = function()
			require("opencode").setup({})
		end,
	},
}
