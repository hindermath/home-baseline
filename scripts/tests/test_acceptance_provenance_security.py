#!/usr/bin/env python3
"""Regression tests for local-vs-Primary acceptance evidence boundaries."""

from __future__ import annotations

import importlib.util
import json
from pathlib import Path
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]


def load(relative: str, name: str):
    spec = importlib.util.spec_from_file_location(name, ROOT / relative)
    assert spec is not None and spec.loader is not None
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


class AcceptanceProvenanceSecurityTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls) -> None:
        cls.stage_b = load("scripts/tests/run_stage_b_rollout_acceptance.py", "stage_b_acceptance_security")
        cls.copilot = load("scripts/tests/run_copilot_review_governance_acceptance.py", "copilot_acceptance_security")
        cls.ci_budget = load("scripts/tests/run_ci_budget_acceptance.py", "ci_budget_acceptance_security")
        cls.requirement = {
            "applicability": "Applicable",
            "requiredScope": "fixture",
            "rationale": "fixture",
            "reevaluationTrigger": "fixture",
        }

    def test_stage_b_local_execution_is_supplemental_open(self) -> None:
        entry = self.stage_b.build_local_evidence_entry(
            "AC-SBR-003", self.requirement, "a" * 40,
            ["Linux", "LocalFixture"], "b" * 64, "python3 fixture", ["GitHub"],
        )
        self.assertEqual((entry["evidenceRole"], entry["result"]), ("Supplemental", "Open"))
        self.assertFalse(entry["primaryCommandExecuted"])
        self.assertNotIn("GitHub", entry["runnerOrPlatform"])
        self.assertEqual(entry["openPrimaryRequirements"]["missingRunnerOrPlatformTokens"], ["GitHub"])

    def test_stage_b_missing_primary_tokens_do_not_suppress_supplemental(self) -> None:
        requirement = {
            "requiredCommandTokens": ["python3 fixture"],
            "requiredRunnerOrPlatformTokens": ["macOS", "GitHub", "Linux", "Windows"],
        }
        missing = self.stage_b.validate_command_and_tokens(requirement, "python3 fixture", ["macOS", "LocalFixture"])
        self.assertEqual(missing, ["GitHub", "Linux", "Windows"])

    def test_ci_budget_local_inputs_are_supplemental_open(self) -> None:
        entry = self.ci_budget.build_local_evidence_entry(
            "AC-CBG-010", self.requirement, "a" * 40,
            "python3 fixture", [{"path": "self.json", "sha256": "b" * 64}],
        )
        self.assertEqual((entry["evidenceRole"], entry["result"]), ("Supplemental", "Open"))
        self.assertFalse(entry["primaryCommandExecuted"])

    def test_self_authored_copilot_primary_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as raw:
            root = Path(raw)
            evidence = root / "evidence"
            primary = evidence / "primary/AC-CRG-001.json"
            primary.parent.mkdir(parents=True)
            primary.write_text(json.dumps({
                "gateId": "AC-CRG-001", "evidenceRole": "Primary", "status": "Passed",
                "providerMutationsOutsideAuthorizedScope": 0, "secretFindings": 0,
                "payloadPath": "payload.json", "payloadSha256": "a" * 64,
            }), encoding="utf-8")
            passed, reason = self.copilot.validate_primary(root, evidence, "AC-CRG-001")
            self.assertFalse(passed)
            self.assertIn("self-attested", reason)

    def test_copilot_preview_modes_do_not_write_supplemental_files(self) -> None:
        with tempfile.TemporaryDirectory() as raw:
            root = Path(raw)
            evidence = root / "evidence"
            for preview_flag in ("--check-only", "--dry-run", "-WhatIf"):
                result = subprocess.run([
                    sys.executable,
                    str(ROOT / "scripts/tests/run_copilot_review_governance_acceptance.py"),
                    "--gate", "AC-CRG-001", "--repository-root", str(root),
                    "--evidence-root", "evidence", preview_flag,
                ], text=True, capture_output=True, check=False)
                self.assertEqual(result.returncode, 3, result.stderr)
                self.assertFalse((root / "specs").exists())
                self.assertFalse(evidence.exists())

    def test_committed_stage_b_ledgers_reclassify_local_records(self) -> None:
        for relative in (
            "specs/030-stage-b-rollout/evidence/v1/acceptance-operational.json",
            "specs/030-stage-b-rollout/evidence/v1/stage-b-causal-postmerge.json",
        ):
            ledger = json.loads((ROOT / relative).read_text(encoding="utf-8"))
            self.assertIn("Supplemental/Open", ledger["securityReclassification"])
            self.assertTrue(ledger["entries"])
            self.assertTrue(all(
                entry["evidenceRole"] == "Supplemental" and entry["result"] == "Open"
                and entry["provider"] == "HistoricalUnverifiedSelfAttestation"
                and entry["runnerOrPlatform"] == "HistoricalUnverifiedSelfLabel"
                and entry["supplementalFor"] == entry["gateId"]
                for entry in ledger["entries"]
            ))


if __name__ == "__main__":
    unittest.main()
