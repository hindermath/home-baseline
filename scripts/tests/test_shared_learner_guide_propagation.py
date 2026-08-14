#!/usr/bin/env python3
"""Contract tests for the guide-only learning-series propagation scope."""

from __future__ import annotations

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


REPO = Path(__file__).resolve().parents[2]
SCRIPT = REPO / "scripts" / "propagate-learning-series.sh"
POWERSHELL_WRAPPER = REPO / "scripts" / "propagate-learning-series.ps1"
GUIDES = (
    "START-HERE-FUER-LERNENDE.md",
    "GIT-START-FUER-LERNENDE.md",
    "INSTITUTIONELLES-GIT-HOSTING.md",
)


def run_git(repo: Path, *args: str) -> None:
    subprocess.run(["git", "-C", str(repo), *args], check=True, capture_output=True)


class SharedGuidePropagationTests(unittest.TestCase):
    def test_public_surfaces_expose_focused_mode(self) -> None:
        help_result = subprocess.run(
            ["bash", str(SCRIPT), "--help"],
            check=True,
            capture_output=True,
            text=True,
        )
        self.assertIn("--shared-guides-only", help_result.stdout)
        self.assertIn("SharedGuidesOnly", POWERSHELL_WRAPPER.read_text(encoding="utf-8"))

    def test_dry_run_lists_only_six_guide_targets_per_repository(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            level0 = root / "level0"
            units = level0 / "docs" / "learning-units"
            scripts = level0 / "scripts"
            scripts.mkdir(parents=True)
            units.mkdir(parents=True)
            shutil.copy2(SCRIPT, scripts / SCRIPT.name)

            for guide in GUIDES:
                (units / guide).write_text(f"canonical {guide}\n", encoding="utf-8")
            (units / "Lastenheft_Secure-CaseTracker-Test.md").write_text(
                "must remain outside focused scope\n", encoding="utf-8"
            )
            (units / "templates").mkdir()
            (units / "templates" / "example.md").write_text(
                "must remain outside focused scope\n", encoding="utf-8"
            )

            run_git(level0, "init", "-b", "main")
            run_git(level0, "config", "user.name", "Contract Test")
            run_git(level0, "config", "user.email", "contract@example.invalid")
            run_git(level0, "add", ".")
            run_git(level0, "commit", "-m", "test fixture")

            home = root / "home"
            targets = (
                (home / "SecureCaseTrackerProjects", 1, "secure-casetracker-baseline"),
                (home / "SecureCaseTracker-CSharp", 2, "securecasetracker-csharp"),
            )
            registry_entries = []
            for target, level, slug in targets:
                target.mkdir(parents=True)
                (target / "README.md").write_text("# Preserve me\n", encoding="utf-8")
                (target / "Lastenheft_Secure-CaseTracker-Test.md").write_text(
                    "preserve target intake\n", encoding="utf-8"
                )
                run_git(target, "init", "-b", "main")
                run_git(target, "config", "user.name", "Contract Test")
                run_git(target, "config", "user.email", "contract@example.invalid")
                run_git(target, "add", ".")
                run_git(target, "commit", "-m", "target fixture")
                run_git(
                    target,
                    "remote",
                    "add",
                    "origin",
                    f"https://github.com/hindermath/{slug}.git",
                )
                run_git(target, "config", "branch.main.remote", "origin")
                run_git(target, "config", "branch.main.merge", "refs/heads/main")
                head = subprocess.run(
                    ["git", "-C", str(target), "rev-parse", "HEAD"],
                    check=True,
                    capture_output=True,
                    text=True,
                ).stdout.strip()
                run_git(target, "update-ref", "refs/remotes/origin/main", head)
                registry_entries.append({"path": str(target), "level": level})

            registry = home / ".home-baseline" / "level2-repository-registry.json"
            registry.parent.mkdir(parents=True)
            registry.write_text(
                json.dumps({"repositories": registry_entries}), encoding="utf-8"
            )

            fake_bin = root / "fake-bin"
            fake_bin.mkdir()
            real_git = shutil.which("git")
            self.assertIsNotNone(real_git)
            git_wrapper = fake_bin / "git"
            git_wrapper.write_text(
                "#!/usr/bin/env bash\n"
                "if [[ \" $* \" == *\" fetch --dry-run origin \"* ]]; then exit 0; fi\n"
                f'exec "{real_git}" "$@"\n',
                encoding="utf-8",
            )
            git_wrapper.chmod(0o755)

            env = os.environ.copy()
            env["PATH"] = f"{fake_bin}{os.pathsep}{env['PATH']}"
            result = subprocess.run(
                [
                    "bash",
                    str(scripts / SCRIPT.name),
                    "--shared-guides-only",
                    "--dry-run",
                    "--verbose",
                    "--series",
                    "SecureCaseTracker",
                    "--home-dir",
                    str(home),
                    "--registry",
                    str(registry),
                ],
                check=True,
                capture_output=True,
                text=True,
                env=env,
            )

            planned_paths = [
                line
                for line in result.stdout.splitlines()
                if line.startswith("  [DRY-RUN] docs/learning-units/")
                or line.startswith("  [DRY-RUN] (root)")
            ]
            self.assertEqual(len(planned_paths), 12)
            for guide in GUIDES:
                self.assertEqual(result.stdout.count(f"docs/learning-units/{guide}"), 2)
                self.assertEqual(result.stdout.count(f"(root) {guide}"), 2)
            self.assertNotIn("Lastenheft_", result.stdout)
            self.assertNotIn("README.md (", result.stdout)
            for target, _, _ in targets:
                self.assertEqual(
                    (target / "README.md").read_text(encoding="utf-8"), "# Preserve me\n"
                )
                self.assertFalse((target / "docs" / "learning-units").exists())


if __name__ == "__main__":
    unittest.main()
