#!/usr/bin/env python3
import copy, importlib.util, unittest
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
def load_validator():
    spec = importlib.util.spec_from_file_location(
        "feature_024_mapping_validator",
        ROOT / "specs/024-mitgeltende-dokumente-verzahnung/tools/validate_mapping.py",
    )
    if spec is None or spec.loader is None:
        raise RuntimeError("Feature-024 validator module could not be loaded.")
    module = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(module)
    return module

V = load_validator()

class MappingTests(unittest.TestCase):
    def setUp(self): self.good=V.build(ROOT)
    def test_positive(self): self.assertEqual([],V.validate(ROOT,self.good))
    def test_missing_document(self):
        bad=copy.deepcopy(self.good); bad["rows"].pop(); self.assertTrue(V.validate(ROOT,bad))
    def test_incomplete_evidence(self):
        bad=copy.deepcopy(self.good); bad["rows"][0]["owner"]=""; self.assertTrue(V.validate(ROOT,bad))
    def test_profile_drift(self):
        bad=copy.deepcopy(self.good); bad["profiles"]["managedOptional"].pop(); self.assertTrue(V.validate(ROOT,bad))
    def test_invalid_axis(self):
        bad=copy.deepcopy(self.good); bad["rows"][0]["applicability"]="Ready"; self.assertTrue(V.validate(ROOT,bad))

if __name__ == "__main__": unittest.main()
