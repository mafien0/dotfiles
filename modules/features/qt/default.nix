{
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.qt = moduleWithSystem (
    { ... }: { pkgs, ... }: {
      environment.systemPackages = with pkgs; [
        qt6Packages.qt6ct
        qt6Packages.qtwayland
        libsForQt5.qt5ct
        libsForQt5.qtwayland
      ];

      environment.sessionVariables = {
        QT_QPA_PLATFORMTHEME = "qt6ct";
      };

      home-manager.users.mafien0 = { config, ... }: {
        home.file.".config/qt6ct/qt6ct.conf".text = ''
          [Appearance]
          color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
          custom_palette=true
        '';
      };
    }
  );
}
