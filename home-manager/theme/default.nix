{
	imports = [
		./stylix.nix
		./gtk.nix
		./qt.nix
	];

	home.pointerCursor.enable = true;

	dconf.settings = {
		"org/gnome/desktop/interface" = {
			color-scheme = "prefer-dark";
		};
	};
}
