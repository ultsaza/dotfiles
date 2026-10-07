-- Migrated from UserConfigs/UserSettings.conf; edit this Lua file going forward.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- User overrides for SystemSettings.conf.
-- Hyprland merges partial blocks — only list keys that DIFFER from
-- ~/.config/hypr/configs/SystemSettings.conf. Other keys keep their defaults.
--
-- Decoration / Animation overrides live in UserDecorations.conf / UserAnimations.conf

hl.config({ ["input.kb_options"] = "ctrl:nocaps" })
hl.config({ ["input.repeat_rate"] = 40 })
hl.config({ ["input.sensitivity"] = 1.0 })

hl.config({ ["misc.swallow_regex"] = "^(com\\.mitchellh\\.ghostty)$" })
