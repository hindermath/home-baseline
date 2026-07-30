<!-- intake-authoring:begin -->
# Lastenheft: ITSE-C#-Lernreihen-Rollout

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 31, nach Position 30
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** ITSE- und FI-Lernende, Lehrende, C#-Maintainer,
Flotten-Operatoren und Reviewer
**Vorausgesetztes Wissen:** abgeschlossene Positionen 28 bis 30; Grundwissen
über Git und Pull Requests

## 1. Zweck / Purpose

Dieser Intake verteilt die freigegebenen ITSE-Lernmaterialien kontrolliert in
die vorhandenen Secure-Trader-Rollouts. Secure ServiceHarvester ist der
primäre ITSE-Referenzkontext.

*This intake rolls out the accepted ITSE materials to the established Level-1
workspaces and C# reference repositories.*

## 2. Verbindliche Ziele / Binding Targets

Level 1:

- `SecureOrderDeskProjects`;
- `SecureServiceHarvesterProjects`;
- `secure-casetracker-baseline`.

Level 2:

- `SecureOrderDeskProjects/SecureOrderDesk-CSharp`;
- `SecureServiceHarvesterProjects/SecureServiceHarvester-CSharp`;
- `secure-casetracker-baseline/securecasetracker-csharp`.

ServiceHarvester erhält die vollständige ITSE-Professional-Reihe. OrderDesk und
CaseTracker erhalten nur passende Aufgaben, Mappings und Verweise.

## 3. Anforderungen / Requirements

- **IRO-001:** Der Rollout verwendet ausschließlich gemergte Level-0-Quellen
  aus Positionen 28 bis 30.
- **IRO-002:** Ein deklaratives Profil `itse-csharp` benennt genau die sechs
  Zielrepositories und ihre Rollen.
- **IRO-003:** ServiceHarvester Level 1 und C# Level 2 sind die primären
  Vollziele.
- **IRO-004:** OrderDesk und CaseTracker erhalten nur fachlich passende
  Inhalte; die Professional-Reihe wird nicht dupliziert.
- **IRO-005:** FI-, KDM- und KITSM-Lernmaterialien bleiben erhalten und werden
  nur bei gemeinsamen kanonischen Verweisen angepasst.
- **IRO-006:** Andere Sprachrepositories und Produktcode bleiben unverändert.
- **IRO-007:** Dry-Run zeigt Quelle, Ziel, Rolle, Entscheidung, Änderung und
  nächste Aktion textorientiert.
- **IRO-008:** Ein schreibender Lauf bearbeitet höchstens ein ausdrücklich
  gewähltes Ziel.
- **IRO-009:** Dirty, Ahead, Diverged, Detached, Non-Default, fehlender
  Upstream oder Remote-Drift blockieren das Ziel ohne Reset oder Force.
- **IRO-010:** Neuere Zielinhalte werden nicht still überschrieben.
- **IRO-011:** Kopie und Receipt sind idempotent.
- **IRO-012:** Quell-/Zielhash, Commit, Branch, Zielrolle, Dateimenge und
  Ausschlüsse werden pro Repository dokumentiert.
- **IRO-013:** Jedes tatsächlich geänderte Ziel erhält einen nicht leeren
  Exact-Head-PR; unveränderte Ziele erhalten keinen Leer-PR.
- **IRO-014:** Bash und PowerShell liefern dieselbe Entscheidung und
  Fehlerklasse.
- **IRO-015:** Position 32 wird nicht automatisch gestartet.

## 4. Ergebnisartefakte / Expected Artifacts

- Rollout-Profil `itse-csharp`;
- Bash-/PowerShell-Oberflächen und Tests;
- sechs Ziel-Receipts;
- nicht leere PRs nur für geänderte Ziele;
- Level-0-Rolloutbericht;
- ITSE-/FI-Adoptionsmatrix.

## 5. Akzeptanzkriterien / Acceptance Criteria

- **AC-IRO-001:** Alle sechs Ziele wurden geprüft und alle fachlich
  erforderlichen Änderungen geliefert.
- **AC-IRO-002:** ServiceHarvester besitzt die vollständige ITSE-Reihe.
- **AC-IRO-003:** OrderDesk und CaseTracker enthalten keine unnötige
  Professional-Duplikation.
- **AC-IRO-004:** Ein zweiter Dry-Run meldet keine Inhaltsänderung.
- **AC-IRO-005:** Andere Sprachpfade und Produktcode sind unverändert.
- **AC-IRO-006:** Alle erzeugten PRs sind gemergt und die lokalen Repositories
  sauber synchronisiert.
- **AC-IRO-007:** Position 32 wurde nicht gestartet.

## 6. Nicht-Ziele / Non-Goals

- Keine Durchführung der Lernendenaufgaben.
- Keine Produktfeatures oder Referenzlösungen.
- Kein Force-Push oder direkter Default-Branch-Push.
- Kein Leer-PR.

<!-- intake-authoring:prompts -->
## 7. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_ITSE-CSharp-Lernreihen-Rollout.md` as position 31. Verify the six exact targets, ServiceHarvester primary/full role, bounded OrderDesk and CaseTracker adoption, FI/KDM/KITSM preservation, declarative profile, dry-run, one-target write boundary, receipts, idempotency, non-empty PR rule, Bash/PowerShell parity, and no closure start.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_ITSE-CSharp-Lernreihen-Rollout.md` as the binding intake for position 31. Create a feature specification for the itse-csharp rollout profile, six target roles, full ServiceHarvester adoption, bounded OrderDesk/CaseTracker references, safe one-target application, receipts, idempotency, and non-empty MergeAndSync PRs. Preserve IRO-001 through IRO-015 and AC-IRO-001 through AC-IRO-007. Do not modify product code, other language repositories, or start position 32.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_ITSE-CSharp-Lernreihen-Rollout.md` with deliveryAuthority=MergeAndSync after positions 28 through 30 are merged. Deliver only accepted ITSE learning materials through one non-empty PR per changed target, preserve other professions and product code, return every repository to clean synchronized default branch, close the Level-0 PR, and do not start position 32.
```

<!-- intake-authoring:end -->
