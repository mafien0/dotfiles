{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    deadnix
    nixd
    alejandra
    nixpkgs-lint-community
    statix

    (import ../../pkgs/build.nix {
      inherit pkgs lib;
      flakePath = "/home/mafien0/nix";
    })
    (import ../../pkgs/nixtest.nix { inherit pkgs; })
    (import ../../pkgs/nixformat.nix { inherit pkgs; })
  ];
}
