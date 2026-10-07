#!/usr/bin/env bash
set -euo pipefail

repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)
code_cli=$(command -v code || true)
if [[ -z "$code_cli" && -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
  code_cli="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
fi
if [[ -z "$code_cli" ]]; then
  printf '%s\n' 'Install VS Code and enable its code command first.' >&2
  exit 1
fi

failed=0
while IFS= read -r extension; do
  [[ -z "$extension" || "$extension" == \#* ]] && continue
  if ! "$code_cli" --install-extension "$extension"; then
    printf 'Failed to install %s\n' "$extension" >&2
    failed=1
  fi
done < "$repo_dir/.chezmoitemplates/vscode/extensions.txt"
exit "$failed"
