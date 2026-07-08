{ pkgs }:
{
  extraPlugins = {
    render-markdown-nvim = {
      package = pkgs.vimPlugins.render-markdown-nvim;
      setup = "require('render-markdown').setup {}";
    };
    opencode-nvim = {
      package = pkgs.vimPlugins.opencode-nvim;
    };
  };
}
