{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./config.nix
    ./input.nix
    ./style.nix
    ./env.nix
    ./misc.nix
    ./windowrules.nix
    inputs.niri-flake.homeModules.stylix
  ];

  programs.niri.package = pkgs.niri;
  stylix.targets.niri.enable = true;
}
