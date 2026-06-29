{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.tailscale = moduleWithSystem (
    { ... }: { ... }: {
      services.tailscale = {
        enable = true;
        openFirewall = true;
      };

      services.resolved.enable = true;
    }
  );
}
