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

		noctalia-plugins = {
			url = "github:noctalia-dev/noctalia-plugins";
			flake = false;
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
		];
		extra-trusted-public-keys = [
			"nix-community.cachix-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
			"nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
			"hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0="
			"vic.cachix.org-1:1fQNG1DxLTGd47MBAtr/IrUYIk+TTXDojOItpqFoxII="
			"spicetify-nix.cachix.org-1:jjnwULkvMdu0E5KGBbtgrISEfDdJTGSZ4ATkiFzZn5I="
			"helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw="
		];
	};

	outputs = inputs: let
		system = "x86_64-linux";

		pkgs =
			import inputs.nixpkgs {
				inherit system;
				config.allowUnfree = true;
			};
	in {
		nixosConfigurations = {
			nixos =
				inputs.nixpkgs.lib.nixosSystem {
					inherit system;

					specialArgs = {
						inherit inputs system pkgs;
					};

					modules = [
						./nixos/configuration.nix
						inputs.home-manager.nixosModules.home-manager
					];
				};
		};
		homeConfigurations = {
			mafien0 =
				inputs.home-manager.lib.homeManagerConfiguration {
					inherit pkgs;
					extraSpecialArgs = {
						inherit inputs system;
					};
					modules = [
						./home-manager/home.nix
						inputs.stylix.homeModules.stylix
						inputs.nixcord.homeModules.nixcord
					];
				};
		};
	};
}
