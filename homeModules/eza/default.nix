{
  pkgs,
  lib,
  ...
}: {
  programs.eza = {
    enable = true;
  };

  home.shellAliases = {
    l = "${lib.getExe pkgs.eza} -la --icons=auto --classify --group-directories-first --header --time-style=long-iso";
    ls = "${lib.getExe pkgs.eza} --icons=auto --classify --group-directories-first --header --time-style=long-iso";
    lt = "${lib.getExe pkgs.eza} --tree --icons=auto --classify --group-directories-first --header --time-style=long-iso";
  };
}
