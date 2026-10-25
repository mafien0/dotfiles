let
  modules = [
    "ai"
    "apps"
    "btop"
    "direnv"
    "eza"
    "flint"
    "foot"
    "git"
    "helium"
    "mcsr"
    "mfetch"
    "hyprland"
    "nixcord"
    "nixtools"
    "noctalia"
    "neovim"
    "prismlauncher"
    "qbittorrent"
    "scr"
    "spicetify"
    "theme"
    "tmux"
    "yazi"
    "zsh"
  ];
in {
  imports = map (m: ../../homeModules/${m}) modules;

  home = {
    username = "mafien0";
    homeDirectory = "/home/mafien0";
    stateVersion = "26.11";
  };

  programs.home-manager.enable = true;

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    download = "$HOME/Downloads";
    pictures = "$HOME/Pictures";
    videos = "$HOME/Videos/";
  };
}
