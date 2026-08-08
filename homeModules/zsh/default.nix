{
  pkgs,
  lib,
  config,
  ...
}: {
  programs.direnv = {
    enable = true;
  };
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    history.size = 10000;
    history.path = "${config.home.homeDirectory}/.zsh_history";

    shellAliases = {
      l = "${lib.getExe pkgs.eza} -la --icons=auto --classify --group-directories-first --header --time-style=long-iso";
      ls = "${lib.getExe pkgs.eza} --icons=auto --classify --group-directories-first --header --time-style=long-iso";
      lt = "${lib.getExe pkgs.eza} --tree --icons=auto --classify --group-directories-first --header --time-style=long-iso";
      g = "${lib.getExe pkgs.git}";
      c = "clear";
      cdtmp = "cd $(mktemp -d)";
    };

    oh-my-zsh = {
      enable = true;
      theme = "candy";
    };

    initContent = ''
      fpath=(~/.zsh $fpath)

      autoload -U up-line-or-beginning-search down-line-or-beginning-search
      zle -N up-line-or-beginning-search
      zle -N down-line-or-beginning-search
      bindkey "^[[A" up-line-or-beginning-search
      bindkey "^[[B" down-line-or-beginning-search

      unsetopt PROMPT_SP

      if [[ ! -f ~/tokens.sh ]]; then
        echo '#!/usr/bin/sh' > ~/tokens.sh
        echo 'echo "change ~/tokens.sh"' >> ~/tokens.sh
        echo 'export GITHUB_TOKEN="changeme"' >> ~/tokens.sh
        chmod +x ~/tokens.sh
      fi
      [[ -f ~/tokens.sh ]] && source ~/tokens.sh
      if [[ -n "$GITHUB_TOKEN" ]]; then
        mkdir -p ~/.config/nix
        echo "access-tokens = github.com=$GITHUB_TOKEN" > ~/.config/nix/access-tokens.conf
      fi
    '';
  };
}
