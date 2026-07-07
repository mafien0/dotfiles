{
  pkgs,
  lib,
  footPkg,
}:
{
  settings = {
    input = {
      keyboard = {
        numlock = _: { };
        xkb = {
          layout = "us,ru";
          options = "grp:win_space_toggle,caps:escape";
        };
      };
    };

    recent-windows = {
      binds = {
        "Mod+Tab"."next-window" = _: { };
        "Mod+Shift+Tab"."previous-window" = _: { };

        "Mod+grave"."next-window" = _: {
          props.filter = "app-id";
        };

        "Mod+Shift+grave"."previous-window" = _: {
          props.filter = "app-id";
        };
      };
    };

    binds = {
      # Launchers
      "Mod+Return".spawn = "${lib.getExe footPkg}";
      "Mod+Shift+Return".spawn-sh = "${lib.getExe footPkg} --title='terminal-popup'";
      "Mod+E".spawn = "${lib.getExe pkgs.nautilus}";
      "Mod+Alt+L".spawn-sh = "niri msg action power-on-monitors";

      # Noctalia shell
      "Mod+A" = _: {
        props."cooldown-ms" = 500;
        content."spawn-sh" = "${lib.getExe pkgs.noctalia-shell} ipc call launcher toggle";
      };
      "Mod+Shift+C" = _: {
        props."cooldown-ms" = 500;
        content."spawn-sh" = "${lib.getExe pkgs.noctalia-shell} ipc call launcher clipboard";
      };
      "Mod+Shift+E" = _: {
        props."cooldown-ms" = 500;
        content."spawn-sh" = "${lib.getExe pkgs.noctalia-shell} ipc call launcher emoji";
      };
      "Mod+Shift+M" = _: {
        props."cooldown-ms" = 500;
        content."spawn-sh" = "${lib.getExe pkgs.noctalia-shell} ipc call sessionMenu toggle";
      };

      # Base actions
      "Mod+Shift+Q" = _: {
        props.repeat = false;
        content."close-window" = _: { };
      };
      "Mod+Escape" = _: {
        props.repeat = false;
        content."toggle-overview" = _: { };
      };
      "Mod+F" = _: {
        props.repeat = false;
        content."maximize-column" = _: { };
      };
      "Mod+Shift+F" = _: {
        props.repeat = false;
        content."fullscreen-window" = _: { };
      };
      "Mod+Shift+V" = _: {
        props.repeat = false;
        content."toggle-window-floating" = _: { };
      };
      "Mod+V" = _: {
        props.repeat = false;
        content."switch-focus-between-floating-and-tiling" = _: { };
      };

      # Util
      "Mod+X" = _: {
        props.repeat = false;
        content."spawn-sh" = "${lib.getExe pkgs.hyprpicker} -a -l";
      };
      "Mod+Shift+Slash" = _: {
        props.repeat = false;
        content."show-hotkey-overlay" = _: { };
      };
      "Mod+S" = _: {
        props.repeat = false;
        content.screenshot = _: { };
      };
      "Mod+Shift+S" = _: {
        props.repeat = false;
        content."screenshot-screen" = _: { };
      };
      "Mod+Alt+S" = _: {
        props.repeat = false;
        content."spawn-sh" =
          "niri msg action screenshot-screen && sleep 0.5; ${lib.getExe' pkgs.wl-clipboard "wl-paste"} | ${lib.getExe pkgs.satty} --filename -";
      };
      "Mod+Z" = _: {
        props.repeat = false;
        content."set-dynamic-cast-window" = _: { };
      };

      # Focus
      "Mod+H"."focus-column-left" = _: { };
      "Mod+J"."focus-window-or-workspace-down" = _: { };
      "Mod+K"."focus-window-or-workspace-up" = _: { };
      "Mod+L"."focus-column-right" = _: { };

      # Move windows
      "Mod+Shift+H"."move-column-left" = _: { };
      "Mod+Shift+J"."move-window-down-or-to-workspace-down" = _: { };
      "Mod+Shift+K"."move-window-up-or-to-workspace-up" = _: { };
      "Mod+Shift+L"."move-column-right" = _: { };

      # Column center
      "Mod+Ctrl+C"."center-column" = _: { };

      # Move to first/last
      "Mod+G"."focus-column-first" = _: { };
      "Mod+Shift+G"."focus-column-last" = _: { };
      "Mod+Ctrl+G"."move-column-to-first" = _: { };
      "Mod+Ctrl+Shift+G"."move-column-to-last" = _: { };

      # Column width
      "Mod+Minus"."set-column-width" = "-10%";
      "Mod+Equal"."set-column-width" = "+10%";

      # Window in column height
      "Mod+Shift+Minus"."set-window-height" = "-10%";
      "Mod+Shift+Equal"."set-window-height" = "+10%";

      # In/Out of column
      "Mod+BracketLeft"."consume-or-expel-window-left" = _: { };
      "Mod+BracketRight"."consume-or-expel-window-right" = _: { };
      "Mod+Comma"."consume-window-into-column" = _: { };
      "Mod+Period"."expel-window-from-column" = _: { };

      # Window size presets
      "Mod+R"."switch-preset-column-width" = _: { };
      "Mod+Ctrl+R"."reset-window-height" = _: { };
      "Mod+Shift+R"."switch-preset-window-height" = _: { };
      "Mod+Ctrl+Shift+R"."reset-window-height" = _: { };

      # Mouse scroll
      "Mod+WheelScrollDown" = _: {
        props."cooldown-ms" = 150;
        content."focus-workspace-down" = _: { };
      };
      "Mod+WheelScrollUp" = _: {
        props."cooldown-ms" = 150;
        content."focus-workspace-up" = _: { };
      };
      "Mod+Shift+WheelScrollDown" = _: {
        props."cooldown-ms" = 100;
        content."focus-column-right" = _: { };
      };
      "Mod+Shift+WheelScrollUp" = _: {
        props."cooldown-ms" = 100;
        content."focus-column-left" = _: { };
      };

      # Workspace switch
      "Mod+1"."focus-workspace" = 1;
      "Mod+2"."focus-workspace" = 2;
      "Mod+3"."focus-workspace" = 3;
      "Mod+4"."focus-workspace" = 4;
      "Mod+5"."focus-workspace" = 5;
      "Mod+6"."focus-workspace" = 6;
      "Mod+7"."focus-workspace" = 7;
      "Mod+8"."focus-workspace" = 8;
      "Mod+9"."focus-workspace" = 9;

      # Move to workspace
      "Mod+Shift+1"."move-window-to-workspace" = 1;
      "Mod+Shift+2"."move-window-to-workspace" = 2;
      "Mod+Shift+3"."move-window-to-workspace" = 3;
      "Mod+Shift+4"."move-window-to-workspace" = 4;
      "Mod+Shift+5"."move-window-to-workspace" = 5;
      "Mod+Shift+6"."move-window-to-workspace" = 6;
      "Mod+Shift+7"."move-window-to-workspace" = 7;
      "Mod+Shift+8"."move-window-to-workspace" = 8;
      "Mod+Shift+9"."move-window-to-workspace" = 9;

      # Audio Control
      "Mod+C"."spawn-sh" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      "Mod+O"."spawn-sh" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0";
      "Mod+Shift+O"."spawn-sh" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.05-";
      "Mod+I"."spawn-sh" = "${lib.getExe pkgs.playerctl} play-pause";
      "Mod+Alt+I"."spawn-sh" = "${lib.getExe pkgs.playerctl} next";
      "Mod+Alt+Shift+I"."spawn-sh" = "${lib.getExe pkgs.playerctl} previous";

      # Obs control
      "Mod+T"."spawn-sh" = "${lib.getExe pkgs.noctalia-shell} ipc call plugin:obs-control saveReplay";

      # Media keys
      "XF86AudioRaiseVolume" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02+ -l 1.0";
      };
      "XF86AudioLowerVolume" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02-";
      };
      "XF86AudioMute" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      };
      "XF86AudioMicMute" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";
      };
      "XF86AudioStop" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "${lib.getExe pkgs.playerctl} stop";
      };
      "XF86AudioPlay" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "${lib.getExe pkgs.playerctl} play-pause";
      };
      "XF86AudioPrev" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "${lib.getExe pkgs.playerctl} previous";
      };
      "XF86AudioNext" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "${lib.getExe pkgs.playerctl} next";
      };
      "XF86MonBrightnessUp" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "${lib.getExe pkgs.brightnessctl} --class=backlight set +10%";
      };
      "XF86MonBrightnessDown" = _: {
        props."allow-when-locked" = true;
        content."spawn-sh" = "${lib.getExe pkgs.brightnessctl} --class=backlight set 10%-";
      };
    };
  };
}
