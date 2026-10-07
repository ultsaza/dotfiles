#!/usr/bin/env bash
# Explicit bootstrap: chezmoi apply never installs packages or starts services.
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
manifest="$repo_dir/.chezmoitemplates/cli/packages.tsv"
mode=${1:-install}
case "$mode" in
  install|--check|--plan) ;;
  *) printf 'Usage: %s [--check|--plan]\n' "$0" >&2; exit 2 ;;
esac
if [[ $(uname -s) != Darwin ]]; then
  printf '%s\n' 'This bootstrap is for macOS. See docs/cli-tools.md for Linux.' >&2
  exit 2
fi
architecture=$(uname -m)
if command -v brew >/dev/null; then
  eval "$(brew shellenv)"
elif [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
if ! command -v brew >/dev/null; then
  printf '%s\n' 'Install Homebrew and Xcode Command Line Tools first.' >&2
  exit 1
fi
brew_prefix=$(brew --prefix)
configure_path() {
  local formula
  export PATH="$HOME/.local/bin:$HOME/.cargo/bin:$HOME/go/bin:$HOME/.moon/bin:$HOME/.codon/bin:$HOME/.kimi-code/bin:$HOME/.nix-profile/bin:/nix/var/nix/profiles/default/bin:$HOME/Library/Application Support/Coursier/bin:$PATH"
  for formula in coreutils findutils gnu-sed gnu-tar grep gawk make; do
    [[ ! -d "$brew_prefix/opt/$formula/libexec/gnubin" ]] || export PATH="$brew_prefix/opt/$formula/libexec/gnubin:$PATH"
  done
  for formula in rustup llvm lld lldb curl gettext gnu-getopt diffutils gzip; do
    [[ ! -d "$brew_prefix/opt/$formula/bin" ]] || export PATH="$brew_prefix/opt/$formula/bin:$PATH"
  done
}
configure_path

run() {
  if [[ "$mode" == --plan ]]; then
    printf '%q ' "$@"; printf '\n'
  else
    "$@"
  fi
}
have_commands() {
  local cli
  for cli in $1; do
    command -v "$cli" >/dev/null || return 1
  done
}
download_install() {
  local installer
  if [[ "$mode" == --plan ]]; then
    printf 'Download %s, then: ' "$1"
    shift
    run "$@" '<downloaded-installer>'
    return
  fi
  installer=$(mktemp "${TMPDIR:-/tmp}/dotfiles-cli.XXXXXX") || return
  # Download completely before running; a failed transfer must never execute.
  if curl --fail --silent --show-error --location "$1" --output "$installer"; then
    shift
    "$@" "$installer"
    local result=$?
    rm -f "$installer"
    return "$result"
  fi
  rm -f "$installer"
  return 1
}
install_tool() {
  case "$1" in
    npm) run env npm_config_prefix="$HOME/.local" npm install --global "$2" ;;
    uv) run uv tool install --python 3.13 "$2" ;;
    cargo) run cargo install --locked "$2" ;;
    go) run env GOBIN="$HOME/go/bin" go install "$2" ;;
    cs) run coursier install "$2" ;;
    ax) download_install "$2" sh ;;
    ctx) download_install "$2" env CTX_INSTALL_NO_SETUP=1 CTX_INSTALL_NO_SKILL=1 CTX_INSTALL_NO_MODIFY_PATH=1 sh ;;
    ntn) download_install "$2" env NTN_INSTALL_DIR="$HOME/.local/bin" bash ;;
    # These installers otherwise edit shell files. The dotfiles already supply PATH.
    codon|moonbit) download_install "$2" env SHELL=/bin/false bash ;;
    viteplus) download_install "$2" env VP_NODE_MANAGER=no bash ;;
    hermes) download_install "$2" hermes_installer ;;
    nix) download_install "$2" nix_installer ;;
    devbox) download_install "$2" bash ;;
    home-manager) run nix profile install "$2" ;;
    pokemon) install_pokemon "$2" ;;
    *) printf 'Unknown installer: %s\n' "$1" >&2; return 1 ;;
  esac
}
hermes_installer() { bash "$1" --non-interactive --skip-browser --skip-computer-use; }
nix_installer() { sh "$1" install --no-confirm; }
install_pokemon() {
  local destination="$HOME/.local/share/pokemon-colorscripts"
  if [[ ! -d "$destination" ]]; then
    run git clone --depth 1 "$1" "$destination" || return 1
  fi
  run ln -s "$destination/pokemon-colorscripts.py" "$HOME/.local/bin/pokemon-colorscripts"
}

failed=0
if [[ "$mode" != --check ]]; then
  run brew bundle --file="$repo_dir/Brewfile" || exit 1
  configure_path
  run mkdir -p "$HOME/.local/bin" "$HOME/.nvm" || exit 1
  # Homebrew rustup has no default compiler until a toolchain is selected.
  if ! rustup show active-toolchain >/dev/null 2>&1; then
    run rustup default stable || exit 1
  fi
  run rustup component add rustfmt clippy rust-analyzer || exit 1
  if ! command -v exa >/dev/null && [[ ! -e "$HOME/.local/bin/exa" && ! -L "$HOME/.local/bin/exa" ]]; then
    run ln -s "$brew_prefix/bin/eza" "$HOME/.local/bin/exa" || exit 1
  fi
fi
while IFS=$'\t' read -r manager package commands supported; do
  [[ -n "$manager" && "$manager" != \#* ]] || continue
  if [[ "$supported" != all && "$supported" != "$architecture" ]]; then
    printf 'UNSUPPORTED on %s: %s (see docs/cli-tools.md)\n' "$architecture" "$commands"
    continue
  fi
  if ! have_commands "$commands" && [[ "$mode" != --check ]]; then
    if ! install_tool "$manager" "$package"; then
      printf 'FAILED: %s (%s)\n' "$commands" "$package" >&2
      failed=1
    fi
  fi
done < "$manifest"
if [[ "$mode" == --plan ]]; then exit "$failed"; fi

check_commands() {
  local cli
  for cli in $1; do
    if ! command -v "$cli" >/dev/null; then
      printf 'MISSING: %s\n' "$cli" >&2
      failed=1
    fi
  done
}
while IFS= read -r cli; do
  [[ -n "$cli" && "$cli" != \#* ]] || continue
  check_commands "$cli"
done < "$repo_dir/.chezmoitemplates/cli/commands.txt"
while IFS=$'\t' read -r manager package commands supported; do
  [[ -n "$manager" && "$manager" != \#* ]] || continue
  [[ "$supported" == all || "$supported" == "$architecture" ]] || continue
  check_commands "$commands"
done < "$manifest"
if (( failed == 0 )); then
  printf '%s\n' 'All supported CLI commands are on PATH. Authentication and services are configured separately.'
fi
exit "$failed"
