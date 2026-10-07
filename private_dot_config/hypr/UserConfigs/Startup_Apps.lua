-- Migrated from UserConfigs/Startup_Apps.conf; edit this Lua file going forward.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- User-only startup apps. Defaults are in ~/.config/hypr/configs/Startup_Apps.conf
-- Anything you'd otherwise add to the vendor file should go here instead.

-- Propagate the Wayland session type to D-Bus/systemd-activated apps.
require("startup")("dbus-update-activation-environment --systemd XDG_SESSION_TYPE")

-- Quickshell overview (used by $scriptsDir/OverviewToggle.sh, bound to SUPER+A)
require("startup")("qs -c overview")

require("startup")("blueman-applet")
require("startup")("ags")

-- Japanese IME
require("startup")("fcitx5 -d --replace")
