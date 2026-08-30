local theme = {
  fill = "TabLineFill",
  head = "TabLine",
  current_tab = "TabLineSel",
  tab = "TabLine",
  win = "TabLine",
  tail = "TabLine",
}

require("tabby").setup({
  line = function(line)
    return {
      {
        { "  ", hl = theme.head },
        { " ", hl = theme.head },
        line.sep(" ", theme.head, theme.fill),
      },
      line.tabs().foreach(function(tab)
        local hl = tab.is_current() and theme.current_tab or theme.tab
        return {
          line.sep(" ", hl, theme.fill),
          tab.number(),
          " ",
          tab.name(),
          " ",
          line.sep(" ", hl, theme.fill),
          hl = hl,
          margin = " ",
        }
      end),
      line.spacer(),
      {
        line.sep(" ", theme.tail, theme.fill),
        { " ", hl = theme.tail },
      },
      hl = theme.fill,
    }
  end,
  option = {
    tab_name = {
      name_fallback = function(tabid)
        return vim.api.nvim_buf_get_name(vim.api.nvim_win_get_buf(tabid))
      end,
    },
  },
})

vim.keymap.set("n", "<leader>tp", "<cmd>TabbyPick<CR>", { desc = "Pick tab" })
