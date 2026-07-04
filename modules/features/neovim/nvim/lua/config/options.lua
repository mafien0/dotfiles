if vim.env.TMUX then
	vim.o.laststatus = 0
end

local globals = {
	mapleader = " ",
	maplocalleader = " ",
}

local opts = {
	tabstop = 2,
	shiftwidth = 2,
	relativenumber = true,
	number = true,
	scrolloff = 10,
	autoindent = true,
	undofile = true,
	formatoptions = "tcqj",
	signcolumn = "yes",
}

-- Parse em
for k, v in pairs(opts) do
	vim.opt[k] = v
end

for k, v in pairs(globals) do
	vim.g[k] = v
end

-- Lsp
vim.diagnostic.enable()
