return {
	"nvim-mini/mini.nvim",
	dependencies = { "lewis6991/gitsigns.nvim" },
	version = "*",
	opts = {
		sessions = {
			autowrite = true,
		},
		surround = {
			mappings = {
				add = "<leader>sa",
				delete = "<leader>sd",
				replace = "<leader>sr",
				find = "<leader>sf",
				find_left = "<leader>sF",
				highlight = "<leader>sh",
			},
		},
	},
	config = function(_, opts)
		require("mini.icons").setup()

		-- Status line --
		local function statusline_active()
			local mode, mode_hl = MiniStatusline.section_mode({ trunc_width = 120 })
			local git = MiniStatusline.section_git({ trunc_width = 40 })
			local diff = MiniStatusline.section_diff({ trunc_width = 75 })
			local diagnostics = MiniStatusline.section_diagnostics({ trunc_width = 75 })
			local filename = MiniStatusline.section_filename({ trunc_width = 140 })
			local fileinfo = MiniStatusline.section_fileinfo({ trunc_width = 120 })
			local location = MiniStatusline.section_location({ trunc_width = 75 })
			return MiniStatusline.combine_groups({
				{ hl = mode_hl, strings = { mode } },
				{ hl = "MiniStatuslineDevinfo", strings = { git, diff, diagnostics } },
				"%<",
				{ hl = "MiniStatuslineFilename", strings = { filename } },
				"%=",
				{ hl = "MiniStatuslineFileinfo", strings = { fileinfo } },
				{ hl = mode_hl, strings = { location } },
			})
		end
		local function statusline_inactive()
			local filename = MiniStatusline.section_filename({ trunc_width = 120 })
			return MiniStatusline.combine_groups({
				{ hl = "MiniStatuslineInactive", strings = { filename } },
			})
		end
		require("mini.statusline").setup({
			content = {
				active = statusline_active,
				inactive = statusline_inactive,
			},
		})
		-- End --

		require("mini.pairs").setup()
		require("mini.comment").setup()
		require("mini.sessions").setup(opts.sessions)
		require("mini.surround").setup(opts.surround)
	end,
}
