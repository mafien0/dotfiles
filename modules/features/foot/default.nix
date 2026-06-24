{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.foot = moduleWithSystem (
    { config, ... }: { ... }: {
      environment.systemPackages = [ config.packages.myFeet ];
    }
  );

  perSystem = { pkgs, ... }: {
    # I will keep it as myFeet
    packages.myFeet = inputs.wrapper-modules.wrappers.foot.wrap {
      inherit pkgs;
      settings = {
        main = {
          font = "JetBrainsMono Nerd Font:style=Medium:size=11";
          pad = "5x5";
          include = "~/.config/foot/themes/noctalia";
        };
        cursor = {
          style = "beam";
          blink = false;
        };
      };
    };
  };
}
