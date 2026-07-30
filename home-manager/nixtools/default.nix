{pkgs, ...}: {
  home.packages = with pkgs; [
    deadnix
    nixd
    alejandra
    nixpkgs-lint-community
    statix

    (import ../../pkgs/nixtest.nix {inherit pkgs;})
    (import ../../pkgs/nixformat.nix {inherit pkgs;})
  ];
}
