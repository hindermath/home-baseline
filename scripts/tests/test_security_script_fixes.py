#!/usr/bin/env python3
"""Focused regression checks for the script security boundaries."""

from __future__ import annotations

import json
import os
from pathlib import Path
import shutil
import shlex
import subprocess
import sys
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
HOOK = ROOT / "scripts/hooks/pre-push"


class InjectionBoundaryTests(unittest.TestCase):
    @unittest.skipIf(os.name == "nt", "POSIX executable stub; Windows uses the PowerShell command stub below")
    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_wsl_wrapper_forwards_values_as_distinct_arguments(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            binary = root / "wsl"
            capture = root / "arguments.json"
            marker = root / "executed"
            binary.write_text(
                "#!/usr/bin/env python3\n"
                "import json, os, sys\n"
                "open(os.environ['WSL_CAPTURE'], 'w').write(json.dumps(sys.argv[1:]))\n",
                encoding="utf-8",
            )
            binary.chmod(0o755)
            payload = f"Secure; touch {marker}"
            env = os.environ.copy()
            env["PATH"] = str(root) + os.pathsep + env["PATH"]
            env["WSL_CAPTURE"] = str(capture)
            result = subprocess.run(
                [shutil.which("pwsh"), "-NoProfile", "-File",
                 str(ROOT / "scripts/propagate-learning-series.ps1"),
                 "-DryRun", "-Series", payload, "-FilePrefix", "Secure A B"],
                env=env, text=True, capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            arguments = json.loads(capture.read_text(encoding="utf-8"))
            self.assertEqual(arguments[:2], ["--exec", "bash"])
            self.assertEqual(arguments[2:5], ["-c", 'exec bash "$HOME/scripts/propagate-learning-series.sh" "$@"', "bash"])
            self.assertEqual(arguments[5:], ["--dry-run", "--series", payload, "--file-prefix", "Secure A B"])
            self.assertFalse(marker.exists())

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_wsl_wrapper_preserves_arguments_with_powershell_command_stub(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            capture = root / "arguments.json"
            marker = root / "executed"
            payload = f"Secure; touch {marker}"
            env = os.environ.copy()
            env.update({
                "WSL_CAPTURE": str(capture), "WSL_SERIES": payload,
                "WSL_WRAPPER": str(ROOT / "scripts/propagate-learning-series.ps1"),
            })
            # A shebang file is not a Windows executable. This stub also avoids
            # depending on a runner's installed WSL distributions or file associations.
            program = """
function global:wsl {
    $args | ConvertTo-Json -AsArray | Set-Content -LiteralPath $env:WSL_CAPTURE -Encoding utf8
    $global:LASTEXITCODE = 0
}
& $env:WSL_WRAPPER -DryRun -Series $env:WSL_SERIES -FilePrefix 'Secure A B'
"""
            result = subprocess.run(
                [shutil.which("pwsh"), "-NoProfile", "-Command", program],
                env=env, text=True, encoding="utf-8", capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            arguments = json.loads(capture.read_text(encoding="utf-8-sig"))
            self.assertEqual(arguments[:5], [
                "--exec", "bash", "-c",
                'exec bash "$HOME/scripts/propagate-learning-series.sh" "$@"', "bash",
            ])
            self.assertEqual(arguments[5:], ["--dry-run", "--series", payload, "--file-prefix", "Secure A B"])
            self.assertFalse(marker.exists())

    def test_workspace_bootstrap_preview_preserves_ordinary_name(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            (home / "Plain Workspace").mkdir()
            (home / ".gitconfig").write_text(
                "[user]\n\tname = Security Fixture\n\temail = fixture@example.invalid\n",
                encoding="utf-8",
            )
            env = os.environ.copy()
            env["HOME"] = str(home)
            env["LC_ALL"] = "C"
            result = subprocess.run(
                [shutil.which("bash"), str(ROOT / "scripts/bootstrap-workspace.sh"),
                 "--dry-run", "--no-remote", "Plain Workspace"],
                env=env, text=True, encoding="utf-8", capture_output=True,
            )
            self.assertEqual(result.returncode, 0, result.stderr)
            self.assertIn("Plain\\ Workspace", result.stdout)
            self.assertFalse((home / "Plain Workspace" / ".git").exists())

    def test_workspace_run_keeps_shell_metacharacters_as_data(self) -> None:
        source = (ROOT / "scripts/bootstrap-workspace.sh").read_text(encoding="utf-8")
        helper = source.split("run() {", 1)[1].split("\n}", 1)[0]
        with tempfile.TemporaryDirectory() as temporary:
            marker = Path(temporary) / "executed"
            payload = f"name'; touch '{marker}'; echo '"
            program = "run() {" + helper + "\n}\nDRY_RUN=0\nrun printf '%s' \"$1\"\n"
            result = subprocess.run(
                [shutil.which("bash"), "-c", program, "bash", payload],
                check=True, capture_output=True, text=True,
            )
            self.assertEqual(result.stdout, payload)
            self.assertFalse(marker.exists())

    def test_project_readme_update_treats_row_as_data(self) -> None:
        source = (ROOT / "scripts/bootstrap-project.sh").read_text(encoding="utf-8")
        python_block = source.split("python3 - \"$home_readme\" \"$row\" <<'PY'", 1)[1].split("\n", 1)[1].split("\nPY", 1)[0]
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            readme = root / "README.md"
            readme.write_text("# Workspaces\n<!-- workspace-table-end -->\n", encoding="utf-8")
            marker = root / "executed"
            row = f"| name'; __import__('pathlib').Path('{marker}').touch(); # |\n"
            subprocess.run(
                [shutil.which("python3"), "-", str(readme), row],
                input=python_block, text=True, capture_output=True, check=True,
            )
            self.assertIn(row, readme.read_text(encoding="utf-8"))
            self.assertFalse(marker.exists())


class PushHookHistoryTests(unittest.TestCase):
    def run_git(self, repo: Path, *args: str) -> str:
        return subprocess.run(
            ["git", "-C", str(repo), *args], check=True, capture_output=True, text=True
        ).stdout.strip()

    def test_workflow_cli_environment_reference_preserves_literal_detection(self) -> None:
        source = HOOK.read_text(encoding="utf-8")
        helper = "secret_content_present() {" + source.split("secret_content_present() {", 1)[1].split("\n}\n", 1)[0] + "\n}\n"
        assignment = next(line for line in source.splitlines() if line.startswith("secret_content_regex="))
        option = "--api" + "-key"
        variable = "$env:NUGET_" + "API_KEY"
        cases = [
            (".github/workflows/release.yml", f"dotnet nuget push file {option} {variable}\n", False),
            (".github/workflows/release.yml", f"dotnet nuget push file {option} literal-fixture-value\n", True),
            (".github/workflows/release.yml", f"dotnet nuget push file {option} {variable}; api" + "_key=literal-fixture-value\n", True),
            ("scripts/release.ps1", f"dotnet nuget push file {option} {variable}\n", True),
            (".github/workflows/release.yml", f"dotnet nuget push file {option} {variable}-literal\n", True),
            ("scripts/hooks/pre-push", assignment + "\npass" + "word=literal-fixture-value\n", True),
        ]
        for path, value, expected in cases:
            with self.subTest(path=path, value=value):
                program = "set -euo pipefail\n" + assignment + "\n" + helper + 'secret_content_present "$1"\n'
                result = subprocess.run([shutil.which("bash"), "-c", program, "bash", path], input=value, text=True, capture_output=True)
                self.assertEqual(result.returncode, 0 if expected else 1, result.stderr)
                self.assertEqual(result.stdout, "")

    def test_regex_fallback_checks_deleted_secret_and_clean_history(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            repo = root / "repo"
            repo.mkdir()
            self.run_git(repo, "init", "-b", "main")
            self.run_git(repo, "config", "user.name", "Security Fixture")
            self.run_git(repo, "config", "user.email", "fixture@example.invalid")

            (repo / "README.md").write_text("base\n", encoding="utf-8")
            self.run_git(repo, "add", "README.md")
            self.run_git(repo, "commit", "-m", "base")
            base = self.run_git(repo, "rev-parse", "HEAD")

            (repo / "README.md").write_text("clean\n", encoding="utf-8")
            workflow = repo / ".github/workflows/credentials.yml"
            workflow.parent.mkdir(parents=True)
            workflow.write_text("name: clean-fixture\n", encoding="utf-8")
            self.run_git(repo, "add", "-A")
            self.run_git(repo, "commit", "-m", "clean")
            clean = self.run_git(repo, "rev-parse", "HEAD")

            secret = repo / "temporary.txt"
            secret.write_text("api" + "_key=historical-fixture-value\n", encoding="utf-8")
            self.run_git(repo, "add", "temporary.txt")
            self.run_git(repo, "commit", "-m", "add fixture secret")
            secret.unlink()
            self.run_git(repo, "add", "-u")
            self.run_git(repo, "commit", "-m", "remove fixture secret")
            head = self.run_git(repo, "rev-parse", "HEAD")

            origin = root / "origin.git"
            other = root / "other.git"
            for remote in (origin, other):
                subprocess.run(["git", "init", "--bare", str(remote)], check=True, capture_output=True)
            self.run_git(repo, "remote", "add", "origin", str(origin))
            self.run_git(repo, "remote", "add", "other", str(other))
            self.run_git(repo, "push", "origin", f"{clean}:refs/heads/main")

            config = repo / "scripts/config"
            config.mkdir(parents=True)
            (config / "profiles.json").write_text(
                json.dumps({
                    "assignments": [{"repositoryId": "fixture", "profileId": "public"}],
                    "profiles": [{"profileId": "public", "requiredVisibility": "public", "displayName": "Fixture"}],
                }),
                encoding="utf-8",
            )
            (config / "paths.json").write_text("{}", encoding="utf-8")
            (config / "workflow.yml").write_text("fixture\n", encoding="utf-8")
            engine = repo / "scripts/lib/agentic_workspace_fleet.py"
            engine.parent.mkdir(parents=True)
            engine.write_text("# fixture\n", encoding="utf-8")

            # A restricted PATH forces the documented regex fallback without
            # depending on the developer machine's gitleaks installation.
            binaries = root / "bin"
            binaries.mkdir()
            for name in ("git", "grep", "sed"):
                target = Path(shutil.which(name))
                suffix = target.suffix if os.name == "nt" else ""
                (binaries / (name + suffix)).symlink_to(target)
            # Use the active interpreter, not a Windows App Execution Alias.
            # A shell wrapper retains its DLL/runtime location on Windows.
            python_wrapper = binaries / "python3"
            python_wrapper.write_text(
                "#!/bin/sh\nexec " + shlex.quote(Path(sys.executable).as_posix()) + ' "$@"\n',
                encoding="utf-8",
            )
            python_wrapper.chmod(0o755)
            env = os.environ.copy()
            env.update({
                "PATH": str(binaries),
                "HB_CI_PROFILES": str(config / "profiles.json"),
                "HB_CI_PATH_CONTRACTS": str(config / "paths.json"),
                "HB_CI_WORKFLOW_TEMPLATE": str(config / "workflow.yml"),
                "HB_CI_REPOSITORY_ID": "fixture",
            })

            def invoke(local: str, remote: str, destination: str = "origin") -> subprocess.CompletedProcess[str]:
                update = f"refs/heads/main {local} refs/heads/main {remote}\n"
                # Git sends LF-delimited bytes to hooks on every host. Python's
                # Windows text pipes would inject CR into the remote SHA instead.
                result = subprocess.run(
                    [shutil.which("bash"), str(HOOK), destination, str(root / f"{destination}.git")],
                    cwd=repo, env=env,
                    input=update.encode("utf-8"), capture_output=True,
                )
                return subprocess.CompletedProcess(
                    result.args, result.returncode,
                    result.stdout.decode("utf-8"), result.stderr.decode("utf-8"),
                )

            clean_result = invoke(clean, base)
            self.assertEqual(clean_result.returncode, 0, clean_result.stderr)
            unavailable_base = invoke(clean, "1" * 40)
            self.assertEqual(unavailable_base.returncode, 2, unavailable_base.stderr)
            self.assertIn("Remote-Basiscommit", unavailable_base.stderr)
            blocked_result = invoke(head, clean)
            self.assertEqual(blocked_result.returncode, 2, blocked_result.stderr)
            self.assertIn("Push-Historie", blocked_result.stderr)
            self.assertNotIn("historical-fixture-value", blocked_result.stderr)
            self.run_git(repo, "update-ref", "refs/remotes/origin/main", head)
            new_ref_result = invoke(head, "0" * 40)
            self.assertEqual(new_ref_result.returncode, 2, new_ref_result.stderr)
            other_remote_result = invoke(head, "0" * 40, "other")
            self.assertEqual(other_remote_result.returncode, 2, other_remote_result.stderr)
            clean_new_ref_result = invoke(clean, "0" * 40)
            self.assertEqual(clean_new_ref_result.returncode, 0, clean_new_ref_result.stderr)

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_fallback_scans_ordinary_tracked_files(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            repo = root / "repo"
            repo.mkdir()
            self.run_git(repo, "init", "-b", "main")
            self.run_git(repo, "config", "user.name", "Security Fixture")
            self.run_git(repo, "config", "user.email", "fixture@example.invalid")
            fake_key = "AKIA" + "QWERTYUIOPASDFGH"
            (repo / "ordinary-config.txt").write_text(
                f"aws_access_key_id = {fake_key}\n", encoding="utf-8"
            )
            self.run_git(repo, "add", "ordinary-config.txt")

            env = os.environ.copy()
            env["PATH"] = "/usr/bin:/bin"
            result = subprocess.run(
                [
                    shutil.which("pwsh"),
                    "-NoProfile",
                    "-File",
                    str(ROOT / "scripts/scan-agent-secrets.ps1"),
                    "-WorkspaceRoot",
                    str(repo),
                    "-FailOnHigh",
                ],
                env=env,
                text=True,
                capture_output=True,
            )
            self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
            self.assertIn("ordinary-config.txt", result.stdout)

    @unittest.skipIf(os.name == "nt", "Bash fallback fixture")
    def test_bash_fallback_scans_clean_committed_non_agent_file_without_gitleaks(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            repo = root / "repo"
            repo.mkdir()
            self.run_git(repo, "init", "-b", "main")
            self.run_git(repo, "config", "user.name", "Security Fixture")
            self.run_git(repo, "config", "user.email", "fixture@example.invalid")
            fake_key = "AKIA" + "QWERTYUIOPASDFGH"
            (repo / "ordinary[1].txt").write_text(
                f"aws_access_key_id = {fake_key}\n", encoding="utf-8"
            )
            self.run_git(repo, "add", "ordinary[1].txt")
            self.run_git(repo, "commit", "-m", "fixture")

            binaries = root / "bin"
            binaries.mkdir()
            for name in ("git", "rg", "find", "sort", "python3"):
                resolved = shutil.which(name)
                self.assertIsNotNone(resolved, name)
                (binaries / name).symlink_to(Path(resolved))
            env = os.environ.copy()
            env["PATH"] = str(binaries)
            result = subprocess.run(
                [
                    shutil.which("bash"),
                    str(ROOT / "scripts/scan-agent-secrets.sh"),
                    "--fail-on-high",
                    str(repo),
                ],
                env=env,
                text=True,
                capture_output=True,
            )
            self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
            self.assertIn("ordinary[1].txt", result.stdout)
            self.assertNotIn(fake_key, result.stdout + result.stderr)

            (repo / "ordinary[1].txt").write_text("ordinary configuration\n", encoding="utf-8")
            self.run_git(repo, "add", "ordinary[1].txt")
            self.run_git(repo, "commit", "-m", "remove fixture")
            clean = subprocess.run(
                [
                    shutil.which("bash"),
                    str(ROOT / "scripts/scan-agent-secrets.sh"),
                    "--fail-on-high",
                    str(repo),
                ],
                env=env,
                text=True,
                capture_output=True,
            )
            self.assertEqual(clean.returncode, 0, clean.stdout + clean.stderr)

            (repo / "production.conf").write_text(
                "pass" + "word=super-secret\n", encoding="utf-8"
            )
            self.run_git(repo, "add", "production.conf")
            self.run_git(repo, "commit", "-m", "production fixture")
            production = subprocess.run(
                [
                    shutil.which("bash"),
                    str(ROOT / "scripts/scan-agent-secrets.sh"),
                    "--fail-on-high",
                    str(repo),
                ],
                env=env,
                text=True,
                capture_output=True,
            )
            self.assertEqual(production.returncode, 2, production.stdout + production.stderr)
            self.assertIn("production.conf", production.stdout)
            self.assertNotIn("super-secret", production.stdout + production.stderr)

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_fallback_treats_metacharacter_filename_literally(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            repo = root / "repo"
            repo.mkdir()
            self.run_git(repo, "init", "-b", "main")
            fake_key = "AKIA" + "ZXCVBNMASDFGHJKL"
            (repo / "tracked[1].txt").write_text(
                f"aws_access_key_id = {fake_key}\n", encoding="utf-8"
            )
            self.run_git(repo, "add", "tracked[1].txt")
            env = os.environ.copy()
            env["PATH"] = "/usr/bin:/bin"
            result = subprocess.run(
                [
                    shutil.which("pwsh"), "-NoProfile", "-File",
                    str(ROOT / "scripts/scan-agent-secrets.ps1"),
                    "-WorkspaceRoot", str(repo), "-FailOnHigh",
                ],
                env=env, text=True, capture_output=True,
            )
            self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
            self.assertIn("tracked[1].txt", result.stdout)
            self.assertNotIn(fake_key, result.stdout + result.stderr)

    @unittest.skipIf(os.name == "nt", "POSIX permissions fixture")
    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_fallback_fails_closed_on_unreadable_tracked_file(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            repo = root / "repo"
            repo.mkdir()
            self.run_git(repo, "init", "-b", "main")
            unreadable = repo / "ordinary.txt"
            unreadable.write_text("clean\n", encoding="utf-8")
            self.run_git(repo, "add", "ordinary.txt")
            unreadable.chmod(0)
            try:
                env = os.environ.copy()
                env["PATH"] = "/usr/bin:/bin"
                result = subprocess.run(
                    [
                        shutil.which("pwsh"),
                        "-NoProfile",
                        "-File",
                        str(ROOT / "scripts/scan-agent-secrets.ps1"),
                        "-WorkspaceRoot",
                        str(repo),
                        "-FailOnHigh",
                    ],
                    env=env,
                    text=True,
                    capture_output=True,
                )
            finally:
                unreadable.chmod(0o600)
            self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
            self.assertIn("konnten nicht gelesen", result.stdout)

    @unittest.skipIf(os.name == "nt", "POSIX symbolic-link fixture")
    def test_tracked_symlink_is_rejected_without_reading_external_content(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            repo = root / "repo"
            repo.mkdir()
            self.run_git(repo, "init", "-b", "main")
            external = root / "external.txt"
            fake_key = "AKIA" + "QWERTYUIOPASDFGH"
            external.write_text(fake_key + "\n", encoding="utf-8")
            (repo / "linked.txt").symlink_to(external)
            self.run_git(repo, "add", "linked.txt")

            binaries = root / "bin"
            binaries.mkdir()
            for name in ("git", "rg", "find", "sort", "python3"):
                resolved = shutil.which(name)
                self.assertIsNotNone(resolved, name)
                (binaries / name).symlink_to(Path(resolved))
            env = os.environ.copy()
            env["PATH"] = str(binaries)

            bash_result = subprocess.run(
                [shutil.which("bash"), str(ROOT / "scripts/scan-agent-secrets.sh"), "--fail-on-high", str(repo)],
                env=env, text=True, capture_output=True,
            )
            self.assertEqual(bash_result.returncode, 2, bash_result.stdout + bash_result.stderr)
            self.assertIn("tracked file could not be read", bash_result.stdout)
            self.assertNotIn(fake_key, bash_result.stdout + bash_result.stderr)

            if shutil.which("pwsh"):
                powershell_result = subprocess.run(
                    [shutil.which("pwsh"), "-NoProfile", "-File", str(ROOT / "scripts/scan-agent-secrets.ps1"),
                     "-WorkspaceRoot", str(repo), "-FailOnHigh"],
                    env=env, text=True, capture_output=True,
                )
                self.assertEqual(powershell_result.returncode, 2, powershell_result.stdout + powershell_result.stderr)
                self.assertIn("konnten nicht gelesen", powershell_result.stdout)
                self.assertNotIn(fake_key, powershell_result.stdout + powershell_result.stderr)

                external.unlink()
                dangling = subprocess.run(
                    [shutil.which("pwsh"), "-NoProfile", "-File", str(ROOT / "scripts/scan-agent-secrets.ps1"),
                     "-WorkspaceRoot", str(repo), "-FailOnHigh"],
                    env=env, text=True, capture_output=True,
                )
                self.assertEqual(dangling.returncode, 2, dangling.stdout + dangling.stderr)
                self.assertIn("konnten nicht gelesen", dangling.stdout)

    @unittest.skipIf(os.name == "nt", "Sparse-file fixture")
    def test_bash_fallback_rejects_oversized_tracked_file(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            root = Path(temporary)
            repo = root / "repo"
            repo.mkdir()
            self.run_git(repo, "init", "-b", "main")
            oversized = repo / "oversized.txt"
            with oversized.open("wb") as stream:
                stream.truncate(8 * 1024 * 1024 + 1)
            self.run_git(repo, "add", "oversized.txt")
            result = subprocess.run(
                ["bash", str(ROOT / "scripts/scan-agent-secrets.sh"), "--fail-on-high", str(repo)],
                text=True, capture_output=True,
            )
            self.assertEqual(result.returncode, 2, result.stdout + result.stderr)
            self.assertIn("oversized.txt", result.stdout)
            if shutil.which("pwsh"):
                powershell = subprocess.run(
                    [shutil.which("pwsh"), "-NoProfile", "-File", str(ROOT / "scripts/scan-agent-secrets.ps1"),
                     "-WorkspaceRoot", str(repo), "-FailOnHigh"],
                    text=True, capture_output=True,
                )
                self.assertEqual(powershell.returncode, 2, powershell.stdout + powershell.stderr)
                self.assertIn("oversized.txt", powershell.stdout)


class AgentIgnorePolicyTests(unittest.TestCase):
    def test_all_migration_and_homogeneity_variants_use_effective_git_policy(self) -> None:
        for relative in (
            "scripts/audit-antigravity-migration.sh",
            "scripts/audit-antigravity-migration.ps1",
            "scripts/check-homogeneity.sh",
            "scripts/check-homogeneity.ps1",
        ):
            with self.subTest(relative=relative):
                source = (ROOT / relative).read_text(encoding="utf-8")
                self.assertIn("check-ignore", source)
                self.assertIn("ls-files", source)
                self.assertIn(".agents/private-state.json", source)
                self.assertIn(".agents/mcp_config.json", source)
                self.assertIn(".agents/runtime/session.json", source)
                self.assertIn(".agents/skills/speckit-probe/SKILL.md", source)

    def test_git_policy_distinguishes_comments_negations_and_tracking(self) -> None:
        def effective(repo: Path) -> bool:
            private = all(subprocess.run(
                ["git", "-C", str(repo), "check-ignore", "-q", "--no-index", "--", path]
            ).returncode == 0 for path in (
                ".agents/private-state.json", ".agents/mcp_config.json", ".agents/runtime/session.json",
            ))
            skill = subprocess.run(
                ["git", "-C", str(repo), "check-ignore", "-q", "--no-index", "--", ".agents/skills/speckit-probe/SKILL.md"]
            ).returncode == 1
            tracked = subprocess.run(
                ["git", "-C", str(repo), "ls-files", "-z", "--", ".agents"], capture_output=True, check=True
            ).stdout.split(b"\0")
            return private and skill and all(not path or path.startswith(b".agents/skills/") for path in tracked)

        with tempfile.TemporaryDirectory() as temporary:
            repo = Path(temporary)
            subprocess.run(["git", "-C", str(repo), "init", "-q"], check=True)
            gitignore = repo / ".gitignore"
            gitignore.write_text("# .agents/*\n# !.agents/skills/**\n", encoding="utf-8")
            self.assertFalse(effective(repo))
            gitignore.write_text(".agents/private-state.json\n!.agents/skills/**\n", encoding="utf-8")
            self.assertFalse(effective(repo))
            gitignore.write_text(".agents/*\n!.agents/skills/\n!.agents/skills/**\n", encoding="utf-8")
            self.assertTrue(effective(repo))
            gitignore.write_text(".agents/*\n!.agents/skills/\n!.agents/skills/**\n!.agents/private-state.json\n", encoding="utf-8")
            self.assertFalse(effective(repo))
            gitignore.write_text(".agents/*\n!.agents/skills/\n!.agents/skills/**\n", encoding="utf-8")
            private = repo / ".agents/private-state.json"
            private.parent.mkdir(parents=True)
            private.write_text("private\n", encoding="utf-8")
            subprocess.run(["git", "-C", str(repo), "add", "-f", ".agents/private-state.json"], check=True)
            self.assertFalse(effective(repo))


if __name__ == "__main__":
    unittest.main()
