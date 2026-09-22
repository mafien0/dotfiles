{
  pkgs,
  config,
  ...
}: let
  # https://github.com/tesselslate/waywall/issues/49
  ninjabrain-bot = pkgs.writeShellScriptBin "ninjabrain-bot" ''
    export JAVA_TOOL_OPTIONS="''${JAVA_TOOL_OPTIONS:-} -Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel"
    exec ${pkgs.ninjabrain-bot}/bin/ninjabrain-bot "$@"
  '';
in {
  home.packages = [
    pkgs.waywall
    ninjabrain-bot
  ];

  home.sessionVariables = {
    __GL_THREADED_OPTIMIZATIONS = "0"; # NVIDIA: fixes GLFW error 65544
  };

  xdg.configFile = {
    "waywall/nix.lua".source =
      pkgs.writeText "nix.lua" # Lua
      
      ''
        return {
            ninjabrain_bot = "${pkgs.lib.getExe ninjabrain-bot}",
            background = "#${config.lib.stylix.colors.base00}",
        }
      '';

    "waywall/init.lua".source = ./init.lua;
  };
}
