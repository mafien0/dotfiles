{moduleWithSystem, ...}: {
	flake.nixosModules.qt =
		moduleWithSystem (
			_: {
				qt = {
					enable = true;
					platformTheme = "qt5ct";
				};

				environment.sessionVariables = {
					QT_QPA_PLATFORM = "wayland";
					XCURSOR_THEME = "Bibata-Modern-Classic";
					XCURSOR_SIZE = "20";
				};

				home-manager.users.mafien0 = {config, ...}: {
					home.file.".config/qt6ct/qt6ct.conf".text = ''
						[Appearance]
						icon_theme=Colloid-Grey-Dark
						color_scheme_path=${config.home.homeDirectory}/.config/qt6ct/colors/noctalia.conf
						custom_palette=true
					'';
				};
			}
		);
}
