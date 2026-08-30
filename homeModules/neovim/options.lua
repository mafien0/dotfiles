vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.number = true
vim.opt.relativenumber = true

-- Options
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 10
vim.opt.autoindent = true
vim.opt.undofile = true
vim.opt.expandtab = true
vim.opt.formatoptions = "tcqj"
vim.opt.signcolumn = "yes"
vim.opt.cmdheight = 0
vim.opt.termguicolors = true

-- Keymaps
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>")

map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

map("n", "<leader>c", "q:", { desc = "Open commands buffer" })

map({ "n", "i", "v", "s", "t", "c", "x", "o" }, "<C-s>", "<cmd>write<CR>", { desc = "Save file" })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")


