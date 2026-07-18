{
	inputs,
	moduleWithSystem,
	config,
	...
}: let
	inherit (config.flake) homeManagerModules;
in {
	flake.nixosModules.homeManager =
		moduleWithSystem (
			_: _: {
				imports = [inputs.home-manager.nixosModules.home-manager];

				home-manager = {
					useGlobalPkgs = true;
					useUserPackages = true;
					backupFileExtension = "bak";
					users.mafien0 = {...}: {
						imports = [homeManagerModules.gtk];

						xdg.userDirs = {
							enable = true;
							createDirectories = true;
							download = "$HOME/Downloads";
							pictures = "$HOME/Pictures";
						};

						home.stateVersion = "26.05";
					};
				};
			}
		);
}
