-- Noctalia shell
local M = {}

function M.setup()
  require("base16-colorscheme").setup({
    -- Background tones
    base00 = "#111416",              -- Default Background
    base01 = "#1d2022",    -- Lighter Background (status bars)
    base02 = "#282a2c", -- Selection Background
    base03 = "#8b9198",              -- Comments, Invisibles
    -- Foreground tones
    base04 = "#c1c7ce",   -- Dark Foreground (status bars)
    base05 = "#e2e2e5",           -- Default Foreground
    base06 = "#e2e2e5",           -- Light Foreground
    base07 = "#e2e2e5",        -- Lightest Foreground
    -- Accent colors
    base08 = "#ffb4ab",                -- Variables, XML Tags, Errors
    base09 = "#cdc0e9",             -- Integers, Constants
    base0A = "#b7c9d8",            -- Classes, Search Background
    base0B = "#87ceff",              -- Strings, Diff Inserted
    base0C = "#cdc0e9",   -- Regex, Escape Chars
    base0D = "#87ceff",    -- Functions, Methods
    base0E = "#b7c9d8",  -- Keywords, Storage
    base0F = "#93000a",      -- Deprecated, Embedded Tags
  })
end

return M
