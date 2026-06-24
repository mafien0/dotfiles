{
  inputs,
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.spicetify = moduleWithSystem (
    { ... }:
    { pkgs, ... }:
    let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in
    {
      imports = [ inputs.spicetify-nix.nixosModules.spicetify ];

      programs.spicetify = {
        enable = true;
        enabledExtensions = with spicePkgs.extensions; [
          adblockify
          hidePodcasts
        ];
        wayland = true;
        windowManagerPatch = true;
      };
    }
  );
}
