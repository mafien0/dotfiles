{pkgs, ...}: {
	stylix.target.gtk.enable = true;

	gtk = {
		iconTheme = {
			package =
				pkgs.papirus-icon-theme.override {
					color = "violet";
				};
		};
	};
}
