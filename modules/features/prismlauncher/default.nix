{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.prismlauncher = moduleWithSystem (
    { config, ... }: _: {
      environment.systemPackages = [ config.packages.myPrismlauncher ];
    }
  );

  perSystem = { pkgs, ... }: {
    packages.myPrismlauncher = pkgs.prismlauncher.override {
      jdks = with pkgs; [
        temurin-bin-25
        temurin-bin-21
        temurin-bin-17
        temurin-bin-11
        temurin-bin-8
      ];
    };
  };
}
