{pkgs, ...}: {
	imports = [
	];

	stylix = {
		enable = true;
		autoEnable = false;

		base16Scheme =
			builtins.fetchurl {
				url = "https://raw.githubusercontent.com/tinted-theming/schemes/refs/heads/spec-0.11/base16/everforest-dark-hard.yaml";
				sha256 = "17wccvb42j2bizzl7pp0ad0hqq843sn7yv0ghhbwdmd0b9gbqgm6";
			};

		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};

		fonts = {
			sizes = {
				terminal = 11;
			};
			serif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Serif";
			};

			sansSerif = {
				package = pkgs.ubuntu-classic;
				name = "Ubuntu";
			};

			monospace = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "JetBrainsMono Nerd Font Medium";
			};

			emoji = {
				package = pkgs.noto-fonts-color-emoji;
				name = "Noto Color Emoji";
			};
		};
	};
}
