require("flash").setup {}

vim.keymap.set({ "n", "x", "o" }, "z", require("flash").jump, { desc = "Flash" })
vim.keymap.set({ "n", "x", "o" }, "Z", require("flash").treesitter, { desc = "Flash Treesitter" })
vim.keymap.set("o", "r", require("flash").remote, { desc = "Remote Flash" })
vim.keymap.set({ "o", "x" }, "R", require("flash").treesitter_search, { desc = "Treesitter Search" })
vim.keymap.set("c", "zt", require("flash").toggle, { desc = "Toggle Flash Search" })
