local db = require("dashboard")

db.setup({
  theme = "hyper",
  config = {
    header = {
      "███▄    █ ▓█████  ▒█████   ██▒   █▒ ██▓ ███▄ ▄███▓",
      "██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒",
      "▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░",
      "▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██",
      "▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒",
      "░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░",
      "░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░",
      "   ░   ░ ░    ░   ░ ░ ▒       ░░   ▒ ░░      ░",
      "        ░  ░    ░ ░        ░   ░         ░",
      "                 ░",
    },
    shortcut = {
      { desc = "Find Files", group = "DashboardShortCut", key = "f", action = "lua require('telescope.builtin').find_files()" },
      { desc = "Recent Files", group = "DashboardShortCut", key = "r", action = "lua require('telescope.builtin').oldfiles()" },
      { desc = "Live Grep", group = "DashboardShortCut", key = "g", action = "lua require('telescope.builtin').live_grep()" },
      { desc = "New File", group = "DashboardShortCut", key = "n", action = "enew" },
      { desc = "Quit", group = "DashboardShortCut", key = "q", action = "qa" },
    },
    footer = {},
  },
})
