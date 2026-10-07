-- Native Lua configuration: Monitor_Profiles/default.lua.
local v = require("variables")

-- Generic high-resolution profile; the personal layout lives in monitors.lua.
-- Use hyprctl monitors to find output names and supported modes.
-- See UserConfigs/Laptops.lua for laptop display handling.
-- Workspace rules belong in workspaces.lua.
--
-- Example for a specific output:
-- hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })

hl.monitor({ ["output"] = "", ["mode"] = "highres", ["position"] = "auto", ["scale"] = "1" })
