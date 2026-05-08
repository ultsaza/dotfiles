#!/bin/bash
# Arrange the first 4 windows of the focused workspace into a 2x2 grid.

aerospace flatten-workspace-tree

ids=( $(aerospace list-windows --workspace focused --format '%{window-id}') )
n=${#ids[@]}

if [ "$n" -lt 4 ]; then
  /usr/bin/osascript -e "display notification \"Need >=4 windows (have $n)\" with title \"AeroSpace 2x2\""
  exit 1
fi

aerospace focus --window-id "${ids[0]}"
aerospace layout tiles 2>/dev/null || true
aerospace layout horizontal 2>/dev/null || true

ids=( $(aerospace list-windows --workspace focused --format '%{window-id}') )

aerospace focus --window-id "${ids[0]}"
aerospace join-with right

aerospace focus --window-id "${ids[2]}"
aerospace join-with right

aerospace balance-sizes
