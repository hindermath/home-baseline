#!/usr/bin/env python3
"""Contract tests for the Feature-020 documentation architecture audit."""

from __future__ import annotations

import copy
import importlib.util
import json
from pathlib import Path
import subprocess
import tempfile
import unittest


FEATURE_DIR = Path(__file__).resolve().parents[1]


def load_module(name: str, relative_path: str):
    path = FEATURE_DIR / relative_path
    spec = importlib.util.spec_from_file_location(name, path)
    if spec is None or spec.loader is None:
        raise RuntimeError(f"cannot load {path}")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


collector = load_module("feature020_collector", "tools/collect_documentation_architecture.py")
validator = load_module("feature020_validator", "tools/validate_documentation_architecture.py")


class DocumentationArchitectureContractTests(unittest.TestCase):
    def setUp(self) -> None:
        self.tempdir = tempfile.TemporaryDirectory()
        self.repo = Path(self.tempdir.name)
        subprocess.run(["git", "init", "-q", str(self.repo)], check=True)
        subprocess.run(["git", "-C", str(self.repo), "config", "user.name", "Fixture"], check=True)
        subprocess.run(["git", "-C", str(self.repo), "config", "user.email", "fixture@example.invalid"], check=True)
        (self.repo / "docs").mkdir()
        (self.repo / "scripts/config").mkdir(parents=True)
        (self.repo / "README.md").write_text("# Fixture\r\n", encoding="utf-8")
        (self.repo / "docs/guide.md").write_text("# Guide\n", encoding="utf-8")
        manifest = {
            "schemaVersion": 2,
            "homeRuntime": {"rootFiles": ["README.md"]},
            "sourceOnly": {"trackedPrefixes": ["docs/"]},
            "machineLocal": {"rootFiles": ["STATS.md"]},
        }
        (self.repo / "scripts/config/home-sync-manifest.json").write_text(
            json.dumps(manifest, indent=2) + "\n", encoding="utf-8"
        )
        subprocess.run(["git", "-C", str(self.repo), "add", "."], check=True)
        subprocess.run(["git", "-C", str(self.repo), "commit", "-qm", "fixture"], check=True)
        self.commit = subprocess.check_output(
            ["git", "-C", str(self.repo), "rev-parse", "HEAD"], text=True
        ).strip()
        self.audit = self._valid_audit()

    def tearDown(self) -> None:
        self.tempdir.cleanup()

    def _unit(self, path: str) -> dict:
        content = subprocess.check_output(
            ["git", "-C", str(self.repo), "show", f"{self.commit}:{path}"]
        )
        return {
            "unitId": validator.stable_unit_id(path),
            "path": path,
            "normalizedSha256": validator.normalized_sha256_bytes(content),
            "family": "Root" if "/" not in path else path.split("/", 1)[0],
            "artifactClass": "ActiveSemantic",
            "decision": "KeepAsIs",
            "audiences": ["DailyUser"],
            "readerPaths": ["DailyUser"],
            "canonicalSource": path,
            "owner": "Level0",
            "rationale": "Fixture evidence.",
            "evidence": [path],
            "risk": "Low",
            "reevaluationTrigger": "Fixture changes.",
            "distributionClass": "sourceOnly",
        }

    def _reader_path(self, path_id: str) -> dict:
        return {
            "readerPathId": path_id,
            "entryPoints": ["README.md"],
            "prerequisites": ["Git access"],
            "steps": ["Open the entry point", "Follow the named link"],
            "deepReferences": ["docs/guide.md"],
            "safeNextAction": "Read the referenced guide.",
            "status": "Pass",
            "evidence": ["README.md", "docs/guide.md"],
            "findingId": None,
        }

    def _contract(self, contract_id: str) -> dict:
        return {
            "contractId": contract_id,
            "sourceFeature": contract_id.split("-", 1)[0],
            "topic": contract_id,
            "expectedBehavior": "The documented contract matches accepted evidence.",
            "proofBoundary": "Fixture-only semantic assertion.",
            "dimensions": {
                surface: {"status": "Pass", "evidence": ["README.md"], "findingId": None}
                for surface in validator.REQUIRED_SURFACES
            },
        }

    def _valid_audit(self) -> dict:
        units = [
            self._unit("README.md"),
            self._unit("docs/guide.md"),
            self._unit("scripts/config/home-sync-manifest.json"),
        ]
        units[0]["distributionClass"] = "homeRuntime"
        return {
            "schemaVersion": "1.0",
            "auditId": "fixture-audit",
            "capturedAt": "2026-08-01T00:00:00Z",
            "repositoryCommit": self.commit,
            "inventorySource": "GitTree",
            "acceptedEvidence": [
                {"path": "README.md", "normalizedSha256": units[0]["normalizedSha256"]}
            ],
            "documentationUnits": units,
            "excludedSurfaces": [],
            "readerPaths": [self._reader_path(path_id) for path_id in validator.REQUIRED_READER_PATHS],
            "maintenanceContracts": [
                self._contract(contract_id) for contract_id in validator.REQUIRED_CONTRACT_IDS
            ],
            "sourceRuntimeRecords": [
                self._source_record("homeRuntime", ["README.md"]),
                self._source_record(
                    "sourceOnly", ["docs/guide.md", "scripts/config/home-sync-manifest.json"]
                ),
                self._source_record("machineLocal", ["STATS.md"]),
            ],
            "findings": [],
            "governance": [
                {
                    "preset": "security-governance",
                    "checkpoint": "NIST SSDF",
                    "applicability": "Applicable",
                    "result": "Pass",
                    "rationale": "Fixture validation.",
                    "evidence": ["README.md"],
                    "owner": "Level0",
                    "reviewer": "Fixture",
                    "reviewDate": "2026-08-01",
                    "residualRisk": "Low",
                    "followUp": "N/A",
                    "reevaluationTrigger": "Fixture changes.",
                }
            ],
            "summary": {
                "status": "Ready",
                "documentationUnitCount": len(units),
                "excludedSurfaceCount": 0,
                "findingCount": 0,
                "d5FindingCount": 0,
                "d6FindingCount": 0,
                "d7FindingCount": 0,
            },
        }

    @staticmethod
    def _source_record(artifact_class: str, paths: list[str]) -> dict:
        return {
            "recordId": artifact_class,
            "artifactClass": artifact_class,
            "resolvedPaths": paths,
            "owner": "Level0",
            "canonicalEditLocation": "Level-0 source",
            "syncRequired": artifact_class == "homeRuntime",
            "commitAuthority": "Level0",
            "remoteAuthority": "Explicit only",
            "benefit": "Separates source, runtime copy, and local state.",
            "proofBoundary": "Fixture manifest.",
            "safeNextAction": "Use the documented source path.",
            "status": "Pass",
            "findingId": None,
        }

    def assert_invalid(self, audit: dict, category: str) -> None:
        errors = validator.validate_audit(audit, self.repo)
        self.assertTrue(any(error.startswith(f"{category}:") for error in errors), errors)

    def test_minimal_positive_fixture(self) -> None:
        self.assertEqual([], validator.validate_audit(self.audit, self.repo))

    def test_missing_inventory_path(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["documentationUnits"].pop()
        self.assert_invalid(audit, "INVENTORY_SET")

    def test_duplicate_inventory_path(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["documentationUnits"].append(copy.deepcopy(audit["documentationUnits"][0]))
        self.assert_invalid(audit, "INVENTORY_DUPLICATE")

    def test_stale_hash(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["documentationUnits"][0]["normalizedSha256"] = "0" * 64
        self.assert_invalid(audit, "INVENTORY_HASH")

    def test_unknown_artifact_class(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["documentationUnits"][0]["artifactClass"] = "Unknown"
        self.assert_invalid(audit, "UNIT_CLASS")

    def test_unknown_primary_decision(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["documentationUnits"][0]["decision"] = "Maybe"
        self.assert_invalid(audit, "UNIT_DECISION")

    def test_positive_claim_requires_evidence(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["documentationUnits"][0]["evidence"] = []
        self.assert_invalid(audit, "UNIT_EVIDENCE")

    def test_incomplete_reader_path(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["readerPaths"] = audit["readerPaths"][:-1]
        self.assert_invalid(audit, "READER_SET")

    def test_missing_maintenance_contract(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["maintenanceContracts"] = audit["maintenanceContracts"][:-1]
        self.assert_invalid(audit, "CONTRACT_SET")

    def test_incomplete_source_runtime_class(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["sourceRuntimeRecords"] = audit["sourceRuntimeRecords"][:-1]
        self.assert_invalid(audit, "SOURCE_CLASS_SET")

    def test_gap_requires_finding(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["readerPaths"][0]["status"] = "Gap"
        self.assert_invalid(audit, "GAP_FINDING")

    def test_finding_requires_owner_and_successor(self) -> None:
        audit = copy.deepcopy(self.audit)
        finding = self._finding("DIA001")
        finding["owner"] = ""
        finding["successor"] = ""
        audit["findings"] = [finding]
        audit["summary"]["findingCount"] = 1
        self.assert_invalid(audit, "FINDING_FIELD")

    def test_accepted_row_cannot_retain_gap(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["maintenanceContracts"][0]["dimensions"]["README"] = {
            "status": "Gap", "evidence": ["README.md"], "findingId": None
        }
        self.assert_invalid(audit, "GAP_FINDING")

    def test_private_absolute_path_is_rejected(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["documentationUnits"][0]["rationale"] = "/Users/example/private"
        self.assert_invalid(audit, "PRIVATE_PATH")

    def test_secret_like_value_is_rejected(self) -> None:
        audit = copy.deepcopy(self.audit)
        audit["documentationUnits"][0]["rationale"] = (
            "gh" + "p_abcdefghijklmnopqrstuvwxyz0123456789"
        )
        self.assert_invalid(audit, "SECRET")

    def test_line_ending_and_bom_normalization(self) -> None:
        expected = validator.normalized_sha256_bytes(b"alpha\nbeta\n")
        self.assertEqual(expected, validator.normalized_sha256_bytes(b"alpha\r\nbeta\r\n"))
        self.assertEqual(expected, validator.normalized_sha256_bytes(b"\xef\xbb\xbfalpha\nbeta\n"))

    def test_collector_uses_frozen_commit(self) -> None:
        decisions = {
            "schemaVersion": "1.0",
            "auditId": "fixture-audit",
            "repositoryCommit": self.commit,
            "documentationSuffixes": [".md", ".json"],
            "includeScriptHelp": False,
            "defaultDecision": {
                "artifactClass": "ActiveSemantic",
                "decision": "KeepAsIs",
                "audiences": ["DailyUser"],
                "readerPaths": ["DailyUser"],
                "canonicalSource": "self",
                "owner": "Level0",
                "rationale": "Fixture evidence.",
                "evidence": ["self"],
                "risk": "Low",
                "reevaluationTrigger": "Fixture changes."
            },
            "rules": [],
            "overrides": {},
        }
        (self.repo / "untracked.md").write_text("not in accepted tree\n", encoding="utf-8")
        inventory = collector.collect_inventory(self.repo, self.commit, decisions)
        self.assertNotIn("untracked.md", [row["path"] for row in inventory["documentationUnits"]])

    @staticmethod
    def _finding(finding_id: str) -> dict:
        return {
            "findingId": finding_id,
            "severity": "Medium",
            "summary": "Fixture finding.",
            "evidence": ["README.md"],
            "owner": "DocumentationArchitecture",
            "residualRisk": "Low",
            "successor": "D5",
            "targetBoundary": "Documentation only.",
            "reevaluationTrigger": "README changes.",
            "status": "Open",
        }


if __name__ == "__main__":
    unittest.main()
