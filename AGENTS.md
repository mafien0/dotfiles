# NixOS Configuration — Agent Guide

I included AGENTS.md into repo for purpose

## Overview

Personal **NixOS flake** for host `desktop` (user `mafien0`). Modular architecture using **flake-parts**, **import-tree** for auto-discovery, and **nix-wrapper-modules** for wrapping CLI tools with baked-in configs. Uses **home-manager** for user-level state.

## Workflow

- **Follow this project's structure** — all modules go in `modules/features/<name>/` — CLI wrappers, system services, and plain programs alike
- **Test with `nix build`** before considering a task done
- **Always Format all Nix code with `nixfmt`**
- **Always Search for the dead code with `deadnix`** (`deadnix -q **/*.nix`) and fix it
- **Always Check for anti-patterns with `statix`** (`statix check .`) and fix it
- **When editing configuration update** `AGENTS.md`
- **Don't make things up** — consult docs first, especially <https://birdeehub.github.io/nix-wrapper-modules/>, use `nix-locate` or `nix search` to find packages
- **Don't take shortcuts** — follow Nix standards and idioms
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
Every CLI tool uses `BirdeeHub/nix-wrapper-modules` to embed config into the Nix store derivation. Supported wrappers: `foot`, `neovim`, `git`, `nh`, `niri`, `noctalia-shell`, `tmux`, `zsh`, `btop`, `opencode`.

## Feature Details

| Feature | NixOS Module | Wrapped Package | Key Config |
|---|---|---|---|---|
| `apps` | `nixosModules.apps` | — | GVfs, udisks2, PolKit, SSH agent, MIME types (Nautilus dirs, Loupe images, Celluloid video, GNOME Text Editor code) |
| `btop` | `nixosModules.btop` | `myBtop` | TTY theme, vim keys, no truecolor |
| `foot` | `nixosModules.foot` | `myFeet` | JetBrainsMono NF 11, 5x5 pad, beam cursor, includes `~/.config/foot/themes/noctalia` |
| `git` | `nixosModules.git` | `myGit` | SSH-signed commits, alias `g`, allowed signers file |
| `gtk` | `nixosModules.gtk` | — | NixOS: adw-gtk3, Bibata cursors, Papirus icons, Colloid-Grey-Dark (patched). Home-manager: GTK config, dconf dark scheme, imports noctalia.css |
| `helium` | `nixosModules.helium` | — | Default browser for http/https/html/xhtml+xml |
| `neovim` | `nixosModules.neovim` | `myNeovim` | See Neovim section below |
| `helpers` | `nixosModules.helpers` → imports `nixosModules.nh` + nix-index-database | — | Aggregates nh feature + nix-index-database + dev tools (deadnix, nixfmt, statix, nil) |
| `nh` | `nixosModules.nh` | `myNh` | nh (flake path baked in, auto-clean 4d/3) |
| `niri` | `nixosModules.niri` | `myNiri` | See niri section below |
| `nixcord` | `nixcord.nixosModules.nixcord` | — | Vesktop enabled, adblock CSS, plugins: hideMedia/callTimer/fakeNitro/friendsSince/keepCurrentChannel/mentionAvatars/noF1 |
| `noctalia` | — | `myNoctalia` | Out-of-store config, noctalia.json (719 lines), neovim template pipeline, **built-in idle management** (300s screen-off → 600s lock → 900s suspend, smooth fade dim) |
| `opencode` | `nixosModules.opencode` | `myOpencode` | System theme |
| `pipewire` | `nixosModules.pipewire` | — | PulseAudio compat, WirePlumber, ALSA + 32-bit |
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

**Wrapper with runtime deps** (neovim):
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

## Neovim (modules/features/neovim/)

**Entry:** `nvim/init.lua` → options → lazy.nvim bootstrap → matugen → keybinds → autocmds.

**Plugin configs** in `nvim/lua/plugins/`:

| File | Plugins | Purpose |
|---|---|---|
| `lsp.lua` | lspconfig, glance, trouble, fidget, lazydev, tiny-inline-diagnostic | LSP client with `vim.lsp.enable` (no Mason) |
| `cmp.lua` | blink.cmp, LuaSnip | Autocompletion + snippets (super-tab preset) |
| `snacks.lua` | snacks.nvim | Picker, explorer, dashboard, terminal, indent, notifier, scratch |
| `mini.lua` | mini.nvim | Statusline, pairs, comment, sessions, surround, icons |
| `format.lua` | conform.nvim | Auto-format on save (500ms timeout) |
| `treesitter.lua` | nvim-treesitter | Syntax highlighting (auto_install=false, bundled at build) |
| `flash.lua` | flash.nvim | Enhanced navigation (z=flash, Z=treesitter) |
| `git.lua` | gitsigns.nvim | Git signs + blame |
| `diffview.lua` | diffview.nvim | Git diff viewer |
| `aerial.lua` | aerial.nvim | Symbol outline |
| `whichkey.lua` | which-key.nvim | Keybinding popup (helix preset) |
| `markdown.lua` | live-preview.nvim, checkmate.nvim | Markdown preview + checkboxes |
| `opencode.lua` | opencode.nvim, render-markdown.nvim | AI chat assistant frontend |
| `tpipeline.lua` | vim-tpipeline | Tmux statusline integration |
| `themes/base16.lua` | base16-nvim | Active Material You theme |
| `themes/rosepine.lua` | rose-pine/neovim | Fallback theme |

**LSP servers** (provided as Nix runtime packages, `vim.lsp.enable`): `lua_ls`, `gopls`, `pyright`, `clangd`, `marksman`, `jsonls`, `yamlls`, `ts_ls`, `bashls`, `nixd`.
**Formatters**: `stylua`, `gofumpt`, `goimports`, `nixfmt`, `prettier`, `black`, `isort`, `shfmt`.
**Tree-sitter grammars** (21 bundled at build): Nix, Lua, Python, Go, C, C++, Bash, JSON, YAML, Markdown, TypeScript, TSX, VimL, CSS, HTML, Rust, JavaScript, Comment, Regex, SQL, TOML.

**Lazy-lock** tracks 26 plugins (blink.cmp, snacks.nvim, mini.nvim, lspconfig, trouble, glance, flash, gitsigns, conform, which-key, aerial, etc.)

**Keybinds**: Space leader, `<C-s>` save, `<C-h/j/k/l>` window nav, `<Esc>` clear search highlight, `<leader>y/p` clipboard.

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
