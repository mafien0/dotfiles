{ ... }: {
  flake.nixosModules.desktopHardware =
    {
      config,
      lib,
      modulesPath,
      ...
    }:
    {
      imports = [
        (modulesPath + "/installer/scan/not-detected.nix")
      ];
      boot.initrd.availableKernelModules = [
        "nvme"
        "xhci_pci"
        "ahci"
        "usb_storage"
        "usbhid"
        "sd_mod"
      ];
      boot.initrd.kernelModules = [ ];
      boot.kernelModules = [ "tcp_bbr" ];
      boot.extraModulePackages = [ ];

      boot.kernelParams = [
        "nowatchdog"
        "udev.log_priority=3"
      ];

      boot.kernel.sysctl = {
        "vm.swappiness" = 10;
        "vm.vfs_cache_pressure" = 50;
        "vm.dirty_ratio" = 10;
        "vm.dirty_background_ratio" = 5;
        "net.core.default_qdisc" = "cake";
        "net.ipv4.tcp_congestion_control" = "bbr";
      };

      powerManagement.cpuFreqGovernor = "performance";

      fileSystems."/" = {
        device = "/dev/disk/by-uuid/05190543-e5df-4868-beb3-ed9e3cd8a159 ";
        fsType = "ext4";
      };

      fileSystems."/boot" = {
        device = "/dev/disk/by-uuid/EF31-4A1B ";
        fsType = "vfat";
        options = [
          "fmask=0022"
          "dmask=0022"
        ];
      };

      swapDevices = [
        { device = "/dev/disk/by-uuid/f3327b66-15cb-4e76-8637-b5d26bb35bbb"; }
      ];

      nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
