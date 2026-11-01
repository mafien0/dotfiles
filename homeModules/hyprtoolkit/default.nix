# MADE BY CLANKER
{
  config,
  lib,
  pkgs,
  ...
}: let
  c = name: "0xFF" + lib.strings.removePrefix "#" config.common.colors.${name};
in {
  imports = [../theme];

  home.packages = [pkgs.hyprtoolkit];

  home.file.".config/hypr/hyprtoolkit.conf".text = ''
    background = ${c "base00"}
    base = ${c "base01"}
    text = ${c "base05"}
    alternate_base = ${c "base02"}
    bright_text = ${c "base06"}
    link_text = ${c "base0D"}
    accent = ${c "base0D"}
    accent_secondary = ${c "base0A"}

    rounding_large = ${toString (builtins.floor config.common.cornerRadius)}
    rounding_small = ${toString (builtins.floor config.common.cornerRadius)}

    font_family = ${config.common.fonts.monospace.name}
    font_family_monospace = ${config.common.fonts.monospace.name}
    font_size = ${toString config.common.fonts.sizes.terminal}
  '';
}
