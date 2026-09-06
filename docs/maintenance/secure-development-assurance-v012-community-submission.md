# Community-Einreichung v0.1.2 / Community Submission v0.1.2

Status: als [github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455)
eingereicht; Upstream-Maintainer-Triage und automatisch erzeugter Draft-PR
stehen aus. Kein manueller Parallel-PR wurde erstellt.

*Status: submitted as
[github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455); upstream
maintainer triage and the automatically generated draft PR remain pending. No
manual parallel PR was created.*

Die folgenden Feldüberschriften bleiben absichtlich im englischen Original,
weil die aktuelle Upstream-Automation sie als exakte GitHub-Issue-Form-Labels
parst. Inhalt und Scope-Grenze bleiben bilingual beziehungsweise sprachneutral.

*The field headings below intentionally retain the exact English upstream
issue-form labels required by the catalog automation. Content and the scope
boundary remain bilingual or language-neutral.*

### Preset ID

secure-development-assurance-governance

### Preset Name

Secure Development Assurance Governance

### Version

0.1.2

### Description

Validates project-owned secure-development manifests, hashes, checklists, reviews, risks, closure, and image-impact evidence without granting human approvals or certifications.

### Author

Thorsten Hindermann

### Repository URL

https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance

### Download URL

https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/archive/refs/tags/v0.1.2.zip

### Documentation URL

https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/blob/v0.1.2/README.md

### License

MIT

### Required Spec Kit Version

>=0.8.3

### Required Extensions (optional)

None

### Templates Provided

- `secure-development-evidence-contract.md` — portable evidence and decision-boundary contract

### Commands Provided

- `speckit.secure-development-status.md` — read-only inspection of a secure-development evidence directory
- `speckit.secure-development-review.md` — validation of one named gate with authority-bounded review evidence

### Number of Scripts (optional)

2

### Tags

security, governance, assurance, evidence, cross-platform

### Key Features

- Validates separately bound baseline, delta, closure, and image-impact gates.
- Checks versions, normalized hashes, twelve unique checklists, review metadata, accepted risks, and image-impact fields.
- Keeps technical validation independent from pilot authorization, project acceptance, product or sandbox release, fleet release, and certification.
- Provides matching Bash and PowerShell validators with read-only status behavior and fail-closed exit semantics.
- Passed native Linux, macOS, and Windows package tests and serial RL-SE and GSDB field tests in TinyCalc.

### Testing Checklist

- [x] Preset installs successfully via `specify preset add`
- [x] Template resolution works correctly after installation
- [x] Documentation is complete and accurate
- [x] Tested on at least one real project

### Submission Requirements

- [x] Valid `preset.yml` manifest included
- [x] Linked README (Documentation URL) explains how to use this preset and includes a valid `specify preset add ...` command (preferably `specify preset add --from <download-url>` using the exact download URL)
- [x] LICENSE file included
- [x] GitHub release created with version tag
- [x] Preset ID follows naming conventions (lowercase-with-hyphens)

### Scope Boundary

The field-test outcome is `ReleaseAccepted` for preset v0.1.2 and its evidence contract only. It does not approve TinyCalc findings, human decisions, product or sandbox release, certification, fleet rollout, or selection of Level-2 repositories.
