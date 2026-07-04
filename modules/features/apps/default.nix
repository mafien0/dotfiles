{
  moduleWithSystem,
  ...
}:
{
  flake.nixosModules.apps = moduleWithSystem (
    _: { pkgs, ... }: {
      services = {
        gvfs.enable = true;
        udisks2.enable = true;
        gnome.gcr-ssh-agent.enable = false;
      };
      programs.ssh.startAgent = true;
      security.polkit.enable = true;

      environment.systemPackages = with pkgs; [
        nautilus
        gnome-calculator
        celluloid
        loupe
        gnome-text-editor
      ];

      xdg.mime.enable = true;

      xdg.mime.defaultApplications = {
        # Nautilus — file manager
        "inode/directory" = "org.gnome.Nautilus.desktop";

        # Loupe — image viewer
        "image/avif" = "org.gnome.Loupe.desktop";
        "image/bmp" = "org.gnome.Loupe.desktop";
        "image/gif" = "org.gnome.Loupe.desktop";
        "image/jpeg" = "org.gnome.Loupe.desktop";
        "image/png" = "org.gnome.Loupe.desktop";
        "image/svg+xml" = "org.gnome.Loupe.desktop";
        "image/tiff" = "org.gnome.Loupe.desktop";
        "image/webp" = "org.gnome.Loupe.desktop";

        # Celluloid — video player
        "video/mp4" = "io.github.celluloid_player.Celluloid.desktop";
        "video/mpeg" = "io.github.celluloid_player.Celluloid.desktop";
        "video/webm" = "io.github.celluloid_player.Celluloid.desktop";
        "video/ogg" = "io.github.celluloid_player.Celluloid.desktop";
        "video/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
        "video/x-msvideo" = "io.github.celluloid_player.Celluloid.desktop";
        "video/quicktime" = "io.github.celluloid_player.Celluloid.desktop";
        "video/x-flv" = "io.github.celluloid_player.Celluloid.desktop";
        "application/vnd.ms-asf" = "io.github.celluloid_player.Celluloid.desktop";
        "application/x-matroska" = "io.github.celluloid_player.Celluloid.desktop";
        "application/ogg" = "io.github.celluloid_player.Celluloid.desktop";

        # GNOME Text Editor
        "text/plain" = "org.gnome.TextEditor.desktop";
        "text/markdown" = "org.gnome.TextEditor.desktop";
        "application/json" = "org.gnome.TextEditor.desktop";
        "text/csv" = "org.gnome.TextEditor.desktop";
        "text/xml" = "org.gnome.TextEditor.desktop";
        "text/javascript" = "org.gnome.TextEditor.desktop";
        "application/xml" = "org.gnome.TextEditor.desktop";
        "text/x-c" = "org.gnome.TextEditor.desktop";
        "text/x-c++" = "org.gnome.TextEditor.desktop";
        "text/x-python" = "org.gnome.TextEditor.desktop";
        "text/x-shellscript" = "org.gnome.TextEditor.desktop";
        "text/x-rust" = "org.gnome.TextEditor.desktop";
        "text/x-toml" = "org.gnome.TextEditor.desktop";
        "text/x-yaml" = "org.gnome.TextEditor.desktop";
        "text/x-nix" = "org.gnome.TextEditor.desktop";
      };
    }
  );
}
