{
	programs.niri.settings."window-rules" = [
		# Style
		{
			matches = [];
			geometry-corner-radius = {
				top-left = 12.0;
				top-right = 12.0;
				bottom-right = 12.0;
				bottom-left = 12.0;
			};
			# Opacity
			opacity = 0.95;
			background-effect = {
				xray = true;
				blur = true;
			};

			clip-to-geometry = true;
		}
	];

	programs.niri.settings = {
		prefer-no-csd = true;

		layout = {
			gaps = 10;
			center-focused-column = "never";

			default-column-width = {
				proportion = 0.5;
			};

			preset-column-widths = [
				{proportion = 0.33333;}
				{proportion = 0.5;}
				{proportion = 0.66667;}
			];

			focus-ring = {
				width = 2;
			};

			shadow = {
				softness = 30;
				spread = 5;
				offset = {
					x = 0;
					y = 5;
				};
			};
		};

		cursor = {
			theme = "Bibata-Modern-Classic";
			size = 20;
		};

		debug = {
			"disable-cursor-plane" = [];
			"skip-cursor-only-updates-during-vrr" = [];
		};

		hotkey-overlay = {
			skip-at-startup = true;
		};

		animations = {
			workspace-switch.kind.spring = {
				"damping-ratio" = 1.0;
				stiffness = 1000;
				epsilon = 0.0001;
			};

			window-open.kind.easing = {
				duration-ms = 150;
				curve = "ease-out-expo";
			};

			window-close.kind.easing = {
				duration-ms = 150;
				curve = "ease-out-quad";
			};

			horizontal-view-movement.kind.spring = {
				"damping-ratio" = 1.0;
				stiffness = 800;
				epsilon = 0.0001;
			};

			window-movement.kind.spring = {
				"damping-ratio" = 1.0;
				stiffness = 800;
				epsilon = 0.0001;
			};

			window-resize.kind.spring = {
				"damping-ratio" = 1.0;
				stiffness = 800;
				epsilon = 0.0001;
			};

			config-notification-open-close.kind.spring = {
				"damping-ratio" = 0.6;
				stiffness = 1000;
				epsilon = 0.001;
			};

			exit-confirmation-open-close.kind.spring = {
				"damping-ratio" = 0.6;
				stiffness = 500;
				epsilon = 0.01;
			};

			screenshot-ui-open.kind.easing = {
				duration-ms = 200;
				curve = "ease-out-quad";
			};

			overview-open-close.kind.spring = {
				"damping-ratio" = 1.0;
				stiffness = 800;
				epsilon = 0.0001;
			};

			/*
         recent-windows-close = {
      	spring = {
      		"damping-ratio" = 1.0;
      		stiffness = 800;
      		epsilon = 0.001;
      	};
      };
      */
		};

		/*
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
    */
	};
}
