{
  config,
  lib,
  pkgs,
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
    kernelModules = ["tcp_bbr" "sch_cake"];
    extraModulePackages = [];

    kernelParams = [
      "nowatchdog"
      "udev.log_priority=3"
      # NVIDIA 580 on Pascal drops the GPU mappings of GL/EGL clients across an
      # S3 cycle (Xid 31 MMU fault on resume), killing the shell. s2idle avoids
      # that power transition, at the cost of a higher idle draw while asleep.
      "mem_sleep_default=s2idle"
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

  powerManagement.cpuFreqGovernor = "schedutil";

  # Read by noctalia-watchdog: a marker younger than a few minutes means the
  # session was locked when the shell broke, so a restarted shell re-locks.
  powerManagement.resumeCommands = "${pkgs.coreutils}/bin/touch /run/noctalia-resume-guard";

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;

  fileSystems."/mnt/drive" = {
    device = "/dev/disk/by-uuid/3cc52577-7ebc-46ca-a059-0276e80fcb46";
    fsType = "ext4";
    options = [
      "defaults"
      "noatime"
      "nofail"
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
