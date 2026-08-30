require("oil").setup({
  default_file_explorer = true,
  columns = {
    "permissions",
    "size",
    "mtime",
    "icon",
  },
  view_options = {
    show_hidden = true,
  },
})

vim.keymap.set("n", "-", "<cmd>Oil<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>e", "<cmd>Oil<CR>", { desc = "File explorer" })
