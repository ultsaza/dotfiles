-- Native Lua configuration: UserConfigs/UserSettings.lua.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- User overrides for SystemSettings.lua.
-- Hyprland merges partial blocks — only list keys that DIFFER from
-- ~/.config/hypr/configs/SystemSettings.lua. Other keys keep their defaults.
--
-- Decoration / Animation overrides live in UserDecorations.lua / UserAnimations.lua

hl.config({ ["input.kb_options"] = "ctrl:nocaps" })
hl.config({ ["input.repeat_rate"] = 40 })
hl.config({ ["input.sensitivity"] = 1.0 })

hl.config({ ["misc.swallow_regex"] = "^(com\\.mitchellh\\.ghostty)$" })
