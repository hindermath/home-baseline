#!/usr/bin/env python3
"""Security regressions for shared guidance propagation."""

from __future__ import annotations

import os
from pathlib import Path
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts/propagate-security-guidance.sh"


def initialize_target(home: Path) -> Path:
    target = home / "Workspace"
    target.mkdir(parents=True)
    subprocess.run(["git", "-C", str(target), "init", "-q"], check=True)
    return target


def run(home: Path) -> subprocess.CompletedProcess[str]:
    env = os.environ.copy()
    env["HOME"] = str(home)
    return subprocess.run(
        ["bash", str(SCRIPT)],
        cwd=ROOT,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )


class SecurityGuidancePropagationSecurityTests(unittest.TestCase):
    def test_linked_guidance_leaf_is_rejected_without_external_write(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home = base / "home"
            target = initialize_target(home)
            outside = base / "outside.md"
            outside.write_text("private\n", encoding="utf-8")
            (target / "AGENTS.md").symlink_to(outside)
            result = run(home)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "private\n")

    def test_dangling_guidance_leaf_is_rejected_without_external_creation(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home = base / "home"
            target = initialize_target(home)
            outside = base / "outside.md"
            (target / "AGENTS.md").symlink_to(outside)
            (target / "CLAUDE.md").write_text("# Agent\n", encoding="utf-8")
            result = run(home)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(outside.exists())

    def test_linked_guidance_parent_is_rejected_without_external_write(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home = base / "home"
            target = initialize_target(home)
            (target / "AGENTS.md").write_text("# Agent\n", encoding="utf-8")
            outside = base / "outside"
            outside.mkdir()
            (target / ".github").symlink_to(outside, target_is_directory=True)
            result = run(home)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((outside / "copilot-instructions.md").exists())

    def test_regular_guidance_file_is_updated(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home = base / "home"
            target = initialize_target(home)
            agents = target / "AGENTS.md"
            agents.write_text(
                "# Agent\n\n## Sicherheitsdokumentation\n\nold\n\n"
                "## Sicherheitsstandards\n\nold\n",
                encoding="utf-8",
            )
            result = run(home)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn(
                "samm-assessment-template.md",
                agents.read_text(encoding="utf-8"),
            )


if __name__ == "__main__":
    unittest.main()
