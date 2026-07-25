{
	programs.niri.settings."window-rules" = [
		{
			matches = [{title = "^Picture-in-Picture$";}];
			draw-border-with-background = false;
			focus-ring.enable = false;
			shadow.enable = false;
			geometry-corner-radius = {
				top-left = 0.0;
				top-right = 0.0;
				bottom-right = 0.0;
				bottom-left = 0.0;
			};
			open-floating = true;
		}

		{
			matches = [{app-id = "^qalculate-gtk$";}];
			open-floating = true;
			default-column-width = {fixed = 794;};
			default-window-height = {fixed = 554;};
		}

		{
			matches = [
				{title = "terminal-popup";}
				{app-id = "popup";}
				{app-id = "waypaper";}
				{app-id = "^[Tt]hunar$";}
				{app-id = "^imv$";}
				{app-id = "^org\\.xfce\\.mousepad$";}
				{app-id = "modrinth-app.*";}
				{app-id = "Bitwarden";}
				{app-id = "ninjabrainbot.*";}
				{app-id = "^.*\\.satty$";}
				{app-id = "^.*\\.Celluloid$";}
				{app-id = "^.*\\.pwvucontrol$";}
				{app-id = "^.*\\.MissionCenter$";}
				{app-id = "^.*\\.Warehouse$";}
				{app-id = "^.*\\.Flatseal$";}
				{app-id = "^.*\\.devtoolbox$";}
				{app-id = "^.*\\.Bazaar$";}
				{app-id = "^.*\\.spider$";}
				{title = "[Ss]ave [Ff]ile";}
			];
			open-floating = true;
			default-window-height = {proportion = 0.8;};
			default-column-width = {proportion = 0.8;};
		}

		{
			matches = [{app-id = "org.gnome.*";}];
			open-floating = true;
		}

		{
			matches = [{title = "Welcome to.*";}];
			open-floating = true;
		}

		{
			matches = [
				{app-id = "org.telegram.desktop";}
				{app-id = "com.rtosta.zapzap";}
				{app-id = "Spotify";}
			];
			block-out-from = "screencast";
		}

		# full opacity
		{
			matches = [
				{app-id = "(?i)^helium$";}
				{app-id = "(?i).*steam.*";}
				{app-id = "(?i).*minecraft.*";}
			];
			opacity = 1.0;
		}
	];

	programs.niri.settings."layer-rules" = [
		{
			matches = [
				{namespace = "^noctalia-overview.*$";}
			];
			place-within-backdrop = true;
		}
		{
			matches = [
				{namespace = "^noctalia-(background|launcher-overlay|dock)-.*$";}
			];
			background-effect.xray = false;
		}
	];
}
