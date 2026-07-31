{
  pkgs,
  lib,
  config,
  noctaliaPackage,
  ...
}: let
  ipc = "${lib.getExe noctaliaPackage} ipc --any-display call";
in {
  programs.niri.settings = {
    input.keyboard = {
      numlock = true;
      xkb = {
        layout = "us,ru";
        options = "grp:win_space_toggle,caps:escape";
      };
    };

    binds = {
      # Launchers
      "Mod+Return".action.spawn = [(lib.getExe pkgs.foot)];
      "Mod+Shift+Return".action."spawn-sh" = "${lib.getExe pkgs.foot} --title='terminal-popup'";
      "Mod+E".action.spawn = [(lib.getExe pkgs.thunar)];
      "Mod+Alt+L".action."spawn-sh" = "${lib.getExe' config.programs.niri.package "niri"} msg action power-on-monitors";

      # Noctalia shell
      "Mod+A" = {
        action."spawn-sh" = "${ipc} launcher toggle";
        cooldown-ms = 500;
      };
      "Mod+Shift+C" = {
        action."spawn-sh" = "${ipc} launcher clipboard";
        cooldown-ms = 500;
      };
      "Mod+Shift+E" = {
        action."spawn-sh" = "${ipc} launcher emoji";
        cooldown-ms = 500;
      };
      "Mod+Shift+M" = {
        action."spawn-sh" = "${ipc} sessionMenu toggle";
        cooldown-ms = 500;
      };

      # Base actions
      # close-window
      "Mod+Shift+Q" = {
        action."close-window" = {};
        repeat = false;
      };
      # toggle-overview
      "Mod+Escape" = {
        action."toggle-overview" = {};
        repeat = false;
      };
      # maximize-column
      "Mod+F" = {
        action."maximize-column" = {};
        repeat = false;
      };
      # fullscreen-window
      "Mod+Shift+F" = {
        action."fullscreen-window" = {};
        repeat = false;
      };
      # toggle-window-floating
      "Mod+Shift+V" = {
        action."toggle-window-floating" = {};
        repeat = false;
      };
      # toggle-window-rule-opacity
      "Mod+W" = {
        action."toggle-window-rule-opacity" = {};
        repeat = false;
      };
      # switch-focus-between-floating-and-tiling
      "Mod+V" = {
        action."switch-focus-between-floating-and-tiling" = {};
        repeat = false;
      };

      # Util
      # Hyprpicker
      "Mod+X" = {
        action."spawn-sh" = "${lib.getExe pkgs.hyprpicker} -a -l";
        repeat = false;
      };
      # show-hotkey-overlay
      "Mod+Shift+Slash" = {
        action."show-hotkey-overlay" = {};
        repeat = false;
      };
      # screenshot
      "Mod+S" = {
        action.screenshot = {};
        repeat = false;
      };
      # screenshot-screen
      "Mod+Shift+S" = {
        action."screenshot-screen" = {};
        repeat = false;
      };
      # Smart screenshot
      "Mod+Alt+S" = {
        action."spawn-sh" = "${lib.getExe' config.programs.niri.package "niri"} msg action screenshot-screen && ${lib.getExe' pkgs.coreutils "sleep"} 0.5; ${lib.getExe' pkgs.wl-clipboard "wl-paste"} | ${lib.getExe pkgs.satty} --filename -";
        repeat = false;
      };
      # set-dynamic-cast-window
      "Mod+Z" = {
        action."set-dynamic-cast-window" = {};
        repeat = false;
      };

      # Focus (Vim-like)
      "Mod+H".action."focus-column-left" = {};
      "Mod+J".action."focus-window-or-workspace-down" = {};
      "Mod+K".action."focus-window-or-workspace-up" = {};
      "Mod+L".action."focus-column-right" = {};

      # Move windows
      "Mod+Shift+H".action."move-column-left" = {};
      "Mod+Shift+J".action."move-window-down-or-to-workspace-down" = {};
      "Mod+Shift+K".action."move-window-up-or-to-workspace-up" = {};
      "Mod+Shift+L".action."move-column-right" = {};

      # Column center
      "Mod+Ctrl+C".action."center-column" = {};

      # First/last column
      "Mod+G".action."focus-column-first" = {};
      "Mod+Shift+G".action."focus-column-last" = {};
      "Mod+Ctrl+G".action."move-column-to-first" = {};
      "Mod+Ctrl+Shift+G".action."move-column-to-last" = {};

      # Column width
      "Mod+Minus".action."set-column-width" = "-10%";
      "Mod+Equal".action."set-column-width" = "+10%";

      # Window height
      "Mod+Shift+Minus".action."set-window-height" = "-10%";
      "Mod+Shift+Equal".action."set-window-height" = "+10%";

      # Consume/expel
      "Mod+BracketLeft".action."consume-or-expel-window-left" = {};
      "Mod+BracketRight".action."consume-or-expel-window-right" = {};
      "Mod+Comma".action."consume-window-into-column" = {};
      "Mod+Period".action."expel-window-from-column" = {};

      # Window size presets
      "Mod+R".action."switch-preset-column-width" = {};
      "Mod+Ctrl+R".action."reset-window-height" = {};
      "Mod+Shift+R".action."switch-preset-window-height" = {};
      "Mod+Ctrl+Shift+R".action."switch-preset-window-height" = {};

      # Mouse scroll
      "Mod+WheelScrollDown" = {
        action."focus-workspace-down" = {};
        cooldown-ms = 150;
      };
      "Mod+WheelScrollUp" = {
        action."focus-workspace-up" = {};
        cooldown-ms = 150;
      };
      "Mod+Shift+WheelScrollDown" = {
        action."focus-column-right" = {};
        cooldown-ms = 100;
      };
      "Mod+Shift+WheelScrollUp" = {
        action."focus-column-left" = {};
        cooldown-ms = 100;
      };

      # Workspace switch 1-9
      "Mod+1".action."focus-workspace" = 1;
      "Mod+2".action."focus-workspace" = 2;
      "Mod+3".action."focus-workspace" = 3;
      "Mod+4".action."focus-workspace" = 4;
      "Mod+5".action."focus-workspace" = 5;
      "Mod+6".action."focus-workspace" = 6;
      "Mod+7".action."focus-workspace" = 7;
      "Mod+8".action."focus-workspace" = 8;
      "Mod+9".action."focus-workspace" = 9;

      # Move to workspace 1-9
      "Mod+Shift+1".action."move-window-to-workspace" = 1;
      "Mod+Shift+2".action."move-window-to-workspace" = 2;
      "Mod+Shift+3".action."move-window-to-workspace" = 3;
      "Mod+Shift+4".action."move-window-to-workspace" = 4;
      "Mod+Shift+5".action."move-window-to-workspace" = 5;
      "Mod+Shift+6".action."move-window-to-workspace" = 6;
      "Mod+Shift+7".action."move-window-to-workspace" = 7;
      "Mod+Shift+8".action."move-window-to-workspace" = 8;
      "Mod+Shift+9".action."move-window-to-workspace" = 9;

      # Audio control
      "Mod+C".action."spawn-sh" = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      "Mod+O".action."spawn-sh" = "${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
      "Mod+Shift+O".action."spawn-sh" = "${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
      "Mod+I".action."spawn-sh" = "${lib.getExe pkgs.playerctl} play-pause";
      "Mod+Alt+I".action."spawn-sh" = "${lib.getExe pkgs.playerctl} next";
      "Mod+Alt+Shift+I".action."spawn-sh" = "${lib.getExe pkgs.playerctl} previous";

      # OBS replay
      "Mod+T".action."spawn-sh" = "${ipc} plugin:obs-control saveReplay";

      # Media keys (allow-when-locked)
      "XF86AudioRaiseVolume" = {
        action."spawn-sh" = "${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 0.02+ -l 1.0";
        allow-when-locked = true;
      };
      "XF86AudioLowerVolume" = {
        action."spawn-sh" = "${lib.getExe' pkgs.wireplumber "wpctl"} set-volume @DEFAULT_AUDIO_SINK@ 0.02-";
        allow-when-locked = true;
      };
      "XF86AudioMute" = {
        action."spawn-sh" = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SINK@ toggle";
        allow-when-locked = true;
      };
      "XF86AudioMicMute" = {
        action."spawn-sh" = "${lib.getExe' pkgs.wireplumber "wpctl"} set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
        allow-when-locked = true;
      };
      "XF86AudioStop" = {
        action."spawn-sh" = "${lib.getExe pkgs.playerctl} stop";
        allow-when-locked = true;
      };
      "XF86AudioPlay" = {
        action."spawn-sh" = "${lib.getExe pkgs.playerctl} play-pause";
        allow-when-locked = true;
      };
      "XF86AudioPrev" = {
        action."spawn-sh" = "${lib.getExe pkgs.playerctl} previous";
        allow-when-locked = true;
      };
      "XF86AudioNext" = {
        action."spawn-sh" = "${lib.getExe pkgs.playerctl} next";
        allow-when-locked = true;
      };
      "XF86MonBrightnessUp" = {
        action."spawn-sh" = "${lib.getExe pkgs.brightnessctl} --class=backlight set +10%";
        allow-when-locked = true;
      };
      "XF86MonBrightnessDown" = {
        action."spawn-sh" = "${lib.getExe pkgs.brightnessctl} --class=backlight set 10%-";
        allow-when-locked = true;
      };
    };
  };
}
