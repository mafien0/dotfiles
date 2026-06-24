{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.gtk = moduleWithSystem (
    { ... }: { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        adw-gtk3
        bibata-cursors
      ];

      environment.variables = {
        XCURSOR_THEME = "Bibata-Modern-Classic";
        XCURSOR_SIZE = "20";
      };
    }
  );

  flake.homeManagerModules.gtk = { pkgs, ... }: {
    gtk = {
      enable = true;
      theme = {
        name = "adw-gtk3";
        package = pkgs.adw-gtk3;
      };
      cursorTheme = {
        name = "Bibata-Modern-Classic";
        package = pkgs.bibata-cursors;
      };
    };
  };
}
