-- Native Lua configuration: configs/WindowRules.lua.
local v = require("variables")

-- /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  #
-- Vendor defaults for window rules and layerrules
-- See https://wiki.hyprland.org/Configuring/Window-Rules/ for more

-- NOTES: This is only for Hyprland >= 0.53

--  Some samples on hwo to start apps on specific workspaces
-- windowrule = match:tag email*, workspace 1
-- windowrule = match:tag browser*, workspace 2
-- windowrule = match:tag projects*, workspace 3
-- windowrule = match:tag screenshare*, workspace 4 silent
-- windowrule = match:tag gamestore*, workspace 5
-- windowrule = match:class ^(virt-manager)$, workspace 6 silent
-- windowrule = match:class ^(.virt-manager-wrapped)$, workspace 6 silent
-- windowrule = match:tag im*, workspace 7
-- windowrule = match:class obsidian, workspace 8
-- windowrule = match:tag games*, workspace 8
-- windowrule = match:tag multimedia*, workspace 9 silent



-- TAGS - add apps under appropriate tag to use the same settings
-- browser tags
hl.window_rule({ ["tag"] = "+browser", ["match"] = { ["class"] = "^([Ff]irefox|org.mozilla.firefox|[Ff]irefox-esr|[Ff]irefox-bin)$" } })
hl.window_rule({ ["tag"] = "+browser", ["match"] = { ["class"] = "^([Gg]oogle-chrome(-beta|-dev|-unstable)?)$" } })
hl.window_rule({ ["tag"] = "+browser", ["match"] = { ["class"] = "^(chrome-.+-Default)$" } })
hl.window_rule({ ["tag"] = "+browser", ["match"] = { ["class"] = "^([Cc]hromium)$" } })
hl.window_rule({ ["tag"] = "+browser", ["match"] = { ["class"] = "^([Mm]icrosoft-edge(-stable|-beta|-dev|-unstable))$" } })
hl.window_rule({ ["tag"] = "+browser", ["match"] = { ["class"] = "^(Brave-browser(-beta|-dev|-unstable)?)$" } })
hl.window_rule({ ["tag"] = "+browser", ["match"] = { ["class"] = "^([Tt]horium-browser|[Cc]achy-browser)$" } })
hl.window_rule({ ["tag"] = "+browser", ["match"] = { ["class"] = "^(zen-alpha|zen)$" } })

-- notif tags
hl.window_rule({ ["tag"] = "+notif", ["match"] = { ["class"] = "^(swaync-control-center|swaync-notification-window|swaync-client|class)$" } })

-- KooL settings tag
hl.window_rule({ ["tag"] = "+KooL_Cheat", ["match"] = { ["title"] = "^(KooL Quick Cheat Sheet)$" } })
hl.window_rule({ ["tag"] = "+KooL_Settings", ["match"] = { ["title"] = "^(KooL Hyprland Settings)$" } })
hl.window_rule({ ["tag"] = "+KooL-Settings", ["match"] = { ["class"] = "^(nwg-displays|nwg-look)$" } })

-- terminal tags
hl.window_rule({ ["tag"] = "+terminal", ["match"] = { ["class"] = "^(Alacritty|kitty|kitty-dropterm)$" } })

-- email tags
hl.window_rule({ ["tag"] = "+email", ["match"] = { ["class"] = "^([Tt]hunderbird|org.mozilla.Thunderbird)$" } })
hl.window_rule({ ["tag"] = "+email", ["match"] = { ["class"] = "^(eu.betterbird.Betterbird)$" } })
hl.window_rule({ ["tag"] = "+email", ["match"] = { ["class"] = "^(org.gnome.Evolution)$" } })

-- project tags
hl.window_rule({ ["tag"] = "+projects", ["match"] = { ["class"] = "^(codium|codium-url-handler|VSCodium)$" } })
hl.window_rule({ ["tag"] = "+projects", ["match"] = { ["class"] = "^(VSCode|code|code-url-handler)$" } })
hl.window_rule({ ["tag"] = "+projects", ["match"] = { ["class"] = "^(jetbrains-.+)$" } })
hl.window_rule({ ["tag"] = "+projects", ["match"] = { ["class"] = "^(dev.zed.Zed|antigravity)$" } })

-- screenshare tags
hl.window_rule({ ["tag"] = "+screenshare", ["match"] = { ["class"] = "^(com.obsproject.Studio)$" } })

-- IM tags
hl.window_rule({ ["tag"] = "+im", ["match"] = { ["class"] = "^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$" } })
hl.window_rule({ ["tag"] = "+im", ["match"] = { ["class"] = "^([Ff]erdium)$" } })
hl.window_rule({ ["tag"] = "+im", ["match"] = { ["class"] = "^([Ww]hatsapp-for-linux)$" } })
hl.window_rule({ ["tag"] = "+im", ["match"] = { ["class"] = "^(org.telegram.desktop|io.github.tdesktop_x64.TDesktop)$" } })
hl.window_rule({ ["tag"] = "+im", ["match"] = { ["class"] = "^(teams-for-linux)$" } })
hl.window_rule({ ["tag"] = "+im", ["match"] = { ["class"] = "^(im.riot.Riot|Element)$" } })

-- game tags
hl.window_rule({ ["tag"] = "+games", ["match"] = { ["class"] = "^(gamescope)$" } })
hl.window_rule({ ["tag"] = "+games", ["match"] = { ["class"] = "^(steam_app_\\\\d+)$" } })

-- gamestore tags
hl.window_rule({ ["tag"] = "+gamestore", ["match"] = { ["class"] = "^([Ss]team)$" } })
hl.window_rule({ ["tag"] = "+gamestore", ["match"] = { ["title"] = "^([Ll]utris)$" } })
hl.window_rule({ ["tag"] = "+gamestore", ["match"] = { ["class"] = "^(com.heroicgameslauncher.hgl)$" } })

-- file-manager tags
hl.window_rule({ ["tag"] = "+file-manager", ["match"] = { ["class"] = "^([Tt]hunar|org.gnome.Nautilus|[Pp]cmanfm-qt)$" } })
hl.window_rule({ ["tag"] = "+file-manager", ["match"] = { ["class"] = "^(app.drey.Warp)$" } })

-- wallpaper tags
hl.window_rule({ ["tag"] = "+wallpaper", ["match"] = { ["class"] = "^([Ww]aytrogen)$" } })

-- multimedia tags
hl.window_rule({ ["tag"] = "+multimedia", ["match"] = { ["class"] = "^([Aa]udacious)$" } })

-- multimedia-video tags
hl.window_rule({ ["tag"] = "+multimedia_video", ["match"] = { ["class"] = "^([Mm]pv|vlc)$" } })

-- settings tags
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["title"] = "^(ROG Control)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(wihotspot(-gui)?)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^([Bb]aobab|org.gnome.[Bb]aobab)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(gnome-disks|wihotspot(-gui)?)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["title"] = "(Kvantum Manager)" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(file-roller|org.gnome.FileRoller)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(nm-applet|nm-connection-editor|blueman-manager)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(qt5ct|qt6ct)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "(xdg-desktop-portal-gtk)" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(org.kde.polkit-kde-authentication-agent-1)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^([Rr]ofi)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(btrfs-assistant)$" } })
hl.window_rule({ ["tag"] = "+settings", ["match"] = { ["class"] = "^(timeshift-gtk)$" } })

-- viewer tags
hl.window_rule({ ["tag"] = "+viewer", ["match"] = { ["class"] = "^(gnome-system-monitor|org.gnome.SystemMonitor|io.missioncenter.MissionCenter)$" } })
hl.window_rule({ ["tag"] = "+viewer", ["match"] = { ["class"] = "^(evince)$" } })
hl.window_rule({ ["tag"] = "+viewer", ["match"] = { ["class"] = "^(eog|org.gnome.Loupe)$" } })

-- Some special override rules
hl.window_rule({ ["no_blur"] = true, ["match"] = { ["tag"] = "multimedia_video" } })
hl.window_rule({ ["opacity"] = "1.0", ["match"] = { ["tag"] = "multimedia_video" } })
hl.window_rule({ ["no_blur"] = true, ["match"] = { ["tag"] = "multimedia" } })
hl.window_rule({ ["opacity"] = "1.0", ["match"] = { ["tag"] = "multimedia" } })

-- POSITION
hl.window_rule({ ["center"] = true, ["match"] = { ["tag"] = "KooL_Cheat" } })
hl.window_rule({ ["center"] = true, ["match"] = { ["tag"] = "KooL-Settings" } })
hl.window_rule({ ["center"] = true, ["match"] = { ["title"] = "^(ROG Control)$" } })
hl.window_rule({ ["center"] = true, ["match"] = { ["title"] = "^(Keybindings)$" } })
hl.window_rule({ ["center"] = true, ["match"] = { ["class"] = "^(pavucontrol|org.pulseaudio.pavucontrol|com.saivert.pwvucontrol)$" } })
hl.window_rule({ ["center"] = true, ["match"] = { ["class"] = "^([Ff]erdium)$" } })

-- windowrule to avoid idle for fullscreen apps
hl.window_rule({ ["idle_inhibit"] = "fullscreen", ["match"] = { ["fullscreen"] = "true" } })
hl.window_rule({ ["idle_inhibit"] = "fullscreen", ["match"] = { ["fullscreen"] = "1" } })
-- Invalid legacy regex ^(*)$ was never a working match; the valid fullscreen rule above is preserved.
-- Invalid legacy regex ^(*)$ was never a working match; the valid fullscreen rule above is preserved.

-- FLOAT
hl.window_rule({ ["float"] = true, ["match"] = { ["tag"] = "KooL_Cheat" } })
hl.window_rule({ ["float"] = true, ["center"] = true, ["match"] = { ["tag"] = "wallpaper" } })
hl.window_rule({ ["float"] = true, ["center"] = true, ["match"] = { ["tag"] = "settings" } })
hl.window_rule({ ["float"] = true, ["center"] = true, ["match"] = { ["tag"] = "viewer" } })
hl.window_rule({ ["float"] = true, ["center"] = true, ["match"] = { ["tag"] = "KooL-Settings" } })
hl.window_rule({ ["float"] = true, ["match"] = { ["class"] = "([Zz]oom|onedriver|onedriver-launcher)" } })
hl.window_rule({ ["float"] = true, ["match"] = { ["class"] = "(org.gnome.Calculator|qalculate-gtk)" } })
hl.window_rule({ ["float"] = true, ["match"] = { ["class"] = "^(mpv|com.github.rafostar.Clapper)$" } })
hl.window_rule({ ["float"] = true, ["match"] = { ["class"] = "^([Qq]alculate-gtk)$" } })
hl.window_rule({ ["float"] = true, ["match"] = { ["class"] = "^([Ff]erdium)$" } })

-- popups and dialogue
hl.window_rule({ ["float"] = true, ["center"] = true, ["match"] = { ["title"] = "^(Authentication Required)$" } })
-- Three legacy popup matchers lacked a comma before match:title, so they did
-- not match the intended applications. Keep them disabled during migration;
-- enabling corrected Codium/Heroic/Steam popup rules would change behavior.
-- hl.window_rule({ ["float"] = true, ["match"] = { ["class"] = "(codium|codium-url-handler|VSCodium)", ["title"] = "negative:(.*codium.*|.*VSCodium.*)" } })
-- hl.window_rule({ ["float"] = true, ["match"] = { ["class"] = "^(com.heroicgameslauncher.hgl)$", ["title"] = "negative:(Heroic Games Launcher)" } })
-- hl.window_rule({ ["float"] = true, ["match"] = { ["class"] = "^([Ss]team)$", ["title"] = "negative:^([Ss]team)$" } })
hl.window_rule({ ["float"] = true, ["size"] = "(monitor_w*0.7) (monitor_h*0.6)", ["center"] = true, ["match"] = { ["title"] = "^(Add Folder to Workspace)$" } })
hl.window_rule({ ["float"] = true, ["size"] = "(monitor_w*0.7) (monitor_h*0.6)", ["center"] = true, ["match"] = { ["title"] = "^(Save As)$" } })
hl.window_rule({ ["float"] = true, ["size"] = "(monitor_w*0.7) (monitor_h*0.6)", ["match"] = { ["initial_title"] = "(Open Files)" } })
hl.window_rule({ ["float"] = true, ["center"] = true, ["size"] = "(monitor_w*0.16) (monitor_h*0.12)", ["match"] = { ["title"] = "^(SDDM Background)$" } })
hl.window_rule({ ["float"] = true, ["center"] = true, ["size"] = "(monitor_w*0.2) (monitor_h*0.2)", ["match"] = { ["class"] = "^(yad)$" } })
hl.window_rule({ ["float"] = true, ["center"] = true, ["match"] = { ["class"] = "^(hyprland-donate-screen)$" } })

-- OPACITY
hl.window_rule({ ["opacity"] = "0.99 0.8", ["match"] = { ["tag"] = "browser" } })
hl.window_rule({ ["opacity"] = "0.9 0.8", ["match"] = { ["tag"] = "projects" } })
hl.window_rule({ ["opacity"] = "0.94 0.86", ["match"] = { ["tag"] = "im" } })
hl.window_rule({ ["opacity"] = "0.94 0.86", ["match"] = { ["tag"] = "multimedia" } })
hl.window_rule({ ["opacity"] = "0.9 0.8", ["match"] = { ["tag"] = "file-manager" } })
hl.window_rule({ ["opacity"] = "0.9 0.7", ["match"] = { ["tag"] = "terminal" } })
hl.window_rule({ ["opacity"] = "0.8 0.7", ["match"] = { ["tag"] = "settings" } })
hl.window_rule({ ["opacity"] = "0.82 0.75", ["match"] = { ["tag"] = "viewer" } })
hl.window_rule({ ["opacity"] = "0.9 0.7", ["match"] = { ["tag"] = "wallpaper" } })
hl.window_rule({ ["opacity"] = "0.8 0.7", ["match"] = { ["class"] = "^(gedit|org.gnome.TextEditor|mousepad)$" } })
hl.window_rule({ ["opacity"] = "0.9 0.8", ["match"] = { ["class"] = "^(deluge)$" } })
hl.window_rule({ ["opacity"] = "0.9 0.8", ["match"] = { ["class"] = "^(seahorse)$" } })
hl.window_rule({ ["opacity"] = "0.95 0.75", ["match"] = { ["title"] = "^(Picture-in-Picture)$" } })

-- SIZE
hl.window_rule({ ["size"] = "(monitor_w*0.65) (monitor_h*0.9)", ["match"] = { ["tag"] = "KooL_Cheat" } })
hl.window_rule({ ["size"] = "(monitor_w*0.7) (monitor_h*0.7)", ["match"] = { ["tag"] = "wallpaper" } })
hl.window_rule({ ["size"] = "(monitor_w*0.7) (monitor_h*0.7)", ["match"] = { ["tag"] = "settings" } })
hl.window_rule({ ["size"] = "(monitor_w*0.6) (monitor_h*0.7)", ["match"] = { ["class"] = "^([Ff]erdium)$" } })


-- BLUR & FULLSCREEN
hl.window_rule({ ["no_blur"] = true, ["fullscreen"] = 0, ["match"] = { ["tag"] = "games" } })
hl.window_rule({ ["fullscreen"] = 0, ["match"] = { ["tag"] = "games" } })

-- This not gonna take the focus to the window that appears when
-- hovering over some of the parts of the IntelliJ Products
hl.window_rule({ ["no_initial_focus"] = true, ["match"] = { ["class"] = "^(jetbrains-*)" } })
hl.window_rule({ ["no_initial_focus"] = true, ["match"] = { ["title"] = "^(wind.*)$" } })

-- LAYER RULES
hl.layer_rule({ ["blur"] = true, ["match"] = { ["namespace"] = "rofi" } })
hl.layer_rule({ ["blur"] = true, ["match"] = { ["namespace"] = "notifications" } })
hl.layer_rule({ ["blur"] = true, ["match"] = { ["namespace"] = "quickshell:overview" } })
hl.layer_rule({ ["ignore_alpha"] = 0.5, ["match"] = { ["namespace"] = "quickshell:overview" } })

-- Named rules for special cases
hl.window_rule({ ["name"] = "Whatsapp-zapzap", ["size"] = "(monitor_w*0.6) (monitor_h*0.7)", ["center"] = true, ["match"] = { ["class"] = "^([Ww]hatsapp-for-linux|ZapZap|com.rtosta.zapzap)$" } })
hl.window_rule({ ["name"] = "Picture-in-Picture", ["float"] = true, ["move"] = "72% 7%", ["opacity"] = "0.95 0.75", ["pin"] = true, ["keep_aspect_ratio"] = true, ["size"] = "(monitor_w*0.3) (monitor_h*0.3)", ["match"] = { ["title"] = "^(Picture-in-Picture)$" } })
-- Thunar copy progress dialog
hl.window_rule({ ["name"] = "Thunar-Progress-bar", ["float"] = true, ["center"] = true, ["size"] = "(monitor_w*0.26) (monitor_h*0.18)", ["match"] = { ["class"] = "^(thunar)$", ["title"] = "^(File Operation Progress)$" } })
