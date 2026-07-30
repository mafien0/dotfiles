{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nvf = {
      url = "github:NotAShelf/nvf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    helium = {
      url = "github:AlvaroParker/helium-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:FlameFlag/nixcord";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri-flake = {
      url = "github:epireyn/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.7";
    };

    noctalia-qs = {
      url = "github:noctalia-dev/noctalia-qs";
    };
  };

  outputs = inputs: let
    system = "x86_64-linux";

    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    specialArgs = {
      inherit inputs system;
      noctaliaPackage = inputs.noctalia-shell.packages.${system}.default;
      helium = inputs.helium.packages.${system}.default;
      spicetifyExtensions = inputs.spicetify-nix.legacyPackages.${system}.extensions;
    };
    lib = inputs.nixpkgs.lib;

    packages.${system} = {
      build = import ./pkgs/build.nix {
        inherit pkgs lib;
        flakePath = toString ./.;
      };
      nixtest = import ./pkgs/nixtest.nix {inherit pkgs;};
      nixformat = import ./pkgs/nixformat.nix {inherit pkgs;};
    };
  in {
    inherit packages;
    nixosConfigurations = {
      desktop = inputs.nixpkgs.lib.nixosSystem {
        inherit system specialArgs;

        modules = [
          ./nixos/configuration.nix
          ./nixos/disko.nix
        ];
      };
    };
    homeConfigurations = {
      mafien0 = inputs.home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = specialArgs;
        modules = [
          ./home-manager/home.nix
        ];
      };
    };
  };
}
