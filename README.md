<h1 id="header" align="center">
    <pre>Dotfiles</pre>
</h1>

- uses stable nixos(26.05)
- Styled with `stylix`
- Formatted with `alejandra`
- Checked with `deadnix`, `statix` and `nixpkgs-lint`

## Screenshots

<table>
    <tr>
        <td><img src="./pictures/01.png" alt="preview 1"></td>
        <td><img src="./pictures/02.png" alt="Preview 2"></td>
    </tr>
    <tr>
        <td><img src="./pictures/03.png" alt="Preview 3"></td>
        <td><img src="./pictures/04.png" alt="Preview 4"></td>
    </tr>
</table>

## Layout

```
flake.nix
install/            # not needed after first build
pkgs/               # exposed packages
hosts/desktop/      # per-system configuration
homeModules/        # shared modules(home-manager)
nixosModules/       # shared modules(nixos)
```
i try to put everything in home-manager first  
then if cannot i put it into nixos modules

## Install

1. Clone repo

```bash
git clone ssh://git@codeberg.org/mafien0/dotfiles.git ~/nix
```

2. if you is not `mafien0` (not cool, you should be), you need to change all my names to yours

```bash
sed -i 's/mafien0/<YOUR_USERNAME>/g' \
  flake.nix \
  homeModules/git/default.nix \
  homeModules/niri/env.nix \
  homeModules/nixcord/default.nix \
  homeModules/noctalia/settings.json \
  hosts/desktop/configuration.nix \
  hosts/desktop/hardware.nix \
  hosts/desktop/home.nix \
  nixosModules/ssh/default.nix
```

3. run builder script:

> you need to cd into directory with `flake.nix`

```bash
./install/firstbuild.sh desktop
```

4. Reboot
