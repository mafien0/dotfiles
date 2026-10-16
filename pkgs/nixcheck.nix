# MADE BY CLANKER
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

    echo "targets: ''${targets[*]}"
    echo "checks:  nixpkgs-lint, alejandra -c, statix check, deadnix"

    status=0
    failed=()
    passed=()

    run() {
      local name="$1"
      shift
      echo
      echo "--- $name ---"
      printf '+'
      printf ' %q' "$@"
      echo
      "$@"
      local code=$?
      if [ "$code" -eq 0 ]; then
        echo "ok: $name"
        passed+=("$name")
      else
        echo "fail: $name (exit $code)"
        failed+=("$name")
        status=$code
      fi
      echo "--- end $name ---"
    }

    run "nixpkgs-lint" nixpkgs-lint "''${targets[@]}"
    run "alejandra check" alejandra -c -q "''${targets[@]}"
    run "statix check" statix check "''${targets[@]}"
    run "deadnix check" deadnix "''${targets[@]}"

    echo
    echo "passed: ''${passed[*]}"
    if [ "$status" -eq 0 ]; then
      echo "result: all checks passed"
    else
      echo "failed: ''${failed[*]}"
      exit "$status"
    fi
  '';
}
