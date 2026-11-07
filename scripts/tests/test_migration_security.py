#!/usr/bin/env python3
"""Focused security regression tests for migration workflows."""

from __future__ import annotations

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
LEVEL0_PS1 = ROOT / "scripts/migrate-level0-source-checkout.ps1"
WORKSPACE_SH = ROOT / "scripts/migrate-workspace.sh"
WORKSPACE_PS1 = ROOT / "scripts/migrate-workspace.ps1"


class WorkspaceMigrationSecurityTests(unittest.TestCase):
    def setUp(self) -> None:
        self.temporary = tempfile.TemporaryDirectory()
        self.addCleanup(self.temporary.cleanup)
        self.home = Path(self.temporary.name) / "home"
        self.workspace = self.home / "Workspace"
        self.workspace.mkdir(parents=True)
        subprocess.run(["git", "init", "-q", str(self.workspace)], check=True)
        subprocess.run(
            ["git", "-C", str(self.workspace), "config", "user.name", "Security Test"],
            check=True,
        )
        subprocess.run(
            ["git", "-C", str(self.workspace), "config", "user.email", "security@example.invalid"],
            check=True,
        )

    def commit_fixture(self) -> None:
        subprocess.run(["git", "-C", str(self.workspace), "add", "-A"], check=True)
        subprocess.run(
            ["git", "-C", str(self.workspace), "commit", "-q", "-m", "fixture"],
            check=True,
        )

    def run_bash(self) -> subprocess.CompletedProcess[str]:
        env = os.environ.copy()
        env["HOME"] = str(self.home)
        return subprocess.run(
            ["bash", str(WORKSPACE_SH), "Workspace", "--yes"],
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )

    def test_bash_rejects_clean_tracked_symlink_without_external_write(self) -> None:
        sentinel = Path(self.temporary.name) / "sentinel.md"
        sentinel.write_text("unchanged\n", encoding="utf-8")
        (self.workspace / "README.md").symlink_to(sentinel)
        self.commit_fixture()

        result = self.run_bash()

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("symbolischen Link", result.stdout)
        self.assertEqual(sentinel.read_text(encoding="utf-8"), "unchanged\n")

    def test_bash_rejects_preexisting_untracked_file(self) -> None:
        (self.workspace / "README.md").write_text("# Fixture\n", encoding="utf-8")
        self.commit_fixture()
        (self.workspace / "unrelated.txt").write_text("must not be committed\n", encoding="utf-8")

        result = self.run_bash()

        self.assertNotEqual(result.returncode, 0, result.stdout)
        status = subprocess.run(
            ["git", "-C", str(self.workspace), "status", "--porcelain=v1"],
            text=True,
            stdout=subprocess.PIPE,
            check=True,
        ).stdout
        self.assertIn("?? unrelated.txt", status)
        self.assertEqual(
            subprocess.run(
                ["git", "-C", str(self.workspace), "rev-list", "--count", "HEAD"],
                text=True,
                stdout=subprocess.PIPE,
                check=True,
            ).stdout.strip(),
            "1",
        )

    def test_bash_skips_post_processing_after_symlink_preflight_failure(self) -> None:
        sentinel = Path(self.temporary.name) / "stats-sentinel.md"
        sentinel.write_text("unchanged\n", encoding="utf-8")
        (self.workspace / "STATS.md").symlink_to(sentinel)
        self.commit_fixture()

        result = self.run_bash()

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertNotIn("Starte init-stats.sh", result.stdout)
        self.assertEqual(sentinel.read_text(encoding="utf-8"), "unchanged\n")

    def test_bash_accepts_clean_nested_repository_before_gitignore_exists(self) -> None:
        (self.workspace / "README.md").write_text("# Workspace\n", encoding="utf-8")
        self.commit_fixture()
        project = self.workspace / "Project"
        project.mkdir()
        subprocess.run(["git", "init", "-q", str(project)], check=True)
        subprocess.run(["git", "-C", str(project), "config", "user.name", "Security Test"], check=True)
        subprocess.run(["git", "-C", str(project), "config", "user.email", "security@example.invalid"], check=True)
        (project / "README.md").write_text("# Project\n", encoding="utf-8")
        subprocess.run(["git", "-C", str(project), "add", "README.md"], check=True)
        subprocess.run(["git", "-C", str(project), "commit", "-q", "-m", "fixture"], check=True)

        result = self.run_bash()

        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertIn("Project/", (self.workspace / ".gitignore").read_text(encoding="utf-8"))

    def test_bash_disables_repository_fsmonitor_during_preflight(self) -> None:
        (self.workspace / "README.md").write_text("# Fixture\n", encoding="utf-8")
        self.commit_fixture()
        marker = Path(self.temporary.name) / "fsmonitor-ran"
        hook = Path(self.temporary.name) / "fsmonitor-hook.sh"
        hook.write_text(f"#!/usr/bin/env bash\nprintf ran > '{marker}'\n", encoding="utf-8")
        hook.chmod(0o755)
        subprocess.run(["git", "-C", str(self.workspace), "config", "core.fsmonitor", str(hook)], check=True)

        result = self.run_bash()

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("FSMonitor-Hook", result.stdout)
        self.assertFalse(marker.exists(), result.stdout)

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_rejects_preexisting_untracked_file(self) -> None:
        (self.workspace / "README.md").write_text("# Fixture\n", encoding="utf-8")
        self.commit_fixture()
        (self.workspace / "unrelated.txt").write_text("must not be committed\n", encoding="utf-8")
        env = os.environ.copy()
        env["HOME"] = str(self.home)

        result = subprocess.run(
            [shutil.which("pwsh"), "-NoProfile", "-File", str(WORKSPACE_PS1), "-WorkspaceName", "Workspace", "-Force"],
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )

        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("ungetrackte Dateien", result.stdout)
        status = subprocess.run(
            ["git", "-C", str(self.workspace), "status", "--porcelain=v1"],
            text=True,
            stdout=subprocess.PIPE,
            check=True,
        ).stdout
        self.assertIn("?? unrelated.txt", status)


@unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
class Level0MigrationSecurityTests(unittest.TestCase):
    def run_preflight(self, remote: str, local_head: str, live_head: str) -> subprocess.CompletedProcess[str]:
        temporary = tempfile.TemporaryDirectory()
        self.addCleanup(temporary.cleanup)
        root = Path(temporary.name)
        source = root / "source"
        source.mkdir()
        fake_bin = root / "bin"
        fake_bin.mkdir()
        fake_git = fake_bin / "git"
        fake_git.write_text(
            "#!/usr/bin/env bash\n"
            "case \"$*\" in\n"
            "  *'ls-remote --exit-code'*) printf '%s\\trefs/heads/main\\n' \"$HB_LIVE_HEAD\" ;;\n"
            "  *'rev-parse --show-toplevel'*) printf '%s\\n' \"$HB_SOURCE\" ;;\n"
            "  *'branch --show-current'*) printf 'main\\n' ;;\n"
            "  *'rev-parse HEAD'*) printf '%s\\n' \"$HB_LOCAL_HEAD\" ;;\n"
            "  *'rev-parse origin/main'*) printf '%s\\n' \"$HB_LOCAL_HEAD\" ;;\n"
            "  *'remote get-url origin'*) printf '%s\\n' \"$HB_REMOTE\" ;;\n"
            "  *'status --porcelain=v1'*) : ;;\n"
            "  *'worktree list --porcelain'*) printf 'worktree %s\\n' \"$HB_SOURCE\" ;;\n"
            "  *) printf 'unexpected git arguments: %s\\n' \"$*\" >&2; exit 91 ;;\n"
            "esac\n",
            encoding="utf-8",
        )
        fake_git.chmod(0o755)
        env = os.environ.copy()
        env.update(
            {
                "PATH": f"{fake_bin}{os.pathsep}{env['PATH']}",
                "HB_SOURCE": str(source),
                "HB_REMOTE": remote,
                "HB_LOCAL_HEAD": local_head,
                "HB_LIVE_HEAD": live_head,
            }
        )
        return subprocess.run(
            [
                shutil.which("pwsh"),
                "-NoProfile",
                "-File",
                str(LEVEL0_PS1),
                "-Source",
                str(source),
                "-Target",
                str(root / "target"),
                "-CheckOnly",
                "-Json",
            ],
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
        )

    def test_hostile_suffix_origin_is_rejected(self) -> None:
        head = "a" * 40
        result = self.run_preflight(
            "https://evil.example/hindermath/home-baseline.git", head, head
        )
        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("Unexpected Level-0 origin", result.stdout)

    def test_origin_credentials_are_never_echoed_in_json_error(self) -> None:
        head = "a" * 40
        secret = "credential-that-must-not-leak"
        result = self.run_preflight(
            f"https://user:{secret}@github.com/hindermath/home-baseline.git", head, head
        )
        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn('"status":"ERROR"', result.stdout)
        self.assertNotIn(secret, result.stdout)

    def test_forged_local_origin_main_cannot_replace_live_ref(self) -> None:
        result = self.run_preflight(
            "https://github.com/hindermath/home-baseline.git", "a" * 40, "b" * 40
        )
        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("live canonical GitHub main", result.stdout)

    def test_canonical_origin_and_live_head_are_ready(self) -> None:
        head = "a" * 40
        result = self.run_preflight(
            "git@github.com:hindermath/home-baseline.git", head, head
        )
        self.assertEqual(result.returncode, 0, result.stdout)
        self.assertIn('"status":"READY"', result.stdout)


if __name__ == "__main__":
    unittest.main()
