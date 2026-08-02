{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    ./hardware.nix
    ./apps.nix
    ./programs.nix
    ./disko.nix
    inputs.noctalia-shell.nixosModules.default
  ];

  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    users.mafien0.imports = [./home.nix];
    extraSpecialArgs = {
      inherit inputs;
      flakePath = "/home/mafien0/nix";
      noctaliaPackage = inputs.noctalia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default;
      helium = inputs.helium.packages.${pkgs.stdenv.hostPlatform.system}.default;
      mfetch = inputs.mfetch.packages.${pkgs.stdenv.hostPlatform.system}.default;
      spicetifyExtensions = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system}.extensions;
    };
  };

  system.stateVersion = "26.05";

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
  nix.settings = {
    trusted-users = ["@wheel"];
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://nvf.cachix.org"
      "https://vic.cachix.org"
      "https://spicetify-nix.cachix.org"
      "https://helium-nix.cachix.org"
      "https://noctalia.cachix.org"
      "https://niri-epireyn.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
      "vic.cachix.org-1:1fQNG1DxLTGd47MBAtr/IrUYIk+TTXDojOItpqFoxII="
      "spicetify-nix.cachix.org-1:jjnwULkvMdu0E5KGBbtgrISEfDdJTGSZ4ATkiFzZn5I="
      "helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw="
      "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
      "niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA="
    ];
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

  services.pipewire = {
    enable = true;
    pulse.enable = true;
    wireplumber.enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
  };
}
