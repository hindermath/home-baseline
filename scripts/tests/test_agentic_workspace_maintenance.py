#!/usr/bin/env python3
"""Exercise desired-state maintenance against local, disposable Git remotes."""

from __future__ import annotations

import json
import os
from pathlib import Path
import subprocess
import tempfile
import unittest


REPOSITORY = Path(__file__).resolve().parents[2]
ENGINE = REPOSITORY / "scripts" / "lib" / "agentic_workspace_fleet.py"


def git(repository: Path | None, *arguments: str) -> str:
    command = ["git"]
    if repository is not None:
        command.extend(["-C", str(repository)])
    command.extend(arguments)
    return subprocess.check_output(command, text=True).strip()


class FleetFixture:
    def __init__(self, root: Path) -> None:
        self.root = root
        self.home = root / "home"
        self.home.mkdir()
        self.remote = root / "remote.git"
        subprocess.run(["git", "init", "--bare", "-q", str(self.remote)], check=True)
        self.seed = root / "seed"
        subprocess.run(["git", "clone", "-q", str(self.remote), str(self.seed)], check=True)
        git(self.seed, "config", "user.name", "Fixture")
        git(self.seed, "config", "user.email", "fixture@example.invalid")
        git(self.seed, "switch", "-c", "main")
        (self.seed / "README.md").write_text("baseline\n", encoding="utf-8")
        git(self.seed, "add", "README.md")
        git(self.seed, "commit", "-q", "-m", "baseline")
        git(self.seed, "push", "-q", "-u", "origin", "main")
        subprocess.run(
            ["git", "--git-dir", str(self.remote), "symbolic-ref", "HEAD", "refs/heads/main"],
            check=True,
        )

    def manifest(self, remote: str | None = None, path: str = "Fleet/Example") -> Path:
        content = {
            "schemaVersion": "1.0",
            "targets": [
                {
                    "id": "fleet",
                    "kind": "collection",
                    "level": 1,
                    "path": "Fleet",
                    "active": True,
                    "maintenanceClass": "canonical-fleet",
                    "memberDiscovery": "declared-targets",
                },
                {
                    "id": "example",
                    "kind": "git-repository",
                    "level": 2,
                    "path": path,
                    "active": True,
                    "maintenanceClass": "canonical-fleet",
                    "remote": remote or str(self.remote),
                    "forge": "generic-git",
                    "defaultBranch": "main",
                },
            ],
        }
        target = self.root / "manifest.json"
        target.write_text(json.dumps(content), encoding="utf-8")
        return target

    def run(self, mode: str, manifest: Path | None = None) -> tuple[subprocess.CompletedProcess[str], dict]:
        report = self.root / f"report-{mode}.json"
        log = self.root / f"run-{mode}.log"
        completed = subprocess.run(
            [
                "python3",
                str(ENGINE),
                "fleet",
                "--manifest",
                str(manifest or self.manifest()),
                "--home-dir",
                str(self.home),
                "--mode",
                mode,
                "--report",
                str(report),
                "--log",
                str(log),
            ],
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        return completed, json.loads(report.read_text(encoding="utf-8"))


class AgenticWorkspaceMaintenanceTests(unittest.TestCase):
    def test_secure_casetracker_uses_the_declared_workspace_paths_only(self) -> None:
        manifest_path = REPOSITORY / "scripts" / "config" / "agentic-workspace-fleet.json"
        manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
        targets = {
            item["id"]: item["path"]
            for item in manifest["targets"]
            if item["id"].startswith("secure-casetracker")
        }
        self.assertEqual(
            targets,
            {
                "secure-casetracker-baseline": "SecureCaseTrackerProjects",
                "secure-casetracker-csharp": "SecureCaseTrackerProjects/SecureCaseTracker-CSharp",
                "secure-casetracker-go": "SecureCaseTrackerProjects/SecureCaseTracker-Go",
                "secure-casetracker-java": "SecureCaseTrackerProjects/SecureCaseTracker-Java",
                "secure-casetracker-python": "SecureCaseTrackerProjects/SecureCaseTracker-Python",
                "secure-casetracker-rust": "SecureCaseTrackerProjects/SecureCaseTracker-Rust",
                "secure-casetracker-swift": "SecureCaseTrackerProjects/SecureCaseTracker-Swift",
            },
        )
        self.assertFalse(
            any(
                path == "secure-casetracker-baseline"
                or path.startswith("secure-casetracker-baseline/")
                for path in targets.values()
            )
        )

    @unittest.skipIf(os.name == "nt", "This local fixture invokes the installed PowerShell on Unix.")
    def test_powershell_surface_exposes_approved_cmdlet_and_manifest_parameter(self) -> None:
        completed = subprocess.run(
            [
                "pwsh",
                "-NoProfile",
                "-Command",
                ". ./scripts/maintain-agentic-workspace.ps1; "
                "$command = Get-Command Invoke-HBAgenticWorkspaceMaintenance; "
                "if (-not $command.Parameters.ContainsKey('ManifestPath')) { exit 1 }; "
                "if (-not $command.Parameters.ContainsKey('AllowAdminPrompts')) { exit 1 }",
            ],
            cwd=REPOSITORY,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )
        self.assertEqual(completed.returncode, 0, completed.stdout)

    def test_check_only_and_dry_run_do_not_create_missing_targets(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            fixture = FleetFixture(Path(directory))
            for mode, expected_action in (("check-only", "CLONE_REQUIRED"), ("dry-run", "WOULD_CLONE")):
                completed, report = fixture.run(mode)
                self.assertEqual(completed.returncode, 1)
                self.assertFalse((fixture.home / "Fleet" / "Example").exists())
                target = next(item for item in report["targets"] if item["targetId"] == "example")
                self.assertEqual(target["action"], expected_action)

    def test_update_clones_once_and_second_run_is_current(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            fixture = FleetFixture(Path(directory))
            first, first_report = fixture.run("update")
            self.assertEqual(first.returncode, 0, first.stdout)
            self.assertEqual(first_report["overallStatus"], "SUCCESS")
            checkout = fixture.home / "Fleet" / "Example"
            self.assertTrue((checkout / ".git").exists())
            first_head = git(checkout, "rev-parse", "HEAD")

            second, second_report = fixture.run("update")
            self.assertEqual(second.returncode, 0, second.stdout)
            self.assertEqual(git(checkout, "rev-parse", "HEAD"), first_head)
            target = next(item for item in second_report["targets"] if item["targetId"] == "example")
            self.assertEqual(target["status"], "CURRENT")
            self.assertEqual(target["action"], "NONE")

    def test_behind_updates_but_dirty_and_path_conflict_remain_unchanged(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            fixture = FleetFixture(Path(directory))
            fixture.run("update")
            checkout = fixture.home / "Fleet" / "Example"
            (fixture.seed / "README.md").write_text("updated\n", encoding="utf-8")
            git(fixture.seed, "add", "README.md")
            git(fixture.seed, "commit", "-q", "-m", "update")
            git(fixture.seed, "push", "-q")
            updated_head = git(fixture.seed, "rev-parse", "HEAD")
            completed, report = fixture.run("update")
            self.assertEqual(completed.returncode, 0, completed.stdout)
            self.assertEqual(git(checkout, "rev-parse", "HEAD"), updated_head)
            self.assertEqual(
                next(item for item in report["targets"] if item["targetId"] == "example")["action"],
                "PULL",
            )

            local = checkout / "local.txt"
            local.write_text("dirty\n", encoding="utf-8")
            dirty, dirty_report = fixture.run("update")
            self.assertEqual(dirty.returncode, 1)
            self.assertTrue(local.exists())
            self.assertEqual(
                next(item for item in dirty_report["targets"] if item["targetId"] == "example")["status"],
                "DIRTY",
            )

        with tempfile.TemporaryDirectory() as directory:
            fixture = FleetFixture(Path(directory))
            conflict = fixture.home / "Fleet" / "Example"
            conflict.parent.mkdir()
            conflict.write_text("do not remove\n", encoding="utf-8")
            completed, report = fixture.run("update")
            self.assertEqual(completed.returncode, 1)
            self.assertEqual(conflict.read_text(encoding="utf-8"), "do not remove\n")
            self.assertEqual(
                next(item for item in report["targets"] if item["targetId"] == "example")["status"],
                "PATH_CONFLICT",
            )

    def test_unsafe_repository_states_are_classified_without_repair(self) -> None:
        scenarios = ("BRANCH_MISMATCH", "DETACHED", "REMOTE_MISMATCH", "MISSING_UPSTREAM", "AHEAD", "DIVERGED")
        for expected in scenarios:
            with self.subTest(expected=expected), tempfile.TemporaryDirectory() as directory:
                fixture = FleetFixture(Path(directory))
                fixture.run("update")
                checkout = fixture.home / "Fleet" / "Example"
                git(checkout, "config", "user.name", "Fixture")
                git(checkout, "config", "user.email", "fixture@example.invalid")
                if expected == "BRANCH_MISMATCH":
                    git(checkout, "switch", "-c", "feature")
                elif expected == "DETACHED":
                    git(checkout, "checkout", "--detach", "HEAD")
                elif expected == "REMOTE_MISMATCH":
                    git(checkout, "remote", "set-url", "origin", str(fixture.root / "other.git"))
                elif expected == "MISSING_UPSTREAM":
                    git(checkout, "branch", "--unset-upstream")
                elif expected in {"AHEAD", "DIVERGED"}:
                    (checkout / "local.txt").write_text("local\n", encoding="utf-8")
                    git(checkout, "add", "local.txt")
                    git(checkout, "commit", "-q", "-m", "local")
                    if expected == "DIVERGED":
                        (fixture.seed / "remote.txt").write_text("remote\n", encoding="utf-8")
                        git(fixture.seed, "add", "remote.txt")
                        git(fixture.seed, "commit", "-q", "-m", "remote")
                        git(fixture.seed, "push", "-q")
                head_before = git(checkout, "rev-parse", "HEAD")
                completed, report = fixture.run("update")
                self.assertEqual(completed.returncode, 1)
                self.assertEqual(git(checkout, "rev-parse", "HEAD"), head_before)
                target = next(item for item in report["targets"] if item["targetId"] == "example")
                self.assertEqual(target["status"], expected)
                self.assertNotEqual(target["nextAction"], "N/A")

    def test_failed_clone_does_not_hide_independent_collection_or_leave_target(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            fixture = FleetFixture(Path(directory))
            missing_remote = str(fixture.root / "missing.git")
            completed, report = fixture.run("update", fixture.manifest(remote=missing_remote))
            self.assertEqual(completed.returncode, 1)
            self.assertEqual(len(report["targets"]), 2)
            self.assertTrue((fixture.home / "Fleet").is_dir())
            self.assertFalse((fixture.home / "Fleet" / "Example").exists())
            self.assertEqual(report["overallStatus"], "PARTIAL")
            self.assertEqual(report["counts"]["failed"], 1)

    def test_stage_update_preserves_targets_and_changes_terminal_status(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            fixture = FleetFixture(Path(directory))
            _, report = fixture.run("dry-run")
            report_path = fixture.root / "report-dry-run.json"
            target_hash = json.dumps(report["targets"], sort_keys=True)
            completed = subprocess.run(
                [
                    "python3",
                    str(ENGINE),
                    "stage",
                    "--report",
                    str(report_path),
                    "--stage-id",
                    "toolchain",
                    "--status",
                    "Blocked",
                    "--exit-code",
                    "1",
                    "--summary",
                    "fixture",
                    "--next-action",
                    "retry",
                ],
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.STDOUT,
                check=False,
            )
            self.assertEqual(completed.returncode, 0, completed.stdout)
            updated = json.loads(report_path.read_text(encoding="utf-8"))
            self.assertEqual(json.dumps(updated["targets"], sort_keys=True), target_hash)
            self.assertEqual(updated["overallStatus"], "PARTIAL")
            self.assertEqual(updated["exitCode"], 1)

    def test_public_surfaces_share_admin_deferral_and_report_contract(self) -> None:
        bash = (REPOSITORY / "scripts" / "maintain-agentic-workspace.sh").read_text(encoding="utf-8")
        powershell = (REPOSITORY / "scripts" / "maintain-agentic-workspace.ps1").read_text(encoding="utf-8")
        for token in (
            "DEFERRED_ADMIN_REQUIRED",
            "agentic_workspace_fleet.py",
            "agentic-workspace-fleet.json",
            "canonical-repositories",
            "maintenance package drift predicted",
        ):
            self.assertIn(token, bash)
            self.assertIn(token, powershell)

    def test_canonical_repository_listing_ignores_unmanifested_preset_and_inactive_paths(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            fixture = FleetFixture(Path(directory))
            fixture.run("update")
            manifest = json.loads(fixture.manifest().read_text(encoding="utf-8"))
            manifest["targets"].extend(
                [
                    {
                        "id": "preset",
                        "kind": "git-repository",
                        "level": 2,
                        "path": "Fleet/Preset",
                        "active": True,
                        "maintenanceClass": "preset",
                        "remote": str(fixture.root / "preset.git"),
                        "forge": "generic-git",
                        "defaultBranch": "main",
                    },
                    {
                        "id": "inactive",
                        "kind": "git-repository",
                        "level": 2,
                        "path": "Fleet/Inactive",
                        "active": False,
                        "maintenanceClass": "canonical-fleet",
                        "remote": str(fixture.root / "inactive.git"),
                        "forge": "generic-git",
                        "defaultBranch": "main",
                    },
                ]
            )
            manifest_path = fixture.root / "listing-manifest.json"
            manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
            for relative in ("Fleet/Preset", "Fleet/Inactive", "Legacy/Old"):
                repository = fixture.home / relative
                repository.mkdir(parents=True)
                subprocess.run(["git", "init", "-q", str(repository)], check=True)

            completed = subprocess.run(
                [
                    "python3",
                    str(ENGINE),
                    "canonical-repositories",
                    "--manifest",
                    str(manifest_path),
                    "--home-dir",
                    str(fixture.home),
                    "--existing-only",
                ],
                text=True,
                capture_output=True,
                check=False,
            )
            self.assertEqual(completed.returncode, 0, completed.stderr)
            self.assertEqual(
                completed.stdout.strip(),
                f"2\t{(fixture.home / 'Fleet' / 'Example').resolve()}",
            )
            self.assertNotIn("Legacy", completed.stdout)
            self.assertNotIn("Preset", completed.stdout)
            self.assertNotIn("Inactive", completed.stdout)

    def test_propagation_surfaces_ignore_unregistered_legacy_repository(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            root = Path(directory)
            home = root / "home"
            canonical = home / "Fleet" / "Canonical"
            legacy = home / "Legacy" / "Old"
            guidance = (REPOSITORY / "AGENTS.md").read_text(encoding="utf-8")
            for repository in (canonical, legacy):
                repository.mkdir(parents=True)
                subprocess.run(["git", "init", "-q", str(repository)], check=True)
                (repository / "AGENTS.md").write_text(guidance, encoding="utf-8")
            registry = root / "registry.json"
            registry.write_text(
                json.dumps(
                    {
                        "schemaVersion": 1,
                        "repositories": [{"path": "Fleet/Canonical", "level": 2}],
                    }
                ),
                encoding="utf-8",
            )
            manifest = root / "propagation-manifest.json"
            manifest.write_text(
                json.dumps(
                    {
                        "schemaVersion": 1,
                        "files": [{"path": "AGENTS.md", "executable": False}],
                    }
                ),
                encoding="utf-8",
            )

            commands = [
                [
                    "bash",
                    str(REPOSITORY / "scripts" / "propagate-agentic-toolchain-maintenance.sh"),
                    "--home-dir",
                    str(home),
                    "--registry",
                    str(registry),
                    "--manifest",
                    str(manifest),
                    "--check-only",
                ],
                [
                    "pwsh",
                    "-NoProfile",
                    "-File",
                    str(REPOSITORY / "scripts" / "propagate-agentic-toolchain-maintenance.ps1"),
                    "-HomeDir",
                    str(home),
                    "-Registry",
                    str(registry),
                    "-Manifest",
                    str(manifest),
                    "-CheckOnly",
                ],
            ]
            for command in commands:
                with self.subTest(surface=command[0]):
                    completed = subprocess.run(
                        command,
                        text=True,
                        stdout=subprocess.PIPE,
                        stderr=subprocess.STDOUT,
                        check=False,
                    )
                    self.assertEqual(completed.returncode, 0, completed.stdout)
                    self.assertIn(str(canonical), completed.stdout)
                    self.assertNotIn(str(legacy), completed.stdout)

    def test_registry_rejects_preset_or_unknown_propagation_targets(self) -> None:
        with tempfile.TemporaryDirectory() as directory:
            fixture = FleetFixture(Path(directory))
            manifest = fixture.manifest()
            registry = fixture.root / "registry.json"
            registry.write_text(
                json.dumps({"repositories": [{"path": "Fleet/Example"}]}),
                encoding="utf-8",
            )
            command = [
                "python3", str(ENGINE), "registry",
                "--manifest", str(manifest), "--registry", str(registry),
            ]
            valid = subprocess.run(command, text=True, capture_output=True, check=False)
            self.assertEqual(valid.returncode, 0, valid.stdout)
            registry.write_text(
                json.dumps({"repositories": [{"path": "Fleet/Unexpected"}]}),
                encoding="utf-8",
            )
            invalid = subprocess.run(command, text=True, capture_output=True, check=False)
            self.assertEqual(invalid.returncode, 2, invalid.stdout)
            self.assertIn("non-canonical propagation target", invalid.stdout)


if __name__ == "__main__":
    unittest.main()
