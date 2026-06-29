{ pkgs, lib }:
{
  settings = {
    environment = {
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      NIXOS_OZONE_WL = "1";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      QT_QPA_PLATFORMTHEME = "qt6ct";
      WINE_VK_VULKAN_ONLY = "1";
      _JAVA_AWT_WM_NONREPARENTING = "1";
      XCURSOR_THEME = "Bibata-Modern-Classic";
      XCURSOR_SIZE = "20";
      XCURSOR_PATH = lib.concatStringsSep ":" [
        "/run/current-system/sw/share/icons"
        "/nix/var/nix/profiles/default/share/icons"
        "/home/mafien0/.nix-profile/share/icons"
        "/home/mafien0/.local/share/icons"
        "/home/mafien0/.icons"
        "/usr/share/icons"
      ];
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
