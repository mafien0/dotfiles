local config_dir = debug.getinfo(1, "S").source:match("^@?(.*)/")
package.path = config_dir .. "/lua/?.lua;" .. config_dir .. "/lua/?/init.lua;" .. package.path

-- Options contains leader config, so it has to be loaded first
require("config.kotlin-lsp-path")
require("config.options")

-- Load lazy
require("config.lazy")

local ok, matugen = pcall(require, "matugen")
if ok then
  matugen.setup()
end

-- Everything else
require("config.keybinds")
require("config.autocmds")
