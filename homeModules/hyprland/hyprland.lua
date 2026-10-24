local nix = require("nix")

hl.monitor({
  output = "HDMI-A-1",
  mode = "1920x1080@75",
  position = "auto",
  scale = 1,
})

hl.config({
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    middle_click_paste = false,
  },
  xwayland = {
    force_zero_scaling = true,
  },
})

for i = 1, 10 do
  hl.workspace_rule({ workspace = tostring(i), persistent = true })
end

hl.on("hyprland.start", function()
  hl.exec_cmd(nix.noctalia)

  hl.exec_cmd(nix.wlClipPersist .. " --clipboard regular")
  hl.exec_cmd(nix.wlPaste .. " --type text --watch " .. nix.cliphist .. " store")
  hl.exec_cmd(nix.wlPaste .. " --type image --watch " .. nix.cliphist .. " store")
  hl.exec_cmd(nix.polkitAgent)
end)
