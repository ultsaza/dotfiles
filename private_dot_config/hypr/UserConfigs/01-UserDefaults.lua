-- Native Lua configuration: UserConfigs/01-UserDefaults.lua.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #

-- This is a file where you put your own default apps, default search Engine etc

-- Default editor for the KooL Quick Settings Menu (SUPER SHIFT E)
-- and applications launched by Hyprland.
v.edit = "nvim"
hl.env("EDITOR", v.edit)

-- These two are for UserKeybinds.lua & Waybar Modules
v.term = v.HOME .. "/.config/hypr/scripts/ghostty-launch"
v.files = "thunar"

-- Default Search Engine for ROFI Search (SUPER S)
v.Search_Engine = "https://www.google.com/search?q={}"
