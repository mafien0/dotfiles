{lib, ...}: {
	stylix.targets.qt = {
		enable = true;
		platform = "qtct";
	};

	qt = {
		enable = true;
		qt6ctSettings = {
			Appearance.icon_theme = lib.mkDefault "Papirus-Dark";
		};
		qt5ctSettings = {
			Appearance.icon_theme = lib.mkDefault "Papirus-Dark";
		};
	};
}
