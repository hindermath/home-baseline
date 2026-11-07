#!/usr/bin/env python3
"""Destination-containment regressions for learning-series propagation."""

from __future__ import annotations

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
SCRIPT = ROOT / "scripts/propagate-learning-series.sh"


def git(repo: Path, *args: str) -> None:
    subprocess.run(["git", "-C", str(repo), *args], check=True, capture_output=True)


def fixture(base: Path) -> tuple[Path, Path, Path, dict[str, str]]:
    home = base / "home"
    target = home / "SecureCaseTrackerProjects"
    target.mkdir(parents=True)
    (target / "README.md").write_text("# Fixture\n", encoding="utf-8")
    git(target, "init", "-q", "-b", "main")
    git(target, "config", "user.name", "Test")
    git(target, "config", "user.email", "test@example.invalid")
    git(target, "add", ".")
    git(target, "commit", "-qm", "initial")
    git(
        target,
        "remote",
        "add",
        "origin",
        "https://github.com/hindermath/secure-casetracker-baseline.git",
    )
    git(target, "config", "branch.main.remote", "origin")
    git(target, "config", "branch.main.merge", "refs/heads/main")
    head = subprocess.run(
        ["git", "-C", str(target), "rev-parse", "HEAD"],
        check=True,
        capture_output=True,
        text=True,
    ).stdout.strip()
    git(target, "update-ref", "refs/remotes/origin/main", head)
    registry = home / ".home-baseline/level2-repository-registry.json"
    registry.parent.mkdir(parents=True)
    registry.write_text(
        json.dumps({"repositories": [{"path": str(target), "level": 1}]}),
        encoding="utf-8",
    )

    fake_bin = base / "fake-bin"
    fake_bin.mkdir()
    real_git = shutil.which("git")
    assert real_git
    wrapper = fake_bin / "git"
    wrapper.write_text(
        "#!/usr/bin/env bash\n"
        "case \" $* \" in\n"
        "  *\" fetch --quiet origin \"*|*\" pull --ff-only --quiet origin main \"*) exit 0 ;;\n"
        "esac\n"
        f'exec "{real_git}" "$@"\n',
        encoding="utf-8",
    )
    wrapper.chmod(0o755)
    env = os.environ.copy()
    env["PATH"] = f"{fake_bin}{os.pathsep}{env['PATH']}"
    return home, target, registry, env


def run(home: Path, registry: Path, env: dict[str, str]) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        [
            "bash",
            str(SCRIPT),
            "--shared-guides-only",
            "--no-push",
            "--series",
            "SecureCaseTracker",
            "--home-dir",
            str(home),
            "--registry",
            str(registry),
        ],
        cwd=ROOT,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )


class LearningPropagationTargetSecurityTests(unittest.TestCase):
    def test_registry_target_with_linked_parent_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home, target, registry, env = fixture(base)
            outside = base / "outside"
            outside.mkdir()
            actual_target = outside / target.name
            target.rename(actual_target)
            linked_parent = home / "linked"
            linked_parent.symlink_to(outside, target_is_directory=True)
            registry.write_text(
                json.dumps(
                    {
                        "repositories": [
                            {"path": str(linked_parent / actual_target.name), "level": 1}
                        ]
                    }
                ),
                encoding="utf-8",
            )
            result = run(home, registry, env)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((actual_target / "START-HERE-FUER-LERNENDE.md").exists())

    def test_registry_control_characters_cannot_inject_repository_row(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home, target, registry, env = fixture(base)
            injected = (
                "SecureCaseTrackerBogus\n1\t"
                + str(target)
                + "\thttps://github.com/hindermath/secure-casetracker-baseline.git"
            )
            registry.write_text(
                json.dumps({"repositories": [{"path": injected, "level": 1}]}),
                encoding="utf-8",
            )
            result = run(home, registry, env)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((target / "START-HERE-FUER-LERNENDE.md").exists())

    def test_linked_learning_target_parent_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home, target, registry, env = fixture(base)
            outside = base / "outside"
            outside.mkdir()
            (target / "docs").symlink_to(outside, target_is_directory=True)
            git(target, "add", "docs")
            git(target, "commit", "-qm", "linked docs")
            head = subprocess.run(
                ["git", "-C", str(target), "rev-parse", "HEAD"],
                check=True,
                capture_output=True,
                text=True,
            ).stdout.strip()
            git(target, "update-ref", "refs/remotes/origin/main", head)
            result = run(home, registry, env)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((outside / "learning-units").exists())

    def test_regular_learning_targets_are_updated(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            home, target, registry, env = fixture(Path(tmp))
            result = run(home, registry, env)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertTrue(
                (target / "docs/learning-units/START-HERE-FUER-LERNENDE.md").is_file()
            )
            self.assertTrue((target / "START-HERE-FUER-LERNENDE.md").is_file())


if __name__ == "__main__":
    unittest.main()
