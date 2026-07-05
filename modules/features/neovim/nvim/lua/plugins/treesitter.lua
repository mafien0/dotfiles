return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	config = function()
		require("nvim-treesitter").setup({
			ensure_installed = {},
			auto_install = false,
			indent = { enable = true },
		})
	end,
}
