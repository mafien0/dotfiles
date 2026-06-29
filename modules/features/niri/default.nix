{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.niri = moduleWithSystem (
    { config, ... }: { pkgs, ... }: {
      programs.niri = {
        enable = true;
        package = config.packages.myNiri;
      };

      environment.systemPackages = [
        pkgs.xwayland-satellite
      ];
    }
  );

  perSystem =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      footPkg = config.packages.myFeet or pkgs.foot;
      hypridlePkg = config.packages.myHypridle or pkgs.hypridle;
      cfg = import ./_/config.nix { inherit pkgs lib hypridlePkg; };
      sty = import ./_/style.nix { inherit pkgs lib; };
      inp = import ./_/input.nix { inherit pkgs lib footPkg; };
      env = import ./_/env.nix { inherit pkgs lib; };
      msc = import ./_/misc.nix { inherit pkgs lib; };
      wrl = import ./_/windowrules.nix { inherit pkgs lib; };
    in
    {
      packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        settings =
          (lib.foldl lib.recursiveUpdate { } [
            cfg.settings
            sty.settings
            inp.settings
            env.settings
            msc.settings
            wrl.settings
          ])
          // {
            window-rules = (sty.windowRules or [ ]) ++ (wrl.windowRules or [ ]) ++ (msc.windowRules or [ ]);
            layer-rules = (wrl.layerRules or [ ]) ++ (msc.layerRules or [ ]);
          };

        extraSettings = [
          {
            include = [
              { optional = true; }
              "~/.config/niri/noctalia.kdl"
            ];
          }
        ];
      };
    };
}
