require("conform").setup({
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
  formatters_by_ft = {
    nix = { "alejandra" },
    go = { "gofumpt", "goimports" },
    python = { "ruff" },
    java = { "google-java-format" },
  },
  formatters = {
    ["google-java-format"] = { stdin = true },
  },
})
