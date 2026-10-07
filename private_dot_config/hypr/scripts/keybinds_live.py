#!/usr/bin/env python3
"""Render Hyprland's effective binds for the read-only Rofi key list."""
import sys

# In 0.56.2, the text IPC includes Lua display_key for code:N binds;
# the JSON IPC leaves both key and keycode empty for those same binds.
for block in sys.stdin.read().strip().split('\n\n'):
    pairs = (line.split(': ', 1) for line in block.splitlines() if ': ' in line)
    bind = {key.strip(): value.strip() for key, value in pairs}
    if 'modmask' not in bind:
        continue
    modifiers = [label for mask, label in ((64, 'SUPER'), (1, 'SHIFT'), (4, 'CTRL'), (8, 'ALT')) if int(bind['modmask']) & mask]
    code = int(bind.get('keycode', 0))
    key = bind.get('key') or (str((code - 9) % 10) if 10 <= code <= 19 else f'code:{code}')
    keys = key if ' + ' in key else ' + '.join(modifiers + [key])
    description = bind.get('description') or ' '.join(filter(None, (bind.get('dispatcher'), bind.get('arg'))))
    print(f'{keys:35} {description}')
