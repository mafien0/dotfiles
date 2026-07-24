{moduleWithSystem, ...}: {
	flake.nixosModules.apps =
		moduleWithSystem (
			_: {pkgs, ...}: {
				services = {
					gvfs.enable = true;
					udisks2.enable = true;
					gnome.gcr-ssh-agent.enable = false;
					avahi = {
						enable = true;
						nssmdns4 = true;
						openFirewall = true;
						publish = {
							enable = true;
							userServices = true;
						};
					};
				};
				programs.ssh.startAgent = true;
				security.polkit.enable = true;

				programs.thunar = {
					enable = true;
					plugins = [pkgs.thunar-volman];
				};

				environment.systemPackages = with pkgs; [
					qalculate-gtk
				];

				xdg.mime = {
					enable = true;
					defaultApplications = {
						"inode/directory" = "thunar.desktop";
						"application/gzip" = "thunar.desktop";
						"application/x-bzip2" = "thunar.desktop";
						"application/x-xz" = "thunar.desktop";
						"application/zstd" = "thunar.desktop";
						"application/zip" = "thunar.desktop";
						"application/x-tar" = "thunar.desktop";
						"application/x-7z-compressed" = "thunar.desktop";
						"application/x-rar" = "thunar.desktop";
						"application/x-brotli" = "thunar.desktop";
						"application/vnd.rar" = "thunar.desktop";
					};
				};
			}
		);
}
