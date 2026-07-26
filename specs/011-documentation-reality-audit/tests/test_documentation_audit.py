import copy
import importlib.util
import json
import pathlib
import tempfile
import unittest


FEATURE_ROOT = pathlib.Path(__file__).resolve().parents[1]
VALIDATOR_PATH = FEATURE_ROOT / "tools" / "validate_documentation_audit.py"


def load_validator():
    spec = importlib.util.spec_from_file_location("documentation_audit", VALIDATOR_PATH)
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module


def valid_fixture():
    snapshot = {
        "schemaVersion": "1.0",
        "level0Commit": "a" * 40,
        "fleetManifestSha256": "b" * 64,
        "repositories": [
            {"targetId": "level0", "level": 0},
            {"targetId": "sample", "level": 2},
        ],
    }
    audit = {
        "schemaVersion": "1.0",
        "status": "Ready",
        "areas": [
            {
                "areaId": "level0:guidance",
                "targetId": "level0",
                "decision": "CurrentAndSupported",
                "claim": "Guidance matches the assessed commit.",
                "evidence": ["README.md@" + "a" * 40],
                "rationale": "Exact current evidence exists.",
                "paths": ["README.md"],
                "residualRisk": "Low",
                "reevaluationTrigger": "README or guidance changes.",
            },
            {
                "areaId": "sample:guidance",
                "targetId": "sample",
                "decision": "NotApplicable",
                "claim": "",
                "evidence": [],
                "rationale": "The fixture has no learner guidance.",
                "paths": [],
                "residualRisk": "Low",
                "reevaluationTrigger": "Guidance is added.",
            },
        ],
        "findings": [],
    }
    return snapshot, audit


class DocumentationAuditContractTests(unittest.TestCase):
    @classmethod
    def setUpClass(cls):
        cls.validator = load_validator()

    def assert_invalid(self, mutator, expected_class):
        snapshot, audit = valid_fixture()
        mutator(snapshot, audit)
        errors = self.validator.validate(snapshot, audit)
        self.assertTrue(
            any(error.startswith(expected_class + ":") for error in errors),
            errors,
        )

    def test_minimal_positive_fixture(self):
        snapshot, audit = valid_fixture()
        self.assertEqual([], self.validator.validate(snapshot, audit))

    def test_missing_target_is_rejected(self):
        self.assert_invalid(
            lambda snapshot, audit: audit["areas"].pop(),
            "TARGET_COVERAGE",
        )

    def test_duplicate_target_area_is_rejected(self):
        self.assert_invalid(
            lambda snapshot, audit: audit["areas"].append(
                copy.deepcopy(audit["areas"][0])
            ),
            "AREA_IDENTITY",
        )

    def test_invalid_decision_is_rejected(self):
        self.assert_invalid(
            lambda snapshot, audit: audit["areas"][0].update(decision="Pass"),
            "DECISION",
        )

    def test_supported_claim_without_evidence_is_rejected(self):
        self.assert_invalid(
            lambda snapshot, audit: audit["areas"][0].update(evidence=[]),
            "CLAIM_EVIDENCE",
        )

    def test_incomplete_finding_is_rejected(self):
        def mutate(snapshot, audit):
            audit["areas"][0]["decision"] = "UpdateRequired"
            audit["findings"].append(
                {"findingId": "DOC001", "areaId": "level0:guidance"}
            )

        self.assert_invalid(mutate, "FINDING_COMPLETENESS")

    def test_duplicate_finding_is_rejected(self):
        def mutate(snapshot, audit):
            audit["areas"][0]["decision"] = "UpdateRequired"
            finding = {
                "findingId": "DOC001",
                "areaId": "level0:guidance",
                "severity": "Medium",
                "summary": "Current evidence contradicts the statement.",
                "evidence": ["README.md@" + "a" * 40],
                "ownerLevel": "Level0",
                "owner": "Home Baseline",
                "residualRisk": "Low",
                "correctionBoundary": "Documentation only",
                "reevaluationTrigger": "README changes.",
                "handoff": "D2",
            }
            audit["findings"] = [finding, copy.deepcopy(finding)]

        self.assert_invalid(mutate, "FINDING_IDENTITY")

    def test_missing_handoff_is_rejected(self):
        def mutate(snapshot, audit):
            audit["areas"][0]["decision"] = "UpdateRequired"
            audit["findings"].append(
                {
                    "findingId": "DOC001",
                    "areaId": "level0:guidance",
                    "severity": "Medium",
                    "summary": "Current evidence contradicts the statement.",
                    "evidence": ["README.md@" + "a" * 40],
                    "ownerLevel": "Level0",
                    "owner": "Home Baseline",
                    "residualRisk": "Low",
                    "correctionBoundary": "Documentation only",
                    "reevaluationTrigger": "README changes.",
                    "handoff": "",
                }
            )

        self.assert_invalid(mutate, "FINDING_COMPLETENESS")

    def test_private_absolute_path_is_rejected(self):
        self.assert_invalid(
            lambda snapshot, audit: audit["areas"][0]["paths"].append(
                "/Users/example/private.md"
            ),
            "PRIVACY",
        )


if __name__ == "__main__":
    unittest.main()
