{
  moduleWithSystem,
  ...
}: {
  flake.nixosModules.pipewire = moduleWithSystem (
    { ... }: { pkgs, ... }: {
      services.pipewire = {
        enable = true;
        pulse.enable = true;
        wireplumber.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
      };

      environment.systemPackages = with pkgs; [
        pulseaudio
        wireplumber
      ];
    }
  );
}
