{
  pkgs,
  inputs,
  system,
  flakePath,
  ...
}: let
  nixosModules = [
    "avahi"
    "nix"
    "ddc"
    "docker"
    "gvfs"
    "hosts-block"
    "localsend"
    "ly"
    "nh"
    "niri"
    "nix-index"
    "nix-ld"
    "nvidia"
    "obs-studio"
    "pipewire"
    "ssh"
    "steam"
    "tailscale"
    "thunar"
  ];
in {
  imports =
    [
      ./hardware.nix
      ./programs.nix
      ./disko.nix
      inputs.noctalia-shell.nixosModules.default
      inputs.home-manager.nixosModules.home-manager
    ]
    ++ (map (m: ../../nixosModules/${m}) nixosModules);

  networking.firewall.allowedTCPPorts = [8000];

  # Home-manager
  home-manager = {
    backupFileExtension = "bak";
    useGlobalPkgs = true;
    users.mafien0.imports = [./home.nix];
    extraSpecialArgs = {
      inherit inputs system flakePath;
    };
  };

  # Nix(OS)
  system.stateVersion = "26.05";
  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];

  # Me specific
  networking = {
    hostName = "ataraxia";
    networkmanager.enable = true;
  };
  time.timeZone = "Asia/Almaty";
  services.xserver.xkb.layout = "us";
  i18n.defaultLocale = "en_US.UTF-8";

  # Preserve token
  security.sudo.extraConfig = ''
    Defaults env_keep += "GITHUB_TOKEN"
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

  # Users
  users.users.mafien0 = {
    isNormalUser = true;
    initialPassword = "passwd";
    extraGroups = [
      "input"
      "wheel"
      "disk"
    ];
    shell = pkgs.zsh;
  };

  # Varios
  services = {
    journald.extraConfig = ''
      SystemMaxUse=500M
    '';
  };
  programs = {
    dconf.enable = true;
    zsh.enable = true;
  };
}
