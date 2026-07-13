{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.mousepad = moduleWithSystem (
    _: { pkgs, ... }: {
      environment.systemPackages = [ pkgs.mousepad ];

      xdg.mime.defaultApplications = {
        "text/plain" = "org.xfce.mousepad.desktop";
        "text/markdown" = "org.xfce.mousepad.desktop";
        "application/json" = "org.xfce.mousepad.desktop";
        "text/csv" = "org.xfce.mousepad.desktop";
        "text/xml" = "org.xfce.mousepad.desktop";
        "text/javascript" = "org.xfce.mousepad.desktop";
        "application/xml" = "org.xfce.mousepad.desktop";
        "text/x-c" = "org.xfce.mousepad.desktop";
        "text/x-c++" = "org.xfce.mousepad.desktop";
        "text/x-python" = "org.xfce.mousepad.desktop";
        "text/x-shellscript" = "org.xfce.mousepad.desktop";
        "text/x-rust" = "org.xfce.mousepad.desktop";
        "text/x-toml" = "org.xfce.mousepad.desktop";
        "text/x-yaml" = "org.xfce.mousepad.desktop";
        "text/x-nix" = "org.xfce.mousepad.desktop";
      };
    }
  );
}
