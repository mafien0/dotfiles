# Nix dotfiles

- uses stable nixos(26.05)
- Styled with `stylix`
- Formatted with `alejandra`
- Checked with `deadnix`, `statix` and `nixpkgs-lint`

## Install

1. Clone repo

```bash
git clone ssh://git@codeberg.org/mafien0/dotfiles.git ~/nix
```

2. if you is not `mafien0` (not cool, you should be), you need to change all my names to yours

```bash
sed -i 's/mafien0/<YOUR_USERNAME>/g' \
  flake.nix \
  home-manager/home.nix \
  home-manager/git/default.nix \
  home-manager/nixcord/default.nix \
  home-manager/niri/env.nix \
  home-manager/noctalia/settings.json \
  nixos/configuration.nix \
  nixos/hardware.nix \
  nixos/programs.nix
```


3. run installer script:

> you need to cd into directory with `flake.nix`

```bash
nix --extra-experimental-features 'nix-command flakes' run .#build -- -foh
```

i eat goo
