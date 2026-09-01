{pkgs, ...}: {
  hardware.uinput.enable = true;
  services.udev.packages = [
    pkgs.game-devices-udev-rules
  ];
  programs = {
    gamescope.enable = true;
    gamemode.enable = true;
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
      extraPackages = with pkgs; [
        pulseaudio
        bibata-cursors
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };
  };
}
