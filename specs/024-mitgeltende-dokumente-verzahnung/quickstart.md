# Quickstart: Feature 024 Validation

```bash
python3 specs/024-mitgeltende-dokumente-verzahnung/tests/test_mapping.py
python3 specs/024-mitgeltende-dokumente-verzahnung/tools/validate_mapping.py --repo .
bash scripts/build-secure-development-docs.sh --check-only
git diff --check
```

PowerShell and provider gates remain repository-wide acceptance evidence.
