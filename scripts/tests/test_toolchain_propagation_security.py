#!/usr/bin/env python3
"""Security regressions for canonical toolchain propagation."""

from __future__ import annotations

import json
import os
from pathlib import Path
import shutil
import subprocess
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
SCRIPTS = ROOT / "scripts"


def prepare_source(base: Path) -> Path:
    source = base / "source"
    scripts = source / "scripts"
    lib = scripts / "lib"
    lib.mkdir(parents=True)
    for name in (
        "propagate-agentic-toolchain-maintenance.sh",
        "propagate-agentic-toolchain-maintenance.ps1",
    ):
        shutil.copy2(SCRIPTS / name, scripts / name)
    for name in (
        "secure-development-hardening.sh",
        "managed-file-hardening.psm1",
        "windows-maintenance-hardening.psm1",
    ):
        shutil.copy2(SCRIPTS / "lib" / name, lib / name)
    return source


def prepare_target(base: Path) -> Path:
    target = base / "target"
    target.mkdir()
    (target / "AGENTS.md").write_text("fixture\n", encoding="utf-8")
    subprocess.run(["git", "-C", str(target), "init", "-q"], check=True)
    return target


def commands(source: Path, target: Path, manifest: Path) -> list[list[str]]:
    result = [
        [
            "bash",
            str(source / "scripts/propagate-agentic-toolchain-maintenance.sh"),
            "--repo",
            str(target),
            "--manifest",
            str(manifest),
        ]
    ]
    if shutil.which("pwsh"):
        result.append(
            [
                "pwsh",
                "-NoProfile",
                "-File",
                str(source / "scripts/propagate-agentic-toolchain-maintenance.ps1"),
                "-Repo",
                str(target),
                "-Manifest",
                str(manifest),
            ]
        )
    return result


def run(command: list[str]) -> subprocess.CompletedProcess[str]:
    return subprocess.run(
        command,
        cwd=ROOT,
        env=os.environ.copy(),
        text=True,
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        check=False,
    )


class ToolchainPropagationSecurityTests(unittest.TestCase):
    def test_explicit_repository_with_linked_parent_is_rejected(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = prepare_source(base)
            outside = base / "outside"
            outside.mkdir()
            actual_target = prepare_target(outside)
            linked_parent = base / "linked"
            linked_parent.symlink_to(outside, target_is_directory=True)
            target = linked_parent / actual_target.name
            (source / "managed.txt").write_text("canonical\n", encoding="utf-8")
            manifest = base / "manifest.json"
            manifest.write_text(
                json.dumps(
                    {
                        "schemaVersion": 1,
                        "files": [{"path": "managed.txt", "executable": False}],
                    }
                ),
                encoding="utf-8",
            )
            for command in commands(source, target, manifest):
                with self.subTest(surface=command[0]):
                    result = run(command)
                    self.assertNotEqual(result.returncode, 0, result.stdout)
                    self.assertFalse((actual_target / "managed.txt").exists())

    def test_manifest_control_character_cannot_inject_second_path(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = prepare_source(base)
            target = prepare_target(base)
            (source / "safe.txt").write_text("safe\n", encoding="utf-8")
            outside = base / "outside.txt"
            outside.write_text("private\n", encoding="utf-8")
            manifest = base / "manifest.json"
            manifest.write_text(
                json.dumps(
                    {
                        "schemaVersion": 1,
                        "files": [
                            {"path": "safe.txt\n../outside.txt", "executable": False}
                        ],
                    }
                ),
                encoding="utf-8",
            )
            for command in commands(source, target, manifest):
                with self.subTest(surface=command[0]):
                    result = run(command)
                    self.assertNotEqual(result.returncode, 0, result.stdout)
                    self.assertEqual(outside.read_text(encoding="utf-8"), "private\n")
                    self.assertFalse((target / "safe.txt").exists())

    def test_linked_source_is_rejected_before_copy(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = prepare_source(base)
            target = prepare_target(base)
            outside = base / "outside.txt"
            outside.write_text("private\n", encoding="utf-8")
            (source / "managed.txt").symlink_to(outside)
            manifest = base / "manifest.json"
            manifest.write_text(
                json.dumps(
                    {
                        "schemaVersion": 1,
                        "files": [{"path": "managed.txt", "executable": False}],
                    }
                ),
                encoding="utf-8",
            )
            for command in commands(source, target, manifest):
                with self.subTest(surface=command[0]):
                    result = run(command)
                    self.assertNotEqual(result.returncode, 0, result.stdout)
                    self.assertFalse((target / "managed.txt").exists())

    def test_linked_target_parent_is_rejected_without_external_write(self) -> None:
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            source = prepare_source(base)
            target = prepare_target(base)
            outside = base / "outside"
            outside.mkdir()
            (source / "managed").mkdir()
            (source / "managed/file.txt").write_text("canonical\n", encoding="utf-8")
            (target / "managed").symlink_to(outside, target_is_directory=True)
            manifest = base / "manifest.json"
            manifest.write_text(
                json.dumps(
                    {
                        "schemaVersion": 1,
                        "files": [
                            {"path": "managed/file.txt", "executable": False}
                        ],
                    }
                ),
                encoding="utf-8",
            )
            for command in commands(source, target, manifest):
                with self.subTest(surface=command[0]):
                    result = run(command)
                    self.assertNotEqual(result.returncode, 0, result.stdout)
                    self.assertFalse((outside / "file.txt").exists())

    def test_regular_managed_file_is_propagated(self) -> None:
        for surface in ("bash", "pwsh"):
            if surface == "pwsh" and not shutil.which("pwsh"):
                continue
            with self.subTest(surface=surface), tempfile.TemporaryDirectory() as tmp:
                base = Path(tmp)
                source = prepare_source(base)
                target = prepare_target(base)
                (source / "managed").mkdir()
                (source / "managed/file.txt").write_text("canonical\n", encoding="utf-8")
                manifest = base / "manifest.json"
                manifest.write_text(
                    json.dumps(
                        {
                            "schemaVersion": 1,
                            "files": [
                                {"path": "managed/file.txt", "executable": False}
                            ],
                        }
                    ),
                    encoding="utf-8",
                )
                command = next(item for item in commands(source, target, manifest) if item[0] == surface)
                result = run(command)
                self.assertEqual(result.returncode, 0, result.stdout)
                self.assertEqual(
                    (target / "managed/file.txt").read_text(encoding="utf-8"),
                    "canonical\n",
                )


if __name__ == "__main__":
    unittest.main()
