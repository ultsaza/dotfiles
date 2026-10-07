# Portable shell paths and current Hyprland source Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [x]`) syntax for tracking.

**Goal:** Remove fixed Neovim/Java installation paths and align managed Hyprland configuration with the current `ultsaza/hypr` Lua branch.

**Architecture:** Keep the native chezmoi source layout. Use the upstream Lua-only configuration as a reviewed snapshot, retaining the current monitor layout and portable launch fixes. Keep Hypridle, Hyprlock, portal, Qt and Hyprlock palette files in their required configuration formats.

**Tech Stack:** chezmoi, Zsh, Lua, Bash, Python unittest, GitHub Actions.

## Global Constraints

- Preserve Linux/macOS selection and the current macOS configuration.
- Remove `/opt/nvim-linux-x86_64/bin` and `/usr/lib/jvm/java-25-openjdk-amd64` from managed Zsh.
- Reference `https://github.com/ultsaza/hypr`, default branch `v0.55+`, commit `55ea356e35b6c14f1885f8068a016ee325da3081`.
- Retain current monitor placement, Ghostty/Zoom/picker launchers, portable desktop entries and SHM picker configuration.
- Do not apply configuration to the real home or reload the running desktop.
- Configuration-only removals use existing integration checks rather than new tests that merely assert source text is absent.

## Task 1: Remove fixed shell installation paths

**Files:** Modify `dot_zshrc.tmpl` and `README.md`.

- [x] Delete the two Linux installation-path lines from the OS-specific Zsh block.
- [x] Document that Neovim resolves through PATH and optional SDK/JAVA_HOME customization belongs in `~/.zshrc.local`.
- [x] Verify the rendered Linux/macOS shell starts using the existing test suite.

## Task 2: Align Hyprland with the Lua-only reference

**Files:** Modify `private_dot_config/hypr/**/*.lua`, Lua migration helper comments/scripts, `README.md`; create `private_dot_config/hypr/README.md` and `docs/hypr-source.md`; remove the obsolete legacy Hyprland config/parser files.

- [x] Import the upstream Lua modules except `monitors.lua`; keep `v.term` pointing to the Ghostty launcher in `UserConfigs/01-UserDefaults.lua`.
- [x] Import the upstream safe no-op replacements in `scripts/KooLsDotsUpdate.sh`, `UserConfigsSwitcher.sh`, and `update_WindowRules.sh` using their existing chezmoi executable filenames.
- [x] Update the upstream Lua-related helper comments and monitor/user configuration guides.
- [x] Delete obsolete `.conf` in `Monitor_Profiles`, `UserConfigs`, `animations`, `configs`, plus `hyprland.conf`, `monitors.conf`, `workspaces.conf`, two `.disable` files and `scripts/keybinds_parser.py`.
- [x] Keep `wallust/wallust-hyprland.conf` because all three Hyprlock profiles source its color variables.
- [x] Record the pinned reference and the retained dotfiles-specific differences in `docs/hypr-source.md` and the deployed Hyprland README.

## Task 3: Validate and publish

- [x] Run `python3 -m unittest discover -s tests -v`.
- [x] Check that every deployed Hyprlock source file exists in an isolated chezmoi destination and every Lua require resolves via the existing suite.
- [x] Run `git diff --check`; inspect the exact staged paths and portable-path checks.
- [ ] Commit the scoped changes and push `master` as authorized in this session.
- [ ] Confirm remote HEAD and GitHub Actions Ubuntu/macOS conclusions; report GUI testing limits.

Local validation completed: 4 unittest checks passed; all three installed Hyprlock source dependencies resolved. Publication checks below are performed after committing this plan, with their results reported in the task response.
