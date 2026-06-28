{ inputs, moduleWithSystem, ... }: {
  flake.nixosModules.zsh = moduleWithSystem (
    { ... }: { pkgs, ... }: {
      programs.zsh = {
        enable = true;
        syntaxHighlighting.enable = true;
        autosuggestions.enable = true;
        histSize = 10000;
        histFile = "~/.zsh_history";

        shellAliases = {
          l = "${pkgs.eza}/bin/eza -la --icons=auto --classify --group-directories-first --header --time-style=long-iso";
          ls = "${pkgs.eza}/bin/eza --icons=auto --classify --group-directories-first --header --time-style=long-iso";
          lt = "${pkgs.eza}/bin/eza --tree --icons=auto --classify --group-directories-first --header --time-style=long-iso";
          g = "${pkgs.git}/bin/git";
          c = "clear";
        };

        setOptions = [
          "appendhistory"
          "incappendhistory"
          "sharehistory"
        ];

        ohMyZsh = {
          enable = true;
          theme = "candy";
        };

        interactiveShellInit = ''
          fpath=(~/.zsh $fpath)

          autoload -U up-line-or-beginning-search down-line-or-beginning-search
          zle -N up-line-or-beginning-search
          zle -N down-line-or-beginning-search
          bindkey "^[[A" up-line-or-beginning-search
          bindkey "^[[B" down-line-or-beginning-search

          unsetopt PROMPT_SP

          function precmd {
              print -Pn "\e[ q"
          }
        '';
      };
    }
  );

  perSystem =
    { pkgs, ... }:
    {
      packages.myZsh = inputs.wrapper-modules.wrappers.zsh.wrap {
        inherit pkgs;
        runtimePkgs = [ pkgs.git ];
        zshrc.content = "# i use nixos btw";
      };
    };
}
