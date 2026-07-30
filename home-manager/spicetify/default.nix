{
  spicetifyExtensions,
  inputs,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

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
