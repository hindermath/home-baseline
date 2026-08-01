#!/usr/bin/env python3
"""Contract tests for the Feature-021 documentation migration validator."""

from __future__ import annotations

import copy
import hashlib
import json
import subprocess
import sys
import tempfile
import unittest
from pathlib import Path


FEATURE = Path(__file__).resolve().parents[1]
VALIDATOR = FEATURE / "tools" / "validate_documentation_migration.py"


class MigrationValidatorTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temp = tempfile.TemporaryDirectory()
        self.repo = Path(self.temp.name)
        (self.repo / "docs").mkdir()
        (self.repo / "README.md").write_text(
            "# Einstieg\n\n[English](README.en.md)\n\n## Start\nText.\n",
            encoding="utf-8",
        )
        (self.repo / "README.en.md").write_text(
            "# Start\n\n[Deutsch](README.md)\n", encoding="utf-8"
        )
        (self.repo / "docs" / "start.md").write_text(
            "# Start\n\n[Portal](../README.md)\n", encoding="utf-8"
        )
        self._git("init", "-q")
        self._git("config", "user.name", "Fixture")
        self._git("config", "user.email", "fixture@example.invalid")
        self._git("add", ".")
        self._git("commit", "-qm", "fixture")
        self.commit = self._git("rev-parse", "HEAD").strip()
        source = self._git("show", f"{self.commit}:README.md").encode()
        self.payload = {
            "schemaVersion": "1.0",
            "findingId": "DIA001",
            "source": {
                "path": "README.md",
                "commit": self.commit,
                "normalizedSha256": hashlib.sha256(source).hexdigest(),
                "lineCount": 6,
            },
            "d6FindingCount": 0,
            "d7FindingCount": 0,
            "requiredSectionIds": ["root", "start"],
            "sections": [
                self._section("root", "# Einstieg", 1, 1, "Retained", "README.md", "einstieg", "README.en.md"),
                self._section("start", "## Start", 5, 6, "Moved", "docs/start.md", "start", "docs/start.md"),
            ],
            "readerPaths": [
                self._reader("Learner"),
                self._reader("DailyUser"),
                self._reader("MaintainerAgent"),
                self._reader("AuditTroubleshooting"),
            ],
        }

    def tearDown(self) -> None:
        self.temp.cleanup()

    def _git(self, *args: str) -> str:
        return subprocess.check_output(
            ["git", *args], cwd=self.repo, text=True
        )

    @staticmethod
    def _section(
        section_id: str,
        heading: str,
        start: int,
        end: int,
        decision: str,
        target: str,
        anchor: str,
        partner: str,
    ) -> dict[str, object]:
        return {
            "sectionId": section_id,
            "sourceHeading": heading,
            "sourceStartLine": start,
            "sourceEndLine": end,
            "decision": decision,
            "targetPath": target,
            "targetAnchor": anchor,
            "languagePartner": partner,
            "linkEvidence": "Validated",
            "rationale": "The active content remains reachable.",
            "findingId": "DIA001",
        }

    @staticmethod
    def _reader(reader_id: str) -> dict[str, object]:
        return {
            "readerPathId": reader_id,
            "entryPoints": ["README.md", "README.en.md"],
            "prerequisites": ["Text-capable browser"],
            "orderedSteps": ["Open the portal", "Select the task"],
            "deepReferences": ["docs/start.md"],
            "safeNextAction": "Read the task page before changing files.",
            "languagePartners": ["README.md", "README.en.md"],
        }

    def _run(self, payload: dict[str, object], line_ending: str = "\n", bom: bool = False) -> subprocess.CompletedProcess[str]:
        path = self.repo / "migration.json"
        rendered = json.dumps(payload, indent=2, ensure_ascii=False).replace("\n", line_ending) + line_ending
        path.write_bytes((b"\xef\xbb\xbf" if bom else b"") + rendered.encode("utf-8"))
        return subprocess.run(
            [sys.executable, str(VALIDATOR), "--repo", str(self.repo), "--migration", str(path)],
            text=True,
            capture_output=True,
            check=False,
        )

    def assert_failure(self, mutate, expected: str) -> None:
        payload = copy.deepcopy(self.payload)
        mutate(payload)
        result = self._run(payload)
        self.assertNotEqual(result.returncode, 0)
        self.assertIn(expected, result.stderr)

    def test_positive_reference(self) -> None:
        result = self._run(self.payload)
        self.assertEqual(result.returncode, 0, result.stderr)
        self.assertIn("PASS", result.stdout)

    def test_missing_section(self) -> None:
        self.assert_failure(lambda p: p["sections"].pop(), "SECTION_SET")

    def test_duplicate_section(self) -> None:
        self.assert_failure(lambda p: p["sections"].append(copy.deepcopy(p["sections"][0])), "SECTION_DUPLICATE")

    def test_invalid_decision(self) -> None:
        self.assert_failure(lambda p: p["sections"][0].update(decision="Copied"), "DECISION")

    def test_missing_target(self) -> None:
        self.assert_failure(lambda p: p["sections"][0].update(targetPath="docs/missing.md"), "TARGET")

    def test_broken_link(self) -> None:
        (self.repo / "docs" / "start.md").write_text("# Start\n\n[Missing](missing.md)\n", encoding="utf-8")
        self.assert_failure(lambda p: None, "LINK")

    def test_missing_language_partner(self) -> None:
        self.assert_failure(lambda p: p["sections"][0].update(languagePartner="README.fr.md"), "LANGUAGE_PARTNER")

    def test_incomplete_reader_path(self) -> None:
        self.assert_failure(lambda p: p["readerPaths"][0].update(safeNextAction=""), "READER_PATH")

    def test_private_absolute_path(self) -> None:
        private_paths = (
            f"{Path.home()}/private",
            "/Users/example/private",
            "/home/example/private",
            r"C:\Users\Example\private",
        )
        for private_path in private_paths:
            with self.subTest(private_path=private_path):
                self.assert_failure(
                    lambda p, value=private_path: p["sections"][0].update(rationale=f"See {value}"),
                    "PRIVATE_PATH",
                )

    def test_d6_or_d7_regression(self) -> None:
        self.assert_failure(lambda p: p.update(d6FindingCount=1), "SUCCESSOR_SCOPE")

    def test_stale_source_hash(self) -> None:
        self.assert_failure(lambda p: p["source"].update(normalizedSha256="0" * 64), "SOURCE_HASH")

    def test_line_endings_and_bom(self) -> None:
        for ending, bom in (("\n", False), ("\r\n", False), ("\n", True)):
            with self.subTest(ending=repr(ending), bom=bom):
                result = self._run(self.payload, ending, bom)
                self.assertEqual(result.returncode, 0, result.stderr)


if __name__ == "__main__":
    unittest.main()
