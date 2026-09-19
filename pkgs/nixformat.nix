# MADE BY AI
{pkgs}:
pkgs.writeShellApplication {
  name = "nixformat";

  runtimeInputs = with pkgs; [
    alejandra
    statix
    deadnix
  ];

  text = ''
    set +e

    targets=("$@")
    if [ ''${#targets[@]} -eq 0 ]; then
      targets=(".")
    fi

    status=0
    run() {
      local name="$1"
      shift
      echo "--- $name ---"
      "$@"
      local code=$?
      [ "$code" -eq 0 ] || status=$code
      echo "end"
    }

    run "statix fix" statix fix "''${targets[@]}"
    run "deadnix edit" deadnix -e "''${targets[@]}"
    run "alejandra format" alejandra -q "''${targets[@]}"

    exit "$status"
  '';
}
