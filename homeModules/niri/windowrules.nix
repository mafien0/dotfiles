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

    # full opacity
    {
      matches = [
        {app-id = "(?i)^helium$";}
        {app-id = "(?i).*steam.*";}
        {app-id = "(?i).*minecraft.*";}
      ];
      opacity = 1.0;
    }

    # open apps on dedicated workspaces
    {
      matches = [
        {app-id = "(?i).*steam.*";}
        {app-id = "(?i).*minecraft.*";}
        {title = "(?i).*minecraft.*";}
        {app-id = "(?i).*prismlauncher.*";}
        {app-id = "(?i)EverestSplash-linux";}
        {app-id = "(?i)Celeste";}
        {app-id = "(?i)waywall";}
      ];
      open-on-workspace = "1";
      open-focused = false;
    }

    {
      matches = [{app-id = "(?i)^helium$";}];
      open-on-workspace = "2";
      open-focused = false;
    }

    {
      matches = [{app-id = "(?i)^equibop$";}];
      open-on-workspace = "3";
      open-focused = false;
    }

    {
      matches = [{app-id = "(?i).*spotify.*";}];
      open-on-workspace = "4";
      open-focused = false;
    }
  ];

  programs.niri.settings."layer-rules" = [
    {
      matches = [
        {namespace = "^noctalia-backdrop";}
      ];
      place-within-backdrop = true;
    }
    {
      matches = [
        {namespace = "^noctalia-(bar-[^\"]+|notification|dock|panel|attached-panel|osd)$";}
      ];
      background-effect.xray = false;
    }
    {
      matches = [
        {namespace = "noctalia-window-switcher";}
      ];
      background-effect.blur = false;
      background-effect.xray = false;
    }
  ];
}
