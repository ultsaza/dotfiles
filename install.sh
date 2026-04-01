#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "$0")" && pwd)"

link() {
  local src="$1" dst="$2"
  if [ -L "$dst" ]; then
    rm "$dst"
  elif [ -e "$dst" ]; then
    echo "Backing up existing $dst -> ${dst}.bak"
    mv "$dst" "${dst}.bak"
  fi
  mkdir -p "$(dirname "$dst")"
  ln -s "$src" "$dst"
  echo "Linked $dst -> $src"
}

# Neovim
link "$DOTFILES_DIR/nvim" "${XDG_CONFIG_HOME:-$HOME/.config}/nvim"

echo "Done!"
