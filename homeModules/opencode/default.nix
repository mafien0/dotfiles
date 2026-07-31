{pkgs, ...}: {
  home.packages = with pkgs; [
    opencode
    mcp-nixos
  ];
}
