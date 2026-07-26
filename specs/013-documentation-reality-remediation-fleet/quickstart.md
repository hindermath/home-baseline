# Quickstart: Feature 013

```bash
bash scripts/maintain-agentic-workspace.sh --check-only
bash scripts/propagate-agentic-toolchain-maintenance.sh --dry-run
bash scripts/test-documentation-impact.sh
```

After each repository change, run its native checks, stage only intended
paths, and validate the exact candidate. Remote delivery uses one branch and
one non-empty PR per repository. Central evidence is written only after target
results are stable.
