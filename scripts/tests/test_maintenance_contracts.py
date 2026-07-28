#!/usr/bin/env python3
"""Validate maintenance registries and supported preset-profile contracts."""

from __future__ import annotations

import json
import importlib.util
import os
from pathlib import Path
import shlex
import shutil
import subprocess
import tempfile
import unittest


REPOSITORY = Path(__file__).resolve().parents[2]
CONFIG = REPOSITORY / "scripts" / "config"
FLEET_ENGINE = REPOSITORY / "scripts" / "lib" / "agentic_workspace_fleet.py"


def read_json(path: Path) -> dict:
    return json.loads(path.read_text(encoding="utf-8"))


def run_git(repository: Path, *arguments: str) -> None:
    subprocess.run(
        ["git", *arguments],
        cwd=repository,
        check=True,
        stdout=subprocess.DEVNULL,
    )


def preset_helper_source() -> str:
    source = (REPOSITORY / "scripts" / "maintain-agentic-workspace.sh").read_text(
        encoding="utf-8"
    )
    cleanup_start = source.index("cleanup_preset_validation_target() {")
    cleanup_end = source.index("\nwhile [ $# -gt 0 ]; do", cleanup_start)
    start = source.index("resolve_default_remote_ref() {")
    end = source.index("\nhandle_preset_profiles() {", start)
    return source[cleanup_start:cleanup_end] + "\n" + source[start:end]


class MaintenanceContractTests(unittest.TestCase):
    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is required.")
    def test_powershell_rename_accepts_repository_root_filename(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            repository = Path(directory)
            run_git(repository, "init", "-q")
            run_git(repository, "config", "user.name", "Fixture")
            run_git(repository, "config", "user.email", "fixture@example.invalid")
            source = repository / "Lastenheft_Foo.md"
            source.write_text("# Fixture\n", encoding="utf-8")
            run_git(repository, "add", source.name)
            run_git(repository, "commit", "-q", "-m", "fixture")

            completed = subprocess.run(
                [
                    "pwsh",
                    "-NoProfile",
                    "-File",
                    str(REPOSITORY / "scripts" / "rename-lastenheft.ps1"),
                    "-File",
                    source.name,
                    "-BranchName",
                    "015-fixture",
                ],
                cwd=repository,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                check=False,
            )

            target = repository / "Lastenheft_Foo.015-fixture.md"
            self.assertEqual(completed.returncode, 0, completed.stdout)
            self.assertFalse(source.exists())
            self.assertTrue(target.is_file())
            subject = subprocess.check_output(
                ["git", "log", "-1", "--format=%s"],
                cwd=repository,
                text=True,
            ).strip()
            self.assertEqual(
                subject,
                "chore: rename Lastenheft to Lastenheft_Foo.015-fixture.md",
            )

    def test_fleet_manifest_has_exact_declared_cardinalities(self) -> None:
        specification = importlib.util.spec_from_file_location("fleet_engine", FLEET_ENGINE)
        self.assertIsNotNone(specification)
        module = importlib.util.module_from_spec(specification)
        specification.loader.exec_module(module)
        manifest = module.load_manifest(CONFIG / "agentic-workspace-fleet.json")
        targets = manifest["targets"]
        self.assertEqual(len(targets), 44)
        self.assertEqual(sum(item["kind"] == "git-repository" for item in targets), 43)
        self.assertEqual(sum(item["kind"] == "collection" for item in targets), 1)
        self.assertEqual(
            sum(item["maintenanceClass"] == "canonical-fleet" for item in targets),
            32,
        )
        self.assertEqual(
            sum(
                item["kind"] == "git-repository"
                and item["maintenanceClass"] == "preset"
                for item in targets
            ),
            11,
        )

    def test_fleet_manifest_rejects_unsafe_semantics(self) -> None:
        specification = importlib.util.spec_from_file_location("fleet_engine_invalid", FLEET_ENGINE)
        module = importlib.util.module_from_spec(specification)
        specification.loader.exec_module(module)
        base = {
            "schemaVersion": "1.0",
            "targets": [
                {
                    "id": "root",
                    "kind": "git-repository",
                    "level": 1,
                    "path": "Root",
                    "active": True,
                    "maintenanceClass": "canonical-fleet",
                    "remote": "https://example.invalid/root.git",
                    "forge": "generic-git",
                    "defaultBranch": "main",
                }
            ],
        }
        invalid_variants = []
        traversal = json.loads(json.dumps(base))
        traversal["targets"][0]["path"] = "../Root"
        invalid_variants.append(traversal)
        duplicate = json.loads(json.dumps(base))
        duplicate["targets"].append(dict(duplicate["targets"][0]))
        invalid_variants.append(duplicate)
        invalid_collection = json.loads(json.dumps(base))
        invalid_collection["targets"][0].update(
            {"kind": "collection", "memberDiscovery": "declared-targets"}
        )
        invalid_variants.append(invalid_collection)
        orphan = json.loads(json.dumps(base))
        orphan["targets"][0].update({"level": 2, "path": "Missing/Child"})
        invalid_variants.append(orphan)

        for index, content in enumerate(invalid_variants):
            with self.subTest(index=index), tempfile.TemporaryDirectory() as directory:
                path = Path(directory) / "manifest.json"
                path.write_text(json.dumps(content), encoding="utf-8")
                with self.assertRaises(module.ContractError):
                    module.load_manifest(path)

    def test_preset_profile_catalog_resolves_exact_matrices(self) -> None:
        catalog = read_json(CONFIG / "spec-kit-preset-profiles.json")
        expected = {
            "standard-eight-governance-presets": 8,
            "intake-review-nine-governance-presets": 9,
            "intake-authoring-ten-governance-presets": 10,
            "intake-sequencing-eleven-governance-presets": 11,
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

    @unittest.skipIf(os.name == "nt", "The Bash registration test runs on macOS and Linux.")
    def test_registration_preserves_explicit_cc65_non_msl_contract(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            home = Path(directory)
            repository = home / "C64Projects" / "cc65"
            repository.mkdir(parents=True)
            subprocess.run(["git", "init", "-q"], cwd=repository, check=True)
            registry = home / ".home-baseline" / "registry.json"
            environment = os.environ.copy()
            environment["HOME"] = str(home)
            subprocess.run(
                [
                    "bash",
                    str(REPOSITORY / "scripts" / "register-level2-repository.sh"),
                    "--repo",
                    str(repository),
                    "--level",
                    "2",
                    "--registry",
                    str(registry),
                    "--primary-language",
                    "cc65",
                    "--msl-status",
                    "non-msl",
                    "--gsdb-required",
                    "true",
                    "--preset-profile",
                    "intake-authoring-ten-governance-presets",
                ],
                env=environment,
                text=True,
                check=True,
            )
            entry = read_json(registry)["repositories"][0]
            self.assertEqual(entry["primaryLanguage"], "cc65")
            self.assertEqual(entry["mslStatus"], "non-msl")
            self.assertIs(entry["gsdbRequired"], True)
            self.assertEqual(
                entry["presetProfile"],
                "intake-authoring-ten-governance-presets",
            )

    @unittest.skipIf(os.name == "nt", "The isolated worktree test uses Bash.")
    def test_preset_check_uses_initialized_origin_default_without_touching_feature_branch(
        self,
    ) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            remote = root / "remote.git"
            repository = root / "cc65"
            home = root / "home"
            home.mkdir()
            subprocess.run(["git", "init", "--bare", "-q", str(remote)], check=True)
            subprocess.run(
                ["git", "clone", "-q", str(remote), str(repository)],
                check=True,
            )
            run_git(repository, "config", "user.name", "Fixture")
            run_git(repository, "config", "user.email", "fixture@example.invalid")
            run_git(repository, "switch", "-c", "master")
            (repository / "README.md").write_text("baseline\n", encoding="utf-8")
            run_git(repository, "add", "README.md")
            run_git(repository, "commit", "-q", "-m", "baseline")
            baseline = subprocess.check_output(
                ["git", "rev-parse", "HEAD"], cwd=repository, text=True
            ).strip()
            run_git(repository, "push", "-q", "-u", "origin", "master")
            run_git(repository, "switch", "-c", "feature-old", baseline)
            run_git(repository, "switch", "master")
            registry = repository / ".specify" / "presets" / ".registry"
            registry.parent.mkdir(parents=True)
            registry.write_text('{"presets": {}}\n', encoding="utf-8")
            run_git(repository, "add", ".specify")
            run_git(repository, "commit", "-q", "-m", "initialize spec kit")
            run_git(repository, "push", "-q", "origin", "master")
            run_git(repository, "remote", "set-head", "origin", "master")
            run_git(repository, "switch", "feature-old")
            (repository / "local.dbg").write_text("local\n", encoding="utf-8")

            status_before = subprocess.check_output(
                ["git", "status", "--porcelain=v1", "-uall"],
                cwd=repository,
                text=True,
            )
            worktrees_before = subprocess.check_output(
                ["git", "worktree", "list", "--porcelain"],
                cwd=repository,
                text=True,
            )
            harness = f"""set -euo pipefail
SOURCE_ROOT=/not-the-fixture
HOME_DIR={shlex.quote(str(home))}
PRESET_WORKTREE_REPO=''
PRESET_WORKTREE_PATH=''
PRESET_WORKTREE_ROOT=''
PRESET_VALIDATION_TARGET=''
PRESET_VALIDATION_ISOLATED=0
warn() {{ :; }}
info() {{ :; }}
{preset_helper_source()}
prepare_preset_validation_target {shlex.quote(str(repository))}
[ "$PRESET_VALIDATION_ISOLATED" -eq 1 ]
[ -f "$PRESET_VALIDATION_TARGET/.specify/presets/.registry" ]
cleanup_preset_validation_target
"""
            subprocess.run(["bash", "-c", harness], check=True)

            self.assertEqual(
                subprocess.check_output(
                    ["git", "status", "--porcelain=v1", "-uall"],
                    cwd=repository,
                    text=True,
                ),
                status_before,
            )
            self.assertEqual(
                subprocess.check_output(
                    ["git", "worktree", "list", "--porcelain"],
                    cwd=repository,
                    text=True,
                ),
                worktrees_before,
            )

    @unittest.skipIf(os.name == "nt", "The isolated worktree test uses Bash.")
    def test_preset_check_rejects_uninitialized_origin_default(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            repository = root / "repository"
            home = root / "home"
            home.mkdir()
            repository.mkdir()
            run_git(repository, "init", "-q", "-b", "master")
            run_git(repository, "config", "user.name", "Fixture")
            run_git(repository, "config", "user.email", "fixture@example.invalid")
            (repository / "README.md").write_text("baseline\n", encoding="utf-8")
            run_git(repository, "add", "README.md")
            run_git(repository, "commit", "-q", "-m", "baseline")
            run_git(repository, "remote", "add", "origin", str(root / "unused.git"))
            run_git(
                repository,
                "update-ref",
                "refs/remotes/origin/master",
                "HEAD",
            )
            run_git(
                repository,
                "symbolic-ref",
                "refs/remotes/origin/HEAD",
                "refs/remotes/origin/master",
            )

            harness = f"""set -euo pipefail
SOURCE_ROOT=/not-the-fixture
HOME_DIR={shlex.quote(str(home))}
PRESET_WORKTREE_REPO=''
PRESET_WORKTREE_PATH=''
PRESET_WORKTREE_ROOT=''
PRESET_VALIDATION_TARGET=''
PRESET_VALIDATION_ISOLATED=0
warn() {{ :; }}
info() {{ :; }}
{preset_helper_source()}
prepare_preset_validation_target {shlex.quote(str(repository))}
"""
            completed = subprocess.run(["bash", "-c", harness], check=False)
            self.assertNotEqual(completed.returncode, 0)

    @unittest.skipIf(os.name == "nt", "The isolated worktree test uses Bash.")
    def test_preset_check_rejects_ambiguous_default_refs(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            repository = root / "repository"
            home = root / "home"
            home.mkdir()
            repository.mkdir()
            run_git(repository, "init", "-q", "-b", "feature")
            run_git(repository, "config", "user.name", "Fixture")
            run_git(repository, "config", "user.email", "fixture@example.invalid")
            (repository / "README.md").write_text("baseline\n", encoding="utf-8")
            run_git(repository, "add", "README.md")
            run_git(repository, "commit", "-q", "-m", "baseline")
            for name in ("main", "master"):
                run_git(
                    repository,
                    "update-ref",
                    f"refs/remotes/origin/{name}",
                    "HEAD",
                )

            harness = f"""set -euo pipefail
SOURCE_ROOT=/not-the-fixture
HOME_DIR={shlex.quote(str(home))}
PRESET_WORKTREE_REPO=''
PRESET_WORKTREE_PATH=''
PRESET_WORKTREE_ROOT=''
PRESET_VALIDATION_TARGET=''
PRESET_VALIDATION_ISOLATED=0
warn() {{ :; }}
info() {{ :; }}
{preset_helper_source()}
prepare_preset_validation_target {shlex.quote(str(repository))}
"""
            completed = subprocess.run(["bash", "-c", harness], check=False)
            self.assertNotEqual(completed.returncode, 0)


if __name__ == "__main__":
    unittest.main()
