{
  pkgs,
  inputs,
  ...
}: let
  nixosModules = [
    "avahi"
    "cachix"
    "ddc"
    "docker"
    "gvfs"
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
    ]
    ++ (map (m: ../../nixosModules/${m}) nixosModules);

  # Home-manager
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

  # Nix(OS)
  system.stateVersion = "26.05";
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];
  nix.settings = {
    trusted-users = ["@wheel"];
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

  # Preserve token
  security.sudo.extraConfig = ''
    Defaults env_keep += "GITHUB_TOKEN"
  '';

  # Me specific
  networking = {
    hostName = "desktop";
    networkmanager.enable = true;
  };
  time.timeZone = "Asia/Almaty";
  services.xserver.xkb.layout = "us";
  i18n.defaultLocale = "en_US.UTF-8";

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
