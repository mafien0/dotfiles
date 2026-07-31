{
  imports = [
    ./modules.nix
  ];

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
