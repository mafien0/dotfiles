{
  pkgs,
  lib,
  flakePath,
  ...
}: {
  programs.nh = {
    enable = true;
    flake = flakePath;
    clean = {
      enable = true;
      extraArgs = "--keep 5 --keep-since 3d";
    };
  };

  environment.shellAliases = {
    nb = "${lib.getExe pkgs.nh} os switch";
  };
}
