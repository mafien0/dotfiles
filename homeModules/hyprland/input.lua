local nix = require("nix")

-- CONFIG -- 
hl.config({
  input = {
    numlock_by_default = true,
    kb_layout = "us,ru",
    kb_options = "grp:win_space_toggle,caps:escape",
  },
})

-- BINDS --
local mod = "SUPER"

-- Launchers
hl.bind(mod .. " + Return", hl.dsp.exec_cmd(nix.terminal))
hl.bind(mod .. " + SHIFT + Return", hl.dsp.exec_cmd(nix.terminal .. " --title=terminal-popup"))
hl.bind(mod .. " + E", hl.dsp.exec_cmd(nix.fileManager))
hl.bind(mod .. " + ALT + L", hl.dsp.exec_cmd(nix.ipc .. " lockScreen lock"))

-- Screenshots (quickshell picker, see pkgs/scr)
hl.bind(mod .. " + S", hl.dsp.exec_cmd(nix.screenshot .. " region"))
hl.bind(mod .. " + SHIFT + S", hl.dsp.exec_cmd(nix.screenshot .. " fullscreen"))

-- Noctalia
hl.bind(mod .. " + A", hl.dsp.exec_cmd(nix.ipc .. " launcher toggle"))
hl.bind(mod .. " + SHIFT + C", hl.dsp.exec_cmd(nix.ipc .. " launcher clipboard"))
hl.bind(mod .. " + SHIFT + E", hl.dsp.exec_cmd(nix.ipc .. " launcher emoji"))
hl.bind(mod .. " + SHIFT + M", hl.dsp.exec_cmd(nix.ipc .. " sessionMenu toggle"))
hl.bind(mod .. " + T", hl.dsp.exec_cmd(nix.ipc .. " plugin:obs-control saveReplay"))


-- Windows
hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close())
hl.bind(mod .. " + F", hl.dsp.window.fullscreen({ mode = "maximized" }))
hl.bind(mod .. " + SHIFT + F", hl.dsp.window.fullscreen())
hl.bind(mod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mod .. " + SHIFT + V", hl.dsp.window.pin({ action = "toggle" }))

-- Utilities
hl.bind(mod .. " + X", hl.dsp.exec_cmd(nix.hyprpicker .. " -a -l"))

-- Focus
hl.bind(mod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mod .. " + J", hl.dsp.focus({ direction = "down" }))
hl.bind(mod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mod .. " + L", hl.dsp.focus({ direction = "right" }))

-- Move windows
hl.bind(mod .. " + SHIFT + H", hl.dsp.window.move({ direction = "left" }))
hl.bind(mod .. " + SHIFT + J", hl.dsp.window.move({ direction = "down" }))
hl.bind(mod .. " + SHIFT + K", hl.dsp.window.move({ direction = "up" }))
hl.bind(mod .. " + SHIFT + L", hl.dsp.window.move({ direction = "right" }))

-- Resize
hl.bind(mod .. " + minus", hl.dsp.window.resize({ x = -40, y = 0, relative = true }))
hl.bind(mod .. " + equal", hl.dsp.window.resize({ x = 40, y = 0, relative = true }))
hl.bind(mod .. " + SHIFT + minus", hl.dsp.window.resize({ x = 0, y = -40, relative = true }))
hl.bind(mod .. " + SHIFT + equal", hl.dsp.window.resize({ x = 0, y = 40, relative = true }))

-- Mouse
hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })
hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))
hl.bind(mod .. " + SHIFT + mouse_down", hl.dsp.focus({ direction = "right" }))
hl.bind(mod .. " + SHIFT + mouse_up", hl.dsp.focus({ direction = "left" }))

-- Workspaces
for i = 1, 9 do
  hl.bind(mod .. " + " .. i, hl.dsp.focus({ workspace = i }))
  hl.bind(mod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end
hl.bind(mod .. " + " .. 0, hl.dsp.focus({ workspace = 10 }))
hl.bind(mod .. " + SHIFT + " .. 0, hl.dsp.window.move({ workspace = 10 }))

-- Audio
hl.bind(mod .. " + C", hl.dsp.exec_cmd(nix.wpctl .. " set-mute @DEFAULT_AUDIO_SOURCE@ toggle"))
hl.bind(mod .. " + O", hl.dsp.exec_cmd(nix.wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 0.05+ -l 1.0"))
hl.bind(mod .. " + SHIFT + O", hl.dsp.exec_cmd(nix.wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 0.05-"))
hl.bind(mod .. " + I", hl.dsp.exec_cmd(nix.playerctl .. " play-pause"))
hl.bind(mod .. " + ALT + I", hl.dsp.exec_cmd(nix.playerctl .. " next"))
hl.bind(mod .. " + ALT + SHIFT + I", hl.dsp.exec_cmd(nix.playerctl .. " previous"))

-- Media keys
local media = { locked = true, repeating = true }
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd(nix.wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 0.02+ -l 1.0"), media)
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd(nix.wpctl .. " set-volume @DEFAULT_AUDIO_SINK@ 0.02-"), media)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd(nix.wpctl .. " set-mute @DEFAULT_AUDIO_SINK@ toggle"), media)
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd(nix.wpctl .. " set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), media)
hl.bind("XF86AudioStop", hl.dsp.exec_cmd(nix.playerctl .. " stop"), media)
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd(nix.playerctl .. " play-pause"), media)
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd(nix.playerctl .. " previous"), media)
hl.bind("XF86AudioNext", hl.dsp.exec_cmd(nix.playerctl .. " next"), media)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd(nix.brightnessctl .. " --class=backlight set +10%"), media)
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd(nix.brightnessctl .. " --class=backlight set 10%-"), media)
