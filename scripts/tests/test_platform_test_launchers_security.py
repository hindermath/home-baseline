#!/usr/bin/env python3
"""Security regression tests for cross-platform result publishers."""

from __future__ import annotations

import os
from pathlib import Path
import shutil
import stat
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
LINUX_LAUNCHER = ROOT / "scripts/linux-test.sh"


def executable(path: Path, text: str) -> None:
    path.write_text(text, encoding="utf-8")
    path.chmod(path.stat().st_mode | stat.S_IXUSR)


class PlatformTestLauncherSecurityTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.home = self.root / "home"
        self.repo = self.home / "home-baseline-source"
        (self.repo / "scripts/lib").mkdir(parents=True)
        shutil.copy2(LINUX_LAUNCHER, self.repo / "scripts/linux-test.sh")
        subprocess.run(["git", "init", "-q", "-b", "main", str(self.repo)], check=True)
        subprocess.run(["git", "-C", str(self.repo), "config", "user.name", "Security Test"], check=True)
        subprocess.run(["git", "-C", str(self.repo), "config", "user.email", "security@example.invalid"], check=True)

    def commit(self, message: str = "fixture") -> None:
        subprocess.run(["git", "-C", str(self.repo), "add", "-A"], check=True)
        subprocess.run(["git", "-C", str(self.repo), "commit", "-q", "-m", message], check=True)

    def run_launcher(self) -> subprocess.CompletedProcess[str]:
        env = os.environ.copy()
        env["HOME"] = str(self.home)
        return subprocess.run(
            ["bash", str(self.repo / "scripts/linux-test.sh")],
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
            timeout=30,
        )

    def test_linked_output_is_rejected_without_external_write(self) -> None:
        sentinel = self.root / "sentinel.txt"
        sentinel.write_text("unchanged\n", encoding="utf-8")
        (self.repo / "linux-test-output.txt").symlink_to(sentinel)
        self.commit()

        result = self.run_launcher()

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertEqual(sentinel.read_text(encoding="utf-8"), "unchanged\n")

    def test_preexisting_staged_file_blocks_before_commit(self) -> None:
        (self.repo / "linux-test-output.txt").write_text("old\n", encoding="utf-8")
        self.commit()
        (self.repo / "unrelated-secret.txt").write_text("secret\n", encoding="utf-8")
        subprocess.run(["git", "-C", str(self.repo), "add", "unrelated-secret.txt"], check=True)

        result = self.run_launcher()

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertEqual(
            subprocess.run(
                ["git", "-C", str(self.repo), "rev-list", "--count", "HEAD"],
                text=True,
                stdout=subprocess.PIPE,
                check=True,
            ).stdout.strip(),
            "1",
        )

    def test_clean_run_pushes_exactly_one_output_path(self) -> None:
        (self.repo / "linux-test-output.txt").write_text("old\n", encoding="utf-8")
        executable(self.repo / "scripts/sync-home.sh", "#!/bin/sh\nexit 0\n")
        executable(self.repo / "scripts/maintain-agentic-brew-apps.sh", "#!/bin/sh\nexit 0\n")
        (self.home / "scripts").mkdir(parents=True)
        executable(self.home / "scripts/check-homogeneity.sh", "#!/bin/sh\nexit 0\n")
        fake_bin = self.root / "bin"
        fake_bin.mkdir()
        for name in ("apt", "brew", "pwsh", "code", "hx"):
            executable(fake_bin / name, "#!/bin/sh\nexit 0\n")
        remote = self.root / "remote.git"
        subprocess.run(["git", "init", "-q", "--bare", str(remote)], check=True)
        subprocess.run(["git", "-C", str(self.repo), "remote", "add", "origin", str(remote)], check=True)
        self.commit()
        subprocess.run(["git", "-C", str(self.repo), "push", "-q", "-u", "origin", "main"], check=True)
        env = os.environ.copy()
        env["HOME"] = str(self.home)
        env["PATH"] = f"{fake_bin}{os.pathsep}{env['PATH']}"

        result = subprocess.run(
            ["bash", str(self.repo / "scripts/linux-test.sh")],
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
            timeout=30,
        )

        self.assertEqual(result.returncode, 0, result.stdout)
        paths = subprocess.run(
            ["git", "--git-dir", str(remote), "diff-tree", "--no-commit-id", "--name-only", "-r", "main^", "main"],
            text=True,
            stdout=subprocess.PIPE,
            check=True,
        ).stdout.splitlines()
        self.assertEqual(paths, ["linux-test-output.txt"])

    def test_distinct_push_url_is_rejected_before_collection(self) -> None:
        (self.repo / "linux-test-output.txt").write_text("old\n", encoding="utf-8")
        fetch_remote = self.root / "fetch.git"
        push_remote = self.root / "push.git"
        subprocess.run(["git", "init", "-q", "--bare", str(fetch_remote)], check=True)
        subprocess.run(["git", "init", "-q", "--bare", str(push_remote)], check=True)
        subprocess.run(["git", "-C", str(self.repo), "remote", "add", "origin", str(fetch_remote)], check=True)
        self.commit()
        subprocess.run(["git", "-C", str(self.repo), "push", "-q", "-u", "origin", "main"], check=True)
        subprocess.run(
            ["git", "-C", str(self.repo), "config", "remote.origin.pushurl", str(push_remote)],
            check=True,
        )

        result = self.run_launcher()

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("Pushziel", result.stdout)
        push_refs = subprocess.run(
            ["git", "--git-dir", str(push_remote), "show-ref"],
            text=True,
            stdout=subprocess.PIPE,
            check=False,
        ).stdout
        self.assertEqual(push_refs, "")


if __name__ == "__main__":
    unittest.main()
