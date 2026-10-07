# Hyprland configuration

Native Lua configuration based on [ultsaza/hypr](https://github.com/ultsaza/hypr/tree/55ea356e35b6c14f1885f8068a016ee325da3081), branch `v0.55+`, commit `55ea356`, for Hyprland 0.56.2.

- `hyprland.lua`: entry point.
- `configs/`, `UserConfigs/`: defaults and personal overrides.
- `monitors.lua`, `workspaces.lua`: display and workspace settings.
- `animations/`, `Monitor_Profiles/`: selectable Lua presets.
- `scripts/`, `UserScripts/`, `tools/`: helpers and companion tooling.

Edit `.lua` files for Hyprland settings. The remaining `.conf` files belong to Hypridle, Hyprlock, the portal and Qt styling. `wallust/wallust-hyprland.conf` supplies the colors sourced by Hyprlock.

The current monitor layout and Ghostty/Zoom/picker launch fixes are preserved in this dotfiles snapshot. See the [source and retained differences](https://github.com/ultsaza/dotfiles/blob/master/docs/hypr-source.md) and [Lua migration notes](https://github.com/ultsaza/hypr/blob/55ea356e35b6c14f1885f8068a016ee325da3081/docs/lua-migration.md).

Review upstream differences before applying them. This configuration requires separately installed companion applications; it is not a full desktop installer.
