{
  config,
  inputs,
  ...
}: let
  wallpaperPath = ../../assets/wallpapers/gruv-abstract-maze.png;
in {
  imports = [
    inputs.stylix.homeModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = false;

    image = wallpaperPath;

    base16Scheme = config.common.colors;
    cursor = config.common.cursor;
    fonts = config.common.fonts;
  };
}
