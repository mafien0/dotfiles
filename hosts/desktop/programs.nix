{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # Cli / Tui

    # Basic
    zip
    unzip
    wget
    killall
    ncdu
    cloc

    gcc
    ffmpeg
    fastfetch # Not cool, use mfetch
    fzf
    go
    lazygit
    lazydocker
    ntfs3g
    python3
    ripgrep

    # -- Gui
    bruno
    libresprite
    obsidian

    jetbrains.idea
  ];

  programs = {
    dconf.enable = true;
    zsh.enable = true;
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
