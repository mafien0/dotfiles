# MADE BY CLANKER
{pkgs}: let
  src = pkgs.lib.cleanSource ./.;
in
  pkgs.writeShellApplication {
    name = "screenshot";

    runtimeInputs = with pkgs; [
      quickshell
      grim
      # Crops the frozen frame down to the selected region.
      imagemagick
      wl-clipboard
      # notify-send, for the "screenshot saved" notification.
      libnotify
      bash
    ];

    text = ''exec ${src}/screenshot "$@"'';
  }
