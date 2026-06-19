{ pkgs, lib }:
{
  settings = {
    prefer-no-csd = _: { };

    layout = {
      gaps = 10;
      center-focused-column = "never";

      default-column-width = {
        proportion = 0.5;
      };

      preset-column-widths = [
        { proportion = 0.33333; }
        { proportion = 0.5; }
        { proportion = 0.66667; }
      ];

      focus-ring = {
        width = 3;
      };

      shadow = {
        softness = 30;
        spread = 5;
        offset = _: {
          props = {
            x = 0;
            y = 5;
          };
        };
      };
    };

    cursor = {
      xcursor-size = 20;
    };

    hotkey-overlay = {
      skip-at-startup = _: { };
    };

    animations = {
      workspace-switch = {
        spring = _: {
          props = {
            "damping-ratio" = 1.0;
            stiffness = 1000;
            epsilon = 0.0001;
          };
        };
      };

      window-open = {
        duration-ms = 150;
        curve = "ease-out-expo";
      };

      window-close = {
        duration-ms = 150;
        curve = "ease-out-quad";
      };

      horizontal-view-movement = {
        spring = _: {
          props = {
            "damping-ratio" = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
      };

      window-movement = {
        spring = _: {
          props = {
            "damping-ratio" = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
      };

      window-resize = {
        spring = _: {
          props = {
            "damping-ratio" = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
      };

      config-notification-open-close = {
        spring = _: {
          props = {
            "damping-ratio" = 0.6;
            stiffness = 1000;
            epsilon = 0.001;
          };
        };
      };

      exit-confirmation-open-close = {
        spring = _: {
          props = {
            "damping-ratio" = 0.6;
            stiffness = 500;
            epsilon = 0.01;
          };
        };
      };

      screenshot-ui-open = {
        duration-ms = 200;
        curve = "ease-out-quad";
      };

      overview-open-close = {
        spring = _: {
          props = {
            "damping-ratio" = 1.0;
            stiffness = 800;
            epsilon = 0.0001;
          };
        };
      };

      recent-windows-close = {
        spring = _: {
          props = {
            "damping-ratio" = 1.0;
            stiffness = 800;
            epsilon = 0.001;
          };
        };
      };
    };

    recent-windows = {
      debounce-ms = 750;
      open-delay-ms = 0;

      highlight = {
        padding = 30;
        corner-radius = 5;
      };

      previews = {
        max-height = 480;
        max-scale = 0.5;
      };
    };
  };

  windowRules = [
    {
      geometry-corner-radius = 10;
      clip-to-geometry = true;
    }
  ];
}
