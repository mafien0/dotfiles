{
  inputs,
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
    }
  );
}
