{moduleWithSystem, ...}: {
	flake.nixosModules.mpv =
		moduleWithSystem (
			_: {pkgs, ...}: {
				environment.systemPackages = [pkgs.mpv];

				xdg.mime.defaultApplications = {
					# Video
					"video/mp4" = "mpv.desktop";
					"video/mpeg" = "mpv.desktop";
					"video/webm" = "mpv.desktop";
					"video/ogg" = "mpv.desktop";
					"video/x-matroska" = "mpv.desktop";
					"video/x-msvideo" = "mpv.desktop";
					"video/quicktime" = "mpv.desktop";
					"video/x-flv" = "mpv.desktop";
					"application/vnd.ms-asf" = "mpv.desktop";
					"application/x-matroska" = "mpv.desktop";
					"application/ogg" = "mpv.desktop";

					# Audio
					"audio/mpeg" = "mpv.desktop";
					"audio/ogg" = "mpv.desktop";
					"audio/wav" = "mpv.desktop";
					"audio/x-wav" = "mpv.desktop";
					"audio/flac" = "mpv.desktop";
					"audio/x-flac" = "mpv.desktop";
					"audio/aac" = "mpv.desktop";
					"audio/x-aac" = "mpv.desktop";
					"audio/x-m4a" = "mpv.desktop";
					"audio/x-matroska" = "mpv.desktop";
					"audio/webm" = "mpv.desktop";
					"audio/x-aiff" = "mpv.desktop";
					"audio/x-musepack" = "mpv.desktop";
					"audio/x-ape" = "mpv.desktop";
					"audio/opus" = "mpv.desktop";
					"audio/x-opus+ogg" = "mpv.desktop";
				};
			}
		);
}
