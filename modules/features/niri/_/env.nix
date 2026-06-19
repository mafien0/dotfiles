{ pkgs, lib }:
{
  settings = {
    environment = {
      ELECTRON_OZONE_PLATFORM_HINT = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      QT_QPA_PLATFORM = "wayland";
      WINE_VK_VULKAN_ONLY = "1";
      XDG_SESSION_TYPE = "wayland";
    };
  };
}
