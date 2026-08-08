{
  pkgs,
  lib,
  ...
}: {
  lsp = {
    enable = true;
    lspconfig.enable = true;
    trouble.enable = true;
    servers = {
      gopls.settings = {
        gopls = {
          analyses = {
            unusedparams = true;
            unreachable = true;
            nilness = true;
            shadow = true;
            fieldalignment = true;
            simplifyrange = true;
          };
          staticcheck = true;
          hints = {
            assignVariableTypes = true;
            compositeLiteralFields = true;
            compositeLiteralTypes = true;
            constantValues = true;
            parameterNames = true;
            rangeVariableTypes = true;
          };
          usePlaceholders = false;
          completeUnimported = true;
          gofumpt = true;
        };
      };
    };
  };
  diagnostics = {
    enable = true;
    config = {
      virtual_text = false;
    };
  };

  languages = {
    enableFormat = true;
    enableTreesitter = true;
    enableExtraDiagnostics = false;

    nix = {
      enable = true;
      lsp.servers = ["nixd"];
      format.type = ["alejandra"];
      treesitter.enable = true;
    };
    go = {
      enable = true;
      format = {
        enable = true;
        type = ["gofumpt" "goimports"];
      };
      dap.enable = true;
      extensions.gopher-nvim.enable = true;
    };
    python = {
      enable = true;
      format.type = ["ruff"];
      lsp.servers = ["ruff"];
    };
    lua.enable = true;
    bash.enable = true;
    json.enable = true;
    yaml.enable = true;
    markdown.enable = true;
    typescript.enable = true;
    css.enable = true;
    html.enable = true;
    rust.enable = true;
    sql.enable = true;
    toml.enable = true;
    java = {
      enable = true;
      extensions.gradle-nvim.enable = true;
    };
  };

  treesitter = {
    enable = true;
    indent = {
      enable = true;
    };
    highlight = {
      enable = true;
    };
    fold = false;
    addDefaultGrammars = false;
    grammars = with pkgs.tree-sitter.builtGrammars; [
      tree-sitter-vim
      tree-sitter-comment
      tree-sitter-regex
    ];
  };

  formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 500;
      };
      formatters_by_ft = lib.mkForce {
        java = ["google-java-format"];
      };
      formatters = {
        google-java-format = {
          stdin = true;
        };
      };
    };
  };

  visuals.fidget-nvim.enable = true;

  extraPackages = with pkgs; [
    ripgrep
    fd
    google-java-format
  ];

  extraPlugins = {
    glance-nvim = {
      package = pkgs.vimPlugins.glance-nvim;
      setup = "require('glance').setup {}";
    };
    lazydev-nvim = {
      package = pkgs.vimPlugins.lazydev-nvim;
      setup = "require('lazydev').setup {}";
    };
    tiny-inline-diagnostic-nvim = {
      package = pkgs.vimPlugins.tiny-inline-diagnostic-nvim;
      setup = "require('tiny-inline-diagnostic').setup { preset = 'simple' }";
    };
    nvim-jdtls = {
      package = pkgs.vimPlugins.nvim-jdtls;
    };
  };

  luaConfigRC = {
    lsp_capabilities = ''
      local ok, blink = pcall(require, "blink.cmp")
      local capabilities = ok and blink.get_lsp_capabilities() or vim.lsp.protocol.make_client_capabilities()
      require("lspconfig.util").default_config.capabilities = capabilities
    '';

    lsp_keybinds = ''
      local map = vim.keymap.set
      map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "Go to definition" })
      map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
      map("n", "<leader>gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
      map("n", "<leader>gR", function()
        require("snacks").picker.lsp_references()
      end, { desc = "Find references" })
      map("n", "<leader>gt", vim.lsp.buf.type_definition, { desc = "Type definition" })
      map("n", "K", vim.lsp.buf.hover, { desc = "Hover documentation" })
      map("n", "<C-k>", vim.lsp.buf.signature_help, { desc = "Signature help" })
      map("n", "<leader>gr", vim.lsp.buf.rename, { desc = "Rename symbol" })
      map("n", "<leader>ga", vim.lsp.buf.code_action, { desc = "Code action" })
      map("n", "[d", vim.diagnostic.goto_prev, { desc = "Previous diagnostic" })
      map("n", "]d", vim.diagnostic.goto_next, { desc = "Next diagnostic" })
      map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Diagnostics list" })
      map("n", "<leader>ge", function()
        require("trouble").toggle({ mode = "diagnostics" })
      end, { desc = "Toggle trouble" })
    '';

    jdtls-compat = ''
      local ok, util = pcall(require, "jdtls.util")
      if ok then
      	local _get = util.get_clients
      	util.get_clients = function(o)
      		if o.name == "jdtls" then o.name = "jdt-language-server" end
      		return _get(o)
      	end
      end
    '';

    lsp_glance = ''
      for _, k in ipairs({
        { "<leader>ld", function() require("glance").actions.open("definitions") end, desc = "Glance definitions" },
        { "<leader>lr", function() require("glance").actions.open("references") end, desc = "Glance references" },
        { "<leader>lt", function() require("glance").actions.open("type_definitions") end, desc = "Glance type definitions" },
        { "<leader>li", function() require("glance").actions.open("implementations") end, desc = "Glance implementations" },
        { "<leader>l",  function() require("glance").actions.resume() end, desc = "Glance resume" },
      }) do
        vim.keymap.set("n", k[1], k[2], { desc = k.desc })
      end
    '';
  };
}
