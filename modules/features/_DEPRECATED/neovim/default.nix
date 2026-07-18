{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.neovim = moduleWithSystem (
    {config, ...}: _: {
      environment.systemPackages = [config.packages.myNeovim];
      environment.sessionVariables.EDITOR = "nvim";
    }
  );

  perSystem = {pkgs, ...}: let
    tsGrammars = with pkgs.tree-sitter.builtGrammars; [
      tree-sitter-nix
      tree-sitter-lua
      tree-sitter-python
      tree-sitter-go
      tree-sitter-c
      tree-sitter-cpp
      tree-sitter-bash
      tree-sitter-json
      tree-sitter-yaml
      tree-sitter-markdown
      tree-sitter-typescript
      tree-sitter-tsx
      tree-sitter-vim
      tree-sitter-css
      tree-sitter-html
      tree-sitter-rust
      tree-sitter-javascript
      tree-sitter-comment
      tree-sitter-regex
      tree-sitter-sql
      tree-sitter-toml
      tree-sitter-java
      tree-sitter-groovy
      tree-sitter-kotlin
    ];

    kotlinLsp = pkgs.stdenv.mkDerivation {
      pname = "kotlin-lsp";
      version = "262.8190.0";
      src = pkgs.fetchurl {
        url = "https://download-cdn.jetbrains.com/language-server/kotlin-server/262.8190.0/kotlin-server-262.8190.0.tar.gz";
        hash = "sha256-i0xw6VBlQg54Z8mar58Y4LTnYxHsRT5MGjnj9q53TL8=";
      };
      sourceRoot = "kotlin-server-262.8190.0";
      nativeBuildInputs = [
        pkgs.patchelf
        pkgs.makeWrapper
      ];
      installPhase = ''
        mkdir -p $out
        cp -r . $out/
        patchelf --set-interpreter ${pkgs.stdenv.cc.bintools.dynamicLinker} $out/bin/intellij-server
        wrapProgram $out/bin/intellij-server --prefix LD_LIBRARY_PATH : \
          ${pkgs.lib.makeLibraryPath [
          pkgs.zlib
          pkgs.stdenv.cc.cc.libgcc
        ]}
      '';
    };

    parserDir = pkgs.runCommand "nvim-parsers" {} (
      let
        links = builtins.concatStringsSep "\n" (
          map (g: ''
            ln -s ${g}/parser "$out/parser/${builtins.replaceStrings ["tree-sitter-"] [""] g.pname}.so"
          '')
          tsGrammars
        );
      in ''
        mkdir -p $out/parser
        ${links}
      ''
    );
  in {
    packages.myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
      inherit pkgs;

      settings = {
        config_directory = pkgs.runCommand "nvim-config" {} ''
          cp -r ${./nvim}/. $out
          chmod -R u+w $out
          cp -r ${parserDir}/parser $out/parser
          echo 'vim.env.KOTLIN_LSP_DIR = "'"${kotlinLsp}"'"' > $out/lua/config/kotlin-lsp-path.lua
        '';
        block_normal_config = false;
        aliases = [
          "vim"
          "v"
        ];
      };

      runtimePkgs = with pkgs; [
        ripgrep
        fd
        matugen

        lua-language-server
        gopls
        pyright
        clang-tools
        nixd
        marksman
        vscode-langservers-extracted
        yaml-language-server
        typescript-language-server
        bash-language-server

        stylua
        gofumpt
        gotools
        nixfmt
        prettier
        python3Packages.black
        python3Packages.isort
        shfmt

        jdt-language-server
        google-java-format
        jdk21
        gradle
        groovy-language-server
        kotlinLsp
        ktlint
      ];
    };
  };
}
