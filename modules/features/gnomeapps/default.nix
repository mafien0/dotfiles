{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.gnomeapps = moduleWithSystem (
    { ... }: { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        gnome-calculator
        celluloid
        loupe
        gnome-text-editor
      ];
    }
  );
}
