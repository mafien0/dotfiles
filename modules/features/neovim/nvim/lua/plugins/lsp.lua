return {

	-- Lsp config
	{
		"neovim/nvim-lspconfig",
		dependencies = { "saghen/blink.cmp", "folke/which-key.nvim" },
		config = function()
			local capabilities = require("blink.cmp").get_lsp_capabilities()
			require("lspconfig.util").default_config.capabilities = capabilities

			local function filter_spelling(diags)
				return vim.tbl_filter(function(d)
					return not (d.message and d.message:match("[Ss]pell"))
				end, diags)
			end

			local orig_handler = vim.lsp.handlers["textDocument/publishDiagnostics"]
			if orig_handler then
				vim.lsp.handlers["textDocument/publishDiagnostics"] = function(err, result, ctx, config)
					if result and result.diagnostics then
						result.diagnostics = filter_spelling(result.diagnostics)
					end
					orig_handler(err, result, ctx, config)
				end
			end

			local map = vim.keymap.set
			local addGroup = require("which-key").add
			addGroup({ { "<leader>g", group = "LSP" } })

			-- Navigation
			map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
			map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
			map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
			map("n", "<leader>gR", function()
				require("snacks").picker.lsp_references()
			end, { desc = "Find references" })
			map("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Type definition" })

			-- Info
			map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
			map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })

			-- Actions
			map("n", "<leader>gr", vim.lsp.buf.rename, { desc = "Rename symbol" })
			map("n", "<leader>ga", vim.lsp.buf.code_action, { desc = "Code action" })

			-- Diagnostics
			map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
			map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
			map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })

			-- Trouble
			map("n", "<leader>ge", function()
				require("trouble").toggle({ mode = "diagnostics" })
			end, { desc = "Toggle trouble" })

			-- LSP servers (provided by Nix system packages)
			vim.lsp.enable({
				"lua_ls",
				"gopls",
				"pyright",
				"clangd",
				"marksman",
				"jsonls",
				"yamlls",
				"ts_ls",
				"bashls",
			})

			vim.lsp.config("nixd", {
				cmd = { "nixd" },
				settings = {
					nixd = {
						nixpkgs = {
							expr = "import /nix/var/nix/profiles/per-user/root/channels/nixos { }",
						},
						formatting = {
							command = { "nixfmt" },
						},
					},
				},
			})
			vim.lsp.enable("nixd")

		end,
	},

	-- Glance
	{
		"DNLHC/glance.nvim",
		opts = {
			height = 18,
			zindex = 45,
			preserve_win_context = true,
			detached = function(winid)
				return vim.api.nvim_win_get_width(winid) < 100
			end,
			preview_win_opts = {
				cursorline = true,
				number = true,
				wrap = true,
			},
			border = { enable = false },
			list = {
				position = "right",
				width = 0.33,
			},
			theme = { enable = true, mode = "auto" },
			folds = {
				fold_closed = "-collapse",
				fold_open = "-expand",
				folded = true,
			},
			indent_lines = { enable = true, icon = "│" },
			winbar = { enable = true },
		},
		keys = {
			{
				"<leader>ld",
				function()
					require("glance").actions.open("definitions")
				end,
				desc = "Glance definitions",
			},
			{
				"<leader>lr",
				function()
					require("glance").actions.open("references")
				end,
				desc = "Glance references",
			},
			{
				"<leader>lt",
				function()
					require("glance").actions.open("type_definitions")
				end,
				desc = "Glance type definitions",
			},
			{
				"<leader>li",
				function()
					require("glance").actions.open("implementations")
				end,
				desc = "Glance implementations",
			},
			{
				"<leader>l",
				function()
					require("glance").actions.resume()
				end,
				desc = "Glance resume",
			},
		},
	},

	-- Trouble
	{
		"folke/trouble.nvim",
		opts = {},
	},

	-- Lazydev
	{
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				vim.fn.stdpath("data") .. "/lazydev.nvim/lua",
				vim.env.HOME .. "/.local/share/dotfile/lua",
			},
		},
	},
	{
		"j-hui/fidget.nvim",
		opts = {},
	},
	{
		"rachartier/tiny-inline-diagnostic.nvim",
		event = "VeryLazy",
		priority = 1000,
		opts = {
			preset = "simple",
		},
		config = function(_, opts)
			require("tiny-inline-diagnostic").setup(opts)
			vim.diagnostic.config({ virtual_text = false }) -- Disable Neovim's default virtual text diagnostics
		end,
	},
}
