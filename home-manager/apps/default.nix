{pkgs, ...}: {
  home.packages = with pkgs; [
    qalculate-gtk
    thunar
    imv
    mousepad
    mpv
    pinta
    blockbench
  ];

  xdg.mimeApps.defaultApplications = {
    # Archives -> thunar
    "inode/directory" = "thunar.desktop";
    "application/gzip" = "thunar.desktop";
    "application/x-bzip2" = "thunar.desktop";
    "application/x-xz" = "thunar.desktop";
    "application/zstd" = "thunar.desktop";
    "application/zip" = "thunar.desktop";
    "application/x-tar" = "thunar.desktop";
    "application/x-7z-compressed" = "thunar.desktop";
    "application/x-rar" = "thunar.desktop";
    "application/x-brotli" = "thunar.desktop";
    "application/vnd.rar" = "thunar.desktop";

    # Images -> imv, edit in pinta
    "image/avif" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/bmp" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/gif" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/jpeg" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/png" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/svg+xml" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/tiff" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/webp" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/x-portable-pixmap" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/x-portable-graymap" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];
    "image/x-portable-bitmap" = ["imv.desktop" "com.github.PintaProject.Pinta.desktop"];

    # Text -> mousepad
    "text/plain" = "org.xfce.mousepad.desktop";
    "text/markdown" = "obsidian.desktop";
    "application/json" = "org.xfce.mousepad.desktop";
    "text/csv" = "org.xfce.mousepad.desktop";
    "text/xml" = "org.xfce.mousepad.desktop";
    "text/javascript" = "org.xfce.mousepad.desktop";
    "application/xml" = "org.xfce.mousepad.desktop";
    "text/x-c" = "org.xfce.mousepad.desktop";
    "text/x-c++" = "org.xfce.mousepad.desktop";
    "text/x-python" = "org.xfce.mousepad.desktop";
    "text/x-shellscript" = "org.xfce.mousepad.desktop";
    "text/x-rust" = "org.xfce.mousepad.desktop";
    "text/x-toml" = "org.xfce.mousepad.desktop";
    "text/x-yaml" = "org.xfce.mousepad.desktop";
    "text/x-nix" = "org.xfce.mousepad.desktop";

    # Video → mpv
    "video/mp4" = "mpv.desktop";
    "video/mpeg" = "mpv.desktop";
    "video/webm" = "mpv.desktop";
    "video/ogg" = "mpv.desktop";
    "video/x-matroska" = "mpv.desktop";
    "video/x-msvideo" = "mpv.desktop";
    "video/quicktime" = "mpv.desktop";
    "video/x-flv" = "mpv.desktop";
    "application/vnd.ms-asf" = "mpv.desktop";
    "application/x-matroska" = "mpv.desktop";
    "application/ogg" = "mpv.desktop";

    # Audio → mpv
    "audio/mpeg" = "mpv.desktop";
    "audio/ogg" = "mpv.desktop";
    "audio/wav" = "mpv.desktop";
    "audio/x-wav" = "mpv.desktop";
    "audio/flac" = "mpv.desktop";
    "audio/x-flac" = "mpv.desktop";
    "audio/aac" = "mpv.desktop";
    "audio/x-aac" = "mpv.desktop";
    "audio/x-m4a" = "mpv.desktop";
    "audio/x-matroska" = "mpv.desktop";
    "audio/webm" = "mpv.desktop";
    "audio/x-aiff" = "mpv.desktop";
    "audio/x-musepack" = "mpv.desktop";
    "audio/x-ape" = "mpv.desktop";
    "audio/opus" = "mpv.desktop";
    "audio/x-opus+ogg" = "mpv.desktop";

    # Torrents -> qbittorrent
    "application/x-bittorrent" = "qbittorrent.desktop";
    "x-scheme-handler/magnet" = "qbittorrent.desktop";
  };
}
