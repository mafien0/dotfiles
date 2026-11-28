local o = vim.opt

vim.g.mapleader = " "
vim.g.maplocalleader = " "
o.timeoutlen = 300

o.number = true
o.relativenumber = true

-- Options
o.tabstop = 2
o.shiftwidth = 2
o.expandtab = true
o.autoindent = true
o.smartindent = true
o.scrolloff = 10
o.undofile = true
o.formatoptions = "tcqj"
o.signcolumn = "yes"
o.cmdheight = 0
o.termguicolors = true
o.cursorline = true

o.ignorecase = true
o.smartcase = true
o.hlsearch = true
o.incsearch = true

o.errorbells = false
o.swapfile = true
o.autochdir = false

-- Keymaps
local map = vim.keymap.set

map("n", "<Esc>", "<cmd>noh<CR>")

map("v", "<leader>y", '"+y', { desc = "Yank to system clipboard" })
map("n", "<leader>yy", '"+yy', { desc = "Yank line to system clipboard" })
map({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from system clipboard" })

map("n", "<leader>c", "q:", { desc = "Open commands buffer" })

map({ "n", "i", "v", "s", "t", "c", "x", "o" }, "<M-s>", "<cmd>write<CR>", { desc = "Save file" })

map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-l>", "<C-w>l")

map("n", "<leader>r", ":tabnew<CR>")
map("n", "<leader>w", ":tabclose<CR>")

map("n", "<leader>Q", ":wq<CR>")
map("n", "<leader>q", ":q!<CR>")

for i = 1, 9 do
    map("n", "<C-" .. i .. ">", function()
        vim.cmd.tabnext(i)
    end, { desc = "Go to tab " .. i })
end
