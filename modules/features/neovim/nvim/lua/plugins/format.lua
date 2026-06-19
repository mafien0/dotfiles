return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofumpt", "goimports" },
			python = { "isort", "black" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			nix = { "nixfmt" },
			json = { "prettier" },
			yaml = { "prettier" },
			markdown = { "prettier" },
			typescript = { "prettier" },
			javascript = { "prettier" },
			typescriptreact = { "prettier" },
			javascriptreact = { "prettier" },
			css = { "prettier" },
			html = { "prettier" },
			bash = { "shfmt" },
			sh = { "shfmt" },
		},
		format_on_save = {
			lsp_format = "fallback",
			timeout_ms = 500,
		},
	},
}
