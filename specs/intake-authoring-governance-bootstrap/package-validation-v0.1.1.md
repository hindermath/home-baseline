# Intake Authoring Governance v0.1.1 Package Validation

## Release Identity

- Repository:
  `https://github.com/hindermath/spec-kit-preset-intake-authoring-governance`
- Pull request:
  `https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/pull/1`
- Tag and release: `v0.1.1`
- Public package commit: `3992500`
- Versioned ZIP:
  `https://github.com/hindermath/spec-kit-preset-intake-authoring-governance/archive/refs/tags/v0.1.1.zip`
- ZIP SHA-256:
  `15d42670c4d2f1e29a591511a671edb75d4c0aaea0bca0b72d2dc37b8597a8ba`
- Spec Kit: `0.12.11`; declared minimum: `>=0.8.3`

## Package Results

- Bash and PowerShell accept schema 1.0 and schema 1.1 receipts.
- Git-blob and snapshot-only `LegacyAdoption` fixtures pass.
- Missing update authority and mismatching prior-target hashes fail.
- The exact tag ZIP passes install, Disable/Enable, Remove/Reinstall, and the
  full positive/negative fixture suite in a ten-preset temporary project.
- Codex exposes exactly one Create and one Create Status skill after reinstall.

## Intake Review Compatibility

Intake Review Governance v0.1.0 consumes the generated target and its
normalized SHA-256 rather than the Authoring receipt schema. It accepted the
14-target v0.1.1 active series as `Ready` with zero findings, questions, or
accepted risks. No Intake Review version change is required.

## Fleet And Community Boundary

The published release grants no review, feature, commit, push, pull-request,
merge, bypass, or learner-run authority. Fleet rollout evidence is recorded
separately after all 33 managed repositories use the versioned tag ZIP.

The Community Catalog update is submitted only after package and fleet
validation. An external catalog merge is not a local completion condition.
