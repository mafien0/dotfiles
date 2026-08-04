let
  minecraftSourcesDir = "minecraft-sources";
in {
  keymaps = [
    {
      mode = "n";
      key = "<leader>m";
      lua = true;
      desc = "Minecraft: Search Source";
      action = "function() require('snacks').picker.files({ dirs = { vim.fn.getcwd() .. '/${minecraftSourcesDir}' }, hidden = true, no_ignore = true }) end";
    }
  ];
}
