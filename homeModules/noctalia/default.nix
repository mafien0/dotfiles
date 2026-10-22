{
  pkgs,
  config,
  lib,
  inputs,
  system,
  ...
}: {
  imports = [
    inputs.noctalia-shell.homeModules.default
  ];

  stylix.targets.noctalia-shell.enable = true;

  programs.noctalia-shell = let
    pluginURL = "https://github.com/noctalia-dev/noctalia-plugins";
  in {
    enable = true;
    package = inputs.noctalia-shell.packages.${system}.default;

    settings = lib.mkForce (lib.recursiveUpdate (builtins.fromJSON (builtins.readFile ./settings.json)) {
      general = {
        radiusRatio = config.common.cornerRadius / 20.0;
        iRadiusRatio = config.common.cornerRadius / 20.0;
        screenRadiusRatio = config.common.cornerRadius / 20.0;
      };
      bar = {
        marginVertical = config.common.gaps;
        frameRadius = config.common.cornerRadius;
      };
    });

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Noctalia Plugins";
          url = pluginURL;
        }
      ];
      states = {
        obs-control = {
          enabled = true;
          sourceUrl = pluginURL;
        };
        privacy-indicator = {
          enabled = true;
          sourceUrl = pluginURL;
        };
      };
      version = 2;
    };
  };

  home.packages = with pkgs; [
    cliphist
    pwvucontrol
    wl-clipboard
    kdePackages.qtwebsockets
  ];
}
