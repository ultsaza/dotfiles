#!/usr/bin/env python3
"""Read shared Lua settings and pass structured arguments to Hyprland."""
import json
import pathlib
import re
import shlex
import subprocess
import sys


def lua(value):
    if isinstance(value, dict):
        return '{' + ','.join('[' + lua(k) + ']=' + lua(v) for k, v in value.items()) + '}'
    if isinstance(value, list):
        return '{' + ','.join(map(lua, value)) + '}'
    return json.dumps(value, ensure_ascii=False)


def query(code):
    result = subprocess.run(['hyprctl', 'repl', code], text=True, capture_output=True, check=True)
    value = result.stdout.strip()
    if value.startswith('error:') or value == 'nil':
        raise RuntimeError(value)
    return value


def main():
    action, *args = sys.argv[1:]
    if action == 'get':
        assert re.fullmatch(r'\w+', args[0])
        print(query('return hypr_vars[' + lua(args[0]) + ']'))
    elif action == 'exec':
        command, rules = args[0], json.loads(args[1])
        subprocess.run(['hyprctl', 'dispatch', f'hl.dsp.exec_cmd({lua(command)}, {lua(rules)})'], check=True)
    elif action == 'touchpad':
        name = query('return hypr_vars.Touchpad_Device')
        spec = {'name': name, 'enabled': args[0] == 'true'}
        subprocess.run(['hyprctl', 'eval', 'hl.device(' + lua(spec) + ')'], check=True)
    elif action == 'palette':
        for i in range(16):
            color = query(f'return hypr_vars.color{i}')
            m = re.fullmatch(r'rgb\(([0-9a-fA-F]{6})\)', color)
            if not m:
                raise ValueError('Unexpected Wallust color: ' + color)
            print('0xff' + m[1])
    elif action == 'gradient':
        # The native gradient parser accepts color strings, not integers.
        colors = args
        subprocess.run(['hyprctl', 'eval', 'hl.config(' + lua({'general.col.active_border': {'colors': colors, 'angle': 270}}) + ')'], check=True)
    elif action == 'wallpaper':
        path = pathlib.Path(args[0])
        target = pathlib.Path.home() / '.config/hypr/UserConfigs/Wallpaper.lua'
        command = ('mpvpaper "*" -o "load-scripts=no no-audio --loop" ' + shlex.quote(str(path))) if path.suffix.lower() in ('.mp4', '.mkv', '.mov', '.webm') else 'swww-daemon --format xrgb'
        target.write_text('-- Wallpaper startup, maintained by WallpaperSelect.sh.\nrequire("startup")(' + lua(command) + ')\n')
    else:
        raise ValueError('Unknown action: ' + action)


if __name__ == '__main__':
    main()
