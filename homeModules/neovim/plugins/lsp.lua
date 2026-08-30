local ok, blink = pcall(require, "blink.cmp")
local capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()

vim.lsp.config("*", { capabilities = capabilities })

vim.lsp.config("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      completion = { callable = { snippets = "add_parentheses" } },
    },
  },
})

vim.lsp.config("gopls", {
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        unreachable = true,
        nilness = true,
        shadow = true,
        fieldalignment = true,
        simplifyrange = true,
      },
      staticcheck = true,
      hints = {
        assignVariableTypes = true,
        compositeLiteralFields = true,
        compositeLiteralTypes = true,
        constantValues = true,
        parameterNames = true,
        rangeVariableTypes = true,
      },
      usePlaceholders = false,
      completeUnimported = true,
      gofumpt = true,
    },
  },
})

vim.lsp.config("nixd", {
  settings = {
    nixd = {
      formatting = { command = { "alejandra", "--quiet" } },
    },
  },
})

vim.lsp.enable({
  "rust_analyzer",
  "gopls",
  "nixd",
  "ruff",
  "lua_ls",
  "bashls",
  "jsonls",
  "yamlls",
  "ts_ls",
  "cssls",
  "html",
  "sqls",
})

vim.diagnostic.config({ virtual_text = false })

local map = vim.keymap.set
map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
map("n", "<leader>gR", vim.lsp.buf.references, { desc = "Find references" })
map("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Type definition" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
map("n", "<leader>gr", vim.lsp.buf.rename, { desc = "Rename symbol" })
map("n", "<leader>ga", vim.lsp.buf.code_action, { desc = "Code action" })
map("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, { desc = "Previous diagnostic" })
map("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, { desc = "Next diagnostic" })
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })
map("n", "<leader>ge", function()
  require("trouble").toggle({ mode = "diagnostics" })
end, { desc = "Toggle trouble" })
