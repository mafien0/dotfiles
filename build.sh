#!/usr/bin/env sh

# Im lazy and will not write this bs in nix "the right way"
sudo -v
nix flake update
nh os switch
nh home switch
