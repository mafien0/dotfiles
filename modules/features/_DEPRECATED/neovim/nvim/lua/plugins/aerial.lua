return {
	"stevearc/aerial.nvim",
	opts = {},
	keys = {
		{
			"<leader>fw",
			function()
				require("snacks").picker.lsp_workspace_symbols()
			end,
			desc = "Search symbols (workspace)",
		},
	},
}
