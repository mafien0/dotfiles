{
  inputs,
  moduleWithSystem,
  config,
  ...
}:
let
  inherit (config.flake) homeManagerModules;
in
{
  flake.nixosModules.homeManager = moduleWithSystem (
    { ... }: { ... }: {
      imports = [ inputs.home-manager.nixosModules.home-manager ];

      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "bak";
        users.mafien0 = { ... }: {
          imports = [ homeManagerModules.gtk ];
          home.stateVersion = "26.05";
        };
      };
    }
  );
}
