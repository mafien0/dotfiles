{
	config,
	lib,
	modulesPath,
	...
}: {
	imports = [
		(modulesPath + "/installer/scan/not-detected.nix")
	];
	boot = {
		initrd = {
			availableKernelModules = [
				"nvme"
				"xhci_pci"
				"ahci"
				"usb_storage"
				"usbhid"
				"sd_mod"
			];
			kernelModules = [];
		};
		kernelModules = ["tcp_bbr"];
		extraModulePackages = [];

		kernelParams = [
			"nowatchdog"
			"udev.log_priority=3"
		];

		kernel.sysctl = {
			"vm.swappiness" = 10;
			"vm.vfs_cache_pressure" = 50;
			"vm.dirty_ratio" = 10;
			"vm.dirty_background_ratio" = 5;
			"net.core.default_qdisc" = "cake";
			"net.ipv4.tcp_congestion_control" = "bbr";
		};
	};

	powerManagement.cpuFreqGovernor = "performance";

	nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
	hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

	systemd.services.nix-daemon.serviceConfig = {
		CPUSchedulingPolicy = lib.mkForce "idle";
		IOSchedulingClass = lib.mkForce "idle";
		Nice = lib.mkForce 19;
	};

	fileSystems."/mnt/drive" = {
		device = "/dev/disk/by-uuid/3cc52577-7ebc-46ca-a059-0276e80fcb46";
		fsType = "ext4";
		options = [
			"defaults"
			"noatime"
		];
	};

	swapDevices = [
		{
			device = "/swapfile";
			size = 8192;
		}
	];

	systemd.tmpfiles.rules = [
		"L+ /home/mafien0/drive - - - - /mnt/drive"
	];
}
