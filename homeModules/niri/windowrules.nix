{
  programs.niri.settings."window-rules" = [
    {
      matches = [{title = "(?i)^Picture-in-Picture$";}];
      draw-border-with-background = false;
      focus-ring.enable = false;
      shadow.enable = false;
      geometry-corner-radius = {
        top-left = 0.0;
        top-right = 0.0;
        bottom-right = 0.0;
        bottom-left = 0.0;
      };
      open-floating = true;
    }

    {
      matches = [
        {
          title = "(?i)^notificationtoasts_[0-9]+_desktop$";
          app-id = "(?i).*steam.*";
        }
      ];
      open-floating = true;
      open-focused = false;
      draw-border-with-background = false;
      focus-ring.enable = false;
      shadow.enable = false;
      default-floating-position = {
        x = 0;
        y = 0;
        relative-to = "bottom-right";
      };
    }

    {
      matches = [{app-id = "(?i)^qalculate-gtk$";}];
      open-floating = true;
      default-column-width = {fixed = 794;};
      default-window-height = {fixed = 554;};
    }

    {
      matches = [
        {title = "(?i)terminal-popup";}
        {app-id = "(?i)popup";}
        {app-id = "(?i)waypaper";}
        {app-id = "(?i)^.*\\.satty$";}
        {app-id = "(?i)^[Tt]hunar$";}
        {app-id = "(?i)^imv$";}
        {app-id = "(?i)^org\\.xfce\\.mousepad$";}
        {app-id = "(?i)modrinth-app.*";}
        {app-id = "(?i)Bitwarden";}
        {app-id = "(?i)ninjabrainbot.*";}
        {app-id = "(?i)^.*\\.Celluloid$";}
        {app-id = "(?i)^.*\\.pwvucontrol$";}
        {app-id = "(?i)^.*\\.MissionCenter$";}
        {app-id = "(?i)^.*\\.Warehouse$";}
        {app-id = "(?i)^.*\\.Flatseal$";}
        {app-id = "(?i)^.*\\.devtoolbox$";}
        {app-id = "(?i)^.*\\.Bazaar$";}
        {app-id = "(?i)^.*\\.spider$";}
        {title = "(?i)[Ss]ave [Ff]ile";}
      ];
      open-floating = true;
      default-window-height = {proportion = 0.8;};
      default-column-width = {proportion = 0.8;};
    }

    {
      matches = [{app-id = "(?i)org.gnome.*";}];
      open-floating = true;
    }

    {
      matches = [{title = "(?i)Welcome to.*";}];
      open-floating = true;
    }

    {
      matches = [
        {app-id = "(?i)org.telegram.desktop";}
        {app-id = "(?i)com.rtosta.zapzap";}
        {app-id = "(?i).*spotify";}
      ];
      block-out-from = "screencast";
    }
  ];

  programs.niri.settings."layer-rules" = [
    {
      matches = [
        {namespace = "(?i)^noctalia-overview.*$";}
      ];
      place-within-backdrop = true;
    }
  ];
}
