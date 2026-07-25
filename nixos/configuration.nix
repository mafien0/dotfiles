{
	pkgs,
	config,
	...
}: {
	imports = [
		./hardware.nix
		./apps.nix
		./programs.nix
	];

	system.stateVersion = "26.05";

	home-manager.backupFileExtension = ".bak";
	nixpkgs.config.allowUnfree = true;
	nix.settings = {
		experimental-features = [
			"nix-command"
			"flakes"
		];
		auto-optimise-store = true;
		max-jobs = 4;
		cores = 0;
	};
	nix.extraOptions = ''
		!include /home/mafien0/.config/nix/access-tokens.conf
	'';

	# Grub
	boot.loader = {
		grub = {
			enable = true;
			device = "nodev";
			efiSupport = true;
			useOSProber = true;
		};
		efi.canTouchEfiVariables = true;
	};

	security.sudo.extraConfig = ''
		Defaults env_keep += "GITHUB_TOKEN"
	'';

	services = {
		journald.extraConfig = ''
			SystemMaxUse=500M
		'';

		# Ly dm
		displayManager.ly.enable = true;
		xserver.xkb.layout = "us";

		tailscale = {
			enable = true;
			openFirewall = true;
		};
		resolved.enable = true;
	};

	networking = {
		hostName = "desktop";
		networkmanager.enable = true;
	};
	time.timeZone = "Asia/Almaty";

	i18n.defaultLocale = "en_US.UTF-8";

	users.users.mafien0 = {
		isNormalUser = true;
		initialPassword = "passwd";
		extraGroups = [
			"wheel"
			"disk"
		];
		shell = pkgs.zsh;
	};

	# Nvidia gtx1060 drivers
	hardware = {
		graphics = {
			enable = true;
			enable32Bit = true;
			extraPackages = with pkgs; [egl-wayland];
		};
		nvidia = {
			open = false;
			modesetting.enable = true;
			powerManagement.enable = true;
			nvidiaSettings = true;
			package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
		};
	};
	services.xserver.videoDrivers = ["nvidia"];

	services.pipewire = {
		enable = true;
		pulse.enable = true;
		wireplumber.enable = true;
		alsa.enable = true;
		alsa.support32Bit = true;
	};
}
