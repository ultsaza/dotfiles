#!/usr/bin/env bash
# WaybarCava.sh — cava audio visualizer feed for Waybar.
# Original concept by JaKooLit. This variant focuses on CPU cost & lifecycle:
#   * framerate 15 (was 30) + duplicate-frame suppression -> Waybar performs
#     ZERO redraws while audio is silent or unchanged. This was the main CPU
#     hog: cava emits a frame every tick even in silence, and each line forced
#     a full bar redraw, pegging ~2 cores with translucent CSS.
#   * cleanup() kills the cava/sed/awk children on exit (the previous version
#     used `exec` + a cleanup that only removed temp files, so cava leaked on
#     every reload/crash and piled up across sessions).
# Stale leftovers from an improperly-killed Waybar (SIGKILL, no TERM) are swept
# in the Waybar (re)launch path (see Refresh.sh), not here, to keep this
# per-bar hot path cheap and race-free on multi-monitor setups.

set -uo pipefail

# Ensure cava exists
if ! command -v cava >/dev/null 2>&1; then
  echo "cava not found in PATH" >&2
  exit 1
fi

# 0..7 → ▁▂▃▄▅▆▇█
bar="▁▂▃▄▅▆▇█"
dict="s/;//g"
bar_length=${#bar}
for ((i = 0; i < bar_length; i++)); do
  dict+=";s/$i/${bar:$i:1}/g"
done

# Unique temp config; kill our children + remove the file on any exit.
RUNTIME_DIR="${XDG_RUNTIME_DIR:-/tmp}"
config_file="$(mktemp "$RUNTIME_DIR/waybar-cava.XXXXXX.conf")"
cleanup() {
  trap - EXIT INT TERM
  pkill -P $$ 2>/dev/null || true   # cava + sed + awk
  rm -f "$config_file"
}
trap cleanup EXIT INT TERM

cat >"$config_file" <<EOF
[general]
framerate = 15
bars = 10

[input]
method = pulse
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# cava → glyph translation → emit only when the frame CHANGES. Suppressing
# identical consecutive frames means no Waybar redraw while audio is silent or
# static. No `exec`, so cava/sed/awk stay children of this script and are
# reaped by cleanup() on exit.
cava -p "$config_file" | sed -u "$dict" | awk '{ if ($0 != prev) { print; fflush() } prev = $0 }'
