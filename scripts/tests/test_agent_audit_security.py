#!/usr/bin/env python3
"""Security regression tests for local agent-audit reports."""

from __future__ import annotations

import os
from pathlib import Path
import shutil
import stat
import subprocess
import tempfile
import time
import unittest


ROOT = Path(__file__).resolve().parents[2]
BASH_SCRIPT = ROOT / "scripts/audit-agent-changes.sh"
POWERSHELL_SCRIPT = ROOT / "scripts/audit-agent-changes.ps1"
SENTINEL = "audit-secret-sentinel-7f93d1"


class AgentAuditSecurityTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        self.home = self.root / "home"
        self.state = self.root / "state"
        (self.home / ".agents").mkdir(parents=True)
        self.monitored = self.home / ".agents/Target.md"
        self.monitored.write_text("initial\n", encoding="utf-8")

    def add_matching_private_log(self) -> None:
        time.sleep(0.02)
        self.monitored.write_text("changed\n", encoding="utf-8")
        log = self.home / ".codex/history.jsonl"
        log.parent.mkdir(parents=True)
        log.write_text(f'{{"message":"Target {SENTINEL}"}}\n', encoding="utf-8")

    def assert_private_outputs(self, output: str) -> None:
        self.assertNotIn(SENTINEL, output)
        reports = list((self.state / "reports").glob("*.json"))
        self.assertGreaterEqual(len(reports), 2)
        for report in reports:
            text = report.read_text(encoding="utf-8")
            self.assertNotIn(SENTINEL, text)
            self.assertIn("[content redacted]", text)
            if os.name != "nt":
                self.assertEqual(stat.S_IMODE(report.stat().st_mode), 0o600)
        if os.name != "nt":
            for directory in (self.state, self.state / "snapshots", self.state / "reports"):
                self.assertEqual(stat.S_IMODE(directory.stat().st_mode), 0o700)

    def test_bash_redacts_log_content_and_forces_private_modes(self) -> None:
        env = os.environ.copy()
        env["HOME"] = str(self.home)
        snapshot = subprocess.run(
            ["bash", str(BASH_SCRIPT), "snapshot", "--home", str(self.home), "--state-dir", str(self.state)],
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        self.assertEqual(snapshot.returncode, 0, snapshot.stdout)
        self.add_matching_private_log()
        result = subprocess.run(
            ["bash", str(BASH_SCRIPT), "report", "--home", str(self.home), "--state-dir", str(self.state), "--json"],
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assert_private_outputs(result.stdout)

    def test_bash_rejects_linked_state_directory_without_external_write(self) -> None:
        external = self.root / "external-state"
        external.mkdir()
        self.state.symlink_to(external, target_is_directory=True)
        env = os.environ.copy()
        env["HOME"] = str(self.home)

        result = subprocess.run(
            ["bash", str(BASH_SCRIPT), "snapshot", "--home", str(self.home), "--state-dir", str(self.state)],
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertEqual(list(external.iterdir()), [])

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_redacts_log_content_and_forces_private_modes(self) -> None:
        pwsh = shutil.which("pwsh")
        snapshot = subprocess.run(
            [pwsh, "-NoProfile", "-File", str(POWERSHELL_SCRIPT), "-Action", "snapshot", "-HomeDir", str(self.home), "-StateDir", str(self.state)],
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        self.assertEqual(snapshot.returncode, 0, snapshot.stdout)
        self.add_matching_private_log()
        result = subprocess.run(
            [pwsh, "-NoProfile", "-File", str(POWERSHELL_SCRIPT), "-Action", "report", "-HomeDir", str(self.home), "-StateDir", str(self.state), "-Json"],
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assert_private_outputs(result.stdout)

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_rejects_linked_state_directory_without_external_write(self) -> None:
        external = self.root / "external-state"
        external.mkdir()
        original_mode = stat.S_IMODE(external.stat().st_mode)
        self.state.symlink_to(external, target_is_directory=True)

        result = subprocess.run(
            [shutil.which("pwsh"), "-NoProfile", "-File", str(POWERSHELL_SCRIPT), "-Action", "snapshot", "-HomeDir", str(self.home), "-StateDir", str(self.state)],
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertEqual(list(external.iterdir()), [])
        self.assertEqual(stat.S_IMODE(external.stat().st_mode), original_mode)


if __name__ == "__main__":
    unittest.main()
