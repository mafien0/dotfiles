let
  modules = [
    "apps"
    "btop"
    "direnv"
    "eza"
    "flint"
    "foot"
    "git"
    "helium"
    "mfetch"
    "niri"
    "nixcord"
    "nixtools"
    "noctalia"
    "neovim"
    "opencode"
    "prismlauncher"
    "qbittorrent"
    "spicetify"
    "theme"
    "tmux"
    "zsh"
  ];
in {
  imports = map (m: ../../homeModules/${m}) modules;

  home = {
    username = "mafien0";
    homeDirectory = "/home/mafien0";
    stateVersion = "26.05";
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
