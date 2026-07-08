{ pkgs, lib }:
let
  kotlin-lsp-src = pkgs.fetchzip {
    name = "kotlin-lsp-src";
    url = "https://download-cdn.jetbrains.com/language-server/kotlin-server/262.8190.0/kotlin-server-262.8190.0.tar.gz";
    sha256 = "1rgpkn1anfja3kd6mf9p78klsqpcan777s46yga2w4jk9l0p85ck";
  };

  kotlin-lsp = pkgs.stdenv.mkDerivation {
    name = "kotlin-lsp";
    dontUnpack = true;
    dontBuild = true;
    nativeBuildInputs = [ pkgs.autoPatchelfHook ];
    buildInputs = with pkgs; [
      zlib
      stdenv.cc.cc.lib
      freetype
      alsa-lib
      wayland
      libxkbcommon
      libx11
      libxext
      libxi
      libxrender
      libxtst
    ];
    installPhase = ''
      cp -r ${kotlin-lsp-src} $out
      chmod -R u+w $out
    '';
  };
in

{
  # Language modules handle LSP servers, formatters, and tree-sitter grammars
  languages = {
    nix = {
      enable = true;
      lsp.servers = [ "nixd" ];
      treesitter.enable = true;
    };
    go.enable = true;
    python.enable = true;
    lua.enable = true;
    clang.enable = true;
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
    java.enable = true;
    kotlin = {
      enable = true;
      treesitter.enable = true;
      lsp.enable = true;
    };
  };

  # Tree-sitter: only extra grammars not covered by language modules
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
      tree-sitter-groovy
    ];
  };

  # Language modules set formatters_by_ft; this only controls format-on-save
  formatter.conform-nvim = {
    enable = true;
    setupOpts = {
      format_on_save = {
        lsp_format = "fallback";
        timeout_ms = 500;
      };
      formatters_by_ft = {
        kotlin = [ "ktlint" ];
      };
      formatters = {
        ktlint = {
          command = "${lib.getExe pkgs.ktlint}";
        };
      };
    };
  };

  # LSP infrastructure — must enable the top-level flag for language modules to hook in
  lsp = {
    enable = true;
    lspconfig.enable = true;
    trouble.enable = true;
    # JetBrains kotlin-lsp via intellij-server
    servers.kotlin-language-server = {
      root_markers = [ ".git" ];
      cmd = lib.mkForce [
        "${kotlin-lsp}/bin/intellij-server"
        "--stdio"
      ];
      init_options = lib.mkForce { };
    };
  };

  visuals.fidget-nvim.enable = true;

  diagnostics = {
    enable = true;
    config = {
      virtual_text = false;
    };
  };

  # Packages outside language module coverage
  extraPackages = with pkgs; [
    ripgrep
    fd
  ];

  # Custom LSP plugins not in nvf
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
  };

  # Filetype detection for languages without built-in Neovim support
  filetype = {
    extension = {
      kt = "kotlin";
      kts = "kotlin";
    };
  };

  # LSP Lua config
  luaConfigRC = {
    lsp_capabilities = ''
      local capabilities = require("blink.cmp").get_lsp_capabilities()
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
