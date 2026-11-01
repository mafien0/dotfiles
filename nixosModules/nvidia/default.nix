{
  config,
  pkgs,
  ...
}: {
  # Nvidia gtx1060 drivers
  hardware = {
    enableRedistributableFirmware = true;
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
      moduleParams = {
        "nvidia-modeset" = {
          vblank_sem_control = 0;
        };
        nvidia = {
          NVreg_TemporaryFilePath = "/var/tmp";
        };
      };
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
  boot.initrd.kernelModules = ["nvidia" "nvidia_modeset" "nvidia_drm"];
  boot.extraModulePackages = [config.hardware.nvidia.package.mod];
}
