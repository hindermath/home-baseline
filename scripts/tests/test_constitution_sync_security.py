#!/usr/bin/env python3
"""Security regressions for Level-1 constitution synchronization."""

from __future__ import annotations

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"


def git(repo: Path, *args: str) -> None:
    subprocess.run(["git", "-C", str(repo), *args], check=True, capture_output=True)


def fixture(base: Path, linked_target: bool) -> tuple[Path, Path, Path]:
    home = base / "home"
    repo = home / "Workspace"
    outside = base / "outside.md"
    home.mkdir()
    repo.mkdir()
    (home / "constitution.md").write_text("# Constitution v2.0.0\nnew\n", encoding="utf-8")
    outside.write_text("private\n", encoding="utf-8")
    if linked_target:
        (repo / "constitution.md").symlink_to(outside)
    else:
        (repo / "constitution.md").write_text("# Constitution v1.0.0\nold\n", encoding="utf-8")
    git(repo, "init", "-q", "-b", "main")
    git(repo, "config", "user.name", "Test")
    git(repo, "config", "user.email", "test@example.invalid")
    git(repo, "add", ".")
    git(repo, "commit", "-qm", "initial")
    return home, repo, outside


def run(home: Path, *args: str) -> subprocess.CompletedProcess[str]:
    env = os.environ.copy()
    env["HOME"] = str(home)
    return subprocess.run(
        args,
        cwd=ROOT,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )


class ConstitutionSyncSecurityTests(unittest.TestCase):
    def test_bash_rejects_linked_constitution_target(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            home, _, outside = fixture(Path(tmp), linked_target=True)
            result = run(
                home,
                "bash",
                str(SCRIPTS / "sync-constitution.sh"),
                "--yes",
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "private\n")

    def test_bash_updates_regular_constitution_target(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            home, repo, _ = fixture(Path(tmp), linked_target=False)
            result = run(
                home,
                "bash",
                str(SCRIPTS / "sync-constitution.sh"),
                "--yes",
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(
                (repo / "constitution.md").read_text(encoding="utf-8"),
                "# Constitution v2.0.0\nnew\n",
            )

    @unittest.skipUnless(shutil.which("pwsh"), "pwsh is not installed")
    def test_powershell_rejects_linked_constitution_target(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            home, _, outside = fixture(Path(tmp), linked_target=True)
            result = run(
                home,
                "pwsh",
                "-NoProfile",
                "-File",
                str(SCRIPTS / "sync-constitution.ps1"),
                "-Force",
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "private\n")

    @unittest.skipUnless(shutil.which("pwsh"), "pwsh is not installed")
    def test_powershell_updates_regular_constitution_target(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            home, repo, _ = fixture(Path(tmp), linked_target=False)
            result = run(
                home,
                "pwsh",
                "-NoProfile",
                "-File",
                str(SCRIPTS / "sync-constitution.ps1"),
                "-Force",
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(
                (repo / "constitution.md").read_text(encoding="utf-8"),
                "# Constitution v2.0.0\nnew\n",
            )


if __name__ == "__main__":
    unittest.main()
