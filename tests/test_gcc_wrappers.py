"""Exercise compiler resolution across upgrades without changing Homebrew."""

from pathlib import Path
import subprocess
import tempfile
import unittest


SOURCE = Path(__file__).resolve().parents[1]


class GccWrappersTest(unittest.TestCase):
    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix="gcc-wrapper-test-")
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.prefix = self.root / "Homebrew with spaces"
        self.compilers = self.prefix / "opt/gcc/bin"
        self.compilers.mkdir(parents=True)
        self.env = {"PATH": "/usr/bin:/bin", "HOMEBREW_PREFIX": str(self.prefix)}
        self.wrappers = {}
        for compiler in ["gcc", "g++"]:
            result = subprocess.run([
                "chezmoi", "--source", str(SOURCE), "execute-template", "--file",
                str(SOURCE / "dot_local/bin" / f"executable_{compiler}.tmpl"),
            ], check=True, capture_output=True, text=True)
            wrapper = self.root / compiler
            wrapper.write_text(result.stdout)
            wrapper.chmod(0o755)
            self.wrappers[compiler] = wrapper

    def driver(self, name):
        path = self.compilers / name
        path.write_text(f"#!/bin/sh\nprintf '%s\\n' '{name}'\nprintf '<%s>\\n' \"$@\"\n")
        path.chmod(0o755)
        return path

    def invoke(self, compiler, *args):
        return subprocess.run([str(self.wrappers[compiler]), *args], env=self.env,
                              capture_output=True, text=True, timeout=10)

    def test_upgrade_and_argument_forwarding(self):
        # Ignore GCC's helper programs and dangling links when choosing a driver.
        self.driver("gcc-ar-99")
        self.driver("g++-invalid")
        for compiler in ["gcc", "g++"]:
            self.driver(f"{compiler}-9")
            previous = self.driver(f"{compiler}-15")
            broken = self.compilers / f"{compiler}-99"
            broken.symlink_to(self.root / "missing driver")
            result = self.invoke(compiler, "-std=gnu++23", "source file.cpp", "-o", "output file")
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout.splitlines(), [
                f"{compiler}-15", "<-std=gnu++23>", "<source file.cpp>", "<-o>", "<output file>",
            ])
            previous.unlink()
            self.driver(f"{compiler}-16")
            result = self.invoke(compiler, "--version")
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertEqual(result.stdout.splitlines(), [f"{compiler}-16", "<--version>"])

    def test_missing_gcc_reports_install_command(self):
        for compiler in ["gcc", "g++"]:
            result = self.invoke(compiler, "--version")
            self.assertEqual(result.returncode, 127)
            self.assertIn("brew install gcc", result.stderr)
            self.assertEqual(result.stdout, "")


if __name__ == "__main__":
    unittest.main()
