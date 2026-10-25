local function rules(matches, effects)
  for _, match in ipairs(matches) do
    local rule = {match = match}
    for key, value in pairs(effects) do
      rule[key] = value
    end
    hl.window_rule(rule)
  end
end

-- Window rules --

hl.window_rule({
  name = "picture-in-picture",
  match = {title = "(?i)^picture[ _-]in[ _-]picture$"},
  float = true,
  pin = true,
  border_size = 0,
  no_shadow = true,
  rounding = 0,
  keep_aspect_ratio = true,
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

-- Layer Rules --

-- https://wiki.hypr.land/useful-utilities/screen-sharing/
hl.window_rule({
    name = "xwayland-video-bridge-fixes",
    match = {
        class = "xwaylandvideobridge"
    },

    no_initial_focus = true,
    no_focus = true,
    no_anim = true,
    no_blur = true,
    max_size = {1,1},
    opacity = 0.0
})

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
hl.layer_rule({match = {namespace = "noctalia-overview.*"}, no_anim = true})
hl.layer_rule({match = {namespace = "noctalia-fade-overlay.*"}, no_anim = true})

-- Region picker (pkgs/scr): full-screen surface that must land and leave instantly,
-- otherwise layersIn/layersOut (popin 93/94%) animate the whole screen.
hl.layer_rule({match = {namespace = "scr-select.*"}, no_anim = true})

