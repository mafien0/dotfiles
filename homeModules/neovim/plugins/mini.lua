require("mini.statusline").setup()
require("mini.icons").setup()
require("mini.pairs").setup()
require("mini.comment").setup()

require("mini.surround").setup({
  mappings = {
    add = "<leader>sa",
    delete = "<leader>sd",
    replace = "<leader>sr",
    find = "<leader>sf",
    find_left = "<leader>sF",
    highlight = "<leader>sh",
  },
})

require("mini.sessions").setup({
  autowrite = true,
})
