{
  outputs = inputs: let
    system = "x86_64-linux";
    flakePath = "/home/mafien0/nix";

    pkgs = import inputs.nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    specialArgs = {
      inherit inputs system flakePath;
    };

    packages.${system} = {
      nixtest = import ./pkgs/nixtest.nix {inherit pkgs;};
      nixformat = import ./pkgs/nixformat.nix {inherit pkgs;};
    };
  in {
    formatter.${system} = pkgs.alejandra;

    inherit packages;
    nixosConfigurations = {
      ataraxia = inputs.nixpkgs.lib.nixosSystem {
        inherit system specialArgs;

        modules = [
          ./hosts/ataraxia/configuration.nix
        ];
      };
    };
  };

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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
      };
    };

    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixcord = {
      url = "github:4evy/nixcord";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-nixcord.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
        flake-parts.follows = "flake-parts";
      };
    };

    niri-flake = {
      url = "github:epireyn/niri-flake";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs";
        niri-stable.follows = "niri";
        niri-unstable.follows = "niri";
        xwayland-satellite-stable.follows = "xwayland-satellite";
        xwayland-satellite-unstable.follows = "xwayland-satellite";
      };
    };

    # shared by: niri-flake (stable + unstable variants)
    niri = {
      url = "github:niri-wm/niri";
      flake = false;
    };

    # shared by: niri-flake (stable + unstable variants)
    xwayland-satellite = {
      url = "github:Supreeeme/xwayland-satellite";
      flake = false;
    };

    noctalia-shell = {
      url = "github:noctalia-dev/noctalia-shell/v4.7.7";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        noctalia-qs.inputs.treefmt-nix.follows = "treefmt-nix";
      };
    };

    # Damn what a cool package i wonder who made it
    mfetch = {
      url = "git+https://codeberg.org/mafien0/mfetch";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        nix-index-database.follows = "nix-index-database";
      };
    };

    # shared by: helium, nix-alien
    flake-compat = {
      url = "github:edolstra/flake-compat";
      flake = false;
    };

    # shared by: nixcord, noctalia-shell
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # shared by: stylix, nixcord
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
  };
}
