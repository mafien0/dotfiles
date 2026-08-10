{
  autocomplete = {
    blink-cmp = {
      enable = true;
      setupOpts = {
        keymap = {
          preset = "super-tab";
        };
        appearance = {
          nerd_font_variant = "mono";
        };
        completion = {
          documentation = {
            auto_show = false;
          };
        };
        sources = {
          default = [
            "lsp"
            "path"
            "snippets"
            "buffer"
          ];
        };
        fuzzy = {
          implementation = "prefer_rust_with_warning";
        };
      };
      friendly-snippets = {
        enable = true;
      };
    };
  };

  snippets = {
    luasnip = {
      enable = true;
    };
  };

  luaConfigRC.cmp_snippets =
    # lua
    ''
      require("luasnip.loaders.from_vscode").load({
        paths = vim.fn.stdpath("config") .. "/snippets",
      })

      local ls = require("luasnip")
      local s = ls.snippet
      local t = ls.text_node
      local i = ls.insert_node

      ls.add_snippets("go", {
        s("iferr", {
          t({ "if err != nil {", "\treturn " }),
          i(1),
          t({ "", "}" }),
        }),
      })
    '';
}
