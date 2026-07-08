{ pkgs }: {
  extraPlugins.base16-nvim = {
    package = pkgs.vimPlugins.base16-nvim;
  };

  luaConfigRC.base16_noctalia = ''
    local ok, matugen = pcall(require, "matugen")
    if ok then
      matugen.setup()
      vim.g.colors_name = "base16-noctalia"
    end
  '';
}
