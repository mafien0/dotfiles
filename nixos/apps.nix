{pkgs, ...}: {
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
}
