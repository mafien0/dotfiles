# MADE BY CLANKER
{
  pkgs,
  lib,
  config,
  ...
}: let
  c = name: config.common.colors.${name};

  scr = import ../../pkgs/scr {inherit pkgs;};
in {
  home.packages = [scr];

  # The picker re-reads this file on change, so colors apply without a restart.
  xdg.configFile."scr/config.toml".text = ''
    save_dir = "~/Pictures/Screenshots"

    border_color = "${c "base0D"}"

    dim_color = "${c "base00"}"
    dim_opacity = 0.30

    readout_color = "${c "base05"}"
    readout_background = "#cc${lib.removePrefix "#" (c "base00")}"
  '';
}
