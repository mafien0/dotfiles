{
  pkgs,
  lib,
  config,
  inputs,
  system,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    package = null; # /nixosModules/hyprland
    portalPackage = null; # /nixosModules/hyprland
    configType = "lua";
    extraLuaFiles = {
      "nix" = {
        autoLoad = false;
        content = ''
          return {
            ipc = "${lib.getExe inputs.noctalia-shell.packages.${system}.default} ipc --any-display call",
            noctalia = "${lib.getExe inputs.noctalia-shell.packages.${system}.default}",
            terminal = "${lib.getExe pkgs.foot}",
            screenshot = "${lib.getExe (import ../../pkgs/scr {inherit pkgs;})}",
            fileManager = "${lib.getExe pkgs.thunar}",
            hyprpicker = "${lib.getExe pkgs.hyprpicker}",
            wlClipPersist = "${lib.getExe pkgs.wl-clip-persist}",
            wlPaste = "${lib.getExe' pkgs.wl-clipboard "wl-paste"}",
            cliphist = "${lib.getExe pkgs.cliphist}",
            wpctl = "${lib.getExe' pkgs.wireplumber "wpctl"}",
            playerctl = "${lib.getExe pkgs.playerctl}",
            brightnessctl = "${lib.getExe pkgs.brightnessctl}",
            polkitAgent = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1",

            borderSize = ${toString config.common.borderSize},
            gaps = ${toString config.common.gaps},
            opacity = ${toString config.common.opacity},
            cursorTheme = "${config.common.cursor.name}",
            cursorSize = "${toString config.common.cursor.size}",
          }
        '';
      };

      "00-config" = ./config.lua;
      "10-input" = ./input.lua;
      "20-style" = ./style.lua;
      "30-windowrules" = ./windowrules.lua;

      "40-env".content = ''
        hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
        hl.env("NIXOS_OZONE_WL", "1")
        hl.env("MOZ_ENABLE_WAYLAND", "1")
        hl.env("WINE_VK_VULKAN_ONLY", "1")
        hl.env("_JAVA_AWT_WM_NONREPARENTING", "1")
        hl.env("GTK_THEME", "adw-gtk3")
        hl.env("SSH_AUTH_SOCK", "/run/user/1000/ssh-agent")
        hl.env("XDG_DATA_DIRS", "${lib.concatStringsSep ":" [
          "/run/current-system/sw/share"
          "/nix/var/nix/profiles/default/share"
          "${config.home.homeDirectory}/.nix-profile/share"
          "${config.home.homeDirectory}/.local/share"
          "/usr/local/share"
          "/usr/share"
        ]}")
        hl.env("XCURSOR_PATH", "${lib.concatStringsSep ":" [
          "/run/current-system/sw/share/icons"
          "/nix/var/nix/profiles/default/share/icons"
          "${config.home.homeDirectory}/.nix-profile/share/icons"
          "${config.home.homeDirectory}/.local/share/icons"
          "${config.home.homeDirectory}/.icons"
          "/usr/share/icons"
        ]}")
      '';
    };
  };

  stylix.targets.hyprland.enable = true;
}
