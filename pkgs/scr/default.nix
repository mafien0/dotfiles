# MADE BY CLANKER
{pkgs}: let
  src = pkgs.lib.cleanSource ./.;
in
  pkgs.writeShellApplication {
    name = "screenshot";

    runtimeInputs = with pkgs; [
      quickshell
      grim
      wl-clipboard
      bash
    ];

    text = ''exec ${src}/screenshot "$@"'';
  }
