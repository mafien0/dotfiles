#!/usr/bin/env bash

# Disko partitioning
# I dont want to pull out phone to check out command

set -euo pipefail

sudo nix --experimental-features "nix-command flakes" \
  run github:nix-community/disko/latest -- \
  --mode destroy,format,mount "$(dirname "$0")/../hosts/$1/disko.nix"
