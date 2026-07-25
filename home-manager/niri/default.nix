{pkgs, ...}: {
	imports = [
		./config.nix
		./input.nix
		./style.nix
		./env.nix
		./misc.nix
		./windowrules.nix
	];

	programs.niri = {
		enable = true;
		package = pkgs.niri;
	};
	stylix.targets.niri.enable = true;
}
