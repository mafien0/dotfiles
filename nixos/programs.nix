{pkgs, ...}: {
	environment.systemPackages = with pkgs; [
		# Nix
		deadnix
		nixfmt
		nil
		alejandra
		nixpkgs-lint-community
		statix

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

		obsidian

		ntfs3g
		docker-compose

		# Im sorry, but i need kotlin
	];

	virtualisation.docker.enable = true;

	programs = {
		nix-index-database = {
			enable = true;
			comma.enable = true;
		};
		dconf.enable = true;
		nh = {
			enable = true;
			flake = "/home/mafien0/nix";
			clean = {
				enable = true;
				extraArgs = "--keep 5 --keep-since 3d";
			};
		};

		niri = {
			enable = true;
			package = pkgs.niri;
		};

		zsh.enable = true;

		localsend = {
			enable = true;
			openFirewall = true;
		};

		nix-ld.enable = true;
		obs-studio.enable = true;
		gamescope.enable = true;

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
}
