-- Native Lua configuration: configs/Startup_Apps.lua.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Commands and Apps to be executed at launch (vendor defaults)
v.scriptsDir = v.HOME .. "/.config/hypr/scripts"
v.UserScripts = v.HOME .. "/.config/hypr/UserScripts"
v.lock = v.scriptsDir .. "/LockScreen.sh"
v.SwwwRandom = v.UserScripts .. "/WallpaperAutoChange.sh"
v.livewallpaper = ""
v.wallDIR = v.HOME .. "/Pictures/wallpapers"

--## wallpaper stuff ###
require("UserConfigs/Wallpaper")
--exec-once = mpvpaper '*' -o "load-scripts=no no-audio --loop" $livewallpaper
-- wallpaper random
--exec-once = $SwwwRandom $wallDIR # random wallpaper switcher every 30 minutes

--## Startup ###
require("startup")("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
require("startup")("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
require("startup")(v.HOME .. "/.config/hypr/scripts/Dropterminal.sh kitty &")
require("startup")(v.scriptsDir .. "/Polkit.sh")
require("startup")("nm-applet --indicator")
require("startup")("nm-tray")
require("startup")("swaync")
--exec-once = ags
--exec-once = blueman-applet
--exec-once = rog-control-center
require("startup")("waybar")
require("startup")("qs -c overview")
require("startup")("hypridle")
require("startup")(v.scriptsDir .. "/Hyprsunset.sh init")

-- Clipboard manager
require("startup")("wl-paste --type text --watch cliphist store")
require("startup")("wl-paste --type image --watch cliphist store")

-- Rainbow borders (disabled by default; use quick settings menu)
--exec-once = $UserScripts/RainbowBorders.sh


-- Here are list of features available but disabled by default
-- Persistent wallpaper
-- exec-once = swww-daemon --format xrgb && swww img $wallDIR/mecha-nostalgia.png

-- Gnome polkit for NixOS
--exec-once = $scriptsDir/Polkit-NixOS.sh

-- xdg-desktop-portal-hyprland (should be auto starting. However, you can force to start)
--exec-once = $scriptsDir/PortalHyprland.sh
require("startup")("blueman-applet")
require("startup")("ags")
require("startup")(v.scriptsDir .. "/KeybindsLayoutInit.sh")
