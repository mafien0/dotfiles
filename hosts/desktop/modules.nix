let
  modules = [
    "apps"
    "btop"
    "foot"
    "git"
    "helium"
    "mfetch"
    "niri"
    "nixcord"
    "nixtools"
    "noctalia"
    "nvf"
    "opencode"
    "prismlauncher"
    "qbittorrent"
    "spicetify"
    "theme"
    "tmux"
    "yazi"
    "zsh"
  ];
in {
  imports = map (m: ../../homeModules/${m}) modules;
}
