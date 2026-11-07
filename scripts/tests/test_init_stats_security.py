#!/usr/bin/env python3
"""Security regressions for statistics and RL-SE managed outputs."""

from __future__ import annotations

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
INIT_SH = ROOT / "scripts/init-stats.sh"
INIT_PS1 = ROOT / "scripts/init-stats.ps1"
RL_SH = ROOT / "scripts/prepare-rl-se-checklist-selbstpruefung.sh"
RL_PS1 = ROOT / "scripts/prepare-rl-se-checklist-selbstpruefung.ps1"


def run(command: list[str], *, home: Path) -> subprocess.CompletedProcess[str]:
    env = os.environ.copy()
    env["HOME"] = str(home)
    env["USERPROFILE"] = str(home)
    return subprocess.run(
        command,
        cwd=ROOT,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
        timeout=30,
    )


class InitStatsSecurityTests(unittest.TestCase):
    def test_bash_regular_file_is_updated_atomically_and_preserves_content(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            target = home / "Workspace"
            target.mkdir()
            stats = target / "STATS.md"
            stats.write_text("# Existing\n", encoding="utf-8")
            stats.chmod(0o640)

            result = run(["bash", str(INIT_SH), str(target)], home=home)

            self.assertEqual(result.returncode, 0, result.stdout)
            self.assertTrue(stats.read_text(encoding="utf-8").startswith("# Existing\n"))
            self.assertEqual(stats.stat().st_mode & 0o777, 0o640)
            self.assertEqual(list(target.glob(".STATS.md.*")), [])

    def test_bash_rejects_existing_and_dangling_stats_links(self) -> None:
        for dangling in (False, True):
            with self.subTest(dangling=dangling), tempfile.TemporaryDirectory() as temporary:
                base = Path(temporary)
                home = base / "home"
                target = home / "Workspace"
                target.mkdir(parents=True)
                outside = base / "outside.md"
                if not dangling:
                    outside.write_text("sentinel\n", encoding="utf-8")
                (target / "STATS.md").symlink_to(outside)

                result = run(["bash", str(INIT_SH), str(target)], home=home)

                self.assertNotEqual(result.returncode, 0, result.stdout)
                if dangling:
                    self.assertFalse(outside.exists())
                else:
                    self.assertEqual(outside.read_text(encoding="utf-8"), "sentinel\n")

    def test_bash_rejects_linked_workspace_root(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            base = Path(temporary)
            home = base / "home"
            home.mkdir()
            outside = base / "outside"
            outside.mkdir()
            (home / "Linked").symlink_to(outside, target_is_directory=True)
            result = run(["bash", str(INIT_SH), "Linked"], home=home)
            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertFalse((outside / "STATS.md").exists())

    def test_bash_rejects_linked_intermediate_workspace_parent(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            base = Path(temporary)
            home = base / "home"
            home.mkdir()
            outside = base / "outside"
            workspace = outside / "Workspace"
            workspace.mkdir(parents=True)
            linked_parent = home / "linked-parent"
            linked_parent.symlink_to(outside, target_is_directory=True)
            result = run(["bash", str(INIT_SH), str(linked_parent / "Workspace")], home=home)
            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertFalse((workspace / "STATS.md").exists())

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_rejects_linked_home_workspace_and_stats_leaf(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            base = Path(temporary)
            home = base / "home"
            home.mkdir()
            outside = base / "outside"
            outside.mkdir()
            (home / "Linked").symlink_to(outside, target_is_directory=True)
            linked_root = run(
                ["pwsh", "-NoProfile", "-File", str(INIT_PS1), "-WorkspaceName", "Linked"],
                home=home,
            )
            self.assertNotEqual(linked_root.returncode, 0, linked_root.stdout)
            self.assertFalse((outside / "STATS.md").exists())

            regular = home / "Regular"
            regular.mkdir()
            sentinel = base / "sentinel.md"
            sentinel.write_text("sentinel\n", encoding="utf-8")
            (regular / "STATS.md").symlink_to(sentinel)
            linked_leaf = run(
                ["pwsh", "-NoProfile", "-File", str(INIT_PS1), "-WorkspaceName", str(regular)],
                home=home,
            )
            self.assertNotEqual(linked_leaf.returncode, 0, linked_leaf.stdout)
            self.assertEqual(sentinel.read_text(encoding="utf-8"), "sentinel\n")

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_rejects_linked_intermediate_workspace_parent(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            base = Path(temporary)
            home = base / "home"
            home.mkdir()
            outside = base / "outside"
            workspace = outside / "Workspace"
            workspace.mkdir(parents=True)
            linked_parent = home / "linked-parent"
            linked_parent.symlink_to(outside, target_is_directory=True)
            result = run(
                ["pwsh", "-NoProfile", "-File", str(INIT_PS1),
                 "-WorkspaceName", str(linked_parent / "Workspace")],
                home=home,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertFalse((workspace / "STATS.md").exists())


class RlSeOutputSecurityTests(unittest.TestCase):
    def make_repo(self, base: Path) -> Path:
        repo = base / "repo"
        (repo / ".git").mkdir(parents=True)
        (repo / "AGENTS.md").write_text("# Agent\n", encoding="utf-8")
        return repo

    def test_bash_dangling_intake_link_blocks_before_baseline_sync(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            base = Path(temporary)
            home = base / "home"
            home.mkdir()
            repo = self.make_repo(base)
            outside = base / "outside.md"
            (repo / "Lastenheft_RL-SE-Checklist-Selbstpruefung.md").symlink_to(outside)

            result = run(
                ["bash", str(RL_SH), "--home-dir", str(home), "--repo", str(repo), "--dry-run"],
                home=home,
            )

            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertFalse(outside.exists())
            self.assertFalse((repo / "docs/secure-development").exists())

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_dangling_intake_link_blocks_before_baseline_sync(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            base = Path(temporary)
            home = base / "home"
            home.mkdir()
            repo = self.make_repo(base)
            outside = base / "outside.md"
            (repo / "Lastenheft_RL-SE-Checklist-Selbstpruefung.md").symlink_to(outside)

            result = run(
                ["pwsh", "-NoProfile", "-File", str(RL_PS1), "-HomeDir", str(home),
                 "-Repo", str(repo), "-WhatIf"],
                home=home,
            )

            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertFalse(outside.exists())
            self.assertFalse((repo / "docs/secure-development").exists())


if __name__ == "__main__":
    unittest.main()
