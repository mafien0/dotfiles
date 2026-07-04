-- Noctalia shell
local M = {}

function M.setup()
	require("base16-colorscheme").setup({
		-- Background tones
		base00 = "#121410", -- Default Background
		base01 = "#1f201c", -- Lighter Background (status bars)
		base02 = "#292b26", -- Selection Background
		base03 = "#8e9286", -- Comments, Invisibles
		-- Foreground tones
		base04 = "#c4c8ba", -- Dark Foreground (status bars)
		base05 = "#e3e3dc", -- Default Foreground
		base06 = "#e3e3dc", -- Light Foreground
		base07 = "#e3e3dc", -- Lightest Foreground
		-- Accent colors
		base08 = "#ffb4ab", -- Variables, XML Tags, Errors
		base09 = "#a0cfcd", -- Integers, Constants
		base0A = "#becbae", -- Classes, Search Background
		base0B = "#a3d577", -- Strings, Diff Inserted
		base0C = "#a0cfcd", -- Regex, Escape Chars
		base0D = "#a3d577", -- Functions, Methods
		base0E = "#becbae", -- Keywords, Storage
		base0F = "#93000a", -- Deprecated, Embedded Tags
	})
end

-- Vibe coded
-- Register a signal handler for SIGUSR1 (matugen updates)
local signal = vim.uv.new_signal()
signal:start(
	"sigusr1",
	vim.schedule_wrap(function()
		package.loaded["matugen"] = nil
		require("matugen").setup()
	end)
)

return M
-- Vibe coded end
