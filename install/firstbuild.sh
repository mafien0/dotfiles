#!/usr/bin/env bash

# Shell script to build system first
# Bc nix cant set cache stuff without a build

set -euo pipefail

SUBSTITUTERS="
https://nix-community.cachix.org
https://vic.cachix.org
https://spicetify-nix.cachix.org
https://helium-nix.cachix.org
https://noctalia.cachix.org
https://niri-epireyn.cachix.org
"

TRUSTED_PUBLIC_KEYS="
nix-community.cachix-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=
vic.cachix.org-1:1fQNG1DxLTGd47MBAtr/IrUYIk+TTXDojOItpqFoxII=
spicetify-nix.cachix.org-1:jjnwULkvMdu0E5KGBbtgrISEfDdJTGSZ4ATkiFzZn5I=
helium-nix.cachix.org-1:a8YPjt9O4GPyX0u3gjg/aWpb14teU9aRiSG/MOaSFgw=
noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=
niri-epireyn.cachix.org-1:tlVyFN7CtsDT+ZcLPS+ekFWeT1X6X4OqvWqbBMyIzFA=
"

sudo nixos-rebuild switch \
    --flake ".#$1" \
    --extra-experimental-features 'nix-command flakes' \
    --option extra-substituters "$SUBSTITUTERS" \
    --option extra-trusted-public-keys "$TRUSTED_PUBLIC_KEYS"
