{
  inputs,
  system,
  ...
}: {
  imports = [
    inputs.spicetify-nix.homeManagerModules.spicetify
  ];

  stylix.targets.spicetify.enable = true;

  programs.spicetify = {
    enable = true;
    enabledExtensions = with inputs.spicetify-nix.legacyPackages.${system}.extensions; [
      adblockify
      hidePodcasts
      aiBandBlocker
    ];
    wayland = true;
    windowManagerPatch = true;
  };
}
