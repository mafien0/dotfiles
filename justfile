default:
    @just --list

format:
    nixformat .

test:
    nixcheck .
    nix flake check

flint:
    nix run github:NotAShelf/flint -- --fail-if-multiple-versions

generate-iso:
    rm -rf iso
    nix build .#nixosConfigurations.iso.config.system.build.isoImage
    mkdir -p iso
    mv -v result/iso/*.iso iso/
