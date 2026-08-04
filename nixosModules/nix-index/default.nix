{inputs, ...}: {
  imports = [
    inputs.nix-index-database.nixosModules.default
  ];
  programs.nix-index-database = {
    enable = true;
    comma.enable = true;
  };
}
