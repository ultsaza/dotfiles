#!/usr/bin/env bash
# /* ---- 💫 https://github.com/JaKooLit 💫 ---- */  ##
# Scripts for refreshing ags, waybar, rofi, swaync, wallust

SCRIPTSDIR=$HOME/.config/hypr/scripts
UserScripts=$HOME/.config/hypr/UserScripts

# Define file_exists function
file_exists() {
  if [ -e "$1" ]; then
    return 0 # File exists
  else
    return 1 # File does not exist
  fi
}

# Kill already running processes
_ps=(waybar rofi swaync ags)
for _prs in "${_ps[@]}"; do
  if pidof "${_prs}" >/dev/null; then
    pkill "${_prs}"
  fi
done

# added since wallust sometimes not applying
pkill -SIGUSR2 -x 'waybar|\.waybar-wrapped'
# Added sleep for GameMode causing multiple waybar
sleep 0.1

# quit ags & relaunch ags
ags -q && ags &

# quit quickshell & relaunch quickshell
#pkill qs && qs &

# some process to kill
for pid in $(pidof waybar rofi swaync ags swaybg); do
  kill -SIGUSR1 "$pid"
  sleep 0.1
done

# Reap Waybar's long-running module helpers before relaunch. Waybar does not
# reliably kill these when it exits, so they pile up across refreshes:
#   cava          -> each survivor keeps redrawing  -> CPU spin (was ~194%)
#   playerctl -F  -> each hoards inotify instances   -> eventual
#                    "Too many open files" that silently breaks modules
#   swaync-client -> idle -swb subscribers accumulate
# (cava also self-reaps via WaybarCava.sh's trap on a clean TERM; this covers
#  the SIGKILL / multi-instance cases.)
pkill -x cava 2>/dev/null
pkill -x playerctl 2>/dev/null
pkill -f 'swaync-client -swb' 2>/dev/null

#Restart waybar
sleep 0.1
waybar &

# relaunch swaync
sleep 0.3
swaync >/dev/null 2>&1 &
# reload swaync
swaync-client --reload-config

# Relaunching rainbow borders if the script exists
sleep 1
if file_exists "${UserScripts}/RainbowBorders.sh"; then
  ${UserScripts}/RainbowBorders.sh &
fi

exit 0
