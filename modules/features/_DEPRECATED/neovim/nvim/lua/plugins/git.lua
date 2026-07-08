return {
	"lewis6991/gitsigns.nvim",
	config = function()
		require("gitsigns").setup({
			signcolumn = true,
			numhl = false,
			current_line_blame = true,
		})
	end,
}
