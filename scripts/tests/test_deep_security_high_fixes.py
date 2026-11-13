#!/usr/bin/env python3
"""Focused regressions for the validated high-severity script boundaries."""

from __future__ import annotations

import json
import os
from pathlib import Path
import re
import shutil
import subprocess
import tempfile
import time
import unittest


ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"


def run(*args: str, env: dict[str, str] | None = None) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        args,
        cwd=ROOT,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )


class HighFindingRegressionTests(unittest.TestCase):
    def test_homogeneity_workflow_cannot_inherit_repository_write_tokens(self) -> None:
        workflow = (ROOT / ".github/workflows/homogeneity-check.yml").read_text(encoding="utf-8")
        # This gate executes repository-controlled checks. Its token authority
        # must remain read-only even when the repository default permits writes.
        # Keep the single workflow declaration: jobs must inherit it rather than
        # replacing it with an inline map or write-all permission shorthand.
        def inherits_read_only_token(text: str) -> bool:
            header = text.split("\njobs:\n", 1)[0]
            declarations = re.findall(r"(?m)^\s*['\"]?permissions['\"]?\s*:", text)
            return "\npermissions:\n  contents: read\n" in header and len(declarations) == 1

        self.assertTrue(inherits_read_only_token(workflow))
        for override in ("permissions: write-all", "permissions: {contents: write}",
                         "'permissions': {contents: write}"):
            with self.subTest(override=override):
                altered = workflow.replace("\n  check:\n", f"\n  check:\n    {override}\n")
                self.assertNotEqual(altered, workflow)
                self.assertFalse(inherits_read_only_token(altered))

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_copilot_evidence_publication_rejects_linked_root(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            outside = base / "outside"
            outside.mkdir()
            evidence = base / "evidence"
            evidence.symlink_to(outside, target_is_directory=True)
            command = (
                "Import-Module $args[0] -Force; "
                "Publish-HBEvidence -EvidenceRoot $args[1] -RelativePath 'restricted/probe.json' "
                "-Value ([ordered]@{schemaVersion='1.0';status='Blocked'})"
            )
            result = run(
                "pwsh", "-NoProfile", "-Command", command,
                str(SCRIPTS / "modules/CopilotReviewGovernance.psm1"), str(evidence),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((outside / "restricted/probe.json").exists())

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_copilot_live_authority_rejects_arbitrary_root_and_non_target(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            arbitrary = Path(tmp) / "evidence"
            arbitrary.mkdir(mode=0o700)
            command = (
                "Import-Module $args[0] -Force; "
                "$module=Get-Module CopilotReviewGovernance; "
                "$rootBlocked=$false;try{& $module {param($p) Assert-HBLiveEvidenceRootAuthority $p} $args[1]}catch{$rootBlocked=$true}; "
                "$targetBlocked=$false;try{& $module {Assert-HBLiveCanonicalRepository ([ordered]@{slug='hindermath/not-approved';defaultBranch='main'})}|Out-Null}catch{$targetBlocked=$true}; "
                "if(-not$rootBlocked-or-not$targetBlocked){exit 9}"
            )
            result = run(
                "pwsh", "-NoProfile", "-Command", command,
                str(SCRIPTS / "modules/CopilotReviewGovernance.psm1"), str(arbitrary),
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_bash_prepare_propagates_baseline_sync_failure(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            repo = Path(tmp) / "repo"
            (repo / ".git").mkdir(parents=True)
            command = (
                'source "$1"; '
                'sdh_sync_baseline(){ return 1; }; '
                'if ! sdh_prepare_repo "$2" Fixture csharp 0 1 "$3"; then '
                'printf "%s:%s\\n" "$SDH_PREPARE_RESULT" "$SDH_PREPARE_REASON"; exit 7; fi; '
                'printf "unexpected:%s\\n" "$SDH_PREPARE_RESULT"'
            )
            result = run(
                "bash", "-c", command, "security-test",
                str(SCRIPTS / "lib/secure-development-hardening.sh"), str(repo), str(SCRIPTS),
            )
            self.assertEqual(result.returncode, 7, result.stdout + result.stderr)
            self.assertIn("error:Secure-Development-Baseline", result.stdout)
            self.assertFalse((repo / "Lastenheft_Secure-Development-Hardening.md").exists())
            self.assertFalse((repo / "Lastenheft_Abarbeitungsreihenfolge.md").exists())
    def test_baseline_sync_rejects_symlinked_managed_parent(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "source"
            repo = base / "repo"
            target = repo / "docs" / "secure-development"
            outside = base / "outside"
            source.mkdir()
            target.mkdir(parents=True)
            outside.mkdir()
            sentinel = outside / "sentinel.txt"
            sentinel.write_text("private\n", encoding="utf-8")
            (target / "linked").symlink_to(outside, target_is_directory=True)

            manifest = {
                "guideline": {"path": "guide.md"},
                "compendium": {"path": "compendium.md"},
                "checklists": [],
                "relatedDocuments": [],
                "learningDocuments": [],
                "managedBinaryFiles": [],
                "managedReferenceFiles": [],
            }
            old_manifest = dict(manifest)
            old_manifest["managedReferenceFiles"] = ["linked/sentinel.txt"]
            (source / "baseline-manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
            (source / "guide.md").write_text("guide\n", encoding="utf-8")
            (source / "compendium.md").write_text("compendium\n", encoding="utf-8")
            (target / "baseline-manifest.json").write_text(json.dumps(old_manifest), encoding="utf-8")

            result = run(
                "bash",
                "-c",
                'source "$1"; sdh_sync_baseline "$2" "$3" 0',
                "security-test",
                str(SCRIPTS / "lib" / "secure-development-hardening.sh"),
                str(source),
                str(target),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(sentinel.read_text(encoding="utf-8"), "private\n")

    def test_secure_template_treats_repository_name_as_data(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            template = base / "template.md"
            output = base / "output.md"
            marker = base / "executed"
            template.write_text("Project {{PROJECT_NAME}} on {{DATE}}\n", encoding="utf-8")
            payload = f"name|g\ne touch {marker}\n#"
            result = run(
                "bash",
                "-c",
                'source "$1"; sdh_render_template "$2" "$3" "$4"',
                "security-test",
                str(SCRIPTS / "lib" / "secure-development-hardening.sh"),
                str(template),
                str(output),
                payload,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(marker.exists())
            self.assertIn("name|g", output.read_text(encoding="utf-8"))

    def test_powershell_baseline_sync_rejects_symlinked_managed_parent(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "source"
            repo = base / "repo"
            target = repo / "docs" / "secure-development"
            outside = base / "outside"
            source.mkdir()
            target.mkdir(parents=True)
            outside.mkdir()
            sentinel = outside / "sentinel.txt"
            sentinel.write_text("private\n", encoding="utf-8")
            (target / "linked").symlink_to(outside, target_is_directory=True)
            manifest = {
                "guideline": {"path": "guide.md"},
                "compendium": {"path": "compendium.md"},
                "checklists": [],
                "relatedDocuments": [],
                "learningDocuments": [],
                "managedBinaryFiles": [],
                "managedReferenceFiles": [],
            }
            old_manifest = dict(manifest)
            old_manifest["managedReferenceFiles"] = ["linked/sentinel.txt"]
            (source / "baseline-manifest.json").write_text(json.dumps(manifest), encoding="utf-8")
            (source / "guide.md").write_text("guide\n", encoding="utf-8")
            (source / "compendium.md").write_text("compendium\n", encoding="utf-8")
            (target / "baseline-manifest.json").write_text(json.dumps(old_manifest), encoding="utf-8")
            result = run(
                "pwsh",
                "-NoProfile",
                "-Command",
                ". $args[0]; Sync-SdhBaseline -SourceDir $args[1] -TargetDir $args[2]",
                str(SCRIPTS / "lib" / "secure-development-hardening.ps1"),
                str(source),
                str(target),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(sentinel.read_text(encoding="utf-8"), "private\n")

    def test_memory_patch_rejects_outside_target_and_dry_run_does_not_write(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            target = base / "target"
            target.mkdir()
            inside = target / "AGENTS.md"
            outside = base / "outside.md"
            inside.write_text("inside\n", encoding="utf-8")
            outside.write_text("outside\n", encoding="utf-8")

            unsafe_patch = base / "unsafe.md"
            unsafe_patch.write_text(
                f"### Target: {outside}\n\n+++ injected\n", encoding="utf-8"
            )
            rejected = run(
                "bash",
                str(SCRIPTS / "check-homogeneity.sh"),
                "--apply-patch",
                str(unsafe_patch),
                "--yes",
                str(target),
            )
            self.assertEqual(rejected.returncode, 2, rejected.stdout + rejected.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "outside\n")

            safe_patch = base / "safe.md"
            safe_patch.write_text("### Target: AGENTS.md\n\n+++ appended\n", encoding="utf-8")
            preview = run(
                "bash",
                str(SCRIPTS / "check-homogeneity.sh"),
                "--dry-run",
                "--apply-patch",
                str(safe_patch),
                "--yes",
                str(target),
            )
            self.assertEqual(preview.returncode, 0, preview.stdout + preview.stderr)
            self.assertEqual(inside.read_text(encoding="utf-8"), "inside\n")

            rejected_ps = run(
                "pwsh",
                "-NoProfile",
                "-File",
                str(SCRIPTS / "check-homogeneity.ps1"),
                "-TargetDir",
                str(target),
                "-ApplyPatch",
                str(unsafe_patch),
                "-Yes",
            )
            self.assertNotEqual(rejected_ps.returncode, 0, rejected_ps.stdout + rejected_ps.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "outside\n")

            scripts_dir = target / "scripts"
            scripts_dir.mkdir()
            executable = scripts_dir / "victim.sh"
            executable.write_text("#!/usr/bin/env bash\n", encoding="utf-8")
            executable_patch = base / "executable.md"
            executable_patch.write_text("### Target: scripts/victim.sh\n\n+++ injected\n", encoding="utf-8")
            for command in (
                ["bash", str(SCRIPTS / "check-homogeneity.sh"), "--apply-patch", str(executable_patch), "--yes", str(target)],
                ["pwsh", "-NoProfile", "-File", str(SCRIPTS / "check-homogeneity.ps1"), "-TargetDir", str(target), "-ApplyPatch", str(executable_patch), "-Yes"],
            ):
                denied = run(*command)
                self.assertNotEqual(denied.returncode, 0, denied.stdout + denied.stderr)
            self.assertEqual(executable.read_text(encoding="utf-8"), "#!/usr/bin/env bash\n")

    def test_memory_patch_revalidates_after_confirmation(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            target = base / "target"
            target.mkdir()
            inside = target / "AGENTS.md"
            outside = base / "outside.md"
            inside.write_text("inside\n", encoding="utf-8")
            outside.write_text("outside\n", encoding="utf-8")
            patch = base / "patch.md"
            patch.write_text("### Target: AGENTS.md\n\n+++ injected\n", encoding="utf-8")
            process = subprocess.Popen(
                ["bash", str(SCRIPTS / "check-homogeneity.sh"), "--apply-patch", str(patch), str(target)],
                cwd=ROOT,
                text=True,
                stdin=subprocess.PIPE,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
            )
            time.sleep(0.3)
            inside.unlink()
            inside.symlink_to(outside)
            stdout, stderr = process.communicate("y\n", timeout=10)
            self.assertNotEqual(process.returncode, 0, stdout + stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "outside\n")

    @unittest.skipIf(os.name == "nt", "POSIX hard-link fixture")
    def test_memory_patch_replaces_hardlink_without_modifying_outside_inode(self) -> None:
        for implementation in ("bash", "pwsh"):
            if implementation == "pwsh" and not shutil.which("pwsh"):
                continue
            with self.subTest(implementation=implementation), tempfile.TemporaryDirectory() as tmp:
                base = Path(tmp)
                target = base / "target"
                target.mkdir()
                outside = base / "outside.md"
                outside.write_text("outside\n", encoding="utf-8")
                inside = target / "AGENTS.md"
                os.link(outside, inside)
                patch = base / "patch.md"
                patch.write_text("### Target: AGENTS.md\n\n+++ appended\n", encoding="utf-8")
                if implementation == "bash":
                    result = run("bash", str(SCRIPTS / "check-homogeneity.sh"), "--apply-patch", str(patch), "--yes", str(target))
                else:
                    result = run("pwsh", "-NoProfile", "-File", str(SCRIPTS / "check-homogeneity.ps1"),
                                 "-TargetDir", str(target), "-ApplyPatch", str(patch), "-Yes")
                self.assertEqual(outside.read_text(encoding="utf-8"), "outside\n")
                if implementation == "pwsh":
                    self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                    self.assertEqual(inside.stat().st_ino, outside.stat().st_ino)
                else:
                    self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
                    self.assertEqual(inside.read_text(encoding="utf-8"), "outside\nappended\n")
                    self.assertNotEqual(inside.stat().st_ino, outside.stat().st_ino)

                inside.unlink()
                inside.write_text("inside\n", encoding="utf-8")
                if implementation == "bash":
                    control = run("bash", str(SCRIPTS / "check-homogeneity.sh"), "--apply-patch", str(patch), "--yes", str(target))
                else:
                    control = run("pwsh", "-NoProfile", "-File", str(SCRIPTS / "check-homogeneity.ps1"),
                                  "-TargetDir", str(target), "-ApplyPatch", str(patch), "-Yes")
                self.assertEqual(control.returncode, 0, control.stdout + control.stderr)
                self.assertEqual(inside.read_text(encoding="utf-8"), "inside\nappended\n")

    def test_teardown_rejects_deceptive_remote_before_deletion(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fake_home = Path(tmp)
            workspace = fake_home / "Workspace"
            workspace.mkdir()
            subprocess.run(["git", "init", "-q", str(workspace)], check=True)
            subprocess.run(
                ["git", "-C", str(workspace), "remote", "add", "origin", "https://attacker.example/github.com/victim/repo.git"],
                check=True,
            )
            env = os.environ.copy()
            env["HOME"] = str(fake_home)
            result = run(
                "bash",
                str(SCRIPTS / "teardown-workspace.sh"),
                "Workspace",
                "--force",
                "--yes",
                env=env,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertTrue(workspace.is_dir())

    def test_teardown_accepts_exact_confirmed_github_remote(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fake_home = Path(tmp)
            workspace = fake_home / "Workspace"
            binaries = fake_home / "bin"
            marker = fake_home / "gh-called"
            workspace.mkdir()
            binaries.mkdir()
            subprocess.run(["git", "init", "-q", str(workspace)], check=True)
            subprocess.run(
                ["git", "-C", str(workspace), "remote", "add", "origin", "https://github.com/owner/repo.git"],
                check=True,
            )
            gh_stub = binaries / "gh"
            gh_stub.write_text(
                '#!/usr/bin/env bash\nprintf "%s|%s\\n" "${GH_HOST-}" "$*" > "$GH_MARKER"\n',
                encoding="utf-8",
            )
            gh_stub.chmod(0o755)
            env = os.environ.copy()
            env["HOME"] = str(fake_home)
            env["PATH"] = f"{binaries}:{env['PATH']}"
            env["GH_MARKER"] = str(marker)
            env["GH_HOST"] = "attacker.example"
            result = subprocess.run(
                ["bash", str(SCRIPTS / "teardown-workspace.sh"), "Workspace", "--force"],
                cwd=ROOT,
                env=env,
                input="y\ngithub.com/owner/repo\n",
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=False,
            )
            self.assertTrue(marker.is_file(), result.stdout + result.stderr)
            self.assertEqual(marker.read_text(encoding="utf-8").strip(), "github.com|repo delete owner/repo --yes")
            self.assertFalse(workspace.exists())

    def test_teardown_accepts_noninteractive_bound_remote(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fake_home = Path(tmp)
            workspace = fake_home / "Workspace"
            binaries = fake_home / "bin"
            marker = fake_home / "gh-called"
            workspace.mkdir()
            binaries.mkdir()
            subprocess.run(["git", "init", "-q", str(workspace)], check=True)
            subprocess.run(
                ["git", "-C", str(workspace), "remote", "add", "origin", "https://github.com/owner/repo.git"],
                check=True,
            )
            gh_stub = binaries / "gh"
            gh_stub.write_text(
                '#!/usr/bin/env bash\nprintf "%s|%s\\n" "${GH_HOST-}" "$*" > "$GH_MARKER"\n',
                encoding="utf-8",
            )
            gh_stub.chmod(0o755)
            env = os.environ.copy()
            env["HOME"] = str(fake_home)
            env["PATH"] = f"{binaries}:{env['PATH']}"
            env["GH_MARKER"] = str(marker)
            env["GH_HOST"] = "attacker.example"
            result = run(
                "bash",
                str(SCRIPTS / "teardown-workspace.sh"),
                "Workspace",
                "--force",
                "--yes",
                "--expected-remote",
                "github.com/owner/repo",
                env=env,
            )
            self.assertTrue(marker.is_file(), result.stdout + result.stderr)
            self.assertEqual(marker.read_text(encoding="utf-8").strip(), "github.com|repo delete owner/repo --yes")
            self.assertFalse(workspace.exists())

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_teardown_binds_github_cli_host(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fake_home = Path(tmp)
            workspace = fake_home / "Workspace"
            binaries = fake_home / "bin"
            marker = fake_home / "gh-called"
            workspace.mkdir()
            binaries.mkdir()
            subprocess.run(["git", "init", "-q", str(workspace)], check=True)
            subprocess.run(
                ["git", "-C", str(workspace), "remote", "add", "origin", "https://github.com/owner/repo.git"],
                check=True,
            )
            gh_stub = binaries / "gh"
            gh_stub.write_text(
                '#!/usr/bin/env bash\nprintf "%s|%s\\n" "${GH_HOST-}" "$*" > "$GH_MARKER"\n',
                encoding="utf-8",
            )
            gh_stub.chmod(0o755)
            env = os.environ.copy()
            env.update({
                "HOME": str(fake_home),
                "PATH": f"{binaries}:{env['PATH']}",
                "GH_MARKER": str(marker),
                "GH_HOST": "attacker.example",
            })
            result = run(
                "pwsh", "-NoProfile", "-File", str(SCRIPTS / "teardown-workspace.ps1"),
                "-WorkspaceName", "Workspace", "-Force", "-Yes",
                "-ExpectedRemoteTarget", "github.com/owner/repo", env=env,
            )
            self.assertIn(result.returncode, (0, 1), result.stdout + result.stderr)
            self.assertEqual(marker.read_text(encoding="utf-8").strip(), "github.com|repo delete owner/repo --yes")
            self.assertFalse(workspace.exists())

    def test_powershell_teardown_rejects_deceptive_remote(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fake_home = Path(tmp)
            workspace = fake_home / "Workspace"
            workspace.mkdir()
            subprocess.run(["git", "init", "-q", str(workspace)], check=True)
            subprocess.run(
                ["git", "-C", str(workspace), "remote", "add", "origin", "https://attacker.example/github.com/victim/repo.git"],
                check=True,
            )
            env = os.environ.copy()
            env["HOME"] = str(fake_home)
            result = run(
                "pwsh",
                "-NoProfile",
                "-File",
                str(SCRIPTS / "teardown-workspace.ps1"),
                "-WorkspaceName",
                "Workspace",
                "-Force",
                "-Yes",
                env=env,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertTrue(workspace.is_dir())

    def test_requested_backup_failure_stops_teardown(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fake_home = Path(tmp)
            workspace = fake_home / "Workspace"
            binaries = fake_home / "bin"
            workspace.mkdir()
            binaries.mkdir()
            subprocess.run(["git", "init", "-q", str(workspace)], check=True)
            tar_stub = binaries / "tar"
            tar_stub.write_text("#!/usr/bin/env bash\nexit 9\n", encoding="utf-8")
            tar_stub.chmod(0o755)
            env = os.environ.copy()
            env["HOME"] = str(fake_home)
            env["PATH"] = f"{binaries}:{env['PATH']}"
            result = run(
                "bash",
                str(SCRIPTS / "teardown-workspace.sh"),
                "Workspace",
                "--backup",
                "--keep-remote",
                "--force",
                "--yes",
                env=env,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertTrue(workspace.is_dir())

            tar_stub.write_text("#!/usr/bin/env bash\nexit 0\n", encoding="utf-8")
            false_success = run(
                "bash",
                str(SCRIPTS / "teardown-workspace.sh"),
                "Workspace",
                "--backup",
                "--keep-remote",
                "--force",
                "--yes",
                env=env,
            )
            self.assertNotEqual(false_success.returncode, 0, false_success.stdout + false_success.stderr)

    def test_teardown_blocks_when_git_status_cannot_be_verified(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fake_home = Path(tmp)
            workspace = fake_home / "Workspace"
            binaries = fake_home / "bin"
            workspace.mkdir()
            binaries.mkdir()
            subprocess.run(["git", "init", "-q", str(workspace)], check=True)
            real_git = shutil.which("git")
            self.assertIsNotNone(real_git)
            git_stub = binaries / "git"
            git_stub.write_text(
                "#!/usr/bin/env bash\n"
                "for arg in \"$@\"; do\n"
                "  if [ \"$arg\" = status ]; then exit 9; fi\n"
                "done\n"
                f"exec {real_git!s} \"$@\"\n",
                encoding="utf-8",
            )
            git_stub.chmod(0o755)
            env = {**os.environ, "HOME": str(fake_home), "PATH": f"{binaries}:{os.environ['PATH']}"}
            commands = [
                ["bash", str(SCRIPTS / "teardown-workspace.sh"), "Workspace", "--keep-remote", "--yes"],
            ]
            if shutil.which("pwsh"):
                commands.append([
                    "pwsh", "-NoProfile", "-File", str(SCRIPTS / "teardown-workspace.ps1"),
                    "-WorkspaceName", "Workspace", "-KeepRemote", "-Yes",
                ])
            for command in commands:
                with self.subTest(command=command[0]):
                    result = run(*command, env=env)
                    self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                    self.assertTrue(workspace.is_dir())
                    self.assertIn("git-status", (result.stdout + result.stderr).lower())

    def test_forgejo_failed_credential_lookup_clears_prior_token_and_stops(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            marker = Path(tmp) / "api-called"
            script = f'''
source "{SCRIPTS / "lib/hg-forgejo.sh"}"
HB_FORGEJO_USERNAME=old-user
HB_FORGEJO_TOKEN=old-token
hb_forgejo_require_tools() {{ :; }}
git() {{
  if [ "$1 $2 $3" = "config --get-all credential.helper" ]; then printf 'helper\\n'; return 0; fi
  if [ "$1 $2" = "credential fill" ]; then return 9; fi
  return 0
}}
hb_forgejo_api_request() {{ touch "{marker}"; }}
if hb_forgejo_delete_repository https://forge.example owner repo; then exit 8; fi
[ -z "$HB_FORGEJO_USERNAME" ] && [ -z "$HB_FORGEJO_TOKEN" ] && [ ! -e "{marker}" ]
'''
            result = run("bash", "-c", script)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_teardown_rejects_local_branch_as_push_evidence(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fake_home = Path(tmp)
            workspace = fake_home / "Workspace"
            subprocess.run(["git", "init", "-q", "-b", "main", str(workspace)], check=True)
            subprocess.run(["git", "-C", str(workspace), "config", "user.name", "Fixture"], check=True)
            subprocess.run(["git", "-C", str(workspace), "config", "user.email", "fixture@example.invalid"], check=True)
            (workspace / "README.md").write_text("local only\n", encoding="utf-8")
            subprocess.run(["git", "-C", str(workspace), "add", "README.md"], check=True)
            subprocess.run(["git", "-C", str(workspace), "commit", "-q", "-m", "local"], check=True)
            subprocess.run(["git", "-C", str(workspace), "branch", "local-upstream"], check=True)
            subprocess.run(
                ["git", "-C", str(workspace), "branch", "--set-upstream-to=local-upstream", "main"],
                check=True,
                stdout=subprocess.DEVNULL,
                stderr=subprocess.DEVNULL,
            )
            env = {**os.environ, "HOME": str(fake_home)}
            commands = [
                ["bash", str(SCRIPTS / "teardown-workspace.sh"), "Workspace", "--keep-remote", "--yes"],
            ]
            if shutil.which("pwsh"):
                commands.append([
                    "pwsh", "-NoProfile", "-File", str(SCRIPTS / "teardown-workspace.ps1"),
                    "-WorkspaceName", "Workspace", "-KeepRemote", "-Yes",
                ])
            for command in commands:
                with self.subTest(command=command[0]):
                    result = run(*command, env=env)
                    self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                    self.assertTrue(workspace.is_dir())
                    self.assertIn("origin", (result.stdout + result.stderr).lower())

    def test_forgejo_rejects_config_injection_url_before_curl(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            binaries = Path(tmp) / "bin"
            marker = Path(tmp) / "curl-called"
            binaries.mkdir()
            curl_stub = binaries / "curl"
            curl_stub.write_text(f'#!/usr/bin/env bash\ntouch "{marker}"\n', encoding="utf-8")
            curl_stub.chmod(0o755)
            script = f'''
source "{SCRIPTS / "lib/hg-forgejo.sh"}"
HB_FORGEJO_TOKEN=secret
hb_forgejo_api_request DELETE $'https://forge.example\\nurl = "https://attacker.invalid"' /api/v1/repos/a/b
'''
            env = {**os.environ, "PATH": f"{binaries}:{os.environ['PATH']}"}
            result = run("bash", "-c", script, env=env)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(marker.exists())

    def test_learning_source_symlink_is_rejected_before_propagation(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fixture = Path(tmp)
            script_dir = fixture / "scripts"
            units = fixture / "docs" / "learning-units"
            script_dir.mkdir()
            (script_dir / "lib").mkdir()
            units.mkdir(parents=True)
            shutil.copy2(SCRIPTS / "propagate-learning-series.sh", script_dir)
            shutil.copy2(
                SCRIPTS / "lib" / "secure-development-hardening.sh",
                script_dir / "lib",
            )
            outside = fixture / "private.md"
            outside.write_text("private\n", encoding="utf-8")
            (units / "Secure-CaseTracker.md").symlink_to(outside)
            registry = fixture / "registry.json"
            registry.write_text('{"repositories": []}\n', encoding="utf-8")
            result = run(
                "bash",
                str(script_dir / "propagate-learning-series.sh"),
                "--dry-run",
                "--registry",
                str(registry),
                "--home-dir",
                str(fixture),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("unsafe learning-series source", result.stderr)

    def test_learning_source_root_symlink_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            fixture = Path(tmp)
            script_dir = fixture / "scripts"
            docs = fixture / "docs"
            outside = fixture / "outside-units"
            script_dir.mkdir()
            (script_dir / "lib").mkdir()
            docs.mkdir()
            outside.mkdir()
            shutil.copy2(SCRIPTS / "propagate-learning-series.sh", script_dir)
            shutil.copy2(
                SCRIPTS / "lib" / "secure-development-hardening.sh",
                script_dir / "lib",
            )
            for name in (
                "START-HERE-FUER-LERNENDE.md",
                "GIT-START-FUER-LERNENDE.md",
                "INSTITUTIONELLES-GIT-HOSTING.md",
            ):
                (outside / name).write_text("external\n", encoding="utf-8")
            (docs / "learning-units").symlink_to(outside, target_is_directory=True)
            registry = fixture / "registry.json"
            registry.write_text('{"repositories": []}\n', encoding="utf-8")
            result = run(
                "bash",
                str(script_dir / "propagate-learning-series.sh"),
                "--shared-guides-only",
                "--dry-run",
                "--registry",
                str(registry),
                "--home-dir",
                str(fixture),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("canonical learning-series source", result.stderr)

    def test_permission_and_trusted_renderer_contracts_are_present(self) -> None:
        bash_bootstrap = (SCRIPTS / "bootstrap-project.sh").read_text(encoding="utf-8")
        ps_bootstrap = (SCRIPTS / "bootstrap-project.ps1").read_text(encoding="utf-8")
        self.assertIn("default_workflow_permissions=read", bash_bootstrap)
        self.assertIn("can_approve_pull_request_reviews=false", bash_bootstrap)
        self.assertIn("default_workflow_permissions=read", ps_bootstrap)
        self.assertIn("can_approve_pull_request_reviews=false", ps_bootstrap)
        self.assertIn("permissions:\n  contents: read", bash_bootstrap)
        self.assertIn("permissions:\n  contents: read", ps_bootstrap)

        bash_homogeneity = (SCRIPTS / "check-homogeneity.sh").read_text(encoding="utf-8")
        ps_homogeneity = (SCRIPTS / "check-homogeneity.ps1").read_text(encoding="utf-8")
        self.assertIn('renderer="${SCRIPT_DIR}/render-project-statistics.sh"', bash_homogeneity)
        self.assertIn("$renderer = Join-Path $ScriptDir 'render-project-statistics.ps1'", ps_homogeneity)

    def test_homogeneity_scan_does_not_execute_target_renderer(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            target = Path(tmp)
            (target / "docs").mkdir()
            (target / "scripts").mkdir()
            (target / "docs" / "project-statistics.md").write_text("# Stats\n", encoding="utf-8")
            (target / "docs" / "project-statistics.config.json").write_text("{}\n", encoding="utf-8")
            marker = target / "target-renderer-executed"
            renderer = target / "scripts" / "render-project-statistics.sh"
            renderer.write_text(f"#!/usr/bin/env bash\ntouch {marker}\n", encoding="utf-8")
            renderer.chmod(0o755)
            run(
                "bash",
                str(SCRIPTS / "check-homogeneity.sh"),
                "--dry-run",
                "--no-patch",
                str(target),
            )
            self.assertFalse(marker.exists())

    def test_document_builder_validates_metadata_before_literal_rendering(self) -> None:
        script = (SCRIPTS / "build-secure-development-docs.sh").read_text(encoding="utf-8")
        self.assertIn('test("^[0-9]+\\\\.[0-9]+\\\\.[0-9]+$")', script)
        self.assertIn('ENVIRON["HB_RELEASE_DATE"]', script)
        self.assertNotIn('s/{{RELEASE_DATE}}/$release_date/g', script)

        with tempfile.TemporaryDirectory() as tmp:
            fixture = Path(tmp)
            (fixture / "scripts" / "templates").mkdir(parents=True)
            (fixture / "scripts" / "config").mkdir(parents=True)
            shutil.copy2(SCRIPTS / "build-secure-development-docs.sh", fixture / "scripts")
            shutil.copy2(
                SCRIPTS / "templates" / "secure-development-compendium-header.md",
                fixture / "scripts" / "templates",
            )
            shutil.copy2(
                SCRIPTS / "config" / "spec-kit-preset-profiles.json",
                fixture / "scripts" / "config",
            )
            shutil.copytree(ROOT / "docs" / "secure-development", fixture / "docs" / "secure-development")
            manifest_path = fixture / "docs" / "secure-development" / "baseline-manifest.json"
            manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
            marker = fixture / "metadata-executed"
            manifest["releaseDate"] = f"2026-01-01/e touch {marker}"
            manifest_path.write_text(json.dumps(manifest), encoding="utf-8")
            result = subprocess.run(
                ["bash", str(fixture / "scripts" / "build-secure-development-docs.sh"), "--check"],
                cwd=fixture,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=False,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(marker.exists())

    def test_spec_kit_cleanup_rejects_linked_gemini_parent(self) -> None:
        bash_script = (SCRIPTS / "update-spec-kit.sh").read_text(encoding="utf-8")
        ps_script = (SCRIPTS / "update-spec-kit.ps1").read_text(encoding="utf-8")
        self.assertIn('[ -L "$repo/.gemini" ]', bash_script)
        self.assertIn("$item.LinkType", ps_script)

        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repo = base / "repo"
            outside = base / "outside"
            repo.mkdir()
            outside.mkdir()
            sentinel = outside / "commands" / "sentinel"
            sentinel.parent.mkdir()
            sentinel.write_text("keep\n", encoding="utf-8")
            (repo / ".gemini").symlink_to(outside, target_is_directory=True)

            bash_result = run(
                "bash",
                "-c",
                """
source <(sed -n '/^remove_legacy_gemini_integration()/,/^}/p' "$1")
OPT_DRY_RUN=false
log() { :; }
remove_legacy_gemini_integration "$2"
""",
                "security-test",
                str(SCRIPTS / "update-spec-kit.sh"),
                str(repo),
            )
            self.assertNotEqual(bash_result.returncode, 0, bash_result.stdout + bash_result.stderr)
            self.assertTrue(sentinel.is_file())

            ps_result = run(
                "pwsh",
                "-NoProfile",
                "-Command",
                """
$tokens = $null
$errors = $null
$ast = [Management.Automation.Language.Parser]::ParseFile($args[0], [ref]$tokens, [ref]$errors)
$functionAst = $ast.Find({ param($node) $node -is [Management.Automation.Language.FunctionDefinitionAst] -and $node.Name -eq 'Remove-HBLegacyGeminiIntegration' }, $true)
. ([scriptblock]::Create($functionAst.Extent.Text))
Remove-HBLegacyGeminiIntegration -Repo $args[1]
""",
                str(SCRIPTS / "update-spec-kit.ps1"),
                str(repo),
            )
            self.assertNotEqual(ps_result.returncode, 0, ps_result.stdout + ps_result.stderr)
            self.assertTrue(sentinel.is_file())

    def test_spec_kit_discovery_rejects_linked_repository(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home = base / "home"
            outside = base / "outside-repo"
            home.mkdir()
            (outside / ".git").mkdir(parents=True)
            (outside / ".specify/templates").mkdir(parents=True)
            (home / "LinkedRepo").symlink_to(outside, target_is_directory=True)
            commands = [
                ["bash", str(SCRIPTS / "update-spec-kit.sh"), "--home-dir", str(home), "--dry-run"],
            ]
            if shutil.which("pwsh"):
                commands.append([
                    "pwsh", "-NoProfile", "-File", str(SCRIPTS / "update-spec-kit.ps1"),
                    "-HomeDir", str(home), "-WhatIf",
                ])
            for command in commands:
                with self.subTest(command=command[0]):
                    result = run(*command)
                    self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                    self.assertIn("link", (result.stdout + result.stderr).lower())

    def test_spec_kit_update_rejects_linked_template_destination(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            home = base / "home"
            repo = home / "Workspace"
            outside = base / "outside-template.md"
            (repo / ".git").mkdir(parents=True)
            (repo / ".specify/templates").mkdir(parents=True)
            outside.write_text("keep\n", encoding="utf-8")
            (repo / ".specify/templates/extra.md").symlink_to(outside)
            commands = [
                ["bash", str(SCRIPTS / "update-spec-kit.sh"), "--home-dir", str(home), "--dry-run"],
            ]
            if shutil.which("pwsh"):
                commands.append([
                    "pwsh", "-NoProfile", "-File", str(SCRIPTS / "update-spec-kit.ps1"),
                    "-HomeDir", str(home), "-WhatIf",
                ])
            for command in commands:
                with self.subTest(command=command[0]):
                    result = run(*command)
                    self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
                    self.assertEqual(outside.read_text(encoding="utf-8"), "keep\n")

    def test_linked_intake_fixture_paths_stay_inside_temporary_root(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "fixture"
            root.mkdir()
            bash_result = run(
                "bash", "-c",
                "source <(sed -n '/^resolve_fixture_output_path()/,/^}/p' \"$1\"); "
                "resolve_fixture_output_path \"$2\" ../outside.md",
                "security-test", str(SCRIPTS / "test-requirements-intake-governance.sh"), str(root),
            )
            self.assertNotEqual(bash_result.returncode, 0, bash_result.stdout + bash_result.stderr)
            if shutil.which("pwsh"):
                ps_result = run(
                    "pwsh", "-NoProfile", "-Command",
                    "$tokens=$null;$errors=$null;"
                    "$ast=[Management.Automation.Language.Parser]::ParseFile($args[0],[ref]$tokens,[ref]$errors);"
                    "$fn=$ast.Find({param($n) $n -is [Management.Automation.Language.FunctionDefinitionAst] "
                    "-and $n.Name -eq 'Resolve-HBFixtureOutputPath'},$true);"
                    ". ([scriptblock]::Create($fn.Extent.Text));"
                    "Resolve-HBFixtureOutputPath -Root $args[1] -RelativePath '../outside.md'",
                    str(SCRIPTS / "test-requirements-intake-governance.ps1"), str(root),
                )
                self.assertNotEqual(ps_result.returncode, 0, ps_result.stdout + ps_result.stderr)
            self.assertFalse((Path(tmp) / "outside.md").exists())

    def test_prepare_commit_excludes_unrelated_staged_files(self) -> None:
        prepare_scripts = (
            "prepare-secure-development-hardening.sh",
            "prepare-secure-development-hardening.ps1",
            "prepare-rl-se-checklist-selbstpruefung.sh",
            "prepare-rl-se-checklist-selbstpruefung.ps1",
        )
        for name in prepare_scripts:
            with self.subTest(script=name):
                self.assertIn("commit --only", (SCRIPTS / name).read_text(encoding="utf-8"))

        with tempfile.TemporaryDirectory() as tmp:
            repo = Path(tmp) / "repo"
            subprocess.run(["git", "init", "-q", "-b", "main", str(repo)], check=True)
            subprocess.run(["git", "-C", str(repo), "config", "user.name", "Fixture"], check=True)
            subprocess.run(["git", "-C", str(repo), "config", "user.email", "fixture@example.invalid"], check=True)
            managed = (
                repo / "docs/secure-development/baseline.md",
                repo / "Lastenheft_Secure-Development-Hardening.md",
                repo / "Lastenheft_Abarbeitungsreihenfolge.md",
            )
            for path in managed:
                path.parent.mkdir(parents=True, exist_ok=True)
                path.write_text("base\n", encoding="utf-8")
            unrelated = repo / "secret-marker.txt"
            unrelated.write_text("base\n", encoding="utf-8")
            subprocess.run(["git", "-C", str(repo), "add", "."], check=True)
            subprocess.run(["git", "-C", str(repo), "commit", "-q", "-m", "base"], check=True)
            managed[0].write_text("managed change\n", encoding="utf-8")
            unrelated.write_text("must remain staged\n", encoding="utf-8")
            subprocess.run(["git", "-C", str(repo), "add", "secret-marker.txt"], check=True)
            result = run(
                "bash", "-c",
                "eval \"$(sed -n '/^commit_and_push()/,/^}/p' \"$1\")\"; "
                "OPT_COMMIT=true; OPT_PUSH=false; OPT_DRY_RUN=false; log(){ :; }; "
                "commit_and_push \"$2\"",
                "security-test", str(SCRIPTS / "prepare-secure-development-hardening.sh"), str(repo),
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            committed = subprocess.check_output(
                ["git", "-C", str(repo), "show", "--pretty=", "--name-only", "HEAD"], text=True
            ).splitlines()
            self.assertEqual(committed, ["docs/secure-development/baseline.md"])
            staged = subprocess.check_output(
                ["git", "-C", str(repo), "diff", "--cached", "--name-only"], text=True
            ).splitlines()
            self.assertEqual(staged, ["secret-marker.txt"])

    def test_compare_only_rejects_registry_selected_probe_command(self) -> None:
        if not shutil.which("pwsh"):
            self.skipTest("PowerShell 7 is required")
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            registry = json.loads(
                (SCRIPTS / "config/required-cli-tools-registry.json").read_text(encoding="utf-8")
            )
            marker = base / "probe-executed"
            registry["mslToolchains"][0]["command"] = "bash"
            registry["mslToolchains"][0]["args"] = ["-c", f"touch {marker}"]
            altered = base / "required-cli-tools.json"
            altered.write_text(json.dumps(registry), encoding="utf-8")
            result = run(
                "pwsh", "-NoProfile", "-File", str(SCRIPTS / "lib/invoke-msl-toolchains.ps1"),
                "-Registry", str(altered),
                "-PackageRegistry", str(SCRIPTS / "config/brew-apps-registry.json"),
                "-CompareOnly",
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(marker.exists())
            self.assertIn("MSL-Vertrag ungueltig", result.stdout)

    def test_windows_compare_only_rejects_non_specify_registry_probe(self) -> None:
        if not shutil.which("pwsh"):
            self.skipTest("PowerShell 7 is required")
        with tempfile.TemporaryDirectory() as tmp:
            fixture = Path(tmp) / "fixture"
            shutil.copytree(SCRIPTS, fixture / "scripts")
            registry_path = fixture / "scripts/config/required-cli-tools-registry.json"
            registry = json.loads(registry_path.read_text(encoding="utf-8"))
            marker = Path(tmp) / "windows-probe-executed"
            pandoc = next(tool for tool in registry["tools"] if tool["id"] == "pandoc")
            pandoc["command"] = "pwsh"
            pandoc["args"] = ["-NoProfile", "-Command", f"New-Item -Path '{marker}' -ItemType File"]
            registry_path.write_text(json.dumps(registry), encoding="utf-8")
            result = run(
                "pwsh", "-NoProfile", "-File",
                str(fixture / "scripts/maintain-agentic-winget-apps.ps1"),
                "-Registry", str(fixture / "scripts/config/winget-apps-registry.json"),
                "-NpmAgentRegistry", str(fixture / "scripts/config/npm-agent-cli-registry.json"),
                "-PowerShellModuleRegistry",
                str(fixture / "scripts/config/powershell-modules-registry.json"),
                "-SkipVSCodeExtensions", "-CompareOnly",
            )
            output = result.stdout + result.stderr
            self.assertNotEqual(result.returncode, 0, output)
            self.assertFalse(marker.exists())
            self.assertIn("CLI-Probe ist nicht durch die Code-Policy autorisiert", output)

    def test_private_logs_and_identity_sources_are_fail_closed(self) -> None:
        maintainer = (SCRIPTS / "maintain-agentic-workspace.sh").read_text(encoding="utf-8")
        identity = (SCRIPTS / "setup-git-identity.sh").read_text(encoding="utf-8")
        identity_ps = (SCRIPTS / "setup-git-identity.ps1").read_text(encoding="utf-8")
        self.assertIn("umask 077", maintainer)
        self.assertIn('set -o noclobber; : > "$LOG_FILE"', maintainer)
        self.assertIn('chmod 600 "$LOG_FILE"', maintainer)
        self.assertNotIn("git -C ~ log --format=", identity)
        self.assertNotIn("git -C ~ log --format=", identity_ps)
        self.assertIn("Commit authors are untrusted repository content", identity_ps)


if __name__ == "__main__":
    unittest.main()
