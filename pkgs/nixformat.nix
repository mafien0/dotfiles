{pkgs}:
pkgs.writeShellApplication {
  name = "nixformat";

  runtimeInputs = with pkgs; [
    alejandra
    statix
    deadnix
  ];

  text = ''
    echo "--- alejandra format ---"
    alejandra -q "$1"
    echo "end"

    echo "--- statix fix ---"
    statix fix "$1"
    echo "end"

    echo "--- deadnix edit ---"
    deadnix -e "$1"
    echo "end"
  '';
}
