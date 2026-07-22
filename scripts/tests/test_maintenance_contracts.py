#!/usr/bin/env python3
"""Validate maintenance registries and supported preset-profile contracts."""

from __future__ import annotations

import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


REPOSITORY = Path(__file__).resolve().parents[2]
CONFIG = REPOSITORY / "scripts" / "config"


def read_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


class MaintenanceContractTests(unittest.TestCase):
    def test_preset_profile_catalog_resolves_exact_matrices(self) -> None:
        catalog = read_json(CONFIG / "spec-kit-preset-profiles.json")
        expected = {
            "standard-eight-governance-presets": 8,
            "intake-review-nine-governance-presets": 9,
            "intake-authoring-ten-governance-presets": 10,
        }
        self.assertEqual(catalog["defaultProfile"], "standard-eight-governance-presets")
        self.assertIsNone(catalog["profiles"]["none"]["presetConfig"])
        for profile, count in expected.items():
            relative = catalog["profiles"][profile]["presetConfig"]
            matrix = read_json(REPOSITORY / relative)
            self.assertEqual(len(matrix["presets"]), count, profile)

        example = read_json(CONFIG / "level2-repository-registry.example.json")
        supported = set(catalog["profiles"])
        self.assertIn(example["defaultPresetProfile"], supported)
        for entry in example["repositories"]:
            self.assertIn(entry["presetProfile"], supported)

    def test_brew_registry_classifies_local_formulae_and_formula_powershell(self) -> None:
        registry = read_json(CONFIG / "brew-apps-registry.json")
        formulae = {item["name"]: item for item in registry["formulae"]}
        for name in (
            "mongodb/brew/mongodb-community@8.0",
            "mono",
            "sqlite",
            "telnet",
        ):
            self.assertEqual(formulae[name]["scope"], "optional", name)
        self.assertNotIn("mongodb/brew/mongodb-community", formulae)
        self.assertEqual(formulae["powershell"]["scope"], "required")
        self.assertIs(formulae["powershell"]["ensureLinked"], True)
        self.assertEqual(formulae["powershell"]["linkCommands"], ["pwsh"])
        self.assertNotIn("powershell", {item["name"] for item in registry["casks"]})

    @unittest.skipIf(os.name == "nt", "The Bash registration test runs on macOS and Linux.")
    def test_registration_rejects_unknown_preset_profile(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            home = Path(directory)
            repository = home / "ExampleProjects" / "ExampleService"
            repository.mkdir(parents=True)
            subprocess.run(["git", "init", "-q"], cwd=repository, check=True)
            registry = home / ".home-baseline" / "registry.json"
            environment = os.environ.copy()
            environment["HOME"] = str(home)
            completed = subprocess.run(
                [
                    "bash",
                    str(REPOSITORY / "scripts" / "register-level2-repository.sh"),
                    "--repo",
                    str(repository),
                    "--level",
                    "2",
                    "--registry",
                    str(registry),
                    "--preset-profile",
                    "unsupported-profile",
                    "--dry-run",
                ],
                env=environment,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                check=False,
            )
            self.assertNotEqual(completed.returncode, 0, completed.stdout)
            self.assertIn("unknown preset profile", completed.stdout)


if __name__ == "__main__":
    unittest.main()
