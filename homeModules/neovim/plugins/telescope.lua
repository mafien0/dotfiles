local telescope = require("telescope")

telescope.setup({
  defaults = {
    file_ignore_patterns = {
      "build/",
      "bin/",
      "dist/",
      "node_modules/",
      "%.gradle",
      "%.devenv",
      "run/",
      "libs/",
      "out/",
      "target/",
    },
  },
})

telescope.load_extension("fzf")

local builtin = require("telescope.builtin")

vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume Picker" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help Tags" })
