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
    };
  };
  services.xserver.videoDrivers = ["nvidia"];
}
