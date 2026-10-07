-- Native Lua configuration: UserConfigs/ENVariables.lua.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- User-only env additions. Defaults are in ~/.config/hypr/configs/ENVariables.lua
-- Only add values here that differ from or extend the defaults.

-- Hyprcursor (modern Wayland cursor protocol)
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("HYPRCURSOR_SIZE", "24")

-- Legacy XCursor fallback for apps that don't support hyprcursor
-- (e.g. Ghostty / GTK4 client-side cursors over their own widgets)
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
