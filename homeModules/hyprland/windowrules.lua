local function rules(matches, effects)
  for _, match in ipairs(matches) do
    local rule = {match = match}
    for key, value in pairs(effects) do
      rule[key] = value
    end
    hl.window_rule(rule)
  end
end

hl.window_rule({
  name = "picture-in-picture",
  match = {title = "(?i)^Picture-in-Picture$"},
  float = true,
  pin = true,
  border_size = 0,
  no_shadow = true,
  rounding = 0,
})

hl.window_rule({
  name = "steam-notification-toast",
  match = {
    class = "(?i).*steam.*",
    title = "(?i)^notificationtoasts_[0-9]+_desktop$",
  },
  float = true,
  no_initial_focus = true,
  border_size = 0,
  no_shadow = true,
  move = {"monitor_w-window_w", "monitor_h-window_h"},
})

hl.window_rule({
  name = "qalculate",
  match = {class = "(?i)^qalculate-gtk$"},
  float = true,
  size = {794, 554},
})

rules({
  {title = "(?i)terminal-popup"},
  {class = "(?i)popup"},
  {class = "(?i)waypaper"},
  {class = "(?i)^.*\\.satty$"},
  {class = "(?i)^[Tt]hunar$"},
  {class = "(?i)^imv$"},
  {class = "(?i)^org\\.xfce\\.mousepad$"},
  {class = "(?i)modrinth-app.*"},
  {class = "(?i)Bitwarden"},
  {class = "(?i)ninjabrainbot.*"},
  {class = "(?i)^.*\\.Celluloid$"},
  {class = "(?i)^.*\\.pwvucontrol$"},
  {class = "(?i)^.*\\.MissionCenter$"},
  {class = "(?i)^.*\\.Warehouse$"},
  {class = "(?i)^.*\\.Flatseal$"},
  {class = "(?i)^.*\\.devtoolbox$"},
  {class = "(?i)^.*\\.Bazaar$"},
  {class = "(?i)^.*\\.spider$"},
  {title = "(?i)[Ss]ave [Ff]ile"},
}, {
  float = true,
  size = {"monitor_w*0.8", "monitor_h*0.8"},
})

rules({
  {class = "(?i)org.gnome.*"},
}, {
  float = true,
})

rules({
  {title = "(?i)Welcome to.*"},
}, {
  float = true,
})

rules({
  {class = "(?i)org.telegram.desktop"},
  {class = "(?i)com.rtosta.zapzap"},
  {class = "(?i).*spotify"},
}, {
  no_screen_share = true,
})

-- Noctalia full-screen overlays carry a translucent panel plus a whole-screen dimmer.
-- With no layer rules they inherit layersOut (popin 94%), so closing one pops the
-- entire screen, and nothing ever gets compositor blur behind the panel.
local noctalia_panels = {
  "noctalia-launcher-overlay", -- verified: 1920x1080 overlay layer
  "noctalia-popupmenu", -- tray + context menus, full-screen top layer
  "noctalia-notifications", -- notification/toast host
}
for _, ns in ipairs(noctalia_panels) do
  hl.layer_rule({
    match = {namespace = ns .. ".*"},
    no_anim = true,
    blur = true,
    ignore_alpha = 0.5,
  })
end

-- Full-screen too, but nothing worth blurring behind them.
hl.layer_rule({match = {namespace = "noctalia-overview.*"}, no_anim = true})
hl.layer_rule({match = {namespace = "noctalia-fade-overlay.*"}, no_anim = true})

-- slurp region selector (screenshot/record region pick); popin on open is pointless.
hl.layer_rule({match = {namespace = "selection"}, no_anim = true})
