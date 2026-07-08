-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Setup lazy.nvim
local theme = require("config.theme")

require("lazy").setup({
	spec = {
		{ import = "plugins" },
		{ import = "plugins.themes" },
	},
	change_detection = {
		notify = false,
	},
	install = { colorscheme = { theme, "habamax" } },
})

vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		vim.api.nvim_set_hl(0, "LazyNormal", { link = "NormalFloat" })
		vim.api.nvim_set_hl(0, "LazyBorder", { link = "FloatBorder" })
		vim.api.nvim_set_hl(0, "LazyButton", { link = "CursorLine" })
		vim.api.nvim_set_hl(0, "LazyButtonActive", { link = "Visual" })
		vim.api.nvim_set_hl(0, "LazyH1", { link = "Title" })
		vim.api.nvim_set_hl(0, "LazyProgressDone", { link = "String" })
		vim.api.nvim_set_hl(0, "LazyProgressTodo", { link = "Comment" })
	end,
})
