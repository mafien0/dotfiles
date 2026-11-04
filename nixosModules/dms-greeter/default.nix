{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.dux-greeter.nixosModules.default];

  # greeter reads the cursor theme from settings.json but only finds it in system icon dirs
  environment.systemPackages = [pkgs.bibata-cursors];

  programs.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/mafien0";
  };
}
