<!-- intake-authoring:begin -->
# Lastenheft: KDM-/KITSM-C#-Lernreihen-Rollout

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 24, nach Position 23
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** KDM-/KITSM-Lernende, Lehrende, Ausbildende, C#-Maintainer,
Flotten-Operatoren und Reviewer
**Vorausgesetztes Wissen:** abgeschlossene Positionen 20 bis 23; Grundwissen
über Git-Branches und Pull Requests, aber keine Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake integriert die freigegebenen KDM-/KITSM-Lernmaterialien in die
vorhandenen Secure-Trader-Rollouts. Ein **Rollout** ist die kontrollierte,
nachweisbare Verteilung kanonischer Level-0-Inhalte in festgelegte
Zielrepositories.

C#/.NET bleibt vorerst die einzige aktive Referenzsprache. Andere vorhandene
MSL-Repositories werden nicht verändert.

*This intake rolls out the accepted KDM and KITSM learning materials to the
existing Level-1 workspaces and C# reference repositories.*

## 2. Verbindliche Ziele / Binding Targets

Level 1:

- `SecureOrderDeskProjects`
- `SecureServiceHarvesterProjects`
- `secure-casetracker-baseline`

Level 2:

- `SecureOrderDeskProjects/SecureOrderDesk-CSharp`
- `SecureServiceHarvesterProjects/SecureServiceHarvester-CSharp`
- `SecureCaseTrackerProjects/SecureCaseTracker-CSharp`

## 3. Rollout-Profil / Rollout Profile

Die bestehenden Bash- und PowerShell-Rolloutoberflächen erhalten ein
deklaratives Profil `kdm-kitsm-csharp`. Das Profil beschreibt:

- kanonische Level-0-Quellen;
- gemeinsame und serienspezifische Dateien;
- Level-1- und Level-2-Zielrollen;
- die drei C#-Referenzrepositories;
- Zielpfade, Root-Intakes und README-/Index-Verweise;
- Ausschlüsse für andere Sprachrepositories und Produktcode;
- Quell- und Zielhash-Evidence.

Bestehende `--series`-/`-Series`-Aufrufe bleiben kompatibel. Das Profil bietet
Dry-Run sowie die Auswahl genau eines Zielrepositories pro schreibendem Aufruf.
Branch, Push, PR und Merge bleiben Aufgabe des übergeordneten
`MergeAndSync`-Workflows.

## 4. Anforderungen / Requirements

- **KRO-001:** Der Rollout verwendet ausschließlich gemergte Level-0-Quellen
  aus Positionen 20 bis 23.
- **KRO-002:** Das Profil `kdm-kitsm-csharp` wählt genau die sechs benannten
  Zielrepositories.
- **KRO-003:** Level 1 erhält das vollständige Lern- und
  Koordinationsmaterial.
- **KRO-004:** C#-Level 2 erhält relevante Root-Intakes,
  `docs/learning-units/`, C#-/SQL-Nachweise, README-/Index-Verweise und den
  eindeutigen nächsten Lernschritt.
- **KRO-005:** Go-, Java-, Python-, Rust- und Swift-Repositories bleiben
  unverändert.
- **KRO-006:** Dry-Run ist read-only und zeigt Quelle, Ziel, Entscheidung,
  Änderung und nächste Aktion textorientiert.
- **KRO-007:** Ein schreibender Lauf bearbeitet höchstens ein explizit
  ausgewähltes Ziel.
- **KRO-008:** Dirty, Ahead, Diverged, Detached, Non-Default, fehlender Upstream
  oder Remote-Drift blockieren das Ziel ohne Reset oder Force.
- **KRO-009:** Nachweislich neuere Zielinhalte werden nicht überschrieben,
  sondern als Konflikt gemeldet.
- **KRO-010:** Kopie und Receipt sind idempotent; ein zweiter Lauf erzeugt keine
  Änderung.
- **KRO-011:** Quell- und Zielhash, Commit, Branch, Zielrolle, Dateimenge und
  Ausschlüsse werden pro Repository dokumentiert.
- **KRO-012:** Jeder Ziel-PR ist nicht leer, besitzt einen Exact-Head-Nachweis
  und wird einzeln geprüft.
- **KRO-013:** Es gibt keinen direkten Push auf den Default-Branch.
- **KRO-014:** Produktcode, Abhängigkeiten, Laufzeitverhalten und
  Lernendenlösungen bleiben unverändert.
- **KRO-015:** Bash und PowerShell liefern dieselbe Zielauswahl, Entscheidung
  und Fehlerklasse.
- **KRO-016:** Position 25 wird nicht automatisch gestartet.

## 5. Ergebnisartefakte / Expected Artifacts

- deklaratives Rollout-Profil;
- kompatibel erweiterte Bash-/PowerShell-Oberflächen und Manpages;
- positive und negative Rollout-Fixtures;
- sechs Ziel-Receipts;
- sechs nicht leere, gemergte Ziel-PRs;
- Level-0-Rolloutbericht und Statistik;
- C#-Referenz-Adoptionsmatrix.

## 6. Akzeptanzkriterien / Acceptance Criteria

- **AC-KRO-001:** Genau drei Level-1- und drei C#-Level-2-Ziele wurden
  erfolgreich aktualisiert.
- **AC-KRO-002:** Alle Zielhashes stimmen mit den vorgesehenen Level-0-Quellen
  überein.
- **AC-KRO-003:** Ein zweiter Dry-Run meldet für alle sechs Ziele keine
  Inhaltsänderung.
- **AC-KRO-004:** Andere MSL-Repositories und Produktcode sind unverändert.
- **AC-KRO-005:** Bash-/PowerShell-Parität, Links, Secrets, Accessibility und
  Agent-Parität bestehen.
- **AC-KRO-006:** Alle sechs PRs sind per Merge-Commit abgeschlossen und die
  lokalen Repositories stehen sauber auf synchronem Default-Branch.
- **AC-KRO-007:** Position 25 wurde nicht gestartet.

## 7. Nicht-Ziele und Stop-Grenzen / Non-Goals

- Keine Ausführung der Lernendenaufgaben.
- Keine Referenzlösung und kein Produktfeature.
- Keine Verteilung an andere MSL-Pfade.
- Kein Force-Push, Reset oder stilles Überschreiben.
- Ein unklarer Eigentümer, eine neuere Zieldatei oder ein nicht grüner
  Pflichtcheck stoppt das betroffene Ziel.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_KDM-KITSM-CSharp-Lernreihen-Rollout.md` as position 24. Verify the exact three Level-1 and three C# Level-2 targets, declarative kdm-kitsm-csharp profile, backward-compatible rollout interface, one-target write boundary, dry-run behavior, hash receipts, idempotency, MergeAndSync PR delivery, exclusion of other MSL repositories and product code, and no automatic closure run.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_KDM-KITSM-CSharp-Lernreihen-Rollout.md` as the binding intake for position 24. Create a feature specification for the declarative kdm-kitsm-csharp rollout profile, compatible Bash/PowerShell selection, six exact targets, source/target receipts, safe one-target application, six non-empty MergeAndSync PRs, idempotency, and exclusions. Preserve KRO-001 through KRO-016 and AC-KRO-001 through AC-KRO-007. Do not implement learner tasks, modify product code, touch other language repositories, or start position 25.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_KDM-KITSM-CSharp-Lernreihen-Rollout.md` with deliveryAuthority=MergeAndSync after positions 20 through 23 are merged. Implement the Level-0 rollout profile and validators, then deliver only the accepted learning materials through one non-empty PR in each of the three Level-1 and three C# Level-2 targets. Never push directly to a default branch, never modify product code or other MSL repositories, return every repository to clean synchronized default branch, close the Level-0 feature PR, and do not start position 25.
```

<!-- intake-authoring:end -->
