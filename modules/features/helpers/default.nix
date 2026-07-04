{
  inputs,
  self,
  ...
}: {
  flake.nixosModules.helpers = { pkgs, ... }: {
    imports = [
      self.nixosModules.nh
      inputs.nix-index-database.nixosModules.default
    ];

    programs.nix-index-database = {
      enable = true;
      comma.enable = true;
    };

    environment.systemPackages = with pkgs; [
      deadnix
      nil
      nixfmt
      statix
    ];
  };
}
