#!/usr/bin/env bash

# Shell script to build system first
# Bc nix cant set cache stuff without a build

set -euo pipefail

SUBSTITUTERS="
https://nix-community.cachix.org
https://nvf.cachix.org
https://vic.cachix.org
https://spicetify-nix.cachix.org
https://helium-nix.cachix.org
https://noctalia.cachix.org
https://niri-epireyn.cachix.org
"

TRUSTED_PUBLIC_KEYS="
nix-community.cachix.org-1:mb9fsh9qf2dcimdsuo8zy7bkq5cx+/rkcwyvrcyg3fs=
nvf.cachix.org-1:gmqwiuhz6ux9d5cvffmwnc2nfruhtegaxrlvbxo+nai=
vic.cachix.org-1:1fqng1dxltgd47mbatr/iruyik+ttxdojoitpqfoxii=
spicetify-nix.cachix.org-1:jjnwulkvmdu0e5kgbbtgrisefddjtgsz4atkifzzn5i=
helium-nix.cachix.org-1:a8ypjt9o4gpyx0u3gjg/awpb14teu9arisg/moasfgw=
noctalia.cachix.org-1:pcor47nnmeo5thcxndtzwpoxnfqsbrgljzxwpp3dku4=
niri-epireyn.cachix.org-1:tlvyfn7ctsdt+zclps+ekfwet1x6x4oqvwqbbmyizfa=
"

sudo nixos-rebuild switch \
    --flake ".#$1)" \
    --option extra-substituters "$SUBSTITUTERS" \
    --option extra-trusted-public-keys "$TRUSTED_PUBLIC_KEYS"
