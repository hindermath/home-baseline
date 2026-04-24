# Sicherheitsdokumentation / Security Documentation

**Repository**: home-baseline (Level-1)
**Constitution-Referenz / Constitution Reference**: Principle XII (A.8.28), Principle XIII (A.8.27), Principle XIV-XVIII

## Zweck / Purpose

Dieses Verzeichnis enthält die projektspezifische Sicherheitsdokumentation
fuer home-baseline. Die Templates stammen aus `.specify/templates/` und
werden hier mit projektspezifischen Inhalten befuellt.

*This directory contains project-specific security documentation for
home-baseline. Templates originate from `.specify/templates/` and are
populated here with project-specific content.*

## Dokumente / Documents

| Dokument / Document | Template-Quelle / Template Source | Status |
|---|---|---|
| [threat-model.md](threat-model.md) | `threat-model-template.md` | Stub |
| [security-checklist.md](security-checklist.md) | `security-checklist-template.md` | Stub |
| [arc42-security.md](arc42-security.md) | `arc42-security-template.md` | Stub |
| [dependency-audit.md](dependency-audit.md) | `dependency-audit-template.md` | Stub |
| [security-quality-scenarios.md](security-quality-scenarios.md) | `security-quality-scenarios-template.md` | Stub |
| [asvs-verification.md](asvs-verification.md) | `asvs-verification-template.md` | Stub |
| [supply-chain-evidence.md](supply-chain-evidence.md) | `supply-chain-evidence-template.md` | Stub |
| [zero-trust-applicability.md](zero-trust-applicability.md) | `zero-trust-applicability-template.md` | Stub |
| [samm-assessment.md](samm-assessment.md) | `samm-assessment-template.md` | Stub |

## Anwendungshinweise / Usage Notes

- ADRs werden im Verzeichnis `docs/security/adr/` als einzelne Dateien abgelegt.
- Jedes Level-2-Projekt pflegt eigene Instanzen dieser Dokumente.
- Die Templates in `.specify/templates/` sind die kanonische Quelle.
- Default-Evidenzort fuer neue Standards: `docs/security/`.
- Falls ein Repo einen gleichwertigen Governance-Pfad statt `docs/security/`
  nutzt, muss diese Abweichung hier dokumentiert und verlinkt werden.

*ADRs are stored as individual files in `docs/security/adr/`.
Each Level-2 project maintains its own instances of these documents.
The templates in `.specify/templates/` are the canonical source.
The default evidence location for newly added standards is `docs/security/`.
If a repository uses an equivalent governance path instead, that deviation must
be documented and linked here.*

<!-- EN: docs/security/README.md
[DE-Zusammenfassung: Index der projektspezifischen Sicherheitsdokumentation fuer home-baseline.]
-->
