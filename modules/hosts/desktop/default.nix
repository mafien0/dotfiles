{ self, inputs, ... }: {
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.desktopConfiguration
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.desktop
    ];
  };
}
