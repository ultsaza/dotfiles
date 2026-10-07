"""Exercise the files chezmoi installs without modifying the real home."""

import json
import os
from pathlib import Path
import pty
import re
import select
import shutil
import stat
import subprocess
import sys
import tempfile
import time
import tomllib
import unittest


SOURCE = Path(__file__).resolve().parents[1]


class DotfilesTest(unittest.TestCase):
    def check_tab_completion(self, shell, home):
        # Exercise argument completion with a real line editor and no framework.
        # Plain Zsh filename completion cannot expand git's --version option.
        master, slave = pty.openpty()
        process = subprocess.Popen(
            [shell, "-di"], stdin=slave, stdout=subprocess.DEVNULL, stderr=slave,
            env={"HOME": str(home), "PATH": "/usr/bin:/bin", "TERM": "xterm-256color"},
        )
        os.close(slave)
        output = bytearray()
        try:
            os.write(master, b'git --ver\t > "$HOME/tab-result.txt"\nexit\n')
            deadline = time.monotonic() + 20
            while process.poll() is None and time.monotonic() < deadline:
                if select.select([master], [], [], 0.1)[0]:
                    try:
                        output.extend(os.read(master, 65536))
                    except OSError:
                        break
            process.wait(timeout=2)
            result = home / "tab-result.txt"
            self.assertTrue(result.is_file(), output.decode(errors="replace"))
            self.assertTrue(result.read_text().startswith("git version "),
                            output.decode(errors="replace"))
            history = home / ".zsh_history"
            self.assertTrue(history.is_file(), "History must persist for suggestions in new shells")
            self.assertIn("git --version", history.read_text())
        finally:
            if process.poll() is None:
                process.kill()
                process.wait()
            os.close(master)

    def test_script_syntax(self):
        # Catch broken imported scripts before anyone applies them to a desktop.
        for file in SOURCE.rglob("*"):
            if ".git" in file.parts or not file.is_file():
                continue
            if file.suffix == ".py":
                compile(file.read_text(), str(file), "exec")
            if file.suffix != ".sh":
                continue
            script = file.read_text()
            # RofiEmoji intentionally stores data after an unconditional exit.
            script = script.split("# # DATA # #\n", 1)[0]
            result = subprocess.run(["bash", "-n"], input=script,
                                    capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, f"{file}: {result.stderr}")
        compiler = shutil.which("nvim")
        self.assertIsNotNone(compiler, "Install Neovim to compile Lua")
        result = subprocess.run([
            compiler, "--headless", "-u", "NONE", "-c",
            "lua for _, dir in ipairs({'private_dot_config/hypr', 'private_dot_config/nvim'}) do "
            "for _, f in ipairs(vim.fn.glob(dir .. '/**/*.lua', false, true)) do "
            "local ok, err = loadfile(f); if not ok then print(err); vim.cmd('cquit 1') end end end",
            "-c", "qa",
        ], cwd=SOURCE, capture_output=True, text=True)
        self.assertEqual(result.returncode, 0, result.stderr)

    def check_platform(self, platform, arch):
        with tempfile.TemporaryDirectory(prefix="dotfiles-test-") as temporary:
            root = Path(temporary)
            home = root / "Home with spaces"
            home.mkdir()
            config = root / "chezmoi.toml"
            config.write_text("")
            env = os.environ.copy()
            # Rendering must never read the developer's credentials.
            for key in list(env):
                if re.search(r"KEY|TOKEN|SECRET|PASSWORD", key, re.I):
                    env.pop(key)
            env["HOME"] = str(home)
            command = [
                "chezmoi", "--source", str(SOURCE), "--destination", str(home),
                "--config", str(config), "--cache", str(root / "cache"),
                "--persistent-state", str(root / "state.boltdb"), "--no-tty",
                "--override-data", json.dumps({"chezmoi": {
                    "os": platform, "arch": arch, "homeDir": str(home),
                }}),
            ]
            result = subprocess.run(command + ["apply", "--exclude=scripts"],
                                    env=env, capture_output=True, text=True)
            self.assertEqual(result.returncode, 0, result.stderr)

            def read_json(file):
                # VS Code accepts JSONC, including comments and trailing commas.
                result = subprocess.run(
                    command + ["execute-template", "--with-stdin",
                               "{{ .chezmoi.stdin | fromJsonc | toJson }}"],
                    input=file.read_text(), env=env, check=True,
                    capture_output=True, text=True,
                )
                return json.loads(result.stdout)

            native = (home / ".config/Code/User" if platform == "linux"
                      else home / "Library/Application Support/Code/User")
            self.assertTrue((native / "settings.json").is_file())
            settings = read_json(native / "settings.json")
            tasks = read_json(native / "tasks.json")
            read_json(native / "keybindings.json")
            self.assertEqual(tasks["tasks"][0]["command"],
                             "g++" if platform == "linux" else "clang++")
            self.assertEqual("launch" in settings, platform == "linux")
            if platform == "darwin":
                self.assertEqual(settings["C_Cpp.default.compilerPath"], "/usr/bin/clang++")
                self.assertEqual(settings["terminal.integrated.fontFamily"],
                                 "JetBrainsMono Nerd Font Mono")
            else:
                self.assertNotIn("C_Cpp.default.compilerPath", settings)

            if platform == "linux":
                for name in ["hyprland.lua", "variables.lua", "startup.lua",
                             "wallust/wallust-hyprland.lua", "xdph.conf"]:
                    self.assertTrue((home / ".config/hypr" / name).is_file(), name)
                for name in ["ghostty-launch", "zoom-launch", "hyprland-share-picker-safe"]:
                    launcher = home / ".local/bin" / name
                    self.assertTrue(launcher.is_file(), name)
                    self.assertTrue(os.access(launcher, os.X_OK), name)
                self.assertTrue((home / ".config/ghostty/config").is_file())
                self.assertTrue((home / ".config/wireplumber").is_dir())
                self.assertTrue((home / ".local/share/applications/Zoom.desktop").is_file())
                self.assertFalse((home / ".aerospace.toml").exists())
                self.assertFalse((home / ".config/aerospace").exists())
                self.assertFalse((home / ".config/karabiner").exists())
                self.assertFalse((home / "Library").exists())
                hypr = home / ".config/hypr"
                for script in hypr.rglob("*.lua"):
                    for module in re.findall(r'require\("([^"]+)"\)', script.read_text()):
                        self.assertTrue((hypr / f"{module}.lua").is_file(), module)
            else:
                self.assertFalse((home / ".aerospace.toml").exists())
                self.assertFalse((home / ".config/aerospace").exists())
                self.assertTrue((home / "Library/Application Support/com.mitchellh.ghostty/config").is_file())
                karabiner_file = home / ".config/karabiner/karabiner.json"
                karabiner = json.loads(karabiner_file.read_text())
                self.assertEqual(stat.S_IMODE(karabiner_file.stat().st_mode), 0o600)
                profile = karabiner["profiles"][0]
                self.assertEqual(profile["virtual_hid_keyboard"]["keyboard_type_v2"], "jis")
                hyper = profile["complex_modifications"]["rules"][0]["manipulators"][0]
                self.assertEqual(hyper["from"]["key_code"], "caps_lock")
                self.assertEqual(hyper["to_if_alone"][0]["key_code"], "escape")
                for name in ["hypr", "wireplumber", "waybar", "rofi", "swaync", "wlogout", "wallust", "Code", "ghostty"]:
                    self.assertFalse((home / ".config" / name).exists(), name)
                self.assertFalse((home / ".local/bin/zoom-launch").exists())
                self.assertFalse((home / ".local/share/applications").exists())

            claude = json.loads((home / ".claude/settings.json").read_text())
            codex = tomllib.loads((home / ".codex/config.toml").read_text())
            self.assertNotIn("NOTION_API_KEY", claude.get("env", {}))
            self.assertNotIn("projects", codex)
            self.assertEqual(stat.S_IMODE((home / ".codex/config.toml").stat().st_mode), 0o600)
            for name in ["README.md", "Brewfile", "docs", "scripts", "tests", ".github"]:
                self.assertFalse((home / name).exists(), name)
            for file in home.rglob("*"):
                if file.is_file() and not file.is_symlink():
                    try:
                        content = file.read_text()
                    except UnicodeDecodeError:
                        continue
                    self.assertNotIn("/home/ultsaza", content, str(file))
                    self.assertNotIn("/Users/ult_saza", content, str(file))
                    self.assertNotRegex(content, r"(?:ntn_|ghp_|sk-ant-)[A-Za-z0-9_-]{20,}")

            # A minimal machine can source the shell config without optional tools.
            shell = shutil.which("zsh")
            self.assertIsNotNone(shell, "Install zsh to validate startup")
            startup = subprocess.run(
                [shell, "-dfc", 'source "$HOME/.zshenv"; source "$HOME/.zshrc"; print -r -- "$PATH"'],
                env={"HOME": str(home), "PATH": "/usr/bin:/bin", "TERM": "dumb"},
                capture_output=True, text=True,
            )
            self.assertEqual(startup.returncode, 0, startup.stderr)
            self.assertEqual(startup.stderr, "")
            self.assertIn(str(home / ".local/bin"), startup.stdout.split(":"))
            self.check_tab_completion(shell, home)
            if platform == "darwin" and sys.platform == "darwin":
                # Native macOS CI installs the real Homebrew packages.
                plugins = subprocess.run(
                    [shell, "-dfc", 'source "$HOME/.zshenv"; source "$HOME/.zshrc"; '
                     '(( $+functions[_zsh_autosuggest_start] && $+functions[_zsh_highlight] ))'],
                    env={"HOME": str(home), "PATH": "/usr/bin:/bin", "TERM": "xterm-256color"},
                    capture_output=True, text=True,
                )
                self.assertEqual(plugins.returncode, 0, plugins.stderr)
                # Exercise real macOS binaries through the installed Zsh PATH.
                cli = subprocess.run(
                    [shell, "-dfc", 'source "$HOME/.zshenv"; source "$HOME/.zshrc"; '
                     'gh --version && aws --version && node --version && uv --version && '
                     'go version && rustup --version && nvm --version && '
                     'sed --version && find --version && stat --version && '
                     'tar --version && grep --version && awk --version && make --version'],
                    env={"HOME": str(home), "PATH": "/usr/bin:/bin", "TERM": "dumb"},
                    capture_output=True, text=True,
                )
                self.assertEqual(cli.returncode, 0, cli.stderr)

            # A second apply must leave the installed content unchanged.
            before = {str(p.relative_to(home)): p.read_bytes() for p in home.rglob("*")
                      if p.is_file()}
            subprocess.run(command + ["apply", "--exclude=scripts"],
                           env=env, check=True, capture_output=True, text=True)
            after = {str(p.relative_to(home)): p.read_bytes() for p in home.rglob("*")
                     if p.is_file()}
            self.assertEqual(before, after)

    def test_linux(self):
        self.check_platform("linux", "amd64")

    def test_macos_apple_silicon(self):
        self.check_platform("darwin", "arm64")

    def test_macos_intel(self):
        self.check_platform("darwin", "amd64")


if __name__ == "__main__":
    unittest.main()
