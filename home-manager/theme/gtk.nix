{pkgs, ...}: {
	stylix.targets.gtk.enable = true;

	home.packages = with pkgs; [
		papirus-icon-theme # Expose it
	];
	gtk = {
		iconTheme = {
			name = "Papirus-Dark";
			package = pkgs.papirus-icon-theme;
		};
	};
}
