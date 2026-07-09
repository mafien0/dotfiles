# NixOS Configuration — Agent Guide

I included AGENTS.md into repo for purpose

## Overview

Personal **NixOS flake** for host `desktop` (user `mafien0`). Modular architecture using **flake-parts**, **import-tree** for auto-discovery. CLI tools use **nix-wrapper-modules** for baked-in configs. Neovim uses **nvf** for declarative configuration. Uses **home-manager** for user-level state.

## Workflow

- **Follow this project's structure** — all modules go in `modules/features/<name>/` — CLI wrappers, system services, and plain programs alike
- **Test with `nix build`** before considering a task done
- **Always Format all Nix code with `nixfmt`**
- **Always Search for the dead code with `deadnix`** (`deadnix -q **/*.nix`) and fix it
- **Always Check for anti-patterns with `statix`** (`statix check .`) and fix it
- **When editing configuration update** `AGENTS.md`
- **Don't make things up** — consult docs first, especially <https://birdeehub.github.io/nix-wrapper-modules/>, use `nix-locate` or `nix search` to find packages; for nvf see <https://nvf.notashelf.dev/options.html>
- **Don't take shortcuts** — follow Nix standards and idioms
- **nvf `luaConfigRC` resolves `require()` at build time** — nvf inlines Lua modules found via `additionalRuntimePaths` into the store path. Use `dofile` + `vim.api.nvim_get_runtime_file` instead of `require` for anything that must be loaded dynamically at runtime (e.g., noctalia-generated matugen.lua).
- **`noctalia-shell` `user-templates` must use `templates` wrapper** — format is `user-templates = { templates = { myName = { input_path = "..."; output_path = "..."; post_hook = "..."; }; }; };` (not `{ myName = ...; }` directly), because attributes are converted to TOML and noctalia-shell reads them under `[templates.*]`
- **Use `lib.getExe`** instead of hardcoded `${pkgs.pkg}/bin/` paths to reference binaries
- **Use `moduleWithSystem`** pattern for all feature modules that need both NixOS module + package exports

## Project Layout

```
flake.nix                    # 36-line entry point — delegates to modules/
modules/
  parts.nix                  # Supported systems
  hosts/desktop/
    default.nix              # nixosConfigurations.desktop definition
    configuration.nix        # Main system module (imports 20 features)
    disko.nix                # Disko partition layout (1GB boot, 4GB swap, rest ext4)
    hardware.nix             # Boot modules, CPU microcode, NVIDIA
    home-manager.nix         # Home-manager NixOS activation (imports modular home configs)
  features/
    apps/                    # Desktop apps, GVfs, MIME associations
    btop/                    # System resource monitor (wrapped)
    foot/                    # Terminal emulator (wrapped + Noctalia themed)
    git/                     # SSH-signed commits (wrapped)
    gtk/                     # GTK theming via adw-gtk3 + Bibata cursors
    helpers/                 # Aggregates wrapped/nh feature
    helium/                  # Web browser (default handler)
    hypridle/                # Idle daemon: dim→lock→sleep pipeline
    neovim/                  # Heavily configured editor (see below)
    nvf/                     # nvf declarative Neovim framework (replaces wrapper-modules neovim)
    nh/                      # Nix helper tool + dev tools (deadnix, nixfmt, statix, nil)
    niri/                    # Wayland compositor (6 sub-configs)
    nixcord/                 # Discord with Vesktop/Vencord
    noctalia/                # Desktop shell with Material You theming
    opencode/                # AI coding assistant (wrapped)
    pipewire/                # Audio system (PulseAudio + WirePlumber)
    qt/                      # Qt theming via qt6ct (noctalia colors)
    spicetify/               # Spotify theming mod
    sync/                    # Daily git auto-sync (systemd timer @ 12:00)
    tailscale/               # VPN mesh network
    tmux/                    # Terminal multiplexer (wrapped)
    zsh/                     # Shell (Oh My Zsh)
```

## Core Patterns

### Module Discovery
`import-tree` auto-discovers `.nix` files under `modules/` and maps them to flake outputs. Each `.nix` file becomes a `flake.<attr>` or `perSystem.<attr>` output based on its return structure.

### `moduleWithSystem` Pattern
Most features export two things:
- `flake.nixosModules.<name>` — NixOS module (system enablement)
- `perSystem.packages.<myName>` — Wrapped binary package

This is achieved via the `moduleWithSystem` helper from `flake-parts`.

### Wrapper Modules
Every CLI tool uses `BirdeeHub/nix-wrapper-modules` to embed config into the Nix store derivation. Supported wrappers: `foot`, `git`, `nh`, `niri`, `noctalia-shell`, `tmux`, `zsh`, `btop`, `opencode`.

## Feature Details

| Feature | NixOS Module | Wrapped Package | Key Config |
|---|---|---|---|---|
| `apps` | `nixosModules.apps` | — | GVfs, udisks2, PolKit, SSH agent, MIME types (Nautilus dirs, Loupe images, Celluloid video, GNOME Text Editor code) |
| `btop` | `nixosModules.btop` | `myBtop` | TTY theme, vim keys, no truecolor |
| `foot` | `nixosModules.foot` | `myFeet` | JetBrainsMono NF 11, 5x5 pad, beam cursor, includes `~/.config/foot/themes/noctalia` |
| `git` | `nixosModules.git` | `myGit` | SSH-signed commits, alias `g`, allowed signers file |
| `gtk` | `nixosModules.gtk` | — | NixOS: adw-gtk3, Bibata cursors, Papirus icons, Colloid-Grey-Dark (patched). Home-manager: GTK config, dconf dark scheme, imports noctalia.css |
| `helium` | `nixosModules.helium` | — | Default browser for http/https/html/xhtml+xml |
| `neovim` | `nixosModules.neovim` → imports `nixosModules.nvf` | — | See Neovim section below |
| `nvf` | `nixosModules.nvf` (uses `inputs.nvf`) | — | nvf Neovim framework: all `programs.nvf` options configured here |
| `helpers` | `nixosModules.helpers` → imports `nixosModules.nh` + nix-index-database | — | Aggregates nh feature + nix-index-database + dev tools (deadnix, nixfmt, statix, nil) |
| `nh` | `nixosModules.nh` | `myNh` | nh (flake path baked in, auto-clean 4d/3) |
| `niri` | `nixosModules.niri` | `myNiri` | See niri section below |
| `nixcord` | `nixcord.nixosModules.nixcord` | — | Vesktop enabled, adblock CSS, plugins: hideMedia/callTimer/fakeNitro/friendsSince/keepCurrentChannel/mentionAvatars/noF1 |
| `noctalia` | — | `myNoctalia` | Out-of-store config, noctalia.json (719 lines), neovim template pipeline, **built-in idle management** (300s screen-off → 600s lock → 900s suspend, smooth fade dim) |
| `opencode` | `nixosModules.opencode` | `myOpencode` | System theme |
| `pipewire` | `nixosModules.pipewire` | — | PulseAudio compat, WirePlumber, ALSA + 32-bit |
| `prismlauncher` | `nixosModules.prismlauncher` | `myPrismlauncher` | Minecraft launcher, Wayland-forced via wrapper (glfw in LD_LIBRARY_PATH, `_JAVA_AWT_WM_NONREPARENTING`, `SDL_VIDEODRIVER`) |
| `qt` | `nixosModules.qt` | — | qt6ct/5ct, Wayland, noctalia colorscheme, Colloid-Grey-Dark icon theme |
| `spicetify` | `nixosModules.spicetify` | — | Wayland patch, extensions: adblockify, hidePodcasts |
| `tailscale` | `nixosModules.tailscale` | — | Firewall open, MagicDNS via systemd-resolved |
| `tmux` | `nixosModules.tmux` | `myTmux` | Prefix C-a, vi keys, resurrect+continuum, top status bar, HJKL pane nav |
| `zsh` | `nixosModules.zsh` | `myZsh` | Oh My Zsh (candy), syntax highlighting, autosuggestions, 10k history, aliases (eza, git, clear) |

### Wrapping Examples

**Simple wrapper** (foot):
```nix
packages.myFeet = inputs.wrapper-modules.wrappers.foot.wrap {
  inherit pkgs;
  settings = {
    main = { font = "JetBrainsMono Nerd Font:style=Medium:size=11"; pad = "5x5"; };
    cursor = { style = "beam"; blink = false; };
  };
};
```

**Wrapper with runtime deps** (neovim — legacy, nvf now replaces this):
```nix
packages.myNeovim = inputs.wrapper-modules.wrappers.neovim.wrap {
  inherit pkgs;
  settings = {
    config_directory = pkgs.runCommand "nvim-config" { } ''
      cp -r ${./nvim}/. $out
      chmod -R u+w $out
      cp -r ${parserDir}/parser $out/parser
    '';
    block_normal_config = false;
    aliases = [ "vim" "v" ];
  };
  runtimePkgs = with pkgs; [ ripgrep fd matugen /* LSPs + formatters */ ];
};
```

**Wrapper with merged sub-configs** (niri):
```nix
packages.myNiri = inputs.wrapper-modules.wrappers.niri.wrap {
  inherit pkgs;
  settings = (lib.foldl lib.recursiveUpdate { } [ cfg.settings sty.settings ... ]) // {
    window-rules = (sty.windowRules or [ ]) ++ (wrl.windowRules or [ ]) ++ ...;
    layer-rules = (wrl.layerRules or [ ]) ++ ...;
  };
  extraSettings = [{ include = [{ optional = true; } "~/.config/niri/noctalia.kdl"]; }];
};
```

### Dynamic Theming Pipeline
Noctalia → Material You color gen → `matugen-template.lua` ({{placeholders}}) → `matugen.lua` → SIGUSR1 → Neovim hot-reload.

## Neovim

**Active config:** `modules/features/nvf/` — declarative via nvf.  
**Legacy wrapper-modules config:** `modules/features/neovim/` (preserved but unused).

### nvf Structure

```
modules/features/nvf/
  default.nix              # Entry — uses moduleWithSystem, mkMerge of all sub-files
  _config/
    options.nix             # vim options (native Nix, no Lua)
    keybinds.nix            # 9 general mappings (save, window nav, clipboard, etc.)
    autocmds.nix            # vim.autocmds + vim.augroups (native Nix, no Lua)
    theme.nix               # additionalRuntimePaths → neovim/ for noctalia matugen
  _plugins/
    languages.nix           # 18 language LSPs, conform-nvim, treesitter, glance, trouble
    cmp.nix                 # blink.cmp (super-tab), LuaSnip, friendly-snippets
    snacks.nix              # Picker, explorer, dashboard (custom header/keys), terminal, scratch
    mini.nix                # Statusline, pairs, comment, surround, sessions, icons
    flash.nix               # Flash navigation (z=flash, Z=treesitter)
    git.nix                 # Gitsigns (current_line_blame)
    diffview.nix            # diffview-nvim
    aerial.nix              # aerial-nvim symbol outline
    whichkey.nix            # which-key (helix preset), group regs for f+g
    markdown.nix            # live-preview, checkmate
    opencode.nix            # opencode.nvim, render-markdown
    tpipeline.nix           # vim-tpipeline tmux integration
    _themes/
      base16.nix            # base16-nvim + matugen (noctalia dynamic theme)
      rosepine.nix          # rose-pine fallback (activates if matugen fails)
```

**LSP servers** (declarative via nvf `vim.languages.*.enable`, no Mason): `lua_ls`, `gopls`, `pyright`, `clangd`, `marksman`, `jsonls`, `yamlls`, `ts_ls`, `bashls`, `nixd`, `jdtls`, `kotlin_language_server`, `groovy`.
**Formatters** (conform-nvim): `stylua`, `gofumpt`, `goimports`, `nixfmt`, `prettier`, `black`, `isort`, `shfmt`.
**Tree-sitter grammars** (nvf-builtin + 4 extra): Nix, Lua, Python, Go, C, C++, Bash, JSON, YAML, Markdown, TypeScript, TSX, VimL, CSS, HTML, Rust, JavaScript, Comment, Regex, SQL, TOML, Groovy.

**Keybinds**: Space leader, `<leader><leader>` files, `<leader>fg` grep, `<leader>fb` buffers, `<leader>fr` resume, `<leader>fh` help, `<leader>fw` workspace symbols, `<leader>e` explorer, `<C-t>` terminal, `<leader>b` scratch, `<leader>gd` def, `<leader>gD` decl, `<leader>gi` impl, `<leader>gR` refs, `<leader>gt` type def, `K` hover, `<C-k>` sig, `<leader>gr` rename, `<leader>ga` code action, `[d`/`]d` diag, `<leader>q` diag list, `<leader>ge` trouble, `<leader>ld/r/t/i` glance, `<leader>?` which-key, `z` flash, `Z` treesitter flash.

## Host Configuration

**`configuration.nix`** wires everything together:
- State version 26.05, unfree allowed
- GRUB + EFI, Ly display manager
- NetworkManager, hostname `desktop`, TZ `Asia/Almaty`
- User `mafien0` (wheel, disk, zsh)
- NVIDIA GTX 1060 (legacy_580, powerManagement enabled, in `hardware.nix`)
- Fonts: 7 Nerd Fonts + Noto + DejaVu + Ubuntu + Adobe Source + metric-compatible MS alternatives
- Steam with remotePlay/dedicatedServer/localNetworkGameTransfers firewall
- Cachix: `nix-community`

**`hardware.nix`**: NVIDIA GTX 1060 (legacy_580, powerManagement, modesetting), ext4 root (`/`), vfat boot, swap, AMD microcode, NVMe/USB boot modules, `nvidia` initrd module.

**`home-manager.nix`**: Uses `moduleWithSystem`, imports `homeManagerModules.gtk`, XDG user dirs (Downloads, Pictures), state version 26.05.

## niri (modules/features/niri/)

Wayland compositor split into 6 sub-configs merged via `lib.foldl lib.recursiveUpdate`:
- **`config.nix`** — Spawns noctalia, hypridle, wl-clip-persist, polkit-gnome, tailscale. Xwayland-satellite. HDMI-A-1 1920x1080@74.986.
- **`input.nix`** — 50+ keybindings. US+RU keyboard (Win+Space toggle, caps→esc). Launchers, window ops, workspace 1-9, audio (wpctl), media keys (allow-when-locked), brightness, screenshots, hyprpicker, dynamic cast, OBS replay.
- **`style.nix`** — 10px gaps, 3 column width presets (33/50/67%), 3px focus ring, shadows (30 softness, 5 spread, offset 0x5). Bibata cursor 20. Spring animations for workspace-switch, window open/close, movement, resize, overview. Recent-windows with 750ms debounce. Global 10px corner radius.
- **`env.nix`** — Wayland env vars: Electron Ozone, Firefox, Qt (qt6ct), WINE, XDG_SESSION_TYPE, cursor theme/size/path.
- **`misc.nix`** — 4 workspaces (main, browser, messenger, misc). Global blur (xray=false). Noctalia layer blur exclusion.
- **`windowrules.nix`** — PiP (no border/shadow/radius), 20+ floating patterns (terminal-popup, waypaper, Bitwarden, satty, Celluloid, MissionCenter, etc.), GNOME apps float, screencast blocks (Telegram, ZapZap, Spotify), noctalia overview backdrop.

## Tips

- **Disko**: Partition layout in `modules/hosts/desktop/disko.nix` (under `modules/` so import-tree picks it up — wrapped in `flake.diskoConfigurations.desktop` to map it to flake output). Wired via `default.nix:6` (`self.diskoConfigurations.desktop`). Override disk at install: `nix run github:nix-community/disko -- --mode disko --flake '.#desktop' --arg disko.devices.disk.main.device '"/dev/sda"'`
- Add a new feature: create `modules/features/<name>/default.nix` following `moduleWithSystem` pattern, then add `self.nixosModules.<name>` to `configuration.nix` imports
- Feature aggregator pattern: `modules/features/helpers/` references `self.nixosModules.nh` to keep configuration.nix imports clean
- LSPs are provided as Nix runtime packages (not Mason) — use `vim.lsp.enable` in Neovim config
- Theme changes in Noctalia propagate live to Neovim via SIGUSR1
- Rebuild: `sudo nixos-rebuild switch --flake .#desktop` or use `nh os switch`, but do not run it yourself
- Nautilus remote connections require `services.gvfs.enable = true` and `programs.ssh.startAgent = true` (in `apps` module). Also `GIO_EXTRA_MODULES` in niri's env
- New niri sub-config: create `modules/features/niri/_/<name>.nix`, import and merge it in `default.nix`
