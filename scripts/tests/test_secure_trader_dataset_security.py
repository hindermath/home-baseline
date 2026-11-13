#!/usr/bin/env python3
"""Security regressions for the deterministic Secure-Trader dataset generator."""

from __future__ import annotations

import importlib.util
import os
from pathlib import Path
import tempfile
import unittest


ROOT = Path(__file__).resolve().parents[2]
GENERATOR = ROOT / "docs/learning-units/datasets/generate-secure-trader-dataset.py"


def load_generator():
    specification = importlib.util.spec_from_file_location(
        "secure_trader_dataset_generator", GENERATOR
    )
    if specification is None or specification.loader is None:
        raise RuntimeError("Secure-Trader dataset generator could not be loaded")
    module = importlib.util.module_from_spec(specification)
    specification.loader.exec_module(module)
    return module


G = load_generator()


class SecureTraderDatasetSecurityTests(unittest.TestCase):
    def test_linked_output_group_is_rejected_without_touching_external_files(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            output = base / "output"
            output.mkdir()
            outside = base / "outside"
            outside.mkdir()
            marker = outside / "categories.csv"
            marker.write_text("owner data\n", encoding="utf-8")
            (output / "orderdesk").symlink_to(outside, target_is_directory=True)

            with self.assertRaises(G.DatasetPathError):
                G.build(1998, 6, G.DEFAULT_SEED, output)

            self.assertEqual(marker.read_text(encoding="utf-8"), "owner data\n")

    def test_csv_leaf_symlink_is_replaced_without_following_external_target(self):
        with tempfile.TemporaryDirectory() as tmp:
            base = Path(tmp)
            output = base / "output"
            for name in ("orderdesk", "serviceharvester", "casetracker"):
                (output / name).mkdir(parents=True, exist_ok=True)
            outside = base / "outside.csv"
            outside.write_text("owner data\n", encoding="utf-8")
            categories = output / "orderdesk/categories.csv"
            categories.symlink_to(outside)

            G.build(1998, 6, G.DEFAULT_SEED, output)

            self.assertEqual(outside.read_text(encoding="utf-8"), "owner data\n")
            self.assertFalse(categories.is_symlink())
            self.assertTrue(categories.read_text(encoding="utf-8").startswith("CategoryID,"))

    def test_normal_run_creates_all_three_output_groups(self):
        with tempfile.TemporaryDirectory() as tmp:
            output = Path(tmp) / "output"

            G.build(1998, 6, G.DEFAULT_SEED, output)

            self.assertTrue((output / "orderdesk/categories.csv").is_file())
            self.assertTrue((output / "serviceharvester/machines.csv").is_file())
            self.assertTrue((output / "casetracker/cases.csv").is_file())
            if os.name != "nt":
                self.assertEqual((output / "orderdesk").stat().st_mode & 0o777, 0o755)
                self.assertEqual(
                    (output / "orderdesk/categories.csv").stat().st_mode & 0o777,
                    0o644,
                )

    def test_existing_regular_csv_mode_is_preserved(self):
        if os.name == "nt":
            self.skipTest("POSIX file modes are not portable to Windows")
        with tempfile.TemporaryDirectory() as tmp:
            output = Path(tmp) / "output"
            for name in ("orderdesk", "serviceharvester", "casetracker"):
                (output / name).mkdir(parents=True, exist_ok=True)
            categories = output / "orderdesk/categories.csv"
            categories.write_text("old\n", encoding="utf-8")
            categories.chmod(0o640)

            G.build(1998, 6, G.DEFAULT_SEED, output)

            self.assertEqual(categories.stat().st_mode & 0o777, 0o640)


if __name__ == "__main__":
    unittest.main()
