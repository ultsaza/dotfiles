#!/usr/bin/env bash
# Screen recorder via wf-recorder. Pairs with scripts/ScreenShot.sh.
# Usage: ScreenRecord.sh {--full|--region|--timed [seconds]|--stop}
#   Invoking --full / --region while a recording is active stops it (toggle).

set -euo pipefail

PID_FILE="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.pid"
OUT_FILE="${XDG_RUNTIME_DIR:-/tmp}/wf-recorder.path"
OUT_DIR="${HOME}/Videos/Recordings"
APP_NAME="ScreenRecord"
NOTIFY_HINT=(-h "string:x-canonical-private-synchronous:screenrecord")

notify() { notify-send -a "$APP_NAME" "${NOTIFY_HINT[@]}" "$@"; }

is_recording() {
  [[ -f "$PID_FILE" ]] && kill -0 "$(cat "$PID_FILE" 2>/dev/null)" 2>/dev/null
}

clear_state() { rm -f "$PID_FILE" "$OUT_FILE"; }

stop_recording() {
  if ! is_recording; then
    clear_state
    return 1
  fi
  local pid out
  pid=$(cat "$PID_FILE")
  out=$(cat "$OUT_FILE" 2>/dev/null || true)
  kill -SIGINT "$pid" 2>/dev/null || true
  for _ in {1..30}; do
    kill -0 "$pid" 2>/dev/null || break
    sleep 0.1
  done
  clear_state
  if [[ -n "$out" && -f "$out" ]]; then
    printf '%s' "$out" | wl-copy
    notify -t 5000 "Recording saved" "$(basename "$out") (path copied)"
  fi
}

start_recording() {
  if ! command -v wf-recorder >/dev/null 2>&1; then
    notify -u critical "wf-recorder not installed" "sudo apt install wf-recorder"
    exit 1
  fi
  mkdir -p "$OUT_DIR"
  local geom="${1:-}"
  local out="${OUT_DIR}/cap-$(date +%Y%m%d-%H%M%S).mp4"

  local args=(-f "$out")
  if [[ -n "$geom" ]]; then
    args+=(-g "$geom")
  elif command -v jq >/dev/null 2>&1; then
    local focused
    focused=$(hyprctl -j monitors 2>/dev/null | jq -r '.[] | select(.focused == true) | .name' || true)
    [[ -n "$focused" ]] && args+=(-o "$focused")
  fi

  nohup wf-recorder "${args[@]}" >/dev/null 2>&1 &
  local pid=$!
  sleep 0.3
  if ! kill -0 "$pid" 2>/dev/null; then
    notify -u critical "Recording failed to start" "Run wf-recorder from a terminal to debug"
    exit 1
  fi
  echo "$pid" > "$PID_FILE"
  echo "$out" > "$OUT_FILE"
  notify -t 3000 "Recording started" "$(basename "$out") — same shortcut to stop"
}

case "${1:---full}" in
  --full)
    if is_recording; then stop_recording; else start_recording; fi
    ;;
  --region)
    if is_recording; then
      stop_recording
    else
      geom=$(slurp 2>/dev/null) || exit 0
      start_recording "$geom"
    fi
    ;;
  --timed)
    if is_recording; then
      stop_recording
      exit 0
    fi
    duration="${2:-5}"
    start_recording
    ( sleep "$duration"; "$0" --stop ) >/dev/null 2>&1 &
    disown || true
    ;;
  --stop)
    stop_recording
    ;;
  *)
    echo "Usage: $0 {--full|--region|--timed [seconds]|--stop}" >&2
    exit 2
    ;;
esac
