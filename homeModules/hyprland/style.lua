local nix = require("nix")

hl.config({
  ["general"] = {
    layout = "dwindle",
    border_size = nix.borderSize,
    gaps_in = nix.gaps,
    gaps_out = nix.gaps,
  },
  ["general.snap"] = {
    enabled = true,
  },

  ["decoration"] = {
    active_opacity = nix.opacity,
    rounding = nix.cornerRadius,
  },

  animations = {
    enabled = true,
  },
})

-- MADE BY CLANKER
-- Curves + animation timings ported from end-4/dots-hyprland
-- (dots/.config/hypr/hyprland/general.lua). Bezier only, no springs.
-- speed is in deciseconds: 1 = 100ms.

-- Curves
hl.curve("emphasizedDecel", {type = "bezier", points = {{0.05, 0.7}, {0.1, 1}}})
hl.curve("emphasizedAccel", {type = "bezier", points = {{0.3, 0}, {0.8, 0.15}}})
hl.curve("standardDecel", {type = "bezier", points = {{0, 0}, {0, 1}}})
hl.curve("menu_decel", {type = "bezier", points = {{0.1, 1}, {0, 1}}})
hl.curve("menu_accel", {type = "bezier", points = {{0.52, 0.03}, {0.72, 0.08}}})
hl.curve("stall", {type = "bezier", points = {{1, -0.1}, {0.7, 0.85}}})

-- Windows
hl.animation({leaf = "windowsIn", enabled = true, speed = 1.5, bezier = "emphasizedDecel", style = "popin 80%"})
hl.animation({leaf = "windowsOut", enabled = true, speed = 1, bezier = "emphasizedDecel", style = "popin 90%"})
hl.animation({leaf = "windowsMove", enabled = true, speed = 1.5, bezier = "emphasizedDecel", style = "slide"})
hl.animation({leaf = "fadeIn", enabled = true, speed = 1.5, bezier = "emphasizedDecel"})
hl.animation({leaf = "fadeOut", enabled = true, speed = 1, bezier = "emphasizedDecel"})
hl.animation({leaf = "border", enabled = true, speed = 5, bezier = "emphasizedDecel"})

-- Layers
hl.animation({leaf = "layersIn", enabled = true, speed = 1.35, bezier = "emphasizedDecel", style = "popin 93%"})
hl.animation({leaf = "layersOut", enabled = true, speed = 1.2, bezier = "menu_accel", style = "popin 94%"})
hl.animation({leaf = "fadeLayersIn", enabled = true, speed = 0.25, bezier = "menu_decel"})
hl.animation({leaf = "fadeLayersOut", enabled = true, speed = 1.35, bezier = "stall"})

-- Workspaces
hl.animation({leaf = "workspaces", enabled = true, speed = 3.5, bezier = "menu_decel", style = "fade"})
hl.animation({leaf = "specialWorkspaceIn", enabled = true, speed = 1.4, bezier = "emphasizedDecel", style = "fade"})
hl.animation({leaf = "specialWorkspaceOut", enabled = true, speed = 0.6, bezier = "emphasizedAccel", style = "fade"})

-- Zoom
hl.animation({leaf = "zoomFactor", enabled = true, speed = 1.5, bezier = "standardDecel"})

hl.env("XCURSOR_THEME", nix.cursorTheme)
hl.env("XCURSOR_SIZE", nix.cursorSize)
hl.env("HYPRCURSOR_THEME", nix.cursorTheme)
hl.env("HYPRCURSOR_SIZE", nix.cursorSize)

-- Everything else handled by stylix
