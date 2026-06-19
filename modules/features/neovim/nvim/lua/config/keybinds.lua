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
