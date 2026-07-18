{moduleWithSystem, ...}: {
  flake.nixosModules.tailscale = moduleWithSystem (
    _: _: {
      services.tailscale = {
        enable = true;
        openFirewall = true;
      };

      services.resolved.enable = true;
    }
  );
}
