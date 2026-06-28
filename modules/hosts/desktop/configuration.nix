{ self, ... }: {

  flake.nixosModules.desktopConfiguration =
    {
      pkgs,
      config,
      ...
    }:
    {

      imports = [
        self.nixosModules.desktopHardware
        self.nixosModules.homeManager

        # GUI
        self.nixosModules.gtk
        self.nixosModules.qt
        self.nixosModules.niri
        self.nixosModules.foot
        self.nixosModules.apps
        self.nixosModules.spicetify
        self.nixosModules.nixcord
        self.nixosModules.helium

        # CLI & TUI
        self.nixosModules.zsh
        self.nixosModules.nh
        self.nixosModules.tmux
        self.nixosModules.neovim
        self.nixosModules.git
        self.nixosModules.opencode
        self.nixosModules.btop
        self.nixosModules.pipewire
        self.nixosModules.tailscale
      ];

      system.stateVersion = "26.05";
      nixpkgs.config.allowUnfree = true;
      nix.settings = {
        experimental-features = [
          "nix-command"
          "flakes"
        ];
        # Nix community cachix
        substituters = [ "https://nix-community.cachix.org" ];
        trusted-public-keys = [ "nix-community.cachix-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" ];
      };

      # Grub
      boot.loader = {
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
        };
        efi.canTouchEfiVariables = true;
      };

      # Ly dm
      services.displayManager.ly.enable = true;

      # Something other configureation
      networking.hostName = "desktop";
      networking.networkmanager.enable = true;
      time.timeZone = "Asia/Almaty";

      i18n.defaultLocale = "en_US.UTF-8";
      services.xserver.xkb.layout = "us";

      users.users.mafien0 = {
        isNormalUser = true;
        initialPassword = "passwd";
        extraGroups = [
          "wheel"
          "disk"
        ];
        shell = pkgs.zsh;
      };

      # Packages
      environment.systemPackages = with pkgs; [
        # Cli / Tui
        cloc
        fzf
        wget
        ripgrep
        killall
        fastfetch # Cool

        localsend
        prismlauncher
        blockbench
      ];

      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
        localNetworkGameTransfers.openFirewall = true;
        extraPackages = with pkgs; [ pulseaudio bibata-cursors ];
      };

      fonts.packages = with pkgs; [
        # Nerd Fonts
        nerd-fonts.fira-code
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
        nerd-fonts.noto
        nerd-fonts.sauce-code-pro

        # General purpose
        noto-fonts
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        dejavu_fonts
        ubuntu-classic

        # Metric-compatible MS fonts
        liberation_ttf
        carlito
        caladea

        # Adobe Source fonts
        source-code-pro
        source-sans-pro
        source-serif-pro
      ];

      fonts.fontconfig.defaultFonts = {
        monospace = [
          "JetBrainsMono Nerd Font"
          "FiraCode Nerd Font"
          "Hack Nerd Font"
          "Source Code Pro"
          "DejaVu Sans Mono"
          "Noto Sans Mono"
        ];
        sansSerif = [
          "Noto Sans"
          "Ubuntu"
          "DejaVu Sans"
          "Source Sans Pro"
        ];
        serif = [
          "Noto Serif"
          "Source Serif Pro"
          "DejaVu Serif"
        ];
        emoji = [
          "Noto Color Emoji"
        ];
      };

      # Nvidia gtx1060 drivers
      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = false;
        modesetting.enable = true;
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.legacy_580;
      };

    };
}
