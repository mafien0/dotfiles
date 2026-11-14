## `MADE BY CLANKER` comment

Use the `MADE BY CLANKER` comment for **big changes**: writing a full module,
rewriting/refactoring an existing module, or otherwise adding a large chunk of
new code.

- Full module write/rewrite: put `# MADE BY CLANKER` at the very top of the file.
- Large change inside an existing file: put `# MADE BY CLANKER` right above the change.

Do **not** add it for small changes. One-liners, a few added/removed options,
typo fixes, config tweaks, and other minor edits get no comment.

## Tools

- Check code with `nixcheck <dir>` (default `.`): runs `nixpkgs-lint`,
  `alejandra -c`, `statix check`, `deadnix`.
- Format with `nixformat <dir>`: runs `statix fix`, `deadnix -e`, `alejandra`.
- Check flake with `flint` inside a flake dir (CI uses
  `--fail-if-multiple-versions`).

All of these are available in your PATH. The `justfile` wraps the common flows:
`just format`, `just test` (nixcheck + `nix flake check`), `just flint`,
`just generate-iso`. A `devShell` provides `just`.

## Edits

- Do not write into the project unless I specifically tell you to.
- Do not write large comments that explain nothing.
- When you change how this repository is organized or configured, update this
  `AGENTS.md` to match.

## Repository

NixOS + home-manager dotfiles, flake-based.

- Two hosts: `ataraxia` (main machine) and `iso` (installer image).
- Single arch: `x86_64-linux`, nixpkgs on `nixos-unstable`, `stateVersion = "26.11"`.
- Styling via `stylix`, formatter `alejandra`.
- `specialArgs` (`inputs`, `system`, `flakePath`) are reachable in every module.

Where things go:

- `hosts/<name>/` — per-machine config. `configuration.nix` imports the NixOS
  modules; `home.nix` imports the home-manager modules.
- `homeModules/<name>/` — home-manager modules. Default place for program config.
- `nixosModules/<name>/` — NixOS (system) modules. Only when home-manager
  cannot do it.
- `pkgs/` — custom packages, exposed as `packages.x86_64-linux`.
- `assets/` — images, wallpapers.

Rule: try home-manager first, fall back to a NixOS module only when necessary.

To add a module: create `homeModules/<name>/default.nix` (or
`nixosModules/<name>/default.nix`), then add its name to the list in the
matching host file (`hosts/ataraxia/home.nix` or `configuration.nix`).

### home-manager

home-manager runs as a NixOS module, not standalone. In
`hosts/ataraxia/configuration.nix`:

- `imports` pulls in `inputs.home-manager.nixosModules.home-manager`.
- The `home-manager` option configures it:
  - `useGlobalPkgs = true` — reuse the system nixpkgs.
  - `backupFileExtension = "bak"` — conflicted files get `.bak`.
  - `users.mafien0.imports = [./home.nix]` — the entry point for the home
    config; `home.nix` maps over the `homeModules` list.
  - `extraSpecialArgs = { inherit inputs system flakePath; }` — extra args
    passed to home-manager modules.

The `iso` host does not use home-manager; it imports
`nixosModules/nix` directly with `nixSettings.extraOptions = false`.

## How things work

Config lives in home-manager module options; big configs are split into
sub-files imported from the module's `default.nix`.

- **theme** — `theme/common.nix` declares the shared `common` option
  (`cornerRadius`, `borderSize`, `gaps`, opacities, `blur`, `colors` base16
  palette, `cursor`, `fonts`) that other modules read via `config.common`.
  `theme/default.nix` imports `common.nix` + `stylix.nix` + `icons.nix`, enables
  the pointer cursor, and opts gtk/qt into stylix. Icons (Papirus) live in
  `theme/icons.nix`.
- **stylix** — `theme/stylix.nix` imports `inputs.stylix.homeModules.stylix`
  and sets `base16Scheme = config.common.colors`, `image` (a
  `assets/wallpapers/*`), `cursor`/`fonts` from `config.common`.
  `autoEnable = false`, so targets opt in explicitly via `stylix.targets.*`.
- **neovim** — `programs.neovim`. Plugins come from nixpkgs `vimPlugins`, each
  with a `config` written as Lua via `toLuaFile ./plugins/<name>.lua`.
  `initLua` loads `options.lua` + `autocmds.lua`. LSP servers/formatters go in
  `extraPackages`. Plugin config lives in `plugins/*.lua`.
- **hyprland** — split in two. `nixosModules/hyprland` enables
  `programs.hyprland` system-wide plus xdg portals. `homeModules/hyprland`
  holds user settings via `wayland.windowManager.hyprland` with
  `configType = "lua"` and `package`/`portalPackage = null` (system provides
  them). `extraLuaFiles` generates `nix.lua` (exec paths for `inputs.dms` and
  friends) plus `common.*` style values from `config.common`, and `40-env`
  (`hl.env` vars); the Hyprland lua API is the global `hl`. Config files load
  in `00-config`, `10-input`, `20-style`, `30-windowrules` order.
  Check changes with `Hyprland --verify-config -c <generated>/hyprland.lua`.
- **ai** — installs `llm-agents.opencode2` + `mcp-nixos` (plus `rg`/`fd`/`python3`),
  writes `~/.config/opencode/AGENTS.md` from the inline rules + `caveman.md` +
  `judge.md`, and sets `~/.config/opencode/opencode.json` (updates disabled) +
  `cli.json` (theme `system`).
- **dms** — `programs.dank-material-shell` from `inputs.dms`, with settings
  split into `dms/config.nix` + `dms/idle.nix`; theming via
  `stylix.targets.dank-material-shell`. `nixosModules/dms-greeter` wires the
  `dux-greeter` login manager (hyprland compositor).

## Patterns

- **Module args** — modules destructure only what they need from
  `{ pkgs, lib, config, inputs, system, ... }`. `inputs`, `system`,
  `flakePath` come from `specialArgs` in `flake.nix`.
- **No-arg modules** — never write `_: {}`; always use plain `{}`.
- **One module per dir** — `homeModules/<name>/default.nix` /
  `nixosModules/<name>/default.nix`. Big configs split into sub-files
  imported from `default.nix` (e.g. `hyprland/*.lua`, `neovim/plugins/*.lua`,
  `theme/stylix.nix`).
- **External flakes** — import modules via
  `imports = [ inputs.<flake>.<homeModules|nixosModules|homeManagerModules>.<name> ]`;
  packages via `inputs.<flake>.packages.${system}.<pkg>`.
- **stylix target** — theme a program with
  `stylix.targets.<program>.enable = true;`.
- **Program config** — native options first (`programs.<name>.settings`);
  raw text via `initContent`/`extraConfig` only when no option exists.
- **Executables** — reference with `lib.getExe pkgs.<pkg>`
  (`lib.getExe'` for a non-default bin), never hardcode paths.
- **Aliases** — `home.shellAliases` or `programs.zsh.shellAliases`.
- **Ad-hoc scripts/config** — `pkgs.writeShellScriptBin` /
  `pkgs.writeText`, placed via `home.packages` / `xdg.configFile`.
- **Custom options** — home-manager options via
  `options.<ns>.<name> = lib.mkOption {...}` (see `theme/common.nix`);
  NixOS options via `options.<ns>.<name>`
  (see `nixosModules/nix`), consumed across hosts.
- **Host wiring** — host file lists module names, then
  `map (m: ../../<kind>Modules/${m})`; `configuration.nix` imports
  `hardware.nix` / `programs.nix` / `disko.nix`.
- **Flake inputs** — pin with `follows` to dedupe nixpkgs; shared inputs
  carry a `# shared by:` comment. `flint --fail-if-multiple-versions` enforces
  no duplicate versions (e.g. `dux-greeter` follows `dms/dank-qml-common`).

## Structure

```plaintext
./
├──  .github/
│   └──  workflows/
│       ├──  flake.yml
│       └──  nixcheck.yml
├──  assets/
│   ├──  mcsr/
│   │   └──  measuring_overlay.png
│   ├──  readme/
│   │   ├──  01.png
│   │   ├──  02.png
│   │   ├──  03.png
│   │   └──  04.png
│   └──  wallpapers/
│       ├──  gruv-abstract-maze.png
│       ├──  gruvbox_city.png
│       ├──  gruvbox_image46.png
│       └──  v1.png
├──  homeModules/
│   ├──  ai/
│   │   ├── 󰂺 caveman.md
│   │   ├──  default.nix
│   │   └── 󰂺 judge.md
│   ├──  apps/
│   │   └──  default.nix
│   ├──  btop/
│   │   └──  default.nix
│   ├──  direnv/
│   │   └──  default.nix
│   ├──  dms/
│   │   ├──  config.nix
│   │   ├──  idle.nix
│   │   └──  default.nix
│   ├──  eza/
│   │   └──  default.nix
│   ├──  flint/
│   │   └──  default.nix
│   ├──  foot/
│   │   └──  default.nix
│   ├──  git/
│   │   └──  default.nix
│   ├──  helium/
│   │   └──  default.nix
│   ├──  hyprland/
│   │   ├──  .luarc.json
│   │   ├── 󰄠 config.lua
│   │   ├──  default.nix
│   │   ├── 󰄠 input.lua
│   │   ├── 󰄠 style.lua
│   │   └── 󰄠 windowrules.lua
│   ├──  hyprtoolkit/
│   │   └──  default.nix
│   ├──  mcsr/
│   │   ├──  default.nix
│   │   └──  init.lua
│   ├──  mfetch/
│   │   └──  default.nix
│   ├──  neovim/
│   │   ├──  plugins/
│   │   │   ├──  cmp.lua
│   │   │   ├──  colorscheme.lua
│   │   │   ├──  conform.lua
│   │   │   ├──  flash.lua
│   │   │   ├──  git.lua
│   │   │   ├──  glance.lua
│   │   │   ├──  lsp.lua
│   │   │   ├──  markdown.lua
│   │   │   ├──  mini.lua
│   │   │   ├──  oil.lua
│   │   │   ├──  snacks.lua
│   │   │   ├──  tabby.lua
│   │   │   ├──  telescope.lua
│   │   │   ├──  tiny-inline-diagnostic.lua
│   │   │   ├──  treesitter.lua
│   │   │   └──  whichkey.lua
│   │   ├──  autocmds.lua
│   │   ├──  default.nix
│   │   └──  options.lua
│   ├──  nixcord/
│   │   └──  default.nix
│   ├──  nixtools/
│   │   └──  default.nix
│   ├──  prismlauncher/
│   │   └──  default.nix
│   ├──  qbittorrent/
│   │   └──  default.nix
│   ├──  spicetify/
│   │   └──  default.nix
│   ├──  theme/
│   │   ├──  common.nix
│   │   ├──  default.nix
│   │   ├──  icons.nix
│   │   └──  stylix.nix
│   ├──  tmux/
│   │   └──  default.nix
│   ├──  yazi/
│   │   └──  default.nix
│   └──  zsh/
│       ├──  default.nix
│       ├──  starship.nix
│       └──  starship.toml
├──  hosts/
│   ├──  ataraxia/
│   │   ├──  configuration.nix
│   │   ├──  disko.nix
│   │   ├──  hardware.nix
│   │   ├──  home.nix
│   │   └──  programs.nix
│   └──  iso/
│       └──  configuration.nix
├──  nixosModules/
│   ├──  avahi/
│   │   └──  default.nix
│   ├──  ddc/
│   │   └──  default.nix
│   ├──  dms-greeter/
│   │   └──  default.nix
│   ├──  docker/
│   │   └──  default.nix
│   ├──  gvfs/
│   │   └──  default.nix
│   ├──  hyprland/
│   │   └──  default.nix
│   ├──  localsend/
│   │   └──  default.nix
│   ├──  nh/
│   │   └──  default.nix
│   ├──  nix/
│   │   └──  default.nix
│   ├──  nix-index/
│   │   └──  default.nix
│   ├──  nix-ld/
│   │   └──  default.nix
│   ├──  nvidia/
│   │   └──  default.nix
│   ├──  obs-studio/
│   │   └──  default.nix
│   ├──  pipewire/
│   │   └──  default.nix
│   ├── 󰢬 ssh/
│   │   └──  default.nix
│   ├──  steam/
│   │   └──  default.nix
│   ├──  tailscale/
│   │   └──  default.nix
│   └──  thunar/
│       └──  default.nix
├──  pkgs/
│   ├──  nixcheck.nix
│   └──  nixformat.nix
├──  .envrc
├──  .gitignore
├── 󰂺 AGENTS.md
├──  flake.lock
├──  flake.nix
├── 󰂺 justfile
├── 󰂺 LICENSE
└── 󰂺 README.md
```
