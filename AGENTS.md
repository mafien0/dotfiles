## `MADE BY AI` comment

Use the `MADE BY AI` comment for **big changes**: writing a full module,
rewriting/refactoring an existing module, or otherwise adding a large chunk of
new code.

- Full module write/rewrite: put `# MADE BY AI` at the very top of the file.
- Large change inside an existing file: put `# MADE BY AI` right above the change.

Do **not** add it for small changes. One-liners, a few added/removed options,
typo fixes, config tweaks, and other minor edits get no comment.

check code with `nixcheck <dir>`, format with `nixformat <dir>`
check flake with `flint` inside of a flake dir
those are availabe in your PATH

## Edits
- Do not write into the project, unless i specificly tell you to.
- Do not write large comments explaining nothing


## Structure
```plaintext
 ./
├──  assets/
│   ├──  readme/
│   │   ├──  01.png
│   │   ├──  02.png
│   │   ├──  03.png
│   │   └──  04.png
│   └──  wallpapers/
│       ├──  gruvbox_city.png
│       └──  v1.png
├──  homeModules/
│   ├──  apps/
│   │   └──  default.nix
│   ├──  btop/
│   │   └──  default.nix
│   ├──  direnv/
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
│   ├──  niri/
│   │   ├──  config.nix
│   │   ├──  default.nix
│   │   ├──  env.nix
│   │   ├──  input.nix
│   │   ├──  misc.nix
│   │   ├──  style.nix
│   │   └──  windowrules.nix
│   ├──  nixcord/
│   │   └──  default.nix
│   ├──  nixtools/
│   │   └──  default.nix
│   ├──  noctalia/
│   │   ├──  default.nix
│   │   └──  settings.json
│   ├──  pi/
│   │   └──  default.nix
│   ├──  prismlauncher/
│   │   └──  default.nix
│   ├──  qbittorrent/
│   │   └──  default.nix
│   ├──  spicetify/
│   │   └──  default.nix
│   ├──  theme/
│   │   ├──  default.nix
│   │   ├──  icons.nix
│   │   └──  stylix.nix
│   ├──  tmux/
│   │   └──  default.nix
│   └──  zsh/
│       └──  default.nix
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
│   ├──  docker/
│   │   └──  default.nix
│   ├──  gvfs/
│   │   └──  default.nix
│   ├──  hosts-block/
│   │   └──  default.nix
│   ├──  localsend/
│   │   └──  default.nix
│   ├──  ly/
│   │   └──  default.nix
│   ├──  nh/
│   │   └──  default.nix
│   ├──  niri/
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
├──  AGENTS.md
├──  flake.lock
├──  flake.nix
└── 󰂺 README.md
```
