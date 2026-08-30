require("glance").setup({})

local glance = require("glance")
local actions = glance.actions

vim.keymap.set("n", "<leader>ld", function() actions.open("definitions") end, { desc = "Glance definitions" })
vim.keymap.set("n", "<leader>lr", function() actions.open("references") end, { desc = "Glance references" })
vim.keymap.set("n", "<leader>lt", function() actions.open("type_definitions") end, { desc = "Glance type definitions" })
vim.keymap.set("n", "<leader>li", function() actions.open("implementations") end, { desc = "Glance implementations" })
vim.keymap.set("n", "<leader>l", function() actions.resume() end, { desc = "Glance resume" })
