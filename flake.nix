{
	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		disko = {
			url = "github:nix-community/disko";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		stylix = {
			url = "github:nix-community/stylix";
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
		};

		noctalia-shell = {
			url = "github:noctalia-dev/noctalia-shell/v4.7.7";
		};

		noctalia-qs = {
			url = "github:noctalia-dev/noctalia-qs";
		};
	};

	nixConfig = {
		extra-substituters = [
			"https://nix-community.cachix.org"
			"https://nvf.cachix.org"
			"https://hercules-ci.cachix.org"
			"https://vic.cachix.org"
			"https://spicetify-nix.cachix.org"
			"https://helium-nix.cachix.org"
			"https://noctalia.cachix.org"
		];
		extra-trusted-public-keys = [
			"nix-community.cachix-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
			"nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
			"hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0="
			"vic.cachix.org-1:1fQNG1DxLTGd47MBAtr/IrUYIk+TTXDojOItpqFoxII="
			"spicetify-nix.cachix.org-1:jjnwULkvMdu0E5KGBbtgrISEfDdJTGSZ4ATkiFzZn5I="
			"helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw="
			"noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
		];
	};

	outputs = inputs: let
		system = "x86_64-linux";

		pkgs =
			import inputs.nixpkgs {
				inherit system;
				config.allowUnfree = true;
			};

		specialArgs = {
			inherit inputs system;
			noctaliaPackage = inputs.noctalia-shell.packages.${system}.default;
			helium = inputs.helium.packages.${system}.default;
			spicetifyExtensions = inputs.spicetify-nix.legacyPackages.${system}.extensions;
		};
	in {
		nixosConfigurations = {
			desktop =
				inputs.nixpkgs.lib.nixosSystem {
					inherit system specialArgs;

					modules = [
						./nixos/configuration.nix
						./nixos/disko.nix
						inputs.nix-index-database.nixosModules.default
						inputs.home-manager.nixosModules.home-manager
						inputs.niri-flake.nixosModules.niri
						inputs.disko.nixosModules.disko
						inputs.noctalia-shell.nixosModules.default
					];
				};
		};
		homeConfigurations = {
			mafien0 =
				inputs.home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					extraSpecialArgs = specialArgs;
					modules = [
						./home-manager/home.nix
						inputs.stylix.homeModules.stylix
						inputs.niri-flake.homeModules.niri
						inputs.niri-flake.homeModules.stylix
						inputs.noctalia-shell.homeModules.default
						inputs.nixcord.homeModules.nixcord
						inputs.spicetify-nix.homeManagerModules.spicetify
						inputs.nvf.homeManagerModules.nvf
					];
				};
		};
	};
}
