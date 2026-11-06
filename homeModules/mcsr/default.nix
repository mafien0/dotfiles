{
  pkgs,
  config,
  ...
}: let
  # tests fail in the sandbox: openjdk-headless has no libfontmanager
  ninjabrain-bot-pkg = pkgs.ninjabrain-bot.overrideAttrs (old: {
    mvnParameters = "${old.mvnParameters or ""} -DskipTests";
    preBuild =
      (old.preBuild or "")
      + ''
        export MAVEN_ARGS="''${MAVEN_ARGS:-} -DskipTests"
      '';
    doCheck = false;
  });

  # https://github.com/tesselslate/waywall/issues/49
  ninjabrain-bot = pkgs.writeShellScriptBin "ninjabrain-bot" ''
    export JAVA_TOOL_OPTIONS="''${JAVA_TOOL_OPTIONS:-} -Dswing.defaultlaf=javax.swing.plaf.metal.MetalLookAndFeel"
    exec ${ninjabrain-bot-pkg}/bin/ninjabrain-bot "$@"
  '';

  measuring-overlay = ../../assets/mcsr/measuring_overlay.png;
in {
  home.packages = [
    pkgs.waywall
    ninjabrain-bot
  ];

  home.sessionVariables = {
    __GL_THREADED_OPTIMIZATIONS = "0"; # NVIDIA: fixes GLFW error 65544
  };

  xdg.configFile = {
    "waywall/nix.lua".text = ''
      return {
          ninjabrain_bot = "${pkgs.lib.getExe ninjabrain-bot}",
          background = "${config.common.colors.base00}",
          measuring_overlay = "${measuring-overlay}",
      }
    '';

    "waywall/init.lua".source = ./init.lua;
  };
}
