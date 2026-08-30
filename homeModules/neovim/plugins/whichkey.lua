require("which-key").setup({
  preset = "helix",
})

require("which-key").add({
  { "<leader>f", group = "Find" },
  { "<leader>g", group = "LSP" },
  { "<leader>m", group = "Minecraft" },
})

vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })
