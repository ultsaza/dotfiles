#!/bin/sh
# Claude Code status line - inspired by Powerlevel10k lean style
input=$(cat)

user=$(whoami)
host=$(hostname -s)
cwd=$(echo "$input" | jq -r '.cwd')
model=$(echo "$input" | jq -r '.model.display_name')

# Shorten home directory to ~
home=$(eval echo "~")
cwd_display=$(echo "$cwd" | sed "s|^$home|~|")

# Git branch (skip optional locks)
git_branch=""
if git -C "$cwd" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  branch=$(git -C "$cwd" -c core.hooksPath=/dev/null symbolic-ref --short HEAD 2>/dev/null || git -C "$cwd" rev-parse --short HEAD 2>/dev/null)
  [ -n "$branch" ] && git_branch=" $branch"
fi

# Context usage
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')
ctx_info=""
[ -n "$used" ] && ctx_info=" ctx:$(printf '%.0f' "$used")%"

printf "\033[1;32m%s@%s\033[0m:\033[1;34m%s\033[0m\033[0;33m%s\033[0m | %s%s" \
  "$user" "$host" "$cwd_display" "$git_branch" "$model" "$ctx_info"
