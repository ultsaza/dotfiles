-- Migrated from UserConfigs/UserKeybinds.conf; edit this Lua file going forward.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- User additions to Keybinds.conf go here.
-- Defaults live in ~/.config/hypr/configs/Keybinds.conf — duplicate them only when overriding.
--
-- Note: Variables ($mainMod, $scriptsDir, $UserScripts, $UserConfigs) are already
-- defined in configs/Keybinds.conf and can be reused here without re-declaration.

hl.bind(v.mainMod .. " + SHIFT + C", hl.dsp.exec_cmd(v.UserScripts .. "/ColorPicker.sh"), { ["description"] = "color picker (HEX to clipboard)" })

-- Screen recording (wf-recorder). Same shortcut toggles stop.
hl.bind(v.mainMod .. " + SHIFT + R", hl.dsp.exec_cmd(v.UserScripts .. "/ScreenRecord.sh --full"), { ["description"] = "screen record full (toggle)" })
hl.bind(v.mainMod .. " + ALT + SHIFT + R", hl.dsp.exec_cmd(v.UserScripts .. "/ScreenRecord.sh --region"), { ["description"] = "screen record region (toggle)" })
