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
      nixcheck = import ./pkgs/nixcheck.nix {inherit pkgs;};
      nixformat = import ./pkgs/nixformat.nix {inherit pkgs;};
      scr = import ./pkgs/scr {inherit pkgs;};
    };
  in {
    inherit packages;
    nixosConfigurations = {
      ataraxia = inputs.nixpkgs.lib.nixosSystem {
        inherit system specialArgs;
        modules = [
          ./hosts/ataraxia/configuration.nix
        ];
      };
      iso = inputs.nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/iso/configuration.nix
        ];
      };
    };

    formatter.${system} = import pkgs/nixformat.nix {inherit pkgs;};

    devShells.${system}.default = pkgs.mkShell {
      packages = with pkgs; [
        just
      ];
    };
  };

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # shared by: llm-agents, stylix
    systems = {
      url = "github:nix-systems/default";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:nix-community/stylix/master";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        systems.follows = "systems";
      };
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
        flake-utils.follows = "flake-utils";
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
        nixpkgs-ci.follows = "nixpkgs";
        nixpkgs-packages.follows = "nixpkgs";
        home-manager.follows = "home-manager";
        treefmt-nix.follows = "treefmt-nix";
      };
    };

    flint = {
      url = "github:NotAShelf/flint";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Custom fork of noctalia-shell(deprecated), i'll try to maintain it
    noctalia-shell = {
      url = "github:mafien0/noctalia/";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Damn what a cool package i wonder who made it
    mfetch = {
      url = "git+https://codeberg.org/mafien0/mfetch";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };

    nix-alien = {
      url = "github:thiagokokada/nix-alien";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-compat.follows = "flake-compat";
        nix-index-database.follows = "nix-index-database";
      };
    };

    # Pinning it, because i dont want to update it that often
    llm-agents = {
      url = "github:numtide/llm-agents.nix/53a2d94ce3b88753200be9a0549d8978b031fa60";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        treefmt-nix.follows = "treefmt-nix";
        flake-parts.follows = "flake-parts";
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
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    # shared by: stylix
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };
  };
}
