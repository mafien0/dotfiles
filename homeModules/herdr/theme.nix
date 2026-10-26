# MADE BY CLANKER
{config, ...}: let
  c = name: config.common.colors.${name};
in {
  # Same tokens as herdr's built-in gruvbox palette, sourced from common.colors.
  # sidebar_bg stays unset so the sidebar keeps the terminal background.
  programs.herdr.settings.theme = {
    name = "gruvbox";
    auto_switch = false;

    custom = {
      accent = c "base0A"; # yellow
      panel_bg = c "base01";
      active_row_bg = c "base02";
      selection_bg = c "base02";
      surface0 = c "base02";
      surface1 = c "base03";
      surface_dim = c "base01";
      overlay0 = c "base04";
      overlay1 = c "base04";
      text = c "base06";
      subtext0 = c "base05";
      mauve = c "base0E";
      green = c "base0B";
      yellow = c "base0A";
      red = c "base08";
      blue = c "base0D";
      teal = c "base0C";
      peach = c "base09";
    };
  };
}
