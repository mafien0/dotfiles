{moduleWithSystem, ...}: {
	flake.nixosModules.qbittorrent =
		moduleWithSystem (
			{pkgs, ...}: {
				environment.systemPackages = [pkgs.qbittorrent];

				xdg.mime.defaultApplications = {
					"application/x-bittorrent" = "qbittorrent.desktop";
					"x-scheme-handler/magnet" = "qbittorrent.desktop";
				};
			}
		);
}
