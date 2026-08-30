-- Highlight on Yank
vim.api.nvim_create_augroup("HighlightYank", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  group = "HighlightYank",
  desc = "Highlight yanked text",
  callback = function()
    vim.highlight.on_yank({
      higroup =
      "IncSearch",
      timeout = 100,
    })
  end,
})
