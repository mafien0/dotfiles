{
	inputs,
	self,
	moduleWithSystem,
	...
}: {
	flake.nixosModules.helpers =
		moduleWithSystem (
			_: {pkgs, ...}: {
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
					nixfmt
					nil
					alejandra
					nixpkgs-lint-community
					statix
				];
			}
		);
}
