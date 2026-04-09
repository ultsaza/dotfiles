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

# Lazygit
link "$DOTFILES_DIR/lazygit" "${XDG_CONFIG_HOME:-$HOME/.config}/lazygit"

# VSCode
VSCODE_USER_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/Code/User"
mkdir -p "$VSCODE_USER_DIR"
link "$DOTFILES_DIR/vscode/settings.json" "$VSCODE_USER_DIR/settings.json"
link "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_USER_DIR/keybindings.json"
link "$DOTFILES_DIR/vscode/tasks.json" "$VSCODE_USER_DIR/tasks.json"

# Install VSCode extensions
if command -v code &>/dev/null; then
  echo "Installing VSCode extensions..."
  while IFS= read -r ext; do
    code --install-extension "$ext" --force 2>/dev/null || true
  done < "$DOTFILES_DIR/vscode/extensions.txt"
fi

echo "Done!"
