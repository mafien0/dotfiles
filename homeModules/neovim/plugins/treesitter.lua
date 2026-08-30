vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "nix", "go", "gomod", "gosum", "gowork", "gotmpl",
    "python", "lua", "bash", "json", "yaml",
    "markdown", "markdown_inline",
    "typescript", "javascript", "tsx",
    "css", "html", "rust", "sql", "toml", "java",
    "vim", "vimdoc", "comment", "regex",
  },
  callback = function(args)
    vim.treesitter.start(args.buf)
  end,
})
