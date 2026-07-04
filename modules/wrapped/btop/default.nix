{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.btop = moduleWithSystem (
    { config, ... }: _: {
      environment.systemPackages = [ config.packages.myBtop ];
    }
  );

  perSystem = { pkgs, ... }: {
    packages.myBtop = inputs.wrapper-modules.wrappers.btop.wrap {
      inherit pkgs;
      settings = {
        color_theme = "TTY";
        theme_background = false;
        truecolor = false;
        vim_keys = true;
      };
    };
  };
}
