{lib, ...}: {
  stylix.targets.starship.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings =
      lib.importTOML ./starship.toml
      // {
        scan_timeout = 100;
        follow_symlinks = false;
      };
  };
}
