{pkgs, ...}: {
  stylix.targets.neovim = {
    enable = true;
    transparentBackground.numberLine = true;
    transparentBackground.signColumn = true;
  };

  home.shellAliases = {
    v = "nvim";
    view = "nvim -R";
    y = "nvim -c 'Oil'";
  };
  programs.neovim = let
    toLua = str: "${str}\n";
    toLuaFile = file: "${builtins.readFile file}\n";
  in {
    enable = true;
    defaultEditor = true;

    viAlias = true;
    vimAlias = true;

    extraPackages = with pkgs; [
      wl-clipboard
      ripgrep
      fd

      # Lsp & Formatters
      rust-analyzer
      gopls
      ruff
      google-java-format
      nixd
      lua-language-server
      bash-language-server
      vscode-langservers-extracted
      sqls
    ];

    initLua = ''
      ${builtins.readFile ./options.lua}
      ${builtins.readFile ./autocmds.lua}
    '';

    plugins = with pkgs.vimPlugins; [
      nvim-web-devicons

      # Mini
      {
        plugin = mini-nvim;
        config = toLuaFile ./plugins/mini.lua;
      }

      # Telescope
      {
        plugin = telescope-nvim;
        config = toLuaFile ./plugins/telescope.lua;
      }
      telescope-fzf-native-nvim

      # Flash
      {
        plugin = flash-nvim;
        config = toLuaFile ./plugins/flash.lua;
      }

      # Which-Key
      {
        plugin = which-key-nvim;
        config = toLuaFile ./plugins/whichkey.lua;
      }

      # Git
      {
        plugin = gitsigns-nvim;
        config = toLuaFile ./plugins/git.lua;
      }

      # Markdown
      {
        plugin = checkmate-nvim;
        config = toLuaFile ./plugins/markdown.lua;
      }
      render-markdown-nvim

      # LSP
      {
        plugin = nvim-lspconfig;
        config = toLuaFile ./plugins/lsp.lua;
      }
      {
        plugin = trouble-nvim;
        config = toLua "require('trouble').setup({})";
      }

      # Treesitter
      {
        plugin = nvim-treesitter;
        config = toLuaFile ./plugins/treesitter.lua;
      }
      nvim-treesitter.withAllGrammars

      # Formatter
      {
        plugin = conform-nvim;
        config = toLuaFile ./plugins/conform.lua;
      }

      # Fidget (LSP progress)
      {
        plugin = fidget-nvim;
        config = toLua "require('fidget').setup({})";
      }

      # Glance (LSP references)
      {
        plugin = glance-nvim;
        config = toLuaFile ./plugins/glance.lua;
      }

      # Lazydev (Lua development)
      {
        plugin = lazydev-nvim;
        config = toLua "require('lazydev').setup({})";
      }

      # Tiny Inline Diagnostic
      {
        plugin = tiny-inline-diagnostic-nvim;
        config = toLuaFile ./plugins/tiny-inline-diagnostic.lua;
      }

      # Tabby
      {
        plugin = tabby-nvim;
        config = toLuaFile ./plugins/tabby.lua;
      }

      # Snacks
      {
        plugin = snacks-nvim;
        config = toLuaFile ./plugins/snacks.lua;
      }

      # Oil
      {
        plugin = oil-nvim;
        config = toLuaFile ./plugins/oil.lua;
      }

      # Completion
      {
        plugin = blink-cmp;
        config = toLuaFile ./plugins/cmp.lua;
      }
      luasnip
      friendly-snippets
    ];
  };
}
