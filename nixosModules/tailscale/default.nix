{
  services = {
    tailscale = {
      enable = true;
      openFirewall = true;
    };
    resolved.enable = true;
  };
}
