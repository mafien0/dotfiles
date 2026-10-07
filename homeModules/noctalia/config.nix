{
  programs.noctalia.settings = {
    backdrop.enabled = true;

    brightness.enable_ddcutil = true;

    idle.behavior = {
      lock = {
        timeout = 660;
        action = "lock";
        enabled = true;
      };
      "screen-off" = {
        timeout = 300;
        action = "screen_off";
        enabled = true;
      };
      suspend = {
        timeout = 900;
        action = "lock_and_suspend";
        enabled = true;
      };
    };

    location.auto_locate = true;

    weather.enabled = true;

    bar.default = {
      end = [
        "tray"
        "group:g1"
        "privacy"
        "notifications"
        "volume"
        "brightness"
        "control-center"
        "session"
      ];
      margin_ends = 10;
      start = [
        "launcher"
        "workspaces"
      ];
      capsule_group = [
        {
          accordion = false;
          accordion_direction = "end";
          border_width = 1.0;
          enabled = true;
          fill = "surface_variant";
          id = "g1";
          members = [
            "cpu"
            "ram"
            "temp"
          ];
          opacity = 1.0;
          padding = 6.0;
        }
      ];
    };

    desktop_widgets = {
      schema_version = 2;
      widget_order = [];
      grid = {
        cell_size = 16;
        major_interval = 4;
        visible = true;
      };
      widget = {};
    };

    lockscreen_widgets = {
      enabled = false;
      schema_version = 2;
      widget_order = ["lockscreen-login-box@HDMI-A-1"];
      grid = {
        cell_size = 16;
        major_interval = 4;
        visible = true;
      };
      widget."lockscreen-login-box@HDMI-A-1" = {
        box_height = 196.0;
        box_width = 810.0;
        cx = 960.0;
        cy = 898.0;
        output = "HDMI-A-1";
        placement_height = 1080.0;
        placement_width = 1920.0;
        rotation = 0.0;
        type = "login_box";
        settings = {
          background_color = "surface_variant";
          background_opacity = 0.88;
          background_radius = 12.0;
          center_password_text = false;
          input_opacity = 1.0;
          input_radius = 6.0;
          layout = "regular";
          show_caps_lock = true;
          show_keyboard_layout = true;
          show_login_button = true;
          show_media = true;
          show_session_buttons = true;
          show_unlock_hint = true;
          show_weather = true;
        };
      };
    };

    shell.screenshot = {
      directory = "~/Pictures/Screenshots";
      filename_pattern = "sc-%Y-%m-%d_%H-%M-%S";
    };

    shell.launcher = {
      pinned = [
        "equibop"
        "org.prismlauncher.PrismLauncher"
        "spotify"
        "helium"
      ];
      sort_by_usage = true;
    };

    widget = {
      "control-center".glyph = "topology-ring-3";
      launcher.glyph = "chart-bubble";
      tray.drawer = true;
    };
  };
}
