-- Native Lua configuration: configs/SystemSettings.lua.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Default settings
-- This is where you put your own settings as this will not be touched during update
-- if the upgrade.sh is used.

-- refer to Hyprland wiki for more info https://wiki.hyprland.org/Configuring/Variables/
-- NOTE: some settings are in ~/.config/hypr/UserConfigs/UserDecorations.lua / UserAnimations.lua

v.scriptsDir = v.HOME .. "/.config/hypr/scripts"

-- pseudotile removed in Hyprland 0.55 (was a no-op).
--pseudotile = true
hl.config({ ["dwindle.preserve_split"] = true })
--smart_split = true
hl.config({ ["dwindle.special_scale_factor"] = 0.8 })

hl.config({ ["master.new_status"] = "master" })
hl.config({ ["master.new_on_top"] = true })
hl.config({ ["master.mfact"] = 0.5 })

hl.config({ ["general.resize_on_border"] = true })
hl.config({ ["general.layout"] = "dwindle" })

hl.config({ ["input.kb_layout"] = "us" })
hl.config({ ["input.kb_variant"] = "" })
hl.config({ ["input.kb_model"] = "" })
hl.config({ ["input.kb_options"] = "" })
hl.config({ ["input.kb_rules"] = "" })
hl.config({ ["input.repeat_rate"] = 50 })
hl.config({ ["input.repeat_delay"] = 300 })

hl.config({ ["input.sensitivity"] = 0 })
--accel_profile =     # flat or adaptive or blank or EMPTY means libinput’s default mode
hl.config({ ["input.numlock_by_default"] = true })
hl.config({ ["input.left_handed"] = false })
hl.config({ ["input.follow_mouse"] = 1 })
hl.config({ ["input.float_switch_override_focus"] = false })

hl.config({ ["input.touchpad.disable_while_typing"] = true })
hl.config({ ["input.touchpad.natural_scroll"] = true })
hl.config({ ["input.touchpad.clickfinger_behavior"] = false })
hl.config({ ["input.touchpad.middle_button_emulation"] = false })
hl.config({ ["input.touchpad.tap_to_click"] = true })
hl.config({ ["input.touchpad.drag_lock"] = false })

-- below for devices with touchdevice ie. touchscreen
hl.config({ ["input.touchdevice.enabled"] = true })

-- below is for table see link above for proper variables
hl.config({ ["input.tablet.transform"] = 0 })
hl.config({ ["input.tablet.left_handed"] = false })


hl.gesture({fingers=3, direction="horizontal", action="workspace"})
hl.config({ ["gestures.workspace_swipe_distance"] = 500 })
hl.config({ ["gestures.workspace_swipe_invert"] = true })
hl.config({ ["gestures.workspace_swipe_min_speed_to_force"] = 30 })
hl.config({ ["gestures.workspace_swipe_cancel_ratio"] = 0.5 })
hl.config({ ["gestures.workspace_swipe_create_new"] = true })
hl.config({ ["gestures.workspace_swipe_forever"] = true })
--workspace_swipe_use_r = true #uncomment if wanted a forever create a new workspace with swipe right

hl.gesture({fingers=4, direction="up", action=function() hl.config({cursor = {zoom_factor = math.max(1, hl.get_config("cursor.zoom_factor")) * 1.5}}) end})
hl.gesture({fingers=4, direction="down", action=function() hl.config({cursor = {zoom_factor = math.max(1, hl.get_config("cursor.zoom_factor")) * (1/1.5)}}) end})
hl.gesture({fingers=3, direction="up", action=function() hl.dispatch(hl.dsp.exec_cmd(v.scriptsDir .. "/OverviewToggle.sh")) end})

hl.config({ ["misc.disable_hyprland_logo"] = true })
hl.config({ ["misc.disable_splash_rendering"] = true })
-- misc:vfr removed in Hyprland 0.55 (now always on / handled automatically).
--vfr = true
hl.config({ ["misc.vrr"] = 2 })
hl.config({ ["misc.mouse_move_enables_dpms"] = true })
hl.config({ ["misc.enable_swallow"] = false })
hl.config({ ["misc.swallow_regex"] = "^(kitty)$" })
hl.config({ ["misc.focus_on_activate"] = false })
hl.config({ ["misc.initial_workspace_tracking"] = 0 })
hl.config({ ["misc.middle_click_paste"] = false })
hl.config({ ["misc.enable_anr_dialog"] = true })
hl.config({ ["misc.anr_missed_pings"] = 15 })
hl.config({ ["misc.allow_session_lock_restore"] = true })
-- This only works with HL v0.53+
hl.config({ ["misc.on_focus_under_fullscreen"] = 1 })
-- 0 - Default, no change
-- 1 - New focused window takes over fullscreen (Windows-like Alt-Tab)
-- 2 - New focused window stays behind the fullscreen one

--opengl {
--  nvidia_anti_flicker = true
--}

hl.config({ ["binds.workspace_back_and_forth"] = true })
hl.config({ ["binds.allow_workspace_cycles"] = true })
hl.config({ ["binds.pass_mouse_when_bound"] = false })

--Could help when scaling and not pixelating
hl.config({ ["xwayland.enabled"] = true })
hl.config({ ["xwayland.force_zero_scaling"] = true })

hl.config({ ["render.direct_scanout"] = 0 })

hl.config({ ["cursor.sync_gsettings_theme"] = true })
hl.config({ ["cursor.no_hardware_cursors"] = 2 })
hl.config({ ["cursor.enable_hyprcursor"] = true })
hl.config({ ["cursor.warp_on_change_workspace"] = 2 })
hl.config({ ["cursor.no_warps"] = true })
