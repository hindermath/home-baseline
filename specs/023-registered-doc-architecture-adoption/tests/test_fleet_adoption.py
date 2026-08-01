#!/usr/bin/env python3
"""Contract tests for the Feature-023 fleet-adoption evidence."""

from __future__ import annotations

import copy
import hashlib
import json
import subprocess
import tempfile
import unittest
from pathlib import Path


FEATURE_DIR = Path(__file__).resolve().parents[1]
VALIDATOR = FEATURE_DIR / "tools" / "validate_fleet_adoption.py"


def normalized_sha256(path: Path) -> str:
    raw = path.read_bytes()
    if raw.startswith(b"\xef\xbb\xbf"):
        raw = raw[3:]
    text = raw.decode("utf-8").replace("\r\n", "\n").replace("\r", "\n")
    return hashlib.sha256(text.encode("utf-8")).hexdigest()


class FleetAdoptionContractTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.repo = Path(self.temp.name)
        (self.repo / "scripts/config").mkdir(parents=True)
        (self.repo / "docs/maintenance").mkdir(parents=True)
        (self.repo / "evidence").mkdir()

        self.manifest_path = self.repo / "scripts/config/fleet.json"
        self.manifest_path.write_text(
            json.dumps(
                {
                    "schemaVersion": "1.0",
                    "targets": [
                        self.manifest_target("adopted", "git-repository", "canonical-fleet"),
                        self.manifest_target("aligned", "git-repository", "canonical-fleet"),
                        self.manifest_target("blocked", "git-repository", "canonical-fleet"),
                        self.manifest_target("preset", "git-repository", "preset"),
                        self.manifest_target("collection", "collection", "preset"),
                    ],
                },
                indent=2,
            )
            + "\n",
            encoding="utf-8",
        )

        self.claims_path = self.repo / "docs/maintenance/claims.json"
        self.claims_path.write_text(
            json.dumps(
                {"claims": [{"id": f"AEC{index:03d}"} for index in range(1, 18)]},
                indent=2,
            )
            + "\n",
            encoding="utf-8",
        )
        self.matrix = self.valid_matrix()

    def tearDown(self) -> None:
        self.temp.cleanup()

    @staticmethod
    def manifest_target(target_id: str, kind: str, maintenance_class: str) -> dict:
        target = {
            "id": target_id,
            "kind": kind,
            "level": 2 if kind == "git-repository" else 1,
            "path": f"targets/{target_id}",
            "active": True,
            "maintenanceClass": maintenance_class,
        }
        if kind == "git-repository":
            target.update(
                remote=f"https://example.invalid/{target_id}.git",
                defaultBranch="main",
            )
        return target

    def impact(self, decision: str, target_id: str) -> dict:
        return {
            "decision": decision,
            "source": "docs/documentation-governance.md",
            "owner": f"{target_id} Repository Owner",
            "audiences": ["Users", "Learners", "Maintainers", "Reviewers"],
            "readerPaths": ["RepositoryEntry", "MaintainerReference"],
            "targetPaths": ["docs/documentation-governance.md"] if decision == "UpdateRequired" else [],
            "navigationImpact": "None",
            "documentClass": "Governance",
            "languageStrategy": "DE-first/EN-second in one file",
            "languagePartners": [],
            "platformAndExampleProof": "Text-first and platform-neutral",
            "distributionClass": "repositorySource",
            "homeSyncRequired": False,
            "evidence": ["evidence/matrix.json"],
            "residualRisk": "Low",
            "reevaluationTrigger": "Documentation architecture changes.",
        }

    def assessments(self, evidence: str) -> list[dict]:
        return [
            {
                "claimId": f"AEC{index:03d}",
                "applicability": "AlreadyCovered" if index in (14, 15) else "N/A",
                "targetEvidence": evidence,
                "targetTerminology": "Repository-native terminology",
                "proofBoundary": "No runtime behavior is inferred.",
            }
            for index in range(1, 18)
        ]

    def target(self, target_id: str, decision: str, kind: str = "git-repository") -> dict:
        adopted = decision == "Adopted"
        blocked = decision == "Blocked"
        impact = self.impact("UpdateRequired" if adopted else "NoUpdateRequired", target_id)
        if blocked:
            impact = self.impact("FollowUp", target_id)
            impact.update(
                followUpOwner=f"{target_id} Repository Owner",
                risk="User-owned work blocks safe adoption.",
                dueDate="2026-08-15",
                scopeRationale="Feature 023 never changes an unsafe checkout.",
            )
        delivery = None
        if adopted:
            delivery = {
                "branch": "codex/adopt-doc-governance",
                "commit": "a" * 40,
                "pullRequest": "https://example.invalid/pr/1",
                "reviewedHead": "a" * 40,
                "requiredGates": ["git diff --check"],
                "providerEvidence": ["evidence/pr.json"],
                "actionableThreads": 0,
                "mergeCommit": "b" * 40,
                "finalDefaultBranchHead": "b" * 40,
                "synchronized": True,
            }
        return {
            "targetId": target_id,
            "kind": kind,
            "level": 2 if kind == "git-repository" else 1,
            "maintenanceClass": "canonical-fleet" if target_id not in ("preset", "collection") else "preset",
            "repositoryPathClass": f"targets/{target_id}",
            "remoteIdentity": f"https://example.invalid/{target_id}.git" if kind == "git-repository" else "N/A",
            "defaultBranch": "main" if kind == "git-repository" else "N/A",
            "observedBranch": "feature" if blocked else ("main" if kind == "git-repository" else "N/A"),
            "observedHead": "c" * 40 if kind == "git-repository" else "N/A",
            "fetchResult": "Completed" if kind == "git-repository" else "N/A",
            "worktreeClass": "BlockedNonDefaultDirty" if blocked else ("CleanSynchronized" if kind == "git-repository" else "Collection"),
            "inventorySummary": {
                "trackedDocumentationCount": 1 if kind == "git-repository" else 0,
                "readerPaths": ["RepositoryEntry", "MaintainerReference"],
                "canonicalSources": ["README.md"],
                "languageStrategy": "Repository policy",
                "agentSurfaceCount": 5 if kind == "git-repository" else 0,
                "generatedAndHistoricalBoundary": "Preserved",
            },
            "claimAssessments": [] if kind == "collection" else self.assessments("README.md"),
            "decision": decision,
            "rationale": f"Fixture decision for {target_id}.",
            "documentationImpact": impact,
            "validation": {"status": "Pass" if adopted else "N/A", "commands": ["git diff --check"] if adopted else []},
            "delivery": delivery,
            "residualRisk": "Low",
            "nextAction": "N/A" if not blocked else "Repository owner resolves local work.",
            "reevaluationTrigger": "Repository documentation changes.",
        }

    def valid_matrix(self) -> dict:
        target_set = "adopted\naligned\nblocked\n"
        target_set_hash = hashlib.sha256(target_set.encode("utf-8")).hexdigest()
        return {
            "schemaVersion": "1.0",
            "feature": "023-registered-doc-architecture-adoption",
            "status": "Complete",
            "sourceManifest": {
                "path": "scripts/config/fleet.json",
                "normalizedSha256": normalized_sha256(self.manifest_path),
            },
            "sourceClaims": {
                "path": "docs/maintenance/claims.json",
                "normalizedSha256": normalized_sha256(self.claims_path),
                "count": 17,
            },
            "preflight": {
                "runId": "11111111-1111-4111-8111-111111111111",
                "gitTargets": 4,
                "collectionTargets": 1,
                "fetchAttemptsCompleted": 4,
                "firstTargetMutation": "AfterFetchBarrier",
                "propagationTargetSetBefore": target_set_hash,
                "propagationTargetSetAfter": target_set_hash,
            },
            "targets": [
                self.target("adopted", "Adopted"),
                self.target("aligned", "AlreadyAligned"),
                self.target("blocked", "Blocked"),
                self.target("preset", "NotApplicable"),
                self.target("collection", "NotApplicable", "collection"),
            ],
        }

    def validate(self, matrix: dict) -> subprocess.CompletedProcess[str]:
        matrix_path = self.repo / "evidence/matrix.json"
        matrix_path.write_text(json.dumps(matrix, indent=2) + "\n", encoding="utf-8")
        return subprocess.run(
            ["python3", str(VALIDATOR), "--repo", str(self.repo), "--matrix", str(matrix_path)],
            check=False,
            capture_output=True,
            text=True,
        )

    def assert_rejected(self, mutate, error_class: str) -> None:
        matrix = copy.deepcopy(self.matrix)
        mutate(matrix)
        result = self.validate(matrix)
        self.assertNotEqual(0, result.returncode)
        self.assertIn(error_class, result.stderr)

    def test_accepts_complete_matrix(self) -> None:
        result = self.validate(self.matrix)
        self.assertEqual(0, result.returncode, result.stderr)

    def test_rejects_missing_target(self) -> None:
        self.assert_rejected(lambda data: data["targets"].pop(), "TARGET_SET")

    def test_rejects_duplicate_target(self) -> None:
        self.assert_rejected(lambda data: data["targets"].append(copy.deepcopy(data["targets"][0])), "TARGET_DUPLICATE")

    def test_rejects_incomplete_claims(self) -> None:
        self.assert_rejected(lambda data: data["targets"][1]["claimAssessments"].pop(), "CLAIM_SET")

    def test_rejects_adopted_without_delivery(self) -> None:
        self.assert_rejected(lambda data: data["targets"][0].update(delivery=None), "DELIVERY_REQUIRED")

    def test_rejects_aligned_with_delivery(self) -> None:
        self.assert_rejected(lambda data: data["targets"][1].update(delivery=copy.deepcopy(data["targets"][0]["delivery"])), "DELIVERY_FORBIDDEN")

    def test_rejects_private_absolute_path(self) -> None:
        self.assert_rejected(lambda data: data["targets"][0].update(repositoryPathClass="/Users/example/private"), "PATH_SAFETY")

    def test_rejects_propagation_drift(self) -> None:
        self.assert_rejected(lambda data: data["preflight"].update(propagationTargetSetAfter="d" * 64), "PROPAGATION_DRIFT")


if __name__ == "__main__":
    unittest.main()
