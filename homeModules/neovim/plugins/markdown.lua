require("checkmate").setup({})
require("render-markdown").setup({})

vim.keymap.set({"n","v"}, "<leader>tt", "<cmd>Checkmate toggle<CR>", { desc = "Toggle todo" })
