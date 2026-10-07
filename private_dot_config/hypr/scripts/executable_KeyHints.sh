#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##

# GDK BACKEND. Change to either wayland or x11 if having issues
BACKEND=wayland

# Check if rofi or yad is running and kill them if they are
if pidof rofi > /dev/null; then
  pkill rofi
fi

if pidof yad > /dev/null; then
  pkill yad
fi

# Launch yad with calculated width and height
GDK_BACKEND=$BACKEND yad \
    --center \
    --title="KooL Quick Cheat Sheet" \
    --no-buttons \
    --list \
    --column=Key: \
    --column=Description: \
    --column=Command: \
    --timeout-indicator=bottom \
"ESC" "close this app" "" \
"SUPER SHIFT K" "Searchable Keybinds" "(Search all Keybinds via rofi)" \
"SUPER SHIFT E" "KooL Hyprland Settings Menu" "" \
"" "" "" \
"SUPER enter" "Terminal" "(kitty)" \
"SUPER SHIFT enter" "DropDown Terminal" "SUPER Q to close" \
"SUPER B" "Launch Browser" "(Default browser)" \
"SUPER A" "Desktop Overview" "(AGS - if opted to install)" \
"SUPER D" "Application Launcher" "(rofi-wayland)" \
"SUPER E" "Open File Manager" "(Thunar)" \
"SUPER S" "Google Search using rofi" "(rofi)" \
"SUPER T" "Global theme switcher" "(rofi)" \
"SUPER Q" "close active window" "(not kill)" \
"SUPER Shift Q " "kills an active window" "(kill)" \
"SUPER ALT mouse scroll up/down   " "Desktop Zoom" "Desktop Magnifier" \
"SUPER Alt V" "Clipboard Manager" "(cliphist)" \
"SUPER W" "Choose wallpaper" "(Wallpaper Menu)" \
"SUPER Shift W" "Choose wallpaper effects" "(imagemagick + swww)" \
"CTRL ALT W" "Random wallpaper" "(via swww)" \
"SUPER CTRL ALT B" "Hide/UnHide Waybar" "waybar" \
"SUPER CTRL B" "Choose waybar styles" "(waybar styles)" \
"SUPER ALT B" "Choose waybar layout" "(waybar layout)" \
"SUPER ALT R" "Reload Waybar swaync Rofi" "CHECK NOTIFICATION FIRST!!!" \
"SUPER SHIFT N" "Launch Notification Panel" "swaync Notification Center" \
"SUPER Print" "screenshot" "(grim)" \
"SUPER Shift Print" "screenshot region" "(grim + slurp)" \
"SUPER Shift S" "screenshot region" "(swappy)" \
"SUPER CTRL Print" "screenshot timer 5 secs " "(grim)" \
"SUPER CTRL SHIFT Print" "screenshot timer 10 secs " "(grim)" \
"ALT Print" "Screenshot active window" "active window only" \
"CTRL ALT P" "power-menu" "(wlogout)" \
"CTRL ALT L" "screen lock" "(hyprlock)" \
"CTRL ALT Del" "Hyprland Exit" "(NOTE: Hyprland Will exit immediately)" \
"SUPER SHIFT F" "Fullscreen" "Toggles to full screen" \
"SUPER CTL F" "Fake Fullscreen" "Toggles to fake full screen" \
"SUPER ALT L" "Toggle Dwindle | Master Layout" "Hyprland Layout" \
"SUPER SPACEBAR" "Toggle float" "single window" \
"SUPER ALT SPACEBAR" "Toggle all windows to float" "all windows" \
"SUPER ALT O" "Toggle Blur" "normal or less blur" \
"SUPER CTRL O" "Toggle Opaque ON or OFF" "on active window only" \
"SUPER Shift A" "Animations Menu" "Choose Animations via rofi" \
"SUPER CTRL R" "Rofi Themes Menu" "Choose Rofi Themes via rofi" \
"SUPER CTRL Shift R" "Rofi Themes Menu v2" "Choose Rofi Themes via Theme Selector (modified)" \
"SUPER SHIFT G" "Gamemode! All animations OFF or ON" "toggle" \
"SUPER ALT E" "Rofi Emoticons" "Emoticon" \
"SUPER H" "Launch this Quick Cheat Sheet" "" \
"" "" "" \
"ultsaza custom (今回のセッション追加)" "" "" \
"SUPER SHIFT C" "Color picker (HEX to clipboard)" "ColorPicker.sh" \
"SUPER SHIFT R" "Screen record - full (toggle)" "ScreenRecord.sh --full" \
"SUPER ALT SHIFT R" "Screen record - region (toggle)" "ScreenRecord.sh --region" \
"" "" "" \
"More tips:" "https://github.com/JaKooLit/Hyprland-Dots/wiki" ""\
