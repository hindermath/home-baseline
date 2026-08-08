# Sicherheitsdokumentation / Security Documentation

## Deutsch

**Repository**: home-baseline (Level 0)
**Constitution-Referenz**: Prinzip XII (A.8.28), Prinzip XIII (A.8.27),
Prinzipien XIV bis XVIII

### Einstieg in die RL-SE-Selbstprüfung

Die Richtlinie für sichere Entwicklung (RL-SE) wird für dieses Level-0-
Repository in zwei Ergebnisdateien geprüft:

1. [Abschlusszusammenfassung der RL-SE-Selbstprüfung](secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md)
   erklärt Status, wichtigste Risiken, Aussagegrenzen und nächste Aktionen.
2. [Vollständige RL-SE-Assessment-Matrix](secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md)
   enthält jede einzelne Entscheidung, Evidence, Rolle und Re-Evaluation.

Beginne ohne Spec-Kit-Vorkenntnisse mit der Zusammenfassung. Wähle dort eine
ID und suche dieselbe ID in der Matrix, wenn du Primärquelle und vollständige
Details brauchst. Diese neue Navigation ändert keine historische
Feature-024-Evidence und deutet ältere, feature-begrenzte Sicherheitsdateien
nicht als repositoryweite Erfüllung um.

### Zweck

Dieses Verzeichnis enthält die projektspezifische Sicherheitsdokumentation für
home-baseline. Die Templates stammen aus `.specify/templates/` und werden hier
mit projektspezifischen Inhalten befüllt.

### Bestehende Dokumente

Die Spalte „historischer Indexstatus“ bewahrt die bisherige Indexbezeichnung.
Die aktuelle Selbstprüfung bewertet Aussageumfang und Frische getrennt.

| Dokument | Template-Quelle | Historischer Indexstatus |
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

### Anwendungshinweise

- Architecture Decision Records (ADRs) liegen als einzelne Dateien unter
  `docs/security/adr/`.
- Jedes Level-2-Projekt pflegt eigene Instanzen dieser Dokumente.
- Die Templates in `.specify/templates/` sind die kanonische Quelle.
- Der Standard-Evidence-Ort für neue Sicherheitsnachweise ist
  `docs/security/`.
- Ein gleichwertiger Governance-Pfad muss hier dokumentiert und verlinkt sein.

## English

**Repository**: home-baseline (Level 0)
**Constitution reference**: Principle XII (A.8.28), Principle XIII (A.8.27),
Principles XIV through XVIII

### Entry point for the RL-SE self-assessment

The Secure Development Guideline (RL-SE) is assessed for this Level 0
repository in two result files:

1. [RL-SE self-assessment summary](secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md)
   explains status, highest risks, claim boundaries, and next actions.
2. [Complete RL-SE assessment matrix](secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md)
   contains every individual decision, evidence item, role, and re-evaluation.

If you have no Spec Kit experience, start with the summary. Select an ID there
and search for the same ID in the matrix when you need its primary source and
complete details. This new navigation does not change historical Feature 024
evidence and does not reinterpret older feature-limited security files as
repository-wide fulfilment.

### Purpose

This directory contains project-specific security documentation for
home-baseline. Templates originate from `.specify/templates/` and are
populated here with project-specific content.

### Existing documents

The “historical index status” column preserves the previous index label. The
current self-assessment evaluates claim scope and freshness separately.

| Document | Template source | Historical index status |
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

### Usage notes

- Architecture Decision Records (ADRs) are individual files under
  `docs/security/adr/`.
- Each Level 2 project maintains its own instances of these documents.
- Templates in `.specify/templates/` are the canonical source.
- The default evidence location for new security records is `docs/security/`.
- An equivalent governance path must be documented and linked here.
