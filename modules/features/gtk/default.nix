{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.gtk = moduleWithSystem (
    { ... }: { pkgs, lib, ... }: {
      programs.dconf.enable = true;

      environment.systemPackages = with pkgs; [
        adw-gtk3
        adwaita-icon-theme
        bibata-cursors
        glib
        gsettings-desktop-schemas
      ];

      environment.sessionVariables = {
        GSETTINGS_SCHEMA_DIR =
          "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-${lib.getVersion pkgs.gsettings-desktop-schemas}/glib-2.0/schemas";
      };

      environment.variables = {
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "20";
      };
    }
  );

  flake.homeManagerModules.gtk = { pkgs, ... }: {
    gtk = {
      enable = true;
      theme.name = "adw-gtk3";
      iconTheme = {
        name = "Adwaita";
        package = pkgs.adwaita-icon-theme;
      };
      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
      };
    };

    home.file.".config/gtk-4.0/gtk.css".text = ''
      @import url("noctalia.css");
    '';

    dconf = {
      enable = true;
      settings."org/gnome/desktop/interface" = {
        "gtk-theme" = "adw-gtk3";
        "color-scheme" = "prefer-dark";
      };
    };
  };
}
