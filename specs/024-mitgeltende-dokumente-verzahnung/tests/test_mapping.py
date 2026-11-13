#!/usr/bin/env python3
import copy
import importlib.util
import json
import os
import shutil
import tempfile
import unittest
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]


def load_validator():
    spec = importlib.util.spec_from_file_location(
        "feature_024_mapping_validator",
        ROOT / "specs/024-mitgeltende-dokumente-verzahnung/tools/validate_mapping.py",
    )
    if spec is None or spec.loader is None:
        raise RuntimeError("Feature-024 validator module could not be loaded.")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

V = load_validator()


class MappingTests(unittest.TestCase):
    def setUp(self):
        self.good = V.build(ROOT)

    def test_positive(self):
        self.assertEqual([], V.validate(ROOT, self.good))

    def test_missing_document(self):
        bad = copy.deepcopy(self.good)
        bad["rows"].pop()
        self.assertTrue(any(e.startswith("MDV-005") for e in V.validate(ROOT, bad)))

    def test_incomplete_evidence(self):
        bad = copy.deepcopy(self.good)
        bad["rows"][0]["owner"] = ""
        self.assertTrue(any(e.startswith("MDV-006") for e in V.validate(ROOT, bad)))

    def test_missing_kind(self):
        bad = copy.deepcopy(self.good)
        del bad["rows"][0]["kind"]
        self.assertTrue(any(e.startswith("MDV-006") for e in V.validate(ROOT, bad)))

    def test_profile_drift(self):
        bad = copy.deepcopy(self.good)
        bad["profiles"]["managedOptional"].pop()
        self.assertTrue(any(e.startswith("MDV-004") for e in V.validate(ROOT, bad)))

    def test_invalid_axis(self):
        bad = copy.deepcopy(self.good)
        bad["rows"][0]["applicability"] = "Ready"
        self.assertTrue(any(e.startswith("MDV-007") for e in V.validate(ROOT, bad)))

    def test_noncanonical_mapping_path(self):
        for path in ("../outside.md", "/tmp/outside.md"):
            with self.subTest(path=path):
                bad = copy.deepcopy(self.good)
                bad["mapping"]["path"] = path
                errors = V.validate(ROOT, bad)
                self.assertIn("MDV-009 canonical mapping path", errors)

    def test_manifest_symlink_outside_repository_is_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repo = base / "repo"
            secure = repo / "docs/secure-development"
            secure.mkdir(parents=True)
            outside = base / "outside-manifest.json"
            shutil.copy2(ROOT / V.MANIFEST_PATH, outside)
            (secure / "baseline-manifest.json").symlink_to(outside)
            mapping = repo / V.MAPPING_PATH
            mapping.parent.mkdir(parents=True)
            shutil.copy2(ROOT / V.MAPPING_PATH, mapping)
            with self.assertRaises(V.MappingSecurityError):
                V.build(repo)

    def test_mapping_symlink_outside_repository_is_rejected(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repo = base / "repo"
            manifest = repo / V.MANIFEST_PATH
            manifest.parent.mkdir(parents=True)
            shutil.copy2(ROOT / V.MANIFEST_PATH, manifest)
            outside = base / "outside-mapping.md"
            shutil.copy2(ROOT / V.MAPPING_PATH, outside)
            mapping = repo / V.MAPPING_PATH
            mapping.parent.mkdir(parents=True)
            mapping.symlink_to(outside)
            with self.assertRaises(V.MappingSecurityError):
                V.build(repo)

    def test_review_write_replaces_leaf_symlink_without_following_it(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repo = base / "repo"
            review = repo / V.REVIEW_PATH
            review.parent.mkdir(parents=True)
            outside = base / "outside.json"
            outside.write_text("owner data\n", encoding="utf-8")
            review.symlink_to(outside)
            payload = {"schemaVersion": "test"}

            V.write_review(repo, payload)

            self.assertEqual(outside.read_text(encoding="utf-8"), "owner data\n")
            self.assertFalse(review.is_symlink())
            self.assertEqual(json.loads(review.read_text(encoding="utf-8")), payload)

    def test_review_write_preserves_existing_regular_file_mode(self):
        if os.name == "nt":
            self.skipTest("POSIX file modes are not portable to Windows")
        with tempfile.TemporaryDirectory() as tmp:
            repo = Path(tmp) / "repo"
            review = repo / V.REVIEW_PATH
            review.parent.mkdir(parents=True)
            review.write_text("{}\n", encoding="utf-8")
            review.chmod(0o640)

            V.write_review(repo, {"schemaVersion": "test"})

            self.assertEqual(review.stat().st_mode & 0o777, 0o640)


if __name__ == "__main__":
    unittest.main()
