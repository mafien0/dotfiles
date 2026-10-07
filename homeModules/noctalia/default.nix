{inputs, ...}: {
  imports = [
    inputs.noctalia.homeModules.default
    ./config.nix
  ];

  stylix.targets.noctalia.enable = true;

  programs.noctalia = {
    enable = true;
  };
}
