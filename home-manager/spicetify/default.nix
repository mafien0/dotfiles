{spicetifyExtensions, ...}: {
	stylix.targets.spicetify.enable = true;

	programs.spicetify = {
		enable = true;
		enabledExtensions = with spicetifyExtensions; [
			adblockify
			hidePodcasts
		];
		wayland = true;
		windowManagerPatch = true;
	};
}
