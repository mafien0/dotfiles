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
hosts/*/            # per-system configuration
homeModules/        # shared modules(home-manager)
nixosModules/       # shared modules(nixos)
```
i try to put everything in home-manager first  
then if cannot i put it into nixos modules

## Install
You really shouldn't install this as your system configuration  
These dotfiles are heavily personalized for my system, configuration, choice and taste  
But you can use it as an example(not that these are good dotfiles)  
