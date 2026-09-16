{inputs, ...}: {
  imports = [
    inputs.hosts.nixosModule
  ];

  networking.stevenBlackHosts = {
    enable = false;
    blockFakenews = true;
    blockGambling = true;
    blockPorn = true;
  };
}
