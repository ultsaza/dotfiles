-- Migrated from configs/Keybinds.conf; edit this Lua file going forward.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Default Keybinds
-- visit https://wiki.hyprland.org/Configuring/Binds/ for more info

-- /* ---- ✴️ Variables ✴️ ---- */  #
v.mainMod = "SUPER"
v.scriptsDir = v.HOME .. "/.config/hypr/scripts"
v.UserConfigs = v.HOME .. "/.config/hypr/UserConfigs"
v.UserScripts = v.HOME .. "/.config/hypr/UserScripts"

-- settings for User defaults apps - set your default terminal and file manager on this file
require("UserConfigs/01-UserDefaults")

--### STANDAR ####
-- Common shortcuts
--bindr = $mainMod, $mainMod_L, exec, pkill rofi || rofi -show drun -modi drun,filebrowser,run,window # Super Key to Launch rofi menu
hl.bind(v.mainMod .. " + D", hl.dsp.exec_cmd("pkill rofi || true && rofi -show drun -modi drun,filebrowser,run,window"), { ["description"] = "app launcher" })
hl.bind(v.mainMod .. " + B", hl.dsp.exec_cmd("xdg-open \"https://\""), { ["description"] = "open default browser" })
hl.bind(v.mainMod .. " + A", hl.dsp.exec_cmd(v.scriptsDir .. "/OverviewToggle.sh"), { ["description"] = "desktop overview" })
--bindd = $mainMod, A, ags overview, exec, pkill rofi || true && ags -t 'overview' # desktop overview (if installed)
--bindd = $mainMod, A, Quickshell overview, global, quickshell:overviewToggle # desktop overview (if installed)
hl.bind(v.mainMod .. " + Return", hl.dsp.exec_cmd(v.term), { ["description"] = "Open terminal" })
hl.bind(v.mainMod .. " + E", hl.dsp.exec_cmd(v.files), { ["description"] = "file manager" })

-- FEATURES / EXTRAS
hl.bind(v.mainMod .. " + T", hl.dsp.exec_cmd(v.scriptsDir .. "/ThemeChanger.sh"), { ["description"] = "Global theme switcher using Wallust" })
hl.bind(v.mainMod .. " + H", hl.dsp.exec_cmd(v.scriptsDir .. "/KeyHints.sh"), { ["description"] = "help / cheat sheet" })
hl.bind(v.mainMod .. " + ALT + R", hl.dsp.exec_cmd(v.scriptsDir .. "/Refresh.sh"), { ["description"] = "refresh bar and menus" })
hl.bind(v.mainMod .. " + ALT + E", hl.dsp.exec_cmd(v.scriptsDir .. "/RofiEmoji.sh"), { ["description"] = "emoji menu" })
hl.bind(v.mainMod .. " + S", hl.dsp.exec_cmd(v.scriptsDir .. "/RofiSearch.sh"), { ["description"] = "web search" })
hl.bind(v.mainMod .. " + CTRL + S", hl.dsp.exec_cmd("rofi -show window"), { ["description"] = "window switcher" })
hl.bind(v.mainMod .. " + ALT + O", hl.dsp.exec_cmd(v.scriptsDir .. "/ChangeBlur.sh"), { ["description"] = "toggle blur" })
hl.bind(v.mainMod .. " + SHIFT + G", hl.dsp.exec_cmd(v.scriptsDir .. "/GameMode.sh"), { ["description"] = "toggle game mode" })
hl.bind(v.mainMod .. " + ALT + L", hl.dsp.exec_cmd(v.scriptsDir .. "/ChangeLayout.sh"), { ["description"] = "toggle master/dwindle layout" })
hl.bind(v.mainMod .. " + ALT + V", hl.dsp.exec_cmd(v.scriptsDir .. "/ClipManager.sh"), { ["description"] = "clipboard manager" })
hl.bind(v.mainMod .. " + CTRL + R", hl.dsp.exec_cmd(v.scriptsDir .. "/RofiThemeSelector.sh"), { ["description"] = "rofi theme selector" })
hl.bind(v.mainMod .. " + CTRL + SHIFT + R", hl.dsp.exec_cmd("pkill rofi || true && " .. v.scriptsDir .. "/RofiThemeSelector-modified.sh"), { ["description"] = "rofi theme selector (modified)" })

hl.bind(v.mainMod .. " + SHIFT + F", hl.dsp.window.fullscreen({mode = "fullscreen"}), { ["description"] = "fullscreen" })
hl.bind(v.mainMod .. " + CTRL + F", hl.dsp.window.fullscreen({mode = "maximized"}), { ["description"] = "maximize window" })
hl.bind(v.mainMod .. " + SPACE", hl.dsp.window.float(), { ["description"] = "Float current window" })
-- workspaceopt allfloat was already removed in 0.56.2; keep its existing no-op behavior.
hl.bind(v.mainMod .. " + ALT + SPACE", hl.dsp.no_op(), { ["description"] = "Float all windows (removed upstream)" })
hl.bind(v.mainMod .. " + SHIFT + Return", hl.dsp.exec_cmd(v.scriptsDir .. "/Dropterminal.sh " .. v.term), { ["description"] = "DropDown terminal" })

-- Desktop zooming or magnifier
hl.bind(v.mainMod .. " + ALT + mouse_down", function() hl.config({cursor = {zoom_factor = math.max(1, hl.get_config("cursor.zoom_factor")) * 2.0}}) end, { ["description"] = "zoom in" })
hl.bind(v.mainMod .. " + ALT + mouse_up", function() hl.config({cursor = {zoom_factor = math.max(1, hl.get_config("cursor.zoom_factor")) * 0.5}}) end, { ["description"] = "zoom out" })

-- Waybar / Bar related
hl.bind(v.mainMod .. " + CTRL + ALT + B", hl.dsp.exec_cmd("pkill -SIGUSR1 waybar"), { ["description"] = "toggle waybar on/off" })
hl.bind(v.mainMod .. " + CTRL + B", hl.dsp.exec_cmd(v.scriptsDir .. "/WaybarStyles.sh"), { ["description"] = "waybar styles menu" })
hl.bind(v.mainMod .. " + ALT + B", hl.dsp.exec_cmd(v.scriptsDir .. "/WaybarLayout.sh"), { ["description"] = "waybar layout menu" })

-- Night light toggle (Hyprsunset)
hl.bind(v.mainMod .. " + N", hl.dsp.exec_cmd(v.scriptsDir .. "/Hyprsunset.sh toggle"), { ["description"] = "toggle night light" })

-- FEATURES / EXTRAS (UserScripts)
hl.bind(v.mainMod .. " + SHIFT + M", hl.dsp.exec_cmd(v.UserScripts .. "/RofiBeats.sh"), { ["description"] = "online music" })
hl.bind(v.mainMod .. " + W", hl.dsp.exec_cmd(v.UserScripts .. "/WallpaperSelect.sh"), { ["description"] = "select wallpaper" })
hl.bind(v.mainMod .. " + SHIFT + W", hl.dsp.exec_cmd(v.UserScripts .. "/WallpaperEffects.sh"), { ["description"] = "wallpaper effects" })
hl.bind("CTRL + ALT + W", hl.dsp.exec_cmd(v.UserScripts .. "/WallpaperRandom.sh"), { ["description"] = "random wallpaper" })
hl.bind(v.mainMod .. " + CTRL + O", hl.dsp.window.set_prop({window="active", prop="opaque", value="toggle"}), { ["description"] = "toggle active window opacity" })
hl.bind(v.mainMod .. " + SHIFT + K", hl.dsp.exec_cmd(v.scriptsDir .. "/KeyBinds.sh"), { ["description"] = "search keybinds" })
hl.bind(v.mainMod .. " + SHIFT + A", hl.dsp.exec_cmd(v.scriptsDir .. "/Animations.sh"), { ["description"] = "animations menu" })
hl.bind(v.mainMod .. " + SHIFT + O", hl.dsp.exec_cmd(v.UserScripts .. "/ZshChangeTheme.sh"), { ["description"] = "change oh-my-zsh theme" })
hl.bind("ALT + SHIFT_L", hl.dsp.exec_cmd(v.scriptsDir .. "/KeyboardLayout.sh switch"), { ["description"] = "switch keyboard layout globally", ["locked"] = true, ["non_consuming"] = true })
hl.bind("SHIFT + ALT_L", hl.dsp.exec_cmd(v.scriptsDir .. "/Tak0-Per-Window-Switch.sh"), { ["description"] = "switch keyboard layout per-window", ["locked"] = true, ["non_consuming"] = true })
hl.bind(v.mainMod .. " + ALT + C", hl.dsp.exec_cmd(v.UserScripts .. "/RofiCalc.sh"), { ["description"] = "calculator" })

-- Move current workspaces to monitors (left right up or down)
hl.bind(v.mainMod .. " + CTRL + F9", hl.dsp.workspace.move({monitor = "l"}), { ["description"] = "move workspace to left monitor" })
hl.bind(v.mainMod .. " + CTRL + F10", hl.dsp.workspace.move({monitor = "r"}), { ["description"] = "move workspace to right monitor" })
hl.bind(v.mainMod .. " + CTRL + F11", hl.dsp.workspace.move({monitor = "u"}), { ["description"] = "move workspace to up monitor" })
hl.bind(v.mainMod .. " + CTRL + F12", hl.dsp.workspace.move({monitor = "d"}), { ["description"] = "move workspace to down monitor" })


--### SYSTEM ####
hl.bind("CTRL + ALT + Delete", hl.dsp.exit(), { ["description"] = "exit Hyprland" })
hl.bind(v.mainMod .. " + Q", hl.dsp.window.close(), { ["description"] = "close active window" })
hl.bind(v.mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd(v.scriptsDir .. "/KillActiveProcess.sh"), { ["description"] = "Terminate active process" })
hl.bind("CTRL + ALT + L", hl.dsp.exec_cmd(v.scriptsDir .. "/LockScreen.sh"), { ["description"] = "lock screen" })
hl.bind("CTRL + ALT + P", hl.dsp.exec_cmd(v.scriptsDir .. "/Wlogout.sh"), { ["description"] = "powermenu" })
hl.bind(v.mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("swaync-client -t -sw"), { ["description"] = "notification panel" })
hl.bind(v.mainMod .. " + SHIFT + E", hl.dsp.exec_cmd(v.scriptsDir .. "/Kool_Quick_Settings.sh"), { ["description"] = "Quick settings menu" })

-- Master Layout
hl.bind(v.mainMod .. " + CTRL + D", hl.dsp.layout("removemaster"), { ["description"] = "remove master" })
hl.bind(v.mainMod .. " + I", hl.dsp.layout("addmaster"), { ["description"] = "add master" })
-- NOTE: J/K bindings are set dynamically by scripts/KeybindsLayoutInit.sh and scripts/ChangeLayout.sh
-- (we intentionally do not bind them statically here to avoid conflicts across layouts)
-- bindd = $mainMod, J, cycle next, layoutmsg, cyclenext
-- bindd = $mainMod, K, cycle previous, layoutmsg, cycleprev
hl.bind(v.mainMod .. " + CTRL + Return", hl.dsp.layout("swapwithmaster"), { ["description"] = "swap with master" })

-- Dwindle Layout
hl.bind(v.mainMod .. " + SHIFT + I", hl.dsp.layout("togglesplit"), { ["description"] = "toggle split (dwindle)" })
hl.bind(v.mainMod .. " + P", hl.dsp.window.pseudo(), { ["description"] = "toggle pseudo (dwindle)" })

-- Works on either layout (Master or Dwindle)
-- The legacy splitratio dispatcher was already removed; layout("splitratio 0.3")
-- would increment the ratio and introduce behavior that was not active before.
hl.bind(v.mainMod .. " + M", hl.dsp.no_op(), { ["description"] = "set split ratio 0.3 (removed upstream)" })
-- layout aware keybinds
require("startup")(v.scriptsDir .. "/ChangeLayout.sh init")


-- Cycle windows; if floating bring to top
hl.bind("ALT + tab", hl.dsp.window.cycle_next({next = true}), { ["description"] = "cycle next window" })
hl.bind("ALT + tab", hl.dsp.window.bring_to_top(), { ["description"] = "bring active to top" })

-- Special Keys / Hot Keys
hl.bind("xf86audioraisevolume", hl.dsp.exec_cmd(v.scriptsDir .. "/Volume.sh --inc"), { ["description"] = "volume up", ["repeating"] = true, ["locked"] = true })
hl.bind("xf86audiolowervolume", hl.dsp.exec_cmd(v.scriptsDir .. "/Volume.sh --dec"), { ["description"] = "volume down", ["repeating"] = true, ["locked"] = true })
hl.bind("ALT + xf86audioraisevolume", hl.dsp.exec_cmd(v.scriptsDir .. "/Volume.sh --inc-precise"), { ["description"] = "volume up precise", ["repeating"] = true, ["locked"] = true })
hl.bind("ALT + xf86audiolowervolume", hl.dsp.exec_cmd(v.scriptsDir .. "/Volume.sh --dec-precise"), { ["description"] = "volume down precise", ["repeating"] = true, ["locked"] = true })
hl.bind("xf86AudioMicMute", hl.dsp.exec_cmd(v.scriptsDir .. "/Volume.sh --toggle-mic"), { ["description"] = "toggle mic mute", ["locked"] = true })
hl.bind("xf86audiomute", hl.dsp.exec_cmd(v.scriptsDir .. "/Volume.sh --toggle"), { ["description"] = "toggle mute", ["locked"] = true })
hl.bind("xf86Sleep", hl.dsp.exec_cmd("systemctl suspend"), { ["description"] = "sleep", ["locked"] = true })
hl.bind("xf86Rfkill", hl.dsp.exec_cmd(v.scriptsDir .. "/AirplaneMode.sh"), { ["description"] = "airplane mode", ["locked"] = true })

-- media controls using keyboards
-- XF86AudioPlayPause is not an XKB keysym; the existing XF86AudioPlay binding below handles play/pause.
hl.bind("xf86AudioPause", hl.dsp.exec_cmd(v.scriptsDir .. "/MediaCtrl.sh --pause"), { ["description"] = "pause", ["locked"] = true })
hl.bind("xf86AudioPlay", hl.dsp.exec_cmd(v.scriptsDir .. "/MediaCtrl.sh --pause"), { ["description"] = "play", ["locked"] = true })
hl.bind("xf86AudioNext", hl.dsp.exec_cmd(v.scriptsDir .. "/MediaCtrl.sh --nxt"), { ["description"] = "next track", ["locked"] = true })
hl.bind("xf86AudioPrev", hl.dsp.exec_cmd(v.scriptsDir .. "/MediaCtrl.sh --prv"), { ["description"] = "previous track", ["locked"] = true })
hl.bind("xf86audiostop", hl.dsp.exec_cmd(v.scriptsDir .. "/MediaCtrl.sh --stop"), { ["description"] = "stop", ["locked"] = true })

-- Screenshot keybindings NOTE: You may need to press Fn key as well
hl.bind(v.mainMod .. " + Print", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --now"), { ["description"] = "screenshot now" })
hl.bind(v.mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --area"), { ["description"] = "screenshot (area)" })
hl.bind(v.mainMod .. " + CTRL + Print", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --in5"), { ["description"] = "screenshot in 5s" })
hl.bind(v.mainMod .. " + CTRL + SHIFT + Print", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --in10"), { ["description"] = "screenshot in 10s" })
hl.bind("ALT + Print", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --active"), { ["description"] = "screenshot active window" })

-- screenshot with swappy (another screenshot tool)
hl.bind(v.mainMod .. " + SHIFT + S", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --swappy"), { ["description"] = "screenshot (swappy)" })

-- Resize windows
hl.bind(v.mainMod .. " + SHIFT + left", hl.dsp.window.resize({x=-50, y=0, relative=true}), { ["description"] = "resize left (-50)", ["repeating"] = true })
hl.bind(v.mainMod .. " + SHIFT + right", hl.dsp.window.resize({x=50, y=0, relative=true}), { ["description"] = "resize right (+50)", ["repeating"] = true })
hl.bind(v.mainMod .. " + SHIFT + up", hl.dsp.window.resize({x=0, y=-50, relative=true}), { ["description"] = "resize up (-50)", ["repeating"] = true })
hl.bind(v.mainMod .. " + SHIFT + down", hl.dsp.window.resize({x=0, y=50, relative=true}), { ["description"] = "resize down (+50)", ["repeating"] = true })

-- Move windows
hl.bind(v.mainMod .. " + CTRL + left", hl.dsp.window.move({direction = "left"}), { ["description"] = "move window left" })
hl.bind(v.mainMod .. " + CTRL + right", hl.dsp.window.move({direction = "right"}), { ["description"] = "move window right" })
hl.bind(v.mainMod .. " + CTRL + up", hl.dsp.window.move({direction = "up"}), { ["description"] = "move window up" })
hl.bind(v.mainMod .. " + CTRL + down", hl.dsp.window.move({direction = "down"}), { ["description"] = "move window down" })

-- Swap windows
hl.bind(v.mainMod .. " + ALT + left", hl.dsp.window.swap({direction = "left"}), { ["description"] = "swap window left" })
hl.bind(v.mainMod .. " + ALT + right", hl.dsp.window.swap({direction = "right"}), { ["description"] = "swap window right" })
hl.bind(v.mainMod .. " + ALT + up", hl.dsp.window.swap({direction = "up"}), { ["description"] = "swap window up" })
hl.bind(v.mainMod .. " + ALT + down", hl.dsp.window.swap({direction = "down"}), { ["description"] = "swap window down" })

-- group
hl.bind(v.mainMod .. " + G", hl.dsp.group.toggle(), { ["description"] = "toggle group" })

-- Navigate within a group
hl.bind(v.mainMod .. " + Tab", hl.dsp.group.next(), { ["description"] = "Change Group Forward" })
hl.bind(v.mainMod .. " + CTRL + tab", hl.dsp.group.next(), { ["description"] = "change active in group" })
hl.bind(v.mainMod .. " + SHIFT + Tab", hl.dsp.group.prev(), { ["description"] = "Change Group Back" })

-- Move window into/out of group
hl.bind(v.mainMod .. " + CTRL + K", hl.dsp.window.move({into_group = "left"}), { ["description"] = "Move left into group" })
hl.bind(v.mainMod .. " + CTRL + L", hl.dsp.window.move({into_group = "right"}), { ["description"] = "Move Right into group" })
hl.bind(v.mainMod .. " + CTRL + H", hl.dsp.window.move({out_of_group=true}), { ["description"] = "Move active out of group" })

-- Try to dynamically move in grouped window and when ungrouped
--  Not working for me DW 11/26/25  PR: https://github.com/JaKooLit/Hyprland-Dots/pull/872
--bindd = $mainMod, right, focus right, exec, bash -c 'if hyprctl activewindow -j | jq -e "((.grouped | type) == \"boolean\") or (.address == (.grouped[-1] // empty))" >/dev/null 2>&1; then hyprctl dispatch movefocus r; else hyprctl dispatch changegroupactive f; fi'
--bindd = $mainMod, left, focus left, exec, bash -c 'if hyprctl activewindow -j | jq -e "((.grouped | type) == \"boolean\") or (.address == (.grouped[0] // empty))" >/dev/null 2>&1; then hyprctl dispatch movefocus l; else hyprctl dispatch changegroupactive b; fi'

-- Move focus with mainMod + arrow keys
hl.bind(v.mainMod .. " + left", hl.dsp.focus({direction = "left"}), { ["description"] = "focus left" })
hl.bind(v.mainMod .. " + right", hl.dsp.focus({direction = "right"}), { ["description"] = "focus right" })
hl.bind(v.mainMod .. " + up", hl.dsp.focus({direction = "up"}), { ["description"] = "focus up" })
hl.bind(v.mainMod .. " + down", hl.dsp.focus({direction = "down"}), { ["description"] = "focus down" })

-- Workspaces related
hl.bind(v.mainMod .. " + tab", hl.dsp.focus({workspace="m+1"}), { ["description"] = "next workspace" })
hl.bind(v.mainMod .. " + SHIFT + tab", hl.dsp.focus({workspace="m-1"}), { ["description"] = "previous workspace" })

-- Special workspace
hl.bind(v.mainMod .. " + SHIFT + U", hl.dsp.window.move({workspace="special", follow=true}), { ["description"] = "move to special workspace" })
hl.bind(v.mainMod .. " + U", hl.dsp.workspace.toggle_special(""), { ["description"] = "toggle special workspace" })

-- The following mappings use the key codes to better support various keyboard layouts
-- 1 is code:10, 2 is code 11, etc
-- Switch workspaces with mainMod + [0-9]
hl.bind(v.mainMod .. " + code:10", hl.dsp.focus({workspace="1"}), { ["description"] = "workspace 1" })
hl.bind(v.mainMod .. " + code:11", hl.dsp.focus({workspace="2"}), { ["description"] = "workspace 2" })
hl.bind(v.mainMod .. " + code:12", hl.dsp.focus({workspace="3"}), { ["description"] = "workspace 3" })
hl.bind(v.mainMod .. " + code:13", hl.dsp.focus({workspace="4"}), { ["description"] = "workspace 4" })
hl.bind(v.mainMod .. " + code:14", hl.dsp.focus({workspace="5"}), { ["description"] = "workspace 5" })
hl.bind(v.mainMod .. " + code:15", hl.dsp.focus({workspace="6"}), { ["description"] = "workspace 6" })
hl.bind(v.mainMod .. " + code:16", hl.dsp.focus({workspace="7"}), { ["description"] = "workspace 7" })
hl.bind(v.mainMod .. " + code:17", hl.dsp.focus({workspace="8"}), { ["description"] = "workspace 8" })
hl.bind(v.mainMod .. " + code:18", hl.dsp.focus({workspace="9"}), { ["description"] = "workspace 9" })
hl.bind(v.mainMod .. " + code:19", hl.dsp.focus({workspace="10"}), { ["description"] = "workspace 10" })

-- Move active window and follow to workspace mainMod + SHIFT [0-9]
hl.bind(v.mainMod .. " + SHIFT + code:10", hl.dsp.window.move({workspace="1", follow=true}), { ["description"] = "move to workspace 1" })
hl.bind(v.mainMod .. " + SHIFT + code:11", hl.dsp.window.move({workspace="2", follow=true}), { ["description"] = "move to workspace 2" })
hl.bind(v.mainMod .. " + SHIFT + code:12", hl.dsp.window.move({workspace="3", follow=true}), { ["description"] = "move to workspace 3" })
hl.bind(v.mainMod .. " + SHIFT + code:13", hl.dsp.window.move({workspace="4", follow=true}), { ["description"] = "move to workspace 4" })
hl.bind(v.mainMod .. " + SHIFT + code:14", hl.dsp.window.move({workspace="5", follow=true}), { ["description"] = "move to workspace 5" })
hl.bind(v.mainMod .. " + SHIFT + code:15", hl.dsp.window.move({workspace="6", follow=true}), { ["description"] = "move to workspace 6" })
hl.bind(v.mainMod .. " + SHIFT + code:16", hl.dsp.window.move({workspace="7", follow=true}), { ["description"] = "move to workspace 7" })
hl.bind(v.mainMod .. " + SHIFT + code:17", hl.dsp.window.move({workspace="8", follow=true}), { ["description"] = "move to workspace 8" })
hl.bind(v.mainMod .. " + SHIFT + code:18", hl.dsp.window.move({workspace="9", follow=true}), { ["description"] = "move to workspace 9" })
hl.bind(v.mainMod .. " + SHIFT + code:19", hl.dsp.window.move({workspace="10", follow=true}), { ["description"] = "move to workspace 10" })
hl.bind(v.mainMod .. " + SHIFT + bracketleft", hl.dsp.window.move({workspace="-1", follow=true}), { ["description"] = "move to previous workspace" })
hl.bind(v.mainMod .. " + SHIFT + bracketright", hl.dsp.window.move({workspace="+1", follow=true}), { ["description"] = "move to next workspace" })

-- Move active window to a workspace silently mainMod + CTRL [0-9]
hl.bind(v.mainMod .. " + CTRL + code:10", hl.dsp.window.move({workspace="1", follow=false}), { ["description"] = "move silently to workspace 1" })
hl.bind(v.mainMod .. " + CTRL + code:11", hl.dsp.window.move({workspace="2", follow=false}), { ["description"] = "move silently to workspace 2" })
hl.bind(v.mainMod .. " + CTRL + code:12", hl.dsp.window.move({workspace="3", follow=false}), { ["description"] = "move silently to workspace 3" })
hl.bind(v.mainMod .. " + CTRL + code:13", hl.dsp.window.move({workspace="4", follow=false}), { ["description"] = "move silently to workspace 4" })
hl.bind(v.mainMod .. " + CTRL + code:14", hl.dsp.window.move({workspace="5", follow=false}), { ["description"] = "move silently to workspace 5" })
hl.bind(v.mainMod .. " + CTRL + code:15", hl.dsp.window.move({workspace="6", follow=false}), { ["description"] = "move silently to workspace 6" })
hl.bind(v.mainMod .. " + CTRL + code:16", hl.dsp.window.move({workspace="7", follow=false}), { ["description"] = "move silently to workspace 7" })
hl.bind(v.mainMod .. " + CTRL + code:17", hl.dsp.window.move({workspace="8", follow=false}), { ["description"] = "move silently to workspace 8" })
hl.bind(v.mainMod .. " + CTRL + code:18", hl.dsp.window.move({workspace="9", follow=false}), { ["description"] = "move silently to workspace 9" })
hl.bind(v.mainMod .. " + CTRL + code:19", hl.dsp.window.move({workspace="10", follow=false}), { ["description"] = "move silently to workspace 10" })
hl.bind(v.mainMod .. " + CTRL + bracketleft", hl.dsp.window.move({workspace="-1", follow=false}), { ["description"] = "move silently to previous workspace" })
hl.bind(v.mainMod .. " + CTRL + bracketright", hl.dsp.window.move({workspace="+1", follow=false}), { ["description"] = "move silently to next workspace" })

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(v.mainMod .. " + mouse_down", hl.dsp.focus({workspace="e+1"}), { ["description"] = "next workspace" })
hl.bind(v.mainMod .. " + mouse_up", hl.dsp.focus({workspace="e-1"}), { ["description"] = "previous workspace" })
hl.bind(v.mainMod .. " + period", hl.dsp.focus({workspace="e+1"}), { ["description"] = "next workspace" })
hl.bind(v.mainMod .. " + comma", hl.dsp.focus({workspace="e-1"}), { ["description"] = "previous workspace" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(v.mainMod .. " + mouse:272", hl.dsp.window.drag(), { ["description"] = "move window" })
hl.bind(v.mainMod .. " + mouse:273", hl.dsp.window.resize(), { ["description"] = "resize window" })
