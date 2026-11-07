#!/usr/bin/env python3
"""Security regressions for GitLab release setup and publication."""

from __future__ import annotations

import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"


def run(*args: str, cwd: Path = ROOT, env: dict[str, str] | None = None) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        args,
        cwd=cwd,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )


def git(*args: str, cwd: Path) -> None:
    result = run("git", *args, cwd=cwd)
    if result.returncode:
        raise AssertionError(result.stdout + result.stderr)


def create_repository(base: Path, remote: str = "https://gitlab.example/group/project.git") -> Path:
    repository = base / "repo"
    repository.mkdir()
    git("init", "-q", "-b", "main", cwd=repository)
    git("config", "user.name", "Test", cwd=repository)
    git("config", "user.email", "test@example.invalid", cwd=repository)
    (repository / "README.md").write_text("# Test\n", encoding="utf-8")
    git("add", "README.md", cwd=repository)
    git("commit", "-qm", "feat: initial", cwd=repository)
    git("remote", "add", "origin", remote, cwd=repository)
    return repository


class GitLabReleaseSecurityTests(unittest.TestCase):
    def test_bash_installer_rejects_linked_managed_output(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repository = create_repository(base)
            scripts_dir = repository / "scripts"
            scripts_dir.mkdir()
            outside = base / "outside.sh"
            outside.write_text("private\n", encoding="utf-8")
            (scripts_dir / "release-gitlab.sh").symlink_to(outside)
            result = run(
                "bash",
                str(SCRIPTS / "setup-gitlab-release.sh"),
                str(repository),
                "--skip-project-settings",
                "--force",
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "private\n")

    def test_bash_installer_does_not_echo_https_userinfo(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            token = "DUMMY_TOKEN_SHOULD_NOT_APPEAR"
            repository = create_repository(
                Path(tmp),
                f"https://user:{token}@gitlab.example/group/project.git",
            )
            result = run("bash", str(SCRIPTS / "setup-gitlab-release.sh"), str(repository))
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertNotIn(token, result.stdout + result.stderr)
            self.assertIn("credential-free", result.stdout + result.stderr)

    @unittest.skipUnless(shutil.which("pwsh"), "pwsh is not installed")
    def test_powershell_whatif_has_no_local_or_remote_mutation(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repository = create_repository(base)
            tools = base / "tools"
            tools.mkdir()
            log = base / "glab.log"
            glab = tools / "glab"
            glab.write_text("#!/usr/bin/env bash\nprintf '%s\\n' \"$*\" >> \"$HB_GLAB_LOG\"\n", encoding="utf-8")
            glab.chmod(0o755)
            env = os.environ.copy()
            env["PATH"] = f"{tools}:{os.environ.get('PATH', '')}"
            env["HB_GLAB_LOG"] = str(log)
            result = run(
                "pwsh",
                "-NoProfile",
                "-File",
                str(SCRIPTS / "setup-gitlab-release.ps1"),
                "-TargetRepository",
                str(repository),
                "-ExpectedProject",
                "gitlab.example/group/project",
                "-WhatIf",
                env=env,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((repository / "scripts").exists())
            self.assertFalse((repository / "CHANGELOG.md").exists())
            self.assertFalse((repository / ".gitlab-ci.yml").exists())
            self.assertFalse(log.exists())

    def _create_release_fixture(self, base: Path) -> tuple[Path, str]:
        origin = base / "origin.git"
        git("init", "-q", "--bare", str(origin), cwd=base)
        repository = base / "release-repo"
        git("clone", "-q", str(origin), str(repository), cwd=base)
        git("config", "user.name", "Test", cwd=repository)
        git("config", "user.email", "test@example.invalid", cwd=repository)
        git("checkout", "-q", "-b", "main", cwd=repository)
        (repository / "scripts").mkdir()
        shutil.copy2(SCRIPTS / "templates/release-gitlab.sh.tmpl", repository / "scripts/release-gitlab.sh")
        (repository / "scripts/release-gitlab.sh").chmod(0o755)
        (repository / "CHANGELOG.md").write_text(
            "# Changelog\n\nAlle Aenderungen.\nAll changes.\n",
            encoding="utf-8",
        )
        (repository / "feature.txt").write_text("feature\n", encoding="utf-8")
        git("add", ".", cwd=repository)
        git("commit", "-qm", "feat: secure release", cwd=repository)
        git("push", "-q", "-u", "origin", "main", cwd=repository)
        sha = run("git", "rev-parse", "HEAD", cwd=repository).stdout.strip()
        return repository, sha

    def _release_environment(self, base: Path, repository: Path, sha: str) -> tuple[dict[str, str], Path, Path]:
        tools = base / "tools"
        tools.mkdir()
        git_log = base / "git-push-argv.log"
        curl_log = base / "curl-argv.log"
        real_git = shutil.which("git")
        self.assertIsNotNone(real_git)
        git_wrapper = tools / "git"
        git_wrapper.write_text(
            "#!/usr/bin/env bash\n"
            "if [ \"${1:-}\" = push ]; then printf '%s\\n' \"$@\" > \"$HB_GIT_LOG\"; exit 0; fi\n"
            f"exec {real_git} \"$@\"\n",
            encoding="utf-8",
        )
        git_wrapper.chmod(0o755)
        curl = tools / "curl"
        curl.write_text("#!/usr/bin/env bash\nprintf '%s\\n' \"$@\" > \"$HB_CURL_LOG\"\nprintf '201'\n", encoding="utf-8")
        curl.chmod(0o755)
        env = os.environ.copy()
        env.update(
            {
                "PATH": f"{tools}:/opt/homebrew/bin:/usr/bin:/bin",
                "HB_GIT_LOG": str(git_log),
                "HB_CURL_LOG": str(curl_log),
                "CI": "true",
                "CI_DEFAULT_BRANCH": "main",
                "CI_COMMIT_REF_NAME": "main",
                "CI_COMMIT_SHA": sha,
                "CI_JOB_TOKEN": "SECRET_TOKEN_123",
                "CI_PROJECT_ID": "123",
                "CI_API_V4_URL": "https://gitlab.example/api/v4",
                "CI_SERVER_HOST": "gitlab.example",
                "CI_PROJECT_PATH": "group/project",
            }
        )
        return env, git_log, curl_log

    def test_release_keeps_job_token_out_of_process_arguments(self) -> None:
        if not shutil.which("jq"):
            self.skipTest("jq is not installed")
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repository, sha = self._create_release_fixture(base)
            env, git_log, curl_log = self._release_environment(base, repository, sha)
            result = run("bash", "scripts/release-gitlab.sh", cwd=repository, env=env)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            combined = git_log.read_text(encoding="utf-8") + curl_log.read_text(encoding="utf-8")
            self.assertNotIn(env["CI_JOB_TOKEN"], combined)
            self.assertNotIn("@gitlab.example", combined)
            self.assertIn("--config", combined)

    def test_release_rejects_branch_advance_before_changelog_write(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repository, old_sha = self._create_release_fixture(base)
            (repository / "later.txt").write_text("later\n", encoding="utf-8")
            git("add", "later.txt", cwd=repository)
            git("commit", "-qm", "fix: later", cwd=repository)
            git("push", "-q", "origin", "main", cwd=repository)
            env, git_log, curl_log = self._release_environment(base, repository, old_sha)
            before = (repository / "CHANGELOG.md").read_bytes()
            result = run("bash", "scripts/release-gitlab.sh", cwd=repository, env=env)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("fresh release job", result.stderr)
            self.assertEqual(before, (repository / "CHANGELOG.md").read_bytes())
            self.assertFalse(git_log.exists())
            self.assertFalse(curl_log.exists())


if __name__ == "__main__":
    unittest.main()
