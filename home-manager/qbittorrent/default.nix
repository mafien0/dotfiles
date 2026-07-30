{pkgs, ...}: {
  home.packages = [pkgs.qbittorrent];

  xdg.mimeApps.defaultApplications = {
    "application/x-bittorrent" = "qbittorrent.desktop";
    "x-scheme-handler/magnet" = "qbittorrent.desktop";
  };
}
