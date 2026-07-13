{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.imv = moduleWithSystem (
    _: { pkgs, ... }: {
      environment.systemPackages = [ pkgs.imv ];

      xdg.mime.defaultApplications = {
        "image/avif" = "imv.desktop";
        "image/bmp" = "imv.desktop";
        "image/gif" = "imv.desktop";
        "image/jpeg" = "imv.desktop";
        "image/png" = "imv.desktop";
        "image/svg+xml" = "imv.desktop";
        "image/tiff" = "imv.desktop";
        "image/webp" = "imv.desktop";
        "image/x-portable-pixmap" = "imv.desktop";
        "image/x-portable-graymap" = "imv.desktop";
        "image/x-portable-bitmap" = "imv.desktop";
      };
    }
  );
}
