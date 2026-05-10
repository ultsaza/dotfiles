#!/usr/bin/env bash
# Pick a color from screen with hyprpicker, copy HEX to clipboard, notify.
# Bound to Super+Shift+C in UserKeybinds.conf.

set -euo pipefail

if ! command -v hyprpicker >/dev/null 2>&1; then
  notify-send -a "ColorPicker" -u critical "hyprpicker not installed" "sudo apt install hyprpicker"
  exit 1
fi

color=$(hyprpicker -a -f hex 2>/dev/null || true)

if [[ -n "${color}" ]]; then
  notify-send -a "ColorPicker" -t 3000 -h "string:x-canonical-private-synchronous:colorpicker" \
    "Color picked" "${color} copied to clipboard"
fi
