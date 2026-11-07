#!/usr/bin/env python3
"""Security regressions for learning-package creation and validation."""

from __future__ import annotations

import hashlib
import os
from pathlib import Path
import shutil
import stat
import subprocess
import tempfile
import unittest
import zipfile


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


def write_package(path: Path, extra: dict[str, bytes] | None = None) -> None:
    root = "SecureExampleProjects"
    files = {
        f"{root}/START-HERE-FUER-LERNENDE.md": b"# Start\n",
        f"{root}/GIT-START-FUER-LERNENDE.md": b"# Git\n",
        f"{root}/INSTITUTIONELLES-GIT-HOSTING.md": b"# Hosting\n",
        f"{root}/PACKAGING-MANIFEST.txt": (
            b"Git data included: no (.git directories excluded)\n"
            b"Original remotes included: no\n"
            b"Start here after extracting: START-HERE-FUER-LERNENDE.md\n"
            b"Institutional hosting guide: INSTITUTIONELLES-GIT-HOSTING.md\n"
        ),
    }
    files.update(extra or {})
    with zipfile.ZipFile(path, "w", zipfile.ZIP_DEFLATED) as package:
        for name, content in files.items():
            package.writestr(name, content)


def write_checksum(package: Path, checksum: Path | None = None) -> Path:
    destination = checksum or Path(f"{package}.sha256")
    digest = hashlib.sha256(package.read_bytes()).hexdigest()
    destination.write_text(f"{digest}  {package.name}\n", encoding="ascii")
    return destination


def create_source(root: Path) -> Path:
    source = root / "SecureExampleProjects"
    guides = source / "docs" / "learning-units"
    guides.mkdir(parents=True)
    (guides / "START-HERE-FUER-LERNENDE.md").write_text("# Start\n", encoding="utf-8")
    (guides / "GIT-START-FUER-LERNENDE.md").write_text("# Git\n", encoding="utf-8")
    (guides / "INSTITUTIONELLES-GIT-HOSTING.md").write_text("# Hosting\n", encoding="utf-8")
    (source / "README.md").write_text("# Example\n", encoding="utf-8")
    return source


class LearningPackageSecurityTests(unittest.TestCase):
    def test_bounded_extractor_rejects_zip_bomb_ratio(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            package = Path(tmp) / "bomb.zip"
            write_package(package, {"SecureExampleProjects/large.bin": b"0" * (2 * 1024 * 1024)})
            result = run("python3", str(SCRIPTS / "lib/learning_package_archive.py"), str(package))
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("Kompressionsrate", result.stderr)

    def test_bounded_extractor_rejects_aggregate_small_entry_ratio(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            package = Path(tmp) / "aggregate-bomb.zip"
            extra = {
                f"SecureExampleProjects/chunk-{index:02d}.bin": b"0" * (512 * 1024)
                for index in range(10)
            }
            write_package(package, extra)
            result = run("python3", str(SCRIPTS / "lib/learning_package_archive.py"), str(package))
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("insgesamt", result.stderr)

    def test_bounded_extractor_rejects_zip_symlink(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            package = Path(tmp) / "link.zip"
            with zipfile.ZipFile(package, "w") as archive:
                link = zipfile.ZipInfo("SecureExampleProjects/outside")
                link.create_system = 3
                link.external_attr = (stat.S_IFLNK | 0o777) << 16
                archive.writestr(link, "../../outside")
            result = run("python3", str(SCRIPTS / "lib/learning_package_archive.py"), str(package))
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("symbolischer Link", result.stderr)

    def test_bash_checksum_is_bound_to_selected_package(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            first = base / "first.zip"
            second = base / "second.zip"
            write_package(first)
            write_package(second, {"SecureExampleProjects/other.txt": b"different\n"})
            checksum = write_checksum(first)
            result = run(
                "bash",
                str(SCRIPTS / "check-learning-package.sh"),
                "--checksum",
                str(checksum),
                str(second),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("SHA-256 stimmt nicht", result.stderr)

    def test_checker_fails_closed_without_gitleaks(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            package = Path(tmp) / "package.zip"
            write_package(package)
            write_checksum(package)
            env = os.environ.copy()
            env["PATH"] = "/usr/bin:/bin"
            result = run(
                "bash",
                str(SCRIPTS / "check-learning-package.sh"),
                str(package),
                env=env,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertNotIn("PASS:", result.stdout)
            self.assertIn("gitleaks", result.stderr)

    def test_checker_uses_immutable_archive_snapshot(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            original = base / "package.zip"
            replacement = base / "replacement.zip"
            write_package(original)
            write_package(replacement, {"SecureExampleProjects/changed.txt": b"changed\n"})
            write_checksum(original)
            tools = base / "tools"
            tools.mkdir()
            real_shasum = shutil.which("shasum")
            self.assertIsNotNone(real_shasum)
            wrapper = tools / "shasum"
            wrapper.write_text(
                "#!/usr/bin/env bash\n"
                f"{real_shasum} \"$@\"\n"
                "rc=$?\n"
                "cp -- \"$HB_REPLACEMENT\" \"$HB_ORIGINAL\"\n"
                "exit $rc\n",
                encoding="utf-8",
            )
            wrapper.chmod(0o755)
            for command in ("python3", "gitleaks"):
                resolved = shutil.which(command)
                self.assertIsNotNone(resolved)
                (tools / command).symlink_to(resolved)
            env = os.environ.copy()
            env["PATH"] = f"{tools}:/usr/bin:/bin"
            env["HB_ORIGINAL"] = str(original)
            env["HB_REPLACEMENT"] = str(replacement)
            result = run("bash", str(SCRIPTS / "check-learning-package.sh"), str(original), env=env)
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("PASS:", result.stdout)
            self.assertEqual(original.read_bytes(), replacement.read_bytes())

    def test_packager_rejects_source_symlink(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = create_source(base)
            outside = base / "outside.txt"
            outside.write_text("private\n", encoding="utf-8")
            (source / "linked.txt").symlink_to(outside)
            result = run(
                "bash",
                str(SCRIPTS / "package-learning-series.sh"),
                "--source-dir",
                str(source),
                "--output-dir",
                str(base / "out"),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("symbolischen Link", result.stderr)
            self.assertFalse((base / "out").exists())

    def test_packager_rejects_untracked_env_but_allows_example(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = create_source(base)
            (source / ".env.example").write_text("TOKEN=replace-me\n", encoding="utf-8")
            (source / ".env").write_text("TOKEN=private\n", encoding="utf-8")
            result = run(
                "bash",
                str(SCRIPTS / "package-learning-series.sh"),
                "--source-dir",
                str(source),
                "--output-dir",
                str(base / "out"),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("credential-verdaechtige Datei", result.stderr)
            self.assertIn(".env", result.stderr)
            self.assertNotIn(".env.example", result.stderr)

    def test_packager_rejects_case_variant_env(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = create_source(base)
            (source / ".ENV").write_text("opaque local data\n", encoding="utf-8")
            result = run(
                "bash",
                str(SCRIPTS / "package-learning-series.sh"),
                "--source-dir",
                str(source),
                "--output-dir",
                str(base / "out"),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn(".ENV", result.stderr)

    def test_no_follow_copy_rejects_swapped_guide_link(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            outside = base / "outside.txt"
            outside.write_text("private\n", encoding="utf-8")
            source = base / "guide.md"
            source.symlink_to(outside)
            destination = base / "stage" / "guide.md"
            result = run(
                "python3",
                str(SCRIPTS / "lib/learning_package_archive.py"),
                "--copy-file",
                str(source),
                str(destination),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(destination.exists())

    def test_bash_dry_run_does_not_require_gitleaks(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = create_source(base)
            env = os.environ.copy()
            env["PATH"] = "/usr/bin:/bin"
            result = run(
                "bash",
                str(SCRIPTS / "package-learning-series.sh"),
                "--source-dir",
                str(source),
                "--output-dir",
                str(base / "out"),
                "--dry-run",
                env=env,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertIn("Dry-run:", result.stdout)

    def test_regex_fallback_distinguishes_prose_from_secret(self) -> None:
        script = (SCRIPTS / "hooks/pre-push").read_text(encoding="utf-8")
        assignment = next(line for line in script.splitlines() if line.startswith("secret_content_regex="))
        fake_aws_key = "AKIA" + "QWERTYUIOPASDFGH"
        command = (
            assignment
            + "\nprintf '%s\\n' 'API-Keys and Bearer eyJ... are teaching examples' | grep -Eiq \"$secret_content_regex\" && exit 7\n"
            + f"printf '%s\\n' 'aws_access_key_id = {fake_aws_key}' | grep -Eiq \"$secret_content_regex\"\n"
        )
        result = run("bash", "-c", command)
        self.assertEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_gitleaks_template_does_not_exempt_secure_docs(self) -> None:
        if not shutil.which("gitleaks"):
            self.skipTest("gitleaks is not installed")
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp)
            target = root / "docs" / "secure-development" / "example.md"
            target.parent.mkdir(parents=True)
            fake_aws_key = "AKIA" + "QWERTYUIOPASDFGH"
            target.write_text(f"aws_access_key_id = {fake_aws_key}\n", encoding="utf-8")
            result = run(
                "gitleaks",
                "dir",
                str(root),
                "--no-banner",
                "--redact",
                "--config",
                str(SCRIPTS / "templates/gitleaks.toml"),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_powershell_packager_rejects_source_symlink(self) -> None:
        if not shutil.which("pwsh"):
            self.skipTest("pwsh is not installed")
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = create_source(base)
            outside = base / "outside.txt"
            outside.write_text("private\n", encoding="utf-8")
            (source / "linked.txt").symlink_to(outside)
            result = run(
                "pwsh",
                "-NoProfile",
                "-File",
                str(SCRIPTS / "package-learning-series.ps1"),
                "-SourceDir",
                str(source),
                "-OutputDir",
                str(base / "out"),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertRegex(result.stderr + result.stdout, "(?i)(link|reparse)")
            self.assertFalse((base / "out").exists())

    def test_powershell_packager_excludes_top_level_build_and_ide_directories(self) -> None:
        if not shutil.which("pwsh"):
            self.skipTest("pwsh is not installed")
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = create_source(base)
            for name in ("bin", "obj", "build", "node_modules", ".vs", ".idea"):
                directory = source / name
                directory.mkdir()
                (directory / "private.marker").write_text("excluded\n", encoding="utf-8")
            (source / "build-notes.md").write_text("keep\n", encoding="utf-8")
            output = base / "out"
            result = run(
                "pwsh", "-NoProfile", "-File", str(SCRIPTS / "package-learning-series.ps1"),
                "-SourceDir", str(source), "-OutputDir", str(output), "-PackagePrefix", "fixture",
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            package = next(output.glob("*.zip"))
            with zipfile.ZipFile(package) as archive:
                names = [name.replace("\\", "/") for name in archive.namelist()]
            self.assertTrue(any(name.endswith("/build-notes.md") for name in names), names)
            for directory in ("bin", "obj", "build", "node_modules", ".vs", ".idea"):
                self.assertFalse(any(f"/{directory}/" in f"/{name}" for name in names), (directory, names))


if __name__ == "__main__":
    unittest.main()
