require("tiny-inline-diagnostic").setup({
  preset = "simple",
  options = {
    show_source = true,
    multiple_diag_under_cursor = true,
    enable_on_insert = false,
  },
})

vim.keymap.set("n", "<leader>dI", function()
  require("tiny-inline-diagnostic").toggle()
end, { desc = "Toggle inline diagnostics" })
