{ lib }:
{
  augroups = [
    {
      name = "HighlightYank";
      clear = true;
    }
  ];

  autocmds = [
    {
      event = [ "TextYankPost" ];
      group = "HighlightYank";
      desc = "Highlight yanked text";
      callback = lib.generators.mkLuaInline ''
        function()
          vim.highlight.on_yank({ higroup = "IncSearch", timeout = 100 })
        end
      '';
    }
  ];
}
