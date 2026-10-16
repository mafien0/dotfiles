# MADE BY CLANKER
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

    echo "targets: ''${targets[*]}"
    echo "fixers:  statix fix, deadnix -e, alejandra"

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

    run "statix fix" statix fix "''${targets[@]}"
    run "deadnix edit" deadnix -e "''${targets[@]}"
    run "alejandra format" alejandra -q "''${targets[@]}"

    echo
    echo "passed: ''${passed[*]}"
    if [ "$status" -eq 0 ]; then
      echo "result: all formatters passed"
    else
      echo "failed: ''${failed[*]}"
      exit "$status"
    fi
  '';
}
