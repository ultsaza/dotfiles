-- Migrated from configs/Laptops.conf; edit this Lua file going forward.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- See https://wiki.hyprland.org/Configuring/Keywords/ for more variable settings
-- These configs are mostly for laptops. This is addemdum to Keybinds.conf

v.mainMod = "SUPER"
v.scriptsDir = v.HOME .. "/.config/hypr/scripts"
v.UserConfigs = v.HOME .. "/.config/hypr/UserConfigs"

-- for disabling Touchpad. hyprctl devices to get device name.
v.Touchpad_Device = "asue1209:00-04f3:319f-touchpad"

hl.bind("xf86KbdBrightnessDown", hl.dsp.exec_cmd(v.scriptsDir .. "/BrightnessKbd.sh --dec"), { ["repeating"] = true })
hl.bind("xf86KbdBrightnessUp", hl.dsp.exec_cmd(v.scriptsDir .. "/BrightnessKbd.sh --inc"), { ["repeating"] = true })
hl.bind("xf86Launch1", hl.dsp.exec_cmd("rog-control-center"), {  })
hl.bind("xf86Launch3", hl.dsp.exec_cmd("asusctl led-mode -n"), {  })
hl.bind("xf86Launch4", hl.dsp.exec_cmd("asusctl profile -n"), {  })
hl.bind("xf86MonBrightnessDown", hl.dsp.exec_cmd(v.scriptsDir .. "/Brightness.sh --dec"), { ["repeating"] = true })
hl.bind("xf86MonBrightnessUp", hl.dsp.exec_cmd(v.scriptsDir .. "/Brightness.sh --inc"), { ["repeating"] = true })
hl.bind("xf86TouchpadToggle", hl.dsp.exec_cmd(v.scriptsDir .. "/TouchPad.sh"), {  })

-- Screenshot keybindings using F6 (no PrinSrc button)
hl.bind(v.mainMod .. " + F6", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --now"), {  })
hl.bind(v.mainMod .. " + SHIFT + F6", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --area"), {  })
hl.bind(v.mainMod .. " + CTRL + F6", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --in5"), {  })
hl.bind(v.mainMod .. " + ALT + F6", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --in10"), {  })
hl.bind("ALT + F6", hl.dsp.exec_cmd(v.scriptsDir .. "/ScreenShot.sh --active"), {  })

v.TOUCHPAD_ENABLED = true
hl.device({ ["name"] = v.Touchpad_Device, ["enabled"] = v.TOUCHPAD_ENABLED })
