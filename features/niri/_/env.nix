{lib, ...}: {
	settings = {
		environment = {
			ELECTRON_OZONE_PLATFORM_HINT = "wayland";
			NIXOS_OZONE_WL = "1";
			MOZ_ENABLE_WAYLAND = "1";
			WINE_VK_VULKAN_ONLY = "1";
			_JAVA_AWT_WM_NONREPARENTING = "1";
			GTK_THEME = "adw-gtk3";
			SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
			XCURSOR_PATH =
				lib.concatStringsSep ":" [
					"/run/current-system/sw/share/icons"
					"/nix/var/nix/profiles/default/share/icons"
					"/home/mafien0/.nix-profile/share/icons"
					"/home/mafien0/.local/share/icons"
					"/home/mafien0/.icons"
					"/usr/share/icons"
				];
			EGL_PLATFORM = "wayland";
			XDG_SESSION_TYPE = "wayland";
		};
	};
}
