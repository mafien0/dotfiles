{moduleWithSystem, ...}: let
	mkMyIconTheme = pkgs:
		(pkgs.colloid-icon-theme.override {colorVariants = ["grey"];}).overrideAttrs (old: {
				postInstall =
					(old.postInstall or "")
					+ ''
						for theme in "$out/share/icons/"*/index.theme; do
						  substituteInPlace "$theme" \
						    --replace-fail "Inherits=hicolor,breeze" "Inherits=Papirus-Dark,Papirus,hicolor,breeze"
						done
					'';
			});
in {
	flake.nixosModules.gtk =
		moduleWithSystem (
			_: {
				pkgs,
				lib,
				...
			}: let
				myIconTheme = mkMyIconTheme pkgs;
			in {
				programs.dconf.enable = true;

				environment = {
					systemPackages = with pkgs; [
						adw-gtk3
						bibata-cursors
						myIconTheme
						papirus-icon-theme
						glib
						gsettings-desktop-schemas
					];

					sessionVariables = {
						GSETTINGS_SCHEMA_DIR = "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/gsettings-desktop-schemas-${lib.getVersion pkgs.gsettings-desktop-schemas}/glib-2.0/schemas";
					};

					variables = {
						XCURSOR_THEME = "Bibata-Modern-Classic";
						XCURSOR_SIZE = "20";
						XCURSOR_PATH = lib.mkForce "$HOME/.nix-profile/share/icons:$HOME/.icons:$HOME/.local/share/icons:/run/current-system/sw/share/icons:/usr/share/icons";
					};
				};
			}
		);

	flake.homeManagerModules.gtk = {pkgs, ...}: let
		myIconTheme = mkMyIconTheme pkgs;
	in {
		gtk = {
			enable = true;
			theme = {
				name = "adw-gtk3";
				package = pkgs.adw-gtk3;
			};
			iconTheme = {
				name = "Colloid-Grey-Dark";
				package = myIconTheme;
			};
			cursorTheme = {
				name = "Bibata-Modern-Classic";
				package = pkgs.bibata-cursors;
			};
		};

		home.file.".config/gtk-4.0/gtk.css".text = ''
			@import url("noctalia.css");
		'';

		home.file.".icons/default/index.theme".text = ''
			[Icon Theme]
			Inherits=Bibata-Modern-Classic
		'';

		dconf = {
			enable = true;
			settings."org/gnome/desktop/interface" = {
				"gtk-theme" = "adw-gtk3";
				"color-scheme" = "prefer-dark";
			};
		};
	};
}
