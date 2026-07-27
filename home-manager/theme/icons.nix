{
	pkgs,
	lib,
	...
}: let
	package = pkgs.papirus-icon-theme;
	name = "Papirus-Dark";
in {
	home.packages = [
		package
	];

	gtk.iconTheme = {
		inherit package name;
	};

	qt = {
		enable = true;
		qt6ctSettings = {
			Appearance.icon_theme = lib.mkDefault name;
		};
		qt5ctSettings = {
			Appearance.icon_theme = lib.mkDefault name;
		};
	};
}
