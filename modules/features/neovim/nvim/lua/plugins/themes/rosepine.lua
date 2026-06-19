local theme = require("config.theme")

return {
	"rose-pine/neovim",
	name = "rose-pine",
	opts = {
		styles = {
			italic = false,
		},
	},
	lazy = false,
	priority = 1000,
	config = function(_, opts)
		if theme == "rose-pine" then
			require("rose-pine").setup(opts)
			vim.cmd.colorscheme("rose-pine")
		end
	end,
}
