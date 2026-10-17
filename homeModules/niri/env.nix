{
  config,
  lib,
  ...
}: let
  home = config.home.homeDirectory;
in {
  programs.niri.settings = {
    environment = {
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      WINE_VK_VULKAN_ONLY = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      GTK_THEME = "adw-gtk3";
      SSH_AUTH_SOCK = "/run/user/1000/ssh-agent";
      XDG_DATA_DIRS = lib.concatStringsSep ":" [
        "/run/current-system/sw/share"
        "/nix/var/nix/profiles/default/share"
        "${home}/.nix-profile/share"
        "${home}/.local/share"
        "/usr/local/share"
        "/usr/share"
      ];
      XCURSOR_PATH = lib.concatStringsSep ":" [
        "/run/current-system/sw/share/icons"
        "/nix/var/nix/profiles/default/share/icons"
        "${home}/.nix-profile/share/icons"
        "${home}/.local/share/icons"
        "${home}/.icons"
        "/usr/share/icons"
      ];
    };
  };
}
