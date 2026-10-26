# MADE BY CLANKER
{
  config,
  lib,
  pkgs,
  ...
}: let
  herdr =
    if config.programs.herdr.package != null
    then config.programs.herdr.package
    else pkgs.herdr;

  # `herdr integration install` only drops this bundled extension file, so
  # extract the payload at build time instead of running herdr at activation.
  ompIntegration = pkgs.runCommand "herdr-omp-integration" {} ''
    export HOME=$(mktemp -d)
    mkdir -p $HOME/.omp/agent
    ${lib.getExe herdr} integration install omp
    mkdir -p $out
    mv $HOME/.omp/agent/extensions/herdr-omp-agent-state.ts $out/
  '';
in {
  options.herdr.ompIntegration.enable = lib.mkEnableOption "the OMP agent-state integration bundled with herdr";

  config = {
    home.file = lib.mkIf config.herdr.ompIntegration.enable {
      ".omp/agent/extensions/herdr-omp-agent-state.ts".source = "${ompIntegration}/herdr-omp-agent-state.ts";
    };

    programs.herdr = {
      enable = true;

      settings = {
        onboarding = false;

        theme = {
          name = "gruvbox";
          auto_switch = false;
        };

        terminal.new_cwd = "follow";

        ui = {
          mouse_capture = true;
          tab_bar_position = "top";
          prompt_new_tab_name = false;
          pane_borders = "auto";
          pane_outer_borders = false;
          pane_gaps = false;
        };

        # Prefix and pane/tab keys mirror tmux where herdr has an equivalent action.
        keys = {
          prefix = "ctrl+a";

          # tmux: bind v copy-mode
          copy_mode = "prefix+v";
          # tmux: bind i/o split-window -h/-v
          split_vertical = "prefix+i";
          split_horizontal = "prefix+o";
          # tmux: bind q killp
          close_pane = "prefix+q";
          # tmux: detach default, moved off prefix+q
          detach = "prefix+d";

          # tmux: bind r rename-window
          rename_tab = "prefix+r";
          # tmux: bind n next-window / N previous-window
          previous_tab = "prefix+shift+n";
          # tmux: bind R source-file
          reload_config = "prefix+shift+r";
          # herdr-only action, moved off prefix+shift+n
          new_workspace = "prefix+shift+c";

          # tmux: bind h/j/k/l select-pane, bind -n M-h/j/k/l select-pane
          focus_pane_left = ["prefix+h" "alt+h"];
          focus_pane_down = ["prefix+j" "alt+j"];
          focus_pane_up = ["prefix+k" "alt+k"];
          focus_pane_right = ["prefix+l" "alt+l"];

          # tmux: bind-key -r H/J/K/L resize-pane
          resize_pane_left = "prefix+shift+h";
          resize_pane_down = "prefix+shift+j";
          resize_pane_up = "prefix+shift+k";
          resize_pane_right = "prefix+shift+l";
          resize_mode = "";

          # tmux: bind-key -n M-1..M-9 select-window
          indexed.tabs = "alt";

          # no tmux equivalent: agent navigation
          previous_agent = "prefix+a";
          next_agent = "prefix+shift+a";
          focus_agent = "prefix+alt+1..9";

          # no tmux equivalent; frees prefix+shift+h/j/k/l for resizing
          swap_pane_left = "";
          swap_pane_down = "";
          swap_pane_up = "";
          swap_pane_right = "";
        };

        # tmux-resurrect + tmux-continuum equivalent
        experimental.pane_history = true;
      };
    };
  };
}
