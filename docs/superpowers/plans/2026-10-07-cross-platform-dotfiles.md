# Cross-platform dotfiles Implementation Plan

> **For agentic workers:** Execute inline with the user's existing authorization. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** Sync the current Linux configuration into chezmoi, make the same repository usable on macOS, and push the verified result.

**Architecture:** Keep chezmoi's existing source layout. Share editor templates, select native paths with `.chezmoiignore`, and retain platform-specific desktop settings.

**Tech Stack:** chezmoi, Zsh, Bash, Lua, Python 3.11+, Homebrew, GitHub Actions.

## Global Constraints

- Preserve the live desktop and the eight existing local commits.
- Never copy credentials, histories, caches, customer files, or project trust records.
- Validate with an isolated destination; do not apply the whole repository to the current home.
- Support Linux and macOS, including Apple Silicon and Intel Homebrew paths.
- Push to the existing `master` branch without rewriting history.

### Task 1: Capture current configuration and select the correct platform

**Files:** `.chezmoiignore`, `.gitignore`, `dot_zshenv`, `dot_zshrc.tmpl`, `dot_p10k.zsh`, `dot_aerospace.toml.tmpl`, `.chezmoitemplates/vscode/`, `private_dot_config/`, `private_Library/`, `dot_claude/`, `dot_codex/`, `tests/test_dotfiles.py`.

- [x] Add integration checks for the actual files produced by `chezmoi apply --exclude=scripts` in temporary homes. Require Linux-only desktop files to be absent on macOS and native VS Code/Ghostty paths to be present. Require repository documentation to be absent from the destination.
- [x] Run `python3 -m unittest discover -s tests -v` and confirm the missing platform files fail.
- [x] Re-add current managed Neovim/lazygit settings. Import the live Hyprland configuration and its desktop dependencies using an explicit allowlist; exclude backups, generated images, hidden state, and worktrees.
- [x] Add guarded Zsh startup with `$HOME` paths, Homebrew initialization, and an untracked `.zshrc.local` hook. Keep the current prompt preferences without importing embedded credentials.
- [x] Use shared VS Code templates at Linux and macOS native paths. Keep the Linux C++ debugger on Linux and select `clang++` for macOS build tasks.
- [x] Update the AI tool preference templates from selected live keys; retain credentials in environment/local files and omit local project/hook/plugin-cache paths.
- [x] Replace the hardcoded AeroSpace user path with a quoted home template and remove the absent macOS wallpaper dependency.
- [x] Run integration tests, shell syntax checks, and compile Lua without evaluating the desktop configuration.

### Task 2: Document setup, automate verification, and publish

**Files:** `README.md`, `Brewfile`, `scripts/install-vscode-extensions.sh`, `.chezmoitemplates/vscode/extensions.txt`, `.github/workflows/check.yml`.

- [x] Record the current VS Code extension IDs and provide an explicit installer that reports failures.
- [x] Document macOS Homebrew/AeroSpace prerequisites, Linux desktop dependencies, local overrides, and safe chezmoi diff/apply/update commands.
- [x] Add native Ubuntu/macOS CI using the same isolated integration test command.
- [x] Verify `git diff --check`, the full integration suite, and that the public tree and all unpublished commits contain no local secret values.
- [ ] Commit the reviewed changes, run `git push origin master`, and verify the remote commit and CI results.
