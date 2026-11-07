#!/usr/bin/env python3
"""Regression tests for shared managed-output containment."""

from __future__ import annotations

from pathlib import Path
import os
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
MODULE = ROOT / "scripts/lib/managed-file-hardening.psm1"
BASH_HELPER = ROOT / "scripts/lib/secure-development-hardening.sh"
POWERSHELL_HELPER = ROOT / "scripts/lib/secure-development-hardening.ps1"
UPDATE_SPEC_KIT = ROOT / "scripts/update-spec-kit.ps1"


def run_pwsh(command: str, *args: str) -> subprocess.CompletedProcess[str]:
    env = os.environ.copy()
    names = []
    for index, value in enumerate(args):
        name = f"HB_MANAGED_TEST_ARG_{index}"
        env[name] = value
        names.append(f"$env:{name}")
    prefix = "$script:TestArgs = @(" + ",".join(names) + "); "
    command = prefix + command.replace("$args[", "$script:TestArgs[")
    return subprocess.run(
        ["pwsh", "-NoProfile", "-Command", command],
        cwd=ROOT,
        env=env,
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        check=False,
    )


@unittest.skipUnless(shutil.which("pwsh"), "pwsh is not installed")
class ManagedOutputSecurityTests(unittest.TestCase):
    def test_bash_linked_intake_staging_ignores_predictable_symlink(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "candidate.md"
            source.write_text("candidate\n", encoding="utf-8")
            sentinel = base / "sentinel.md"
            sentinel.write_text("private\n", encoding="utf-8")
            (base / ".sdh-publish-123-0.tmp").symlink_to(sentinel)
            result = subprocess.run(
                [
                    "bash", "-c",
                    'source "$1"; staged="$(sdh_stage_private_copy "$2" "$3" sdh-publish)"; '
                    '[ -f "$staged" ] && [ ! -L "$staged" ] && cat "$staged"; rm -f -- "$staged"',
                    "linked-intake-stage-test", str(BASH_HELPER), str(source), str(base),
                ],
                cwd=ROOT, text=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, check=False,
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(result.stdout, "candidate\n")
            self.assertEqual(sentinel.read_text(encoding="utf-8"), "private\n")

    def test_powershell_linked_intake_staging_ignores_predictable_symlink(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "candidate.md"
            source.write_text("candidate\n", encoding="utf-8")
            sentinel = base / "sentinel.md"
            sentinel.write_text("private\n", encoding="utf-8")
            result = run_pwsh(
                ". $args[0]; "
                "$predictable=Join-Path $args[2] ('.sdh-publish-{0}-0.tmp' -f $PID); "
                "New-Item -ItemType SymbolicLink -Path $predictable -Target $args[3] | Out-Null; "
                "$staged=New-SdhPrivateStagedCopy -Source $args[1] -Parent $args[2] -Prefix 'sdh-publish'; "
                "if ((Get-Item -LiteralPath $staged -Force).LinkType) { throw 'staged path is linked' }; "
                "Get-Content -Raw -LiteralPath $staged; Remove-Item -LiteralPath $staged -Force",
                str(POWERSHELL_HELPER), str(source), str(base), str(sentinel),
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(result.stdout, "candidate\n\n")
            self.assertEqual(sentinel.read_text(encoding="utf-8"), "private\n")

    def test_powershell_spec_kit_whitespace_repair_rejects_linked_settings(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repo = base / "repo"
            (repo / ".vscode").mkdir(parents=True)
            sentinel = base / "outside.json"
            sentinel.write_text('{"private":true}\n', encoding="utf-8")
            (repo / ".vscode/settings.json").symlink_to(sentinel)
            command = (
                "$tokens=$null;$errors=$null;"
                "$ast=[Management.Automation.Language.Parser]::ParseFile($args[0],[ref]$tokens,[ref]$errors);"
                "$fn=$ast.Find({param($node) $node -is [Management.Automation.Language.FunctionDefinitionAst] "
                "-and $node.Name -eq 'Repair-HBGeneratedWhitespace'},$true);"
                "Import-Module $args[1] -Force;. ([scriptblock]::Create($fn.Extent.Text));"
                "$WhatIfPreference=$false;Repair-HBGeneratedWhitespace -Repo $args[2]"
            )
            result = run_pwsh(command, str(UPDATE_SPEC_KIT), str(MODULE), str(repo))
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(sentinel.read_text(encoding="utf-8"), '{"private":true}\n')

    def test_bash_managed_copy_rejects_linked_source(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "source"
            target = base / "target"
            source.mkdir()
            target.mkdir()
            outside = base / "outside.txt"
            outside.write_text("private\n", encoding="utf-8")
            (source / "guide.md").symlink_to(outside)
            result = subprocess.run(
                [
                    "bash",
                    "-c",
                    'source "$1"; sdh_copy_managed_file_atomic "$2" guide.md "$3" guide.md',
                    "managed-copy-test",
                    str(BASH_HELPER),
                    str(source),
                    str(target),
                ],
                cwd=ROOT,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=False,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((target / "guide.md").exists())

    def test_bash_managed_copy_rejects_linked_target_parent(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "source"
            target = base / "target"
            outside = base / "outside"
            source.mkdir()
            target.mkdir()
            outside.mkdir()
            (source / "guide.md").write_text("safe\n", encoding="utf-8")
            (target / "docs").symlink_to(outside, target_is_directory=True)
            result = subprocess.run(
                [
                    "bash",
                    "-c",
                    'source "$1"; sdh_copy_managed_file_atomic "$2" guide.md "$3" docs/guide.md',
                    "managed-copy-test",
                    str(BASH_HELPER),
                    str(source),
                    str(target),
                ],
                cwd=ROOT,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=False,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((outside / "guide.md").exists())

    def test_bash_order_writer_rejects_linked_output(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repo = base / "repo"
            repo.mkdir()
            (repo / ".git").mkdir()
            (repo / "Lastenheft_Test.md").write_text("# Intake\n", encoding="utf-8")
            outside = base / "outside.md"
            outside.write_text("private\n", encoding="utf-8")
            (repo / "Lastenheft_Abarbeitungsreihenfolge.md").symlink_to(outside)
            result = subprocess.run(
                [
                    "bash",
                    "-c",
                    'source "$1"; sdh_update_order_file "$2" 0',
                    "order-test",
                    str(BASH_HELPER),
                    str(repo),
                ],
                cwd=ROOT,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=False,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "private\n")

    def test_bash_template_renderer_rejects_linked_source_parent(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "source"
            outside = base / "outside"
            source.mkdir()
            outside.mkdir()
            (outside / "template.md").write_text("private {{PROJECT_NAME}}\n", encoding="utf-8")
            (source / "templates").symlink_to(outside, target_is_directory=True)
            output = base / "output.md"
            result = subprocess.run(
                [
                    "bash",
                    "-c",
                    'source "$1"; sdh_render_template "$2" "$3" Project',
                    "template-test",
                    str(BASH_HELPER),
                    str(source / "templates/template.md"),
                    str(output),
                ],
                cwd=ROOT,
                text=True,
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE,
                check=False,
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(output.exists())

    def test_atomic_writer_rejects_linked_leaf(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            root = base / "repo"
            root.mkdir()
            outside = base / "outside.txt"
            outside.write_text("private\n", encoding="utf-8")
            (root / "report.md").symlink_to(outside)
            result = run_pwsh(
                "Import-Module $args[0] -Force; "
                "Write-HBManagedTextAtomic -Root $args[1] -RelativePath 'report.md' -Content 'changed'",
                str(MODULE),
                str(root),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "private\n")

    def test_atomic_copy_rejects_linked_source(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "source"
            target = base / "target"
            source.mkdir()
            target.mkdir()
            outside = base / "outside.txt"
            outside.write_text("private\n", encoding="utf-8")
            (source / "guide.md").symlink_to(outside)
            result = run_pwsh(
                "Import-Module $args[0] -Force; "
                "Copy-HBManagedFileAtomic -SourceRoot $args[1] -SourceRelativePath 'guide.md' "
                "-Root $args[2] -RelativePath 'guide.md'",
                str(MODULE),
                str(source),
                str(target),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((target / "guide.md").exists())

    def test_powershell_order_writer_rejects_linked_output(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            repo = base / "repo"
            repo.mkdir()
            (repo / ".git").mkdir()
            (repo / "Lastenheft_Test.md").write_text("# Intake\n", encoding="utf-8")
            outside = base / "outside.md"
            outside.write_text("private\n", encoding="utf-8")
            (repo / "Lastenheft_Abarbeitungsreihenfolge.md").symlink_to(outside)
            result = run_pwsh(
                ". $args[0]; Update-SdhOrderFile -Repo $args[1]",
                str(POWERSHELL_HELPER),
                str(repo),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(outside.read_text(encoding="utf-8"), "private\n")

    def test_powershell_template_renderer_rejects_linked_source_parent(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = base / "source"
            outside = base / "outside"
            source.mkdir()
            outside.mkdir()
            (outside / "template.md").write_text("private {{PROJECT_NAME}}\n", encoding="utf-8")
            (source / "templates").symlink_to(outside, target_is_directory=True)
            output = base / "output.md"
            result = run_pwsh(
                ". $args[0]; Write-SdhRenderedTemplate -Template $args[1] -Output $args[2] -ProjectName Project",
                str(POWERSHELL_HELPER),
                str(source / "templates/template.md"),
                str(output),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse(output.exists())

    def test_atomic_writer_rejects_linked_parent(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            root = base / "repo"
            outside = base / "outside"
            root.mkdir()
            outside.mkdir()
            (root / "docs").symlink_to(outside, target_is_directory=True)
            result = run_pwsh(
                "Import-Module $args[0] -Force; "
                "Write-HBManagedTextAtomic -Root $args[1] -RelativePath 'docs/report.md' -Content 'changed'",
                str(MODULE),
                str(root),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((outside / "report.md").exists())

    def test_atomic_writer_creates_regular_file_and_parent(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "repo"
            root.mkdir()
            result = run_pwsh(
                "Import-Module $args[0] -Force; "
                "Write-HBManagedTextAtomic -Root $args[1] -RelativePath 'docs/report.md' -Content 'ok' -CreateParent; "
                "Read-HBManagedText -Root $args[1] -RelativePath 'docs/report.md'",
                str(MODULE),
                str(root),
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual((root / "docs/report.md").read_text(encoding="utf-8"), "ok")

    def test_managed_path_rejects_parent_traversal(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "repo"
            root.mkdir()
            result = run_pwsh(
                "Import-Module $args[0] -Force; "
                "Get-HBManagedPath -Root $args[1] -RelativePath '../outside.md'",
                str(MODULE),
                str(root),
            )
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)

    def test_group_staging_failure_preserves_all_existing_outputs(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "repo"
            locked = root / "locked"
            locked.mkdir(parents=True)
            first = root / "first.md"
            first.write_text("old-first\n", encoding="utf-8")
            locked.chmod(0o500)
            try:
                result = run_pwsh(
                    "Import-Module $script:TestArgs[0] -Force; "
                    "$content=[ordered]@{'first.md'='new-first';'locked/second.md'='new-second'}; "
                    "Write-HBManagedTextSetAtomic -Root $script:TestArgs[1] -ContentByRelativePath $content",
                    str(MODULE),
                    str(root),
                )
            finally:
                locked.chmod(0o700)
            self.assertNotEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertEqual(first.read_text(encoding="utf-8"), "old-first\n")
            self.assertFalse((locked / "second.md").exists())

    def test_allow_missing_parent_is_read_only(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            root = Path(tmp) / "repo"
            root.mkdir()
            result = run_pwsh(
                "Import-Module $script:TestArgs[0] -Force; "
                "Get-HBManagedPath -Root $script:TestArgs[1] -RelativePath 'docs/scripts/reference.md' -AllowMissingParent",
                str(MODULE),
                str(root),
            )
            self.assertEqual(result.returncode, 0, result.stdout + result.stderr)
            self.assertFalse((root / "docs").exists())


if __name__ == "__main__":
    unittest.main()
