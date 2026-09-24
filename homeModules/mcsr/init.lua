local waywall = require("waywall")
local helpers = require("waywall.helpers")
local nix = require("nix")

local config = {
  input = {
    layout = "us",
    repeat_rate = 40,
    repeat_delay = 300,

    sensitivity = 1.0,
    confine_pointer = false,

    remaps = {
      ["CAPSLOCK"] = "F3",
      ["GRAVE"] = "F5",
    },
  },
  theme = {
    background = nix.background .. "ff",
    ninb_anchor = "topright",
  },
}

local screen_eye = helpers.toggle_res(384, 16384, 0.50077085)
local screen_preemptive = helpers.toggle_res(350, 1080)
local screen_wide = helpers.toggle_res(1920, 300)

helpers.res_mirror({
  src = { x = (384 - 30) / 2, y = (16384 - 580) / 2, w = 30, h = 580 },
  dst = { x = 34, y = 34, w = 700, h = 500 },
  depth = 2,
}, 384, 16384)

helpers.res_mirror({
  src = { x = 1, y = 37, w = 49, h = 9 },
  dst = { x = 20, y = 20, w = 400, h = 80 },
}, 350, 1080)

helpers.res_mirror({
  src = { x = 43, y = 181, w = 61, h = 9 },
  dst = { x = 20, y = 120, w = 500, h = 80 },
}, 350, 1080)

helpers.res_mirror({
  src = { x = 18, y = 660, w = 325, h = 190 },
  dst = { x = 20, y = 315, w = 745, h = 745 },
}, 350, 1080)

helpers.res_mirror({
  src = { x = 18, y = 860, w = 100, h = 95 },
  dst = { x = 1155, y = 20, w = 500, h = 475 },
}, 350, 1080)

helpers.res_mirror({
  src = { x = 255, y = 860, w = 88, h = 95 },
  dst = { x = 1155, y = 520, w = 500, h = 540 },
}, 350, 1080)

config.actions = {
  ["Ctrl-Shift-N"] = function()
    waywall.exec(nix.ninjabrain_bot)
  end,

  ["Ctrl-g"] = function()
    screen_eye()
  end,

  ["Ctrl-b"] = function()
    screen_preemptive()
  end,

  ["Ctrl-t"] = function()
    screen_wide()
  end,

  ["Ctrl-m"] = function()
    helpers.toggle_floating()
  end,
}

return config
