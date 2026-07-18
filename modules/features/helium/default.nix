{
  inputs,
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.helium = moduleWithSystem (
    _: {pkgs, ...}: {
      environment.systemPackages = [inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default];

      xdg.mime.defaultApplications = {
        "text/html" = "helium.desktop";
        "application/xhtml+xml" = "helium.desktop";
        "x-scheme-handler/http" = "helium.desktop";
        "x-scheme-handler/https" = "helium.desktop";
        "x-scheme-handler/ftp" = "helium.desktop";
        "x-scheme-handler/about" = "helium.desktop";
        "x-scheme-handler/unknown" = "helium.desktop";
      };
    }
  );
}
