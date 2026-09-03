{pkgs, ...}: {
  home.packages = with pkgs; [
    deadnix
    nixd
    alejandra
    nixpkgs-lint-community
    statix

    (import ../../pkgs/nixcheck.nix {inherit pkgs;})
    (import ../../pkgs/nixformat.nix {inherit pkgs;})
  ];
}
