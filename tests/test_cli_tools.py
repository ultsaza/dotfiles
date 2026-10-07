"""Bootstrap failure/retry behavior without installing anything on the host."""

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


SOURCE = Path(__file__).resolve().parents[1]


class CliToolsTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="cli-test-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name) / "Home with spaces"
        self.bin = self.root / "bin"
        self.bin.mkdir(parents=True)
        self.repo = self.root / "repo with spaces"
        (self.repo / "scripts").mkdir(parents=True)
        self.data = self.repo / ".chezmoitemplates/cli"
        self.data.mkdir(parents=True)
        self.script = self.repo / "scripts/install-cli-tools.sh"
        shutil.copyfile(SOURCE / "scripts/install-cli-tools.sh", self.script)
        (self.repo / "Brewfile").write_text("")
        (self.data / "commands.txt").write_text("base-cli\n")
        self.log = self.root / "calls"
        self.env = {
            "HOME": str(self.root), "PATH": f"{self.bin}:/usr/bin:/bin",
            "TERM": "dumb", "TEST_BIN": str(self.bin), "TEST_LOG": str(self.log),
        }
        self.stub("uname", 'if [ "$1" = -s ]; then echo Darwin; else echo arm64; fi')
        self.stub("brew", 'case "$1" in --prefix) echo "$HOME/brew";; shellenv) :;; *) echo "brew $*" >> "$TEST_LOG";; esac')
        self.stub("rustup", 'echo "rustup $*" >> "$TEST_LOG"')
        self.stub("base-cli", "exit 0")

    def stub(self, name, body):
        file = self.bin / name
        file.write_text(f"#!/bin/bash\n{body}\n")
        file.chmod(0o755)

    def invoke(self, option=None):
        return subprocess.run(
            ["/bin/bash", str(self.script)] + ([option] if option else []),
            env=self.env, capture_output=True, text=True, timeout=20,
        )

    def test_plan_does_not_install(self):
        (self.data / "packages.tsv").write_text(
            "npm\tpackage-alpha\talpha-cli\tall\nax\thttps://example.invalid/install\tax-cli\tall\n"
        )
        self.stub("npm", 'echo invoked >> "$TEST_LOG"; exit 99')
        self.stub("curl", 'echo invoked >> "$TEST_LOG"; exit 99')
        result = self.invoke("--plan")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("package-alpha", result.stdout)
        self.assertIn("https://example.invalid/install", result.stdout)
        self.assertNotIn("invoked", self.log.read_text())
        self.assertFalse((self.root / ".local").exists())

    def test_check_reports_missing_without_running_tools(self):
        (self.data / "packages.tsv").write_text("npm\talpha\talpha-cli\tall\n")
        result = self.invoke("--check")
        self.assertEqual(result.returncode, 1)
        self.assertIn("MISSING: alpha-cli", result.stderr)
        self.assertFalse(self.log.exists())
        self.stub("alpha-cli", 'echo must-not-run >> "$TEST_LOG"')
        result = self.invoke("--check")
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertFalse(self.log.exists())

    def test_failure_continues_and_partial_download_is_never_executed(self):
        (self.data / "packages.tsv").write_text(
            "npm\tbroken\talpha-cli\tall\nuv\tworking\tbeta-cli\tall\n"
            "ax\thttps://example.invalid/partial\tax-cli\tall\n"
            "hermes\thttps://example.invalid/hermes\thermes\tarm64\n"
        )
        self.stub("npm", "exit 9")
        self.stub("uv", 'printf "#!/bin/sh\\nexit 0\\n" > "$TEST_BIN/beta-cli"; chmod +x "$TEST_BIN/beta-cli"')
        self.stub("curl", '''
url=""; output=""
while [ "$#" -gt 0 ]; do
  case "$1" in https:*) url="$1";; --output) shift; output="$1";; esac
  shift
done
if [[ "$url" == */partial ]]; then
  echo 'touch "$HOME/executed-partial-download"' > "$output"
  exit 22
fi
cat > "$output" <<'INSTALLER'
#!/bin/bash
echo "hermes $*" >> "$TEST_LOG"
printf '#!/bin/sh\\nexit 0\\n' > "$TEST_BIN/hermes"
chmod +x "$TEST_BIN/hermes"
INSTALLER
''')
        result = self.invoke()
        self.assertEqual(result.returncode, 1)
        self.assertIn("FAILED: alpha-cli", result.stderr)
        self.assertIn("FAILED: ax-cli", result.stderr)
        self.assertTrue((self.bin / "beta-cli").exists())
        self.assertTrue((self.bin / "hermes").exists())
        self.assertFalse((self.root / "executed-partial-download").exists())
        self.assertIn("hermes --non-interactive --skip-browser --skip-computer-use", self.log.read_text())
        # Existing commands are kept on retry; only failed tools are attempted.
        self.stub("npm", 'printf "#!/bin/sh\\nexit 0\\n" > "$TEST_BIN/alpha-cli"; chmod +x "$TEST_BIN/alpha-cli"')
        self.stub("ax-cli", "exit 0")
        self.stub("uv", "exit 99")
        result = self.invoke()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertEqual(self.log.read_text().count("hermes --non-interactive"), 1)

    def test_linux_is_rejected_before_installing(self):
        self.stub("uname", "echo Linux")
        result = self.invoke()
        self.assertEqual(result.returncode, 2)
        self.assertFalse(self.log.exists())

    def test_fresh_brew_rustup_is_on_path_before_initializing(self):
        (self.bin / "rustup").unlink()
        (self.data / "packages.tsv").write_text("")
        self.stub("brew", '''
case "$1" in
  --prefix) echo "$HOME/brew";;
  shellenv) :;;
  bundle)
    mkdir -p "$HOME/brew/opt/rustup/bin"
    cat > "$HOME/brew/opt/rustup/bin/rustup" <<'RUSTUP'
#!/bin/bash
echo "rustup $*" >> "$TEST_LOG"
if [[ "$1" == show ]]; then exit 1; fi
RUSTUP
    chmod +x "$HOME/brew/opt/rustup/bin/rustup"
    ;;
esac
''')
        result = self.invoke()
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("rustup default stable", self.log.read_text())
        self.assertIn("rustup component add rustfmt clippy rust-analyzer", self.log.read_text())


if __name__ == "__main__":
    unittest.main()
