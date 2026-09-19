# MADE BY AI
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

    run "nixpkgs-lint" nixpkgs-lint "''${targets[@]}"
    run "alejandra check" alejandra -c -q "''${targets[@]}"
    run "statix check" statix check "''${targets[@]}"
    run "deadnix check" deadnix "''${targets[@]}"

    exit "$status"
  '';
}
