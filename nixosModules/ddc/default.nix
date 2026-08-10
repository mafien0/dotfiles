{
  config,
  pkgs,
  ...
}: {
  boot.kernelModules = [
    "i2c-dev"
    "ddcci"
    "ddcci_backlight"
  ];
  boot.extraModulePackages = [
    config.boot.kernelPackages.ddcci-driver
  ];
  hardware.i2c.enable = true;

  users.users.mafien0.extraGroups = [
    "i2c"
  ];

  environment.systemPackages = with pkgs; [
    ddcutil
    brightnessctl
  ];

  services.udev.packages = [
    pkgs.brightnessctl
  ];
}
