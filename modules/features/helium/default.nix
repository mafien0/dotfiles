{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.helium = moduleWithSystem (
    { ... }: { pkgs, ... }: {
      environment.systemPackages = [ inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default ];
    }
  );
}
