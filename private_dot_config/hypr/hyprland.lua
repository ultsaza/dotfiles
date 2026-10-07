-- Native Lua configuration: hyprland.lua.
local v = require("variables")

hypr_vars = v -- Readable by settings helpers through hyprctl eval.
-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Always refer to Hyprland wiki
-- https://wiki.hyprland.org/

-- Initial boot script enable to apply initial wallpapers, theming, new settings etc.
-- suggest not to change this or delete this including deleting referrence file in ~/.config/hypr/.initial_startup_done
-- as long as the referrence file is present, this initial-boot.sh will not execute
require("startup")(v.HOME .. "/.config/hypr/initial-boot.sh")

--## Sourcing external config files ###
v.configs = v.HOME .. "/.config/hypr/configs"
v.UserConfigs = v.HOME .. "/.config/hypr/UserConfigs"

require("configs/Keybinds")

-- Load defaults, then user additions/overrides
require("configs/Startup_Apps")
require("UserConfigs/Startup_Apps")

require("configs/ENVariables")
require("UserConfigs/ENVariables")

-- For laptop related
require("configs/Laptops")
require("UserConfigs/Laptops")
require("UserConfigs/LaptopDisplay")

-- Load defaults, then user additions
require("configs/WindowRules")
require("UserConfigs/WindowRules")

require("configs/SystemSettings")

require("UserConfigs/UserDecorations")
require("UserConfigs/UserAnimations")
require("UserConfigs/UserKeybinds")
require("UserConfigs/UserSettings")
require("UserConfigs/01-UserDefaults")

-- nwg-displays
require("monitors")
require("workspaces")
