{pkgs, ...}: {
  stylix.targets.tmux.enable = true;

  home.shellAliases = {
    t = "tmux";
    tm = "tmux";
  };

  programs.tmux = {
    enable = true;
    baseIndex = 1;
    keyMode = "vi";
    mouse = true;
    escapeTime = 0;
    prefix = "C-a";

    plugins = with pkgs.tmuxPlugins; [
      resurrect
      continuum
    ];

    extraConfig = ''
      set -g default-terminal "tmux-256color"
      set -ga terminal-overrides ",*256col*:Tc"
      set -g cursor-style bar

      bind q killp
      bind v copy-mode
      bind R source-file ~/.config/tmux/tmux.conf \; display "config reloaded"

      bind-key r command-prompt -I "#w" "rename-window -- '%%'"

      unbind '"'
      unbind %
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"

      bind c new-window -c "#{pane_current_path}"

      bind n next-window
      bind N previous-window

      bind-key -n M-1 select-window -t 1
      bind-key -n M-2 select-window -t 2
      bind-key -n M-3 select-window -t 3
      bind-key -n M-4 select-window -t 4
      bind-key -n M-5 select-window -t 5
      bind-key -n M-6 select-window -t 6
      bind-key -n M-7 select-window -t 7
      bind-key -n M-8 select-window -t 8
      bind-key -n M-9 select-window -t 9
      bind-key -n M-0 select-window -t 10

      bind-key h select-pane -L
      bind-key j select-pane -D
      bind-key k select-pane -U
      bind-key l select-pane -R

      bind -n M-h select-pane -L
      bind -n M-j select-pane -D
      bind -n M-k select-pane -U
      bind -n M-l select-pane -R

      bind-key -r H resize-pane -L 1
      bind-key -r J resize-pane -D 1
      bind-key -r K resize-pane -U 1
      bind-key -r L resize-pane -R 1

      bind -T copy-mode-vi V send-keys -X select-line
      bind -T copy-mode-vi PageUp   send-keys -X halfpage-up
      bind -T copy-mode-vi PageDown send-keys -X halfpage-down
      bind -T copy-mode-vi g send-keys -X history-top
      bind -T copy-mode-vi G send-keys -X history-bottom

      set -g allow-passthrough on
      set -ga update-environment TERM
      set -ga update-environment TERM_PROGRAM

      bind p paste-buffer

      set-option -g status-position top
      set -g status-style bg=default
      set -g status-justify absolute-centre
      set -g window-status-style         "bg=default,fg=default"
      set -g window-status-current-style "bg=default,fg=default,bold"
      set -g window-status-separator     " "
    '';
  };
}
