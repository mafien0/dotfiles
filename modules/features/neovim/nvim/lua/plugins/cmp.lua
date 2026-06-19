return {
	-- Completion engine
	{
		"saghen/blink.cmp",
		dependencies = { "L3MON4D3/LuaSnip" },

		version = "1.*",
		opts = {
			keymap = { preset = "super-tab" },
			appearance = {
				nerd_font_variant = "mono",
			},

			completion = { documentation = { auto_show = false } },
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},

	-- Snippet engine
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			require("luasnip.loaders.from_vscode").load({
				paths = vim.fn.stdpath("config") .. "/snippets",
			})
		end,
	},
}
