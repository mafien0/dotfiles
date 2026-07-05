return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "gofumpt", "goimports" },
			python = { "isort", "black" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			java = { "google-java-format" },
			kotlin = { "ktlint" },

			nix = { "nixfmt" },
			json = { "prettier" },
			typescript = { "prettier" },
			javascript = { "prettier" },
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
