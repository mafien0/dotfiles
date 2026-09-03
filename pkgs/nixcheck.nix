{pkgs}:
pkgs.writeShellApplication {
  name = "nixcheck";

  runtimeInputs = with pkgs; [
    nixpkgs-lint-community
    alejandra
    statix
    deadnix
  ];

  text = ''
    echo "--- nixpkgs-lint ---"
    nixpkgs-lint "$1"
    echo "end"

    echo "--- alejandra check ---"
    alejandra -c -q "$1"
    echo "end"

    echo "--- statix check ---"
    statix check "$1"
    echo "end"

    echo "--- deadnix check ---"
    deadnix "$1"
    echo "end"
  '';
}
