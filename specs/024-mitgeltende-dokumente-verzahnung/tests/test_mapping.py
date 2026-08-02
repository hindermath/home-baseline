#!/usr/bin/env python3
import copy, importlib.util, json, tempfile, unittest
from pathlib import Path

ROOT=Path(__file__).resolve().parents[3]
SPEC=importlib.util.spec_from_file_location("validator", ROOT/"specs/024-mitgeltende-dokumente-verzahnung/tools/validate_mapping.py")
V=importlib.util.module_from_spec(SPEC); SPEC.loader.exec_module(V)

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
