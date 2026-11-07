#!/usr/bin/env python3
"""Focused regression tests for bootstrap path and link confinement."""

from __future__ import annotations

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


REPO_ROOT = Path(__file__).resolve().parents[2]
WORKSPACE_SH = REPO_ROOT / "scripts/bootstrap-workspace.sh"
WORKSPACE_PS1 = REPO_ROOT / "scripts/bootstrap-workspace.ps1"
PROJECT_SH = REPO_ROOT / "scripts/bootstrap-project.sh"
PROJECT_PS1 = REPO_ROOT / "scripts/bootstrap-project.ps1"
FORGEJO_SH = REPO_ROOT / "scripts/lib/hg-forgejo.sh"
FORGEJO_PS1 = REPO_ROOT / "scripts/lib/hg-forgejo.ps1"


class BootstrapPathSecurityTests(unittest.TestCase):
    def run_command(
        self,
        command: list[str],
        *,
        home: Path,
        timeout: int = 20,
        extra_env: dict[str, str] | None = None,
    ) -> subprocess.CompletedProcess[str]:
        env = os.environ.copy()
        env["HOME"] = str(home)
        env["USERPROFILE"] = str(home)
        env["GIT_AUTHOR_NAME"] = "Bootstrap Test"
        env["GIT_AUTHOR_EMAIL"] = "bootstrap@example.invalid"
        env["GIT_COMMITTER_NAME"] = "Bootstrap Test"
        env["GIT_COMMITTER_EMAIL"] = "bootstrap@example.invalid"
        if extra_env:
            env.update(extra_env)
        return subprocess.run(
            command,
            cwd=REPO_ROOT,
            env=env,
            text=True,
            stdout=subprocess.PIPE,
            stderr=subprocess.STDOUT,
            check=False,
            timeout=timeout,
        )

    def test_workspace_rejects_path_component_name(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            result = self.run_command(
                ["bash", str(WORKSPACE_SH), "--dry-run", "../outside"],
                home=Path(temporary),
            )
        self.assertNotEqual(result.returncode, 0, result.stdout)
        self.assertIn("einzelner sicherer Verzeichnisname", result.stdout)

    def test_project_rejects_path_component_name(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            result = self.run_command(
                ["bash", str(PROJECT_SH), "../outside", temporary, "--preview", "--no-speckit"],
                home=Path(temporary),
            )
        self.assertEqual(result.returncode, 2, result.stdout)
        self.assertIn("one safe path component", result.stdout)

    def test_bash_variants_reject_newline_names(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            workspace_result = self.run_command(
                ["bash", str(WORKSPACE_SH), "--dry-run", "Safe\nInjected"],
                home=home,
            )
            project_result = self.run_command(
                ["bash", str(PROJECT_SH), "Safe\nInjected", str(home), "--preview", "--no-speckit"],
                home=home,
            )
        self.assertNotEqual(workspace_result.returncode, 0, workspace_result.stdout)
        self.assertNotEqual(project_result.returncode, 0, project_result.stdout)
        self.assertIn("Steuerzeichen", workspace_result.stdout)
        self.assertIn("control characters", project_result.stdout)

    def test_project_rejects_symlink_target(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            workspace = home / "workspace"
            outside = home / "outside"
            workspace.mkdir()
            outside.mkdir()
            (workspace / "Example").symlink_to(outside, target_is_directory=True)
            result = self.run_command(
                ["bash", str(PROJECT_SH), "Example", str(workspace), "--preview", "--no-speckit"],
                home=home,
            )
        self.assertEqual(result.returncode, 2, result.stdout)
        self.assertIn("untrusted symbolic link", result.stdout)

    def test_home_readme_symlink_is_rejected_before_bootstrap_writes(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            workspace = home / "Workspace"
            workspace.mkdir()
            outside = home / "outside.md"
            outside.write_text("sentinel\n", encoding="utf-8")
            (home / "README.md").symlink_to(outside)

            workspace_result = self.run_command(
                ["bash", str(WORKSPACE_SH), "--dry-run", "--no-remote", "Workspace"],
                home=home,
            )
            project_result = self.run_command(
                ["bash", str(PROJECT_SH), "Example", str(workspace), "--preview", "--no-speckit"],
                home=home,
            )

            self.assertNotEqual(workspace_result.returncode, 0, workspace_result.stdout)
            self.assertNotEqual(project_result.returncode, 0, project_result.stdout)
            self.assertEqual(outside.read_text(encoding="utf-8"), "sentinel\n")

    def test_project_commit_excludes_preexisting_private_file_and_target_renderer(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            (home / "constitution.md").write_text("# Constitution v1.0.0\n", encoding="utf-8")
            workspace = home / "workspace"
            target = workspace / "Example"
            target_scripts = target / "scripts"
            target_scripts.mkdir(parents=True)
            (target / "private.txt").write_text("do not publish\n", encoding="utf-8")
            (target_scripts / "private.txt").write_text("do not publish\n", encoding="utf-8")
            outside_marker = home / "renderer-ran"
            hostile_renderer = target_scripts / "render-project-statistics.sh"
            hostile_renderer.write_text(
                f"#!/usr/bin/env bash\nprintf ran > {outside_marker!s}\n",
                encoding="utf-8",
            )
            hostile_renderer.chmod(0o755)
            subprocess.run(["git", "init", "-q", str(target)], check=True)
            commit_hook_marker = home / "post-commit-ran"
            post_commit = target / ".git/hooks/post-commit"
            post_commit.write_text(
                f"#!/usr/bin/env bash\nprintf ran > {commit_hook_marker!s}\n",
                encoding="utf-8",
            )
            post_commit.chmod(0o755)

            result = self.run_command(
                [
                    "bash",
                    str(PROJECT_SH),
                    "Example",
                    str(workspace),
                    "--no-remote",
                    "--no-speckit",
                    "--no-agents",
                    "--no-release-please",
                    "--force",
                ],
                home=home,
                # This fixture intentionally runs the complete secure bootstrap,
                # including hook installation and the staged secret scan. Hosted
                # macOS runners can need more than 40 seconds under parallel load.
                timeout=90,
            )

            self.assertIn(result.returncode, (0, 1), result.stdout)
            tracked = subprocess.run(
                ["git", "-C", str(target), "ls-files"],
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=True,
            ).stdout.splitlines()
            self.assertNotIn("private.txt", tracked)
            self.assertNotIn("scripts/private.txt", tracked)
            self.assertFalse(outside_marker.exists(), result.stdout)
            self.assertFalse(commit_hook_marker.exists(), result.stdout)
            source_hook = REPO_ROOT / "scripts/hooks/pre-push"
            installed_hook = target / ".git/home-baseline-hooks/pre-push"
            self.assertEqual(source_hook.read_bytes(), installed_hook.read_bytes())
            self.assertTrue(os.access(installed_hook, os.X_OK))
            hooks_path = subprocess.run(
                ["git", "-C", str(target), "config", "--path", "core.hooksPath"],
                text=True,
                stdout=subprocess.PIPE,
                check=True,
            ).stdout.strip()
            self.assertEqual(hooks_path, str(target.resolve() / ".git/home-baseline-hooks"))

    def test_failed_gitleaks_scan_blocks_remote_creation(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            (home / "constitution.md").write_text("# Constitution v1.0.0\n", encoding="utf-8")
            workspace = home / "workspace"
            workspace.mkdir()
            fake_bin = home / "bin"
            fake_bin.mkdir()
            remote_marker = home / "gh-called"
            gitleaks = fake_bin / "gitleaks"
            gitleaks.write_text(
                "#!/usr/bin/env bash\n"
                "for arg in \"$@\"; do [ \"$arg\" = \"--staged\" ] && exit 2; done\n"
                "exit 0\n",
                encoding="utf-8",
            )
            gitleaks.chmod(0o755)
            gh = fake_bin / "gh"
            gh.write_text(
                f"#!/usr/bin/env bash\nprintf called > {remote_marker!s}\nexit 0\n",
                encoding="utf-8",
            )
            gh.chmod(0o755)

            result = self.run_command(
                [
                    "bash",
                    str(PROJECT_SH),
                    "Example",
                    str(workspace),
                    "--no-speckit",
                    "--no-agents",
                    "--no-release-please",
                ],
                home=home,
                timeout=40,
                extra_env={"PATH": f"{fake_bin}{os.pathsep}{os.environ['PATH']}"},
            )

            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertFalse(remote_marker.exists(), result.stdout)

    def test_workspace_bootstrap_preserves_ignores_and_disables_template_hooks(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            workspace = home / "Workspace"
            workspace.mkdir()
            (workspace / "private.txt").write_text("do not publish\n", encoding="utf-8")
            (workspace / ".gitignore").write_text("private.txt\n", encoding="utf-8")
            template_hooks = home / "git-template/hooks"
            template_hooks.mkdir(parents=True)
            hook_marker = home / "template-hook-ran"
            post_commit = template_hooks / "post-commit"
            post_commit.write_text(
                f"#!/usr/bin/env bash\nprintf ran > {hook_marker!s}\n",
                encoding="utf-8",
            )
            post_commit.chmod(0o755)
            (home / ".gitconfig").write_text(
                "[user]\n"
                "\tname = Bootstrap Test\n"
                "\temail = bootstrap@example.invalid\n"
                "[init]\n"
                f"\ttemplateDir = {template_hooks.parent!s}\n",
                encoding="utf-8",
            )

            result = self.run_command(
                ["bash", str(WORKSPACE_SH), "--no-remote", "Workspace"],
                home=home,
                timeout=60,
            )

            self.assertEqual(result.returncode, 0, result.stdout)
            tracked = subprocess.run(
                ["git", "-C", str(workspace), "ls-files"],
                text=True,
                stdout=subprocess.PIPE,
                check=True,
            ).stdout.splitlines()
            self.assertNotIn("private.txt", tracked)
            self.assertIn("private.txt", (workspace / ".gitignore").read_text(encoding="utf-8"))
            self.assertFalse(hook_marker.exists(), result.stdout)
            hooks_path = subprocess.run(
                ["git", "-C", str(workspace), "config", "--path", "core.hooksPath"],
                text=True,
                stdout=subprocess.PIPE,
                check=True,
            ).stdout.strip()
            self.assertEqual(hooks_path, str(workspace.resolve() / ".git/home-baseline-hooks"))

    def test_forged_existing_origin_is_rejected_before_github_api_or_push(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            (home / "constitution.md").write_text("# Constitution v1.0.0\n", encoding="utf-8")
            workspace = home / "workspace"
            target = workspace / "Example"
            target.mkdir(parents=True)
            subprocess.run(["git", "init", "-q", str(target)], check=True)
            subprocess.run(
                [
                    "git",
                    "-C",
                    str(target),
                    "remote",
                    "add",
                    "origin",
                    "https://attacker.example/github.com/victim/example.git",
                ],
                check=True,
            )
            fake_bin = home / "bin"
            fake_bin.mkdir()
            gitleaks = fake_bin / "gitleaks"
            gitleaks.write_text("#!/usr/bin/env bash\nexit 0\n", encoding="utf-8")
            gitleaks.chmod(0o755)
            gh_marker = home / "gh-called"
            gh = fake_bin / "gh"
            gh.write_text(
                f"#!/usr/bin/env bash\nprintf called > {gh_marker!s}\nexit 0\n",
                encoding="utf-8",
            )
            gh.chmod(0o755)

            result = self.run_command(
                [
                    "bash",
                    str(PROJECT_SH),
                    "Example",
                    str(workspace),
                    "--no-speckit",
                    "--no-agents",
                    "--no-release-please",
                ],
                home=home,
                timeout=60,
                extra_env={"PATH": f"{fake_bin}{os.pathsep}{os.environ['PATH']}"},
            )

            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertFalse(gh_marker.exists(), result.stdout)

    def test_existing_public_forgejo_repository_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            probe = home / "probe.sh"
            probe.write_text(
                f"""#!/usr/bin/env bash
source {FORGEJO_SH!s}
hb_forgejo_require_tools() {{ :; }}
hb_forgejo_get_credential() {{ :; }}
hb_forgejo_approve_credential() {{ :; }}
hb_forgejo_api_request() {{
  if [ \"$3\" = \"/api/v1/user\" ]; then
    HB_FORGEJO_HTTP_STATUS=200
    HB_FORGEJO_HTTP_BODY='{{\"login\":\"alice\"}}'
  else
    HB_FORGEJO_HTTP_STATUS=200
    HB_FORGEJO_HTTP_BODY='{{\"name\":\"example\",\"private\":false,\"owner\":{{\"login\":\"alice\"}},\"clone_url\":\"https://forge.example/alice/example.git\",\"html_url\":\"https://forge.example/alice/example\"}}'
  fi
}}
hb_forgejo_create_or_get_repository https://forge.example example test
""",
                encoding="utf-8",
            )
            result = self.run_command(["bash", str(probe)], home=home)
            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertIn("privatem authentifiziertem Ziel", result.stdout)

            if shutil.which("pwsh"):
                ps_probe = home / "probe.ps1"
                ps_probe.write_text(
                    f""". '{FORGEJO_PS1!s}'
function Get-HBForgejoCredential {{ param([string]$BaseUrl) return @{{ Username='alice'; Password='token' }} }}
function Approve-HBForgejoCredential {{ param([string]$BaseUrl, $AuthenticationData) }}
function Invoke-HBForgejoApi {{
  param([string]$Method,[string]$BaseUrl,[string]$Path,$AuthenticationData,[string]$Body='')
  if ($Path -eq '/api/v1/user') {{
    return [pscustomobject]@{{ StatusCode=200; Content='{{\"login\":\"alice\"}}' }}
  }}
  return [pscustomobject]@{{ StatusCode=200; Content='{{\"name\":\"example\",\"private\":false,\"owner\":{{\"login\":\"alice\"}},\"clone_url\":\"https://forge.example/alice/example.git\",\"html_url\":\"https://forge.example/alice/example\"}}' }}
}}
New-HBForgejoRepository -BaseUrl 'https://forge.example' -RepositoryName 'example'
""",
                    encoding="utf-8",
                )
                ps_result = self.run_command(
                    ["pwsh", "-NoProfile", "-File", str(ps_probe)], home=home
                )
                self.assertNotEqual(ps_result.returncode, 0, ps_result.stdout)
                self.assertIn("private authenticated target", ps_result.stdout)

    def test_forgejo_clone_url_must_match_authenticated_host_owner_and_path(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            response = '{"name":"example","private":true,"owner":{"login":"alice"},"clone_url":"https://attacker.example/alice/example.git?redirect=1","html_url":"https://forge.example/alice/example"}'
            probe = home / "probe.sh"
            probe.write_text(
                f"""#!/usr/bin/env bash
source {FORGEJO_SH!s}
hb_forgejo_require_tools() {{ :; }}
hb_forgejo_get_credential() {{ :; }}
hb_forgejo_approve_credential() {{ :; }}
hb_forgejo_api_request() {{
  if [ "$3" = "/api/v1/user" ]; then HB_FORGEJO_HTTP_STATUS=200; HB_FORGEJO_HTTP_BODY='{{"login":"alice"}}';
  else HB_FORGEJO_HTTP_STATUS=200; HB_FORGEJO_HTTP_BODY='{response}'; fi
}}
hb_forgejo_create_or_get_repository https://forge.example example test
""",
                encoding="utf-8",
            )
            result = self.run_command(["bash", str(probe)], home=home)
            self.assertNotEqual(result.returncode, 0, result.stdout)

            if shutil.which("pwsh"):
                ps_probe = home / "probe.ps1"
                ps_probe.write_text(
                    f""". '{FORGEJO_PS1!s}'
function Get-HBForgejoCredential {{ param([string]$BaseUrl) return @{{ Username='alice'; Password='token' }} }}
function Approve-HBForgejoCredential {{ param([string]$BaseUrl, $AuthenticationData) }}
function Invoke-HBForgejoApi {{
  param([string]$Method,[string]$BaseUrl,[string]$Path,$AuthenticationData,[string]$Body='')
  if ($Path -eq '/api/v1/user') {{ return [pscustomobject]@{{StatusCode=200;Content='{{"login":"alice"}}'}} }}
  return [pscustomobject]@{{StatusCode=200;Content='{response}'}}
}}
New-HBForgejoRepository -BaseUrl 'https://forge.example' -RepositoryName 'example'
""",
                    encoding="utf-8",
                )
                ps_result = self.run_command(["pwsh", "-NoProfile", "-File", str(ps_probe)], home=home)
                self.assertNotEqual(ps_result.returncode, 0, ps_result.stdout)

    def test_mismatched_pushurl_is_rejected_after_private_origin_validation(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            (home / "constitution.md").write_text("# Constitution v1.0.0\n", encoding="utf-8")
            workspace = home / "workspace"
            target = workspace / "Example"
            target.mkdir(parents=True)
            subprocess.run(["git", "init", "-q", str(target)], check=True)
            subprocess.run(
                ["git", "-C", str(target), "remote", "add", "origin", "https://github.com/testuser/example.git"],
                check=True,
            )
            subprocess.run(
                ["git", "-C", str(target), "remote", "set-url", "--push", "origin", "https://attacker.example/testuser/example.git"],
                check=True,
            )
            fake_bin = home / "bin"
            fake_bin.mkdir()
            gitleaks = fake_bin / "gitleaks"
            gitleaks.write_text("#!/usr/bin/env bash\nexit 0\n", encoding="utf-8")
            gitleaks.chmod(0o755)
            gh = fake_bin / "gh"
            gh.write_text(
                "#!/usr/bin/env bash\n"
                "case \"$*\" in\n"
                "  *'api user'*) printf 'testuser\\n' ;;\n"
                "  *) printf 'testuser\\texample\\ttrue\\n' ;;\n"
                "esac\n",
                encoding="utf-8",
            )
            gh.chmod(0o755)

            result = self.run_command(
                [
                    "bash",
                    str(PROJECT_SH),
                    "Example",
                    str(workspace),
                    "--no-speckit",
                    "--no-agents",
                    "--no-release-please",
                ],
                home=home,
                timeout=60,
                extra_env={"PATH": f"{fake_bin}{os.pathsep}{os.environ['PATH']}"},
            )

            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertIn("effektives origin/pushurl", result.stdout)

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_variants_parse_and_reject_path_names(self) -> None:
        for script, arguments in (
            (WORKSPACE_PS1, ["-WorkspaceName", "../outside", "-WhatIf"]),
            (PROJECT_PS1, ["-ProjectName", "../outside", "-Preview", "-NoSpeckit"]),
        ):
            with self.subTest(script=script.name), tempfile.TemporaryDirectory() as temporary:
                result = self.run_command(
                    ["pwsh", "-NoProfile", "-File", str(script), *arguments],
                    home=Path(temporary),
                )
                self.assertNotEqual(result.returncode, 0, result.stdout)
                self.assertIn("one safe path component", result.stdout)

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_project_commit_excludes_private_files_and_hooks(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            home = Path(temporary)
            (home / "constitution.md").write_text("# Constitution v1.0.0\n", encoding="utf-8")
            workspace = home / "workspace"
            target = workspace / "Example"
            target.mkdir(parents=True)
            (target / "private.txt").write_text("do not publish\n", encoding="utf-8")
            subprocess.run(["git", "init", "-q", str(target)], check=True)
            hook_marker = home / "post-commit-ran"
            post_commit = target / ".git/hooks/post-commit"
            post_commit.write_text(
                f"#!/usr/bin/env bash\nprintf ran > {hook_marker!s}\n",
                encoding="utf-8",
            )
            post_commit.chmod(0o755)

            result = self.run_command(
                [
                    "pwsh",
                    "-NoProfile",
                    "-File",
                    str(PROJECT_PS1),
                    "-ProjectName",
                    "Example",
                    "-TargetWorkspace",
                    str(workspace),
                    "-NoRemote",
                    "-NoSpeckit",
                    "-NoAgents",
                    "-NoReleasePlease",
                    "-Force",
                ],
                home=home,
                timeout=60,
            )

            self.assertIn(result.returncode, (0, 1), result.stdout)
            tracked = subprocess.run(
                ["git", "-C", str(target), "ls-files"],
                text=True,
                stdout=subprocess.PIPE,
                check=True,
            ).stdout.splitlines()
            self.assertNotIn("private.txt", tracked)
            self.assertFalse(hook_marker.exists(), result.stdout)
            installed_hook = target / ".git/home-baseline-hooks/pre-push"
            self.assertTrue(installed_hook.is_file())
            self.assertTrue(os.access(installed_hook, os.X_OK))

    def test_bash_project_rejects_existing_and_dangling_release_output_links(self) -> None:
        release_paths = (
            "release-please-config.json",
            ".release-please-manifest.json",
            ".github/workflows/release-please.yml",
        )
        for relative in release_paths:
            for dangling in (False, True):
                with self.subTest(relative=relative, dangling=dangling), tempfile.TemporaryDirectory() as temporary:
                    base = Path(temporary)
                    home = base / "home"
                    workspace = home / "workspace"
                    target = workspace / "Example"
                    target.mkdir(parents=True)
                    outside = base / "outside.txt"
                    if not dangling:
                        outside.write_text("sentinel\n", encoding="utf-8")
                    link = target / relative
                    link.parent.mkdir(parents=True, exist_ok=True)
                    link.symlink_to(outside)

                    result = self.run_command(
                        ["bash", str(PROJECT_SH), "Example", str(workspace), "--preview", "--no-speckit", "--no-agents"],
                        home=home,
                    )

                    self.assertEqual(result.returncode, 2, result.stdout)
                    if dangling:
                        self.assertFalse(outside.exists())
                    else:
                        self.assertEqual(outside.read_text(encoding="utf-8"), "sentinel\n")

    @unittest.skipUnless(shutil.which("pwsh"), "PowerShell 7 is unavailable")
    def test_powershell_project_rejects_dangling_release_output_link(self) -> None:
        with tempfile.TemporaryDirectory() as temporary:
            base = Path(temporary)
            home = base / "home"
            workspace = home / "workspace"
            target = workspace / "Example"
            target.mkdir(parents=True)
            outside = base / "outside.txt"
            (target / "release-please-config.json").symlink_to(outside)

            result = self.run_command(
                ["pwsh", "-NoProfile", "-File", str(PROJECT_PS1), "-ProjectName", "Example",
                 "-TargetWorkspace", str(workspace), "-Preview", "-NoSpeckit", "-NoAgents"],
                home=home,
            )

            self.assertNotEqual(result.returncode, 0, result.stdout)
            self.assertFalse(outside.exists())

    def test_release_writers_use_managed_atomic_publication(self) -> None:
        bash_source = PROJECT_SH.read_text(encoding="utf-8")
        bash_release = bash_source.split("# ─── Step 9b:", 1)[1].split("# ─── Step 10:", 1)[0]
        powershell_source = PROJECT_PS1.read_text(encoding="utf-8")
        powershell_release = powershell_source.split("# 9b. Release-Automation", 1)[1].split("# 10. Copy scripts/", 1)[0]
        for relative in (
            "release-please-config.json",
            ".release-please-manifest.json",
            ".github/workflows/release-please.yml",
        ):
            self.assertIn(f'sdh_replace_managed_file_atomic "$TARGET_DIR" "{relative}"', bash_release)
            self.assertIn(f"-RelativePath '{relative}'", powershell_release)
        self.assertNotIn('> "${TARGET_DIR}/release-please-config.json"', bash_release)
        self.assertNotIn("Set-Content", powershell_release)


if __name__ == "__main__":
    unittest.main()
