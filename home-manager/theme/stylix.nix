{pkgs, ...}: {
	imports = [
	];

	stylix = {
		enable = true;
		autoEnable = false;

		base16Scheme =
			builtins.fetchurl {
				url = "https://raw.githubusercontent.com/catppuccin/base16/main/base16/mocha.yaml";
				sha256 = "1wyn8ww8d9q8m6cycppx98n15sbms62aydf25wp9wkbv3p64bnfg";
			};

		cursor = {
			package = pkgs.bibata-cursors;
			name = "Bibata-Modern-Classic";
			size = 24;
		};

		fonts = {
			serif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Serif";
			};

			sansSerif = {
				package = pkgs.dejavu_fonts;
				name = "DejaVu Sans";
			};

			monospace = {
				package = pkgs.nerd-fonts.jetbrains-mono;
				name = "JetBrainsMono Nerd Font";
			};

			emoji = {
				package = pkgs.noto-fonts-color-emoji;
				name = "Noto Color Emoji";
			};
		};
	};
}
