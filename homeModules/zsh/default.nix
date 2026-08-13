{config, ...}: {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    history.size = 10000;
    history.path = "${config.home.homeDirectory}/.zsh_history";

    shellAliases = {
      c = "clear";
      cdtmp = "cd $(mktemp -d)";
    };

    oh-my-zsh = {
      enable = true;
      theme = "candy";
    };

    initContent =
      # Bash
      ''
        fpath=(~/.zsh $fpath)

        autoload -U up-line-or-beginning-search down-line-or-beginning-search
        zle -N up-line-or-beginning-search
        zle -N down-line-or-beginning-search
        bindkey "^[[A" up-line-or-beginning-search
        bindkey "^[[B" down-line-or-beginning-search

        unsetopt PROMPT_SP
      '';
  };
}
