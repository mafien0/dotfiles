{
  binds.whichKey = {
    enable = true;
    setupOpts = {
      preset = "helix";
    };
    register = {
      "<leader>f" = "Find";
      "<leader>g" = "LSP";
      "<leader>m" = "Minecraft";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>?";
      lua = true;
      desc = "Buffer Local Keymaps (which-key)";
      action = "function() require('which-key').show({ global = false }) end";
    }
  ];
}
