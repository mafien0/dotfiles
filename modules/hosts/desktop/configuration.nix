{self, ...}: {
	flake.nixosModules.desktopConfiguration = {
		pkgs,
		config,
		lib,
		...
	}: {
		imports = [
			self.nixosModules.desktopHardware
			self.nixosModules.homeManager

			self.nixosModules.apps
			self.nixosModules.btop
			self.nixosModules.foot
			self.nixosModules.git
			self.nixosModules.gtk
			self.nixosModules.helpers
			self.nixosModules.helium
			self.nixosModules.imv
			self.nixosModules.mousepad
			self.nixosModules.mpv
			self.nixosModules.nvf
			self.nixosModules.niri
			self.nixosModules.nixcord
			self.nixosModules.opencode
			self.nixosModules.pipewire
			self.nixosModules.prismlauncher
			self.nixosModules.qbittorrent
			self.nixosModules.qt
			self.nixosModules.spicetify
			self.nixosModules.sync
			self.nixosModules.tailscale
			self.nixosModules.tmux
			self.nixosModules.yazi
			self.nixosModules.zsh
		];

		system.stateVersion = "26.05";
		nixpkgs.config = {
			allowUnfree = true;
			permittedInsecurePackages = ["electron-40.10.5"];
		};

		nix.settings = {
			experimental-features = [
				"nix-command"
				"flakes"
			];
			auto-optimise-store = true;
			max-jobs = 4;
			cores = 0;
			# Cachix
			substituters = [
				"https://nix-community.cachix.org"
				"https://nvf.cachix.org"
				"https://hercules-ci.cachix.org"
				"https://vic.cachix.org"
				"https://spicetify-nix.cachix.org"
				"https://helium-nix.cachix.org"
			];
			trusted-public-keys = [
				"nix-community.cachix-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
				"nvf.cachix.org-1:GMQWiUhZ6ux9D5CvFFMwnc2nFrUHTeGaXRlVBXo+naI="
				"hercules-ci.cachix.org-1:ZZeDl9Va+xe9j+KqdzoBZMFJHVQ42Uu/c/1/KMC5Lw0="
				"vic.cachix.org-1:1fQNG1DxLTGd47MBAtr/IrUYIk+TTXDojOItpqFoxII="
				"spicetify-nix.cachix.org-1:jjnwULkvMdu0E5KGBbtgrISEfDdJTGSZ4ATkiFzZn5I="
				"helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw="
			];
		};

		systemd.services.nix-daemon.serviceConfig = {
			CPUSchedulingPolicy = lib.mkForce "idle";
			IOSchedulingClass = lib.mkForce "idle";
			Nice = lib.mkForce 19;
		};

		# Grub
		boot.loader = {
			grub = {
				enable = true;
				device = "nodev";
				efiSupport = true;
				useOSProber = true;
				theme = pkgs.minimal-grub-theme;
			};
			efi.canTouchEfiVariables = true;
		};

		services = {
			journald.extraConfig = ''
				SystemMaxUse=500M
			'';

			# Ly dm
			displayManager.ly.enable = true;

			xserver.xkb.layout = "us";
		};

		# Something other configuration
		networking.hostName = "desktop";
		networking.networkmanager.enable = true;
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

		swapDevices = [
			{
				device = "/swapfile";
				size = 8192;
			}
		];

		# Packages
		environment.systemPackages = with pkgs; [
			# Cli / Tui
			devenv
			python3
			zip
			unzip
			cloc
			fzf
			wget
			ripgrep
			killall
			wrangler
			go
			fastfetch # Cool

			localsend
			blockbench
			obsidian

			ntfs3g
			docker-compose

			# Im sorry, but i need kotlin
			vscodium
		];

		virtualisation.docker.enable = true;

		programs = {
			nix-ld.enable = true;

			obs-studio.enable = true;

			gamescope.enable = true;
			# Steam
			steam = {
				enable = true;
				remotePlay.openFirewall = true;
				dedicatedServer.openFirewall = true;
				localNetworkGameTransfers.openFirewall = true;
				gamescopeSession.enable = true;
				extraPackages = with pkgs; [
					pulseaudio
					bibata-cursors
				];
			};
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
		hardware = {
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
	};
}
