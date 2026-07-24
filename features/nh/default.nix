{
	inputs,
	moduleWithSystem,
	...
}: {
	flake.nixosModules.nh =
		moduleWithSystem (
			{config, ...}: _: {
				programs.nh = {
					enable = true;
					package = config.packages.myNh;
					clean = {
						enable = true;
						extraArgs = "--keep-since 4d --keep 3";
					};
				};
			}
		);

	perSystem = {pkgs, ...}: {
		packages.myNh =
			inputs.wrapper-modules.wrappers.nh.wrap {
				inherit pkgs;
				flake = "/home/mafien0/nix";
			};
	};
}
