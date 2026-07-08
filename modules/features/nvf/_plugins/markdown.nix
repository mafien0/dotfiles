{ pkgs }:
{
  extraPlugins = {
    live-preview-nvim = {
      package = pkgs.vimPlugins.live-preview-nvim;
    };
    checkmate-nvim = {
      package = pkgs.vimPlugins.checkmate-nvim;
      setup = "require('checkmate').setup {}";
    };
  };

  keymaps = [
    {
      mode = [
        "n"
        "v"
      ];
      key = "<leader>tt";
      action = "<cmd>Checkmate toggle<CR>";
      desc = "Toggle todo";
    }
  ];
}
