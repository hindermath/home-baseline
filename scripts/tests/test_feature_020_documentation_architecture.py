#!/usr/bin/env python3
"""Expose Feature-020 contract and aggregate validation to provider CI."""

from __future__ import annotations

from pathlib import Path
import subprocess
import sys
import unittest


REPOSITORY_ROOT = Path(__file__).resolve().parents[2]
FEATURE_ROOT = REPOSITORY_ROOT / "specs" / "020-documentation-architecture-audit"


class Feature020ProviderDiscoveryTests(unittest.TestCase):
    def test_feature_contract_suite(self) -> None:
        process = subprocess.run(
            [
                sys.executable,
                "-m",
                "unittest",
                "discover",
                "-s",
                str(FEATURE_ROOT / "tests"),
                "-p",
                "test_*.py",
            ],
            cwd=REPOSITORY_ROOT,
            text=True,
            capture_output=True,
            check=False,
        )
        self.assertEqual(0, process.returncode, process.stdout + process.stderr)

    def test_committed_audit_aggregate(self) -> None:
        process = subprocess.run(
            [
                sys.executable,
                str(FEATURE_ROOT / "tools" / "validate_documentation_architecture.py"),
                "--repo",
                str(REPOSITORY_ROOT),
                "--audit",
                str(FEATURE_ROOT / "documentation-architecture-audit.json"),
            ],
            cwd=REPOSITORY_ROOT,
            text=True,
            capture_output=True,
            check=False,
        )
        self.assertEqual(0, process.returncode, process.stdout + process.stderr)


if __name__ == "__main__":
    unittest.main()
