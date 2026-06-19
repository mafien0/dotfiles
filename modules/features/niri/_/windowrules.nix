{ pkgs, lib }:
{
  settings = { };

  windowRules = [
    # Picture-in-Picture
    {
      matches = [
        { title = "^Picture-in-Picture$"; }
      ];
      draw-border-with-background = false;
      focus-ring = {
        off = _: { };
      };
      shadow = {
        off = _: { };
      };
      geometry-corner-radius = 0;
      open-floating = true;
    }

    # Floating windows (multiple matches)
    {
      matches = [
        { title = "terminal-popup"; }
        { app-id = "popup"; }
        { app-id = "waypaper"; }
        { app-id = "modrinth-app.*"; }
        { app-id = "Bitwarden"; }
        { app-id = "ninjabrainbot.*"; }
        { app-id = "^.*\\.satty$"; }
        { app-id = "^.*\\.Celluloid$"; }
        { app-id = "^.*\\.Loupe$"; }
        { app-id = "^.*\\.TextEditor$"; }
        { app-id = "^.*\\.pwvucontrol$"; }
        { app-id = "^.*\\.MissionCenter$"; }
        { app-id = "^.*\\.Warehouse$"; }
        { app-id = "^.*\\.Flatseal$"; }
        { app-id = "^.*\\.devtoolbox$"; }
        { app-id = "^.*\\.Bazaar$"; }
        { app-id = "^.*\\.spider$"; }
        { title = "[Ss]ave [Ff]ile"; }
      ];
      open-floating = true;
      default-window-height = {
        proportion = 0.8;
      };
      default-column-width = {
        proportion = 0.8;
      };
    }

    # GNOME apps float
    {
      matches = [
        { app-id = "org.gnome.*"; }
        { title = "Welcome to.*"; }
      ];
      open-floating = true;
    }

    # Block from screencast
    {
      matches = [
        { app-id = "org.telegram.desktop"; }
        { app-id = "com.rtosta.zapzap"; }
        { app-id = "spotify"; }
      ];
      block-out-from = "screencast";
    }
  ];

  layerRules = [
    {
      matches = [
        { namespace = "^noctalia-overview*"; }
      ];
      place-within-backdrop = true;
    }
  ];
}
