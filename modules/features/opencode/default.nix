{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.opencode = moduleWithSystem (
    { config, ... }: { ... }: {
      environment.systemPackages = [ config.packages.myOpencode ];
    }
  );

  perSystem = { pkgs, ... }: {
    packages.myOpencode = inputs.wrapper-modules.wrappers.opencode.wrap {
      inherit pkgs;
      settings = {
        theme = "system";
      };
    };
  };
}
