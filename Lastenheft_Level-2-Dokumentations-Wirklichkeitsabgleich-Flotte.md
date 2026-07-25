<!-- intake-authoring:begin -->
# Lastenheft: Level-2-Dokumentations-Wirklichkeitsabgleich der Flotte

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-25
**Reihenfolge:** verbindlicher Vorlauf D3
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Auszubildende in IT-Berufen, Lehrende, Repository-Owner,
Maintainer und Reviewer

## 1. Zweck / Purpose

Dieser Intake überträgt den in Vorlauf D2 gemergten
Documentation-Impact-Vertrag kontrolliert auf alle zum Ausführungszeitpunkt
registrierten Level-2-Repositories. Jedes Repository wird zuerst gegen seine
eigene Runtime, Sprache, Toolchain, Plattformen und fachliche Dokumentation
geprüft. Danach werden nur bestätigte Abweichungen korrigiert.

Eine **Flotte** ist hier die zentral registrierte Menge eigenständiger
Level-2-Git-Repositories. Flottenarbeit bedeutet nicht, dass Dateien blind
gleichgemacht werden.

*This intake applies the merged Level 0 documentation-impact contract to every
registered Level 2 repository. Each repository is assessed against its own
runtime and project reality before evidence-based corrections are delivered.*

## 2. Reihenfolge und Voraussetzungen / Order and Prerequisites

Der Intake ist Vorlauf D3 und benötigt den vollständig gemergten
Level-0-Abgleich samt Governance aus D2. Nach seinem Abschluss dürfen die
bestehenden Positionen 1 bis 17 mit der aktualisierten Dokumentationsbaseline
weiterlaufen. Die Flotteninventur wird bei Laufbeginn aus dem aktuellen
Level-2-Register erzeugt; eine historische feste Repository-Anzahl ist nicht
verbindlich.

## 3. Flottenmodell / Fleet Model

Für jedes registrierte Repository werden mindestens erfasst:

- Registry-ID, lokaler Pfad, kanonischer Remote und Default-Branch;
- Level-, Lernreihen- und Projektzuordnung;
- Primärsprache, Memory-Safe-Language-Status und dokumentierte Ausnahme;
- Runtime, Build-, Test-, A11Y- und Plattformvertrag;
- installierte Preset-Profile und Agentenoberflächen;
- repository-eigene Dokumentationsfamilien und generierte Dokumente;
- aktuelle Branch-, Remote-, Ahead-/Behind- und Worktree-Klassifikation.

Vor schreibenden Aktionen gilt die flottenweite Remote-Freshness-Barriere.
Unsichere, schmutzige, vorausliegende, divergierte oder nicht eindeutig
zugeordnete Repositories werden nicht verändert.

## 4. Anforderungen / Requirements

- **DRF-001:** Der Lauf inventarisiert alle aktuell registrierten
  Level-2-Repositories und dokumentiert ausdrücklich ausgeschlossene oder
  unerreichbare Einträge.
- **DRF-002:** Jeder erreichbare `origin` wird vor weiteren Aktionen per
  `fetch --prune` geprüft; sichere Fast-forward-Pulls folgen ausschließlich
  dem genehmigten Remote-Freshness-Vertrag.
- **DRF-003:** Jedes Repository erhält ein eigenes Dokumentationsinventar,
  Claim-to-Evidence-Mapping und genau eine Hauptentscheidung pro geprüfter
  Einheit.
- **DRF-004:** Die Level-0-Regel wird als Governance-Baseline übernommen,
  ohne projektspezifische Dokumentation, Sprache, Runtime oder Evidence blind
  zu überschreiben.
- **DRF-005:** Findings werden pro Repository dedupliziert, besitzen stabile
  IDs, Owner, Schweregrad, Evidence, Restrisiko und Wiedervorlage.
- **DRF-006:** Jede Änderung verwendet `UpdateRequired`,
  `NoUpdateRequired`, `GeneratedUpdate` oder `FollowUp` mit denselben
  Zulässigkeitsregeln wie Position 19.
- **DRF-007:** Agentenflächen, Constitution, Spec-Kit-Templates und
  Projekt-Guidance werden nur entsprechend dem jeweiligen Repository-Vertrag
  synchronisiert.
- **DRF-008:** Lernreihen-Repositories behalten ihren Berufsbild-, Sprach-,
  A11Y- und Ausbildungsjahreskontext.
- **DRF-009:** Nicht-MSL-Repositories wie `cc65` behalten ihre dokumentierte
  Sprach- und Sicherheitsbegründung; MSL-Regeln werden nicht fälschlich
  erzwungen.
- **DRF-010:** Native Windows-, Linux- und macOS-Nachweise werden dort
  ausgeführt, wo Dokumentation plattformspezifisches Verhalten behauptet.
- **DRF-011:** Pro Repository entsteht ein nicht leerer, separat prüfbarer PR;
  zentrale Evidence-, Registry- und Statistikdateien werden serialisiert.
- **DRF-012:** Parallele Bearbeitung ist nur für voneinander unabhängige,
  saubere Repositories zulässig; Status, Konsolidierung und Remote-Autorität
  folgen dem installierten Parallel-Autonomous-Vertrag.
- **DRF-013:** Admin-Bypass ist nur im bereits genehmigten engen Rahmen
  zulässig: technische Gates grün oder nachgewiesene Provider-Zero-Step-
  Abweisung, null umsetzbare Threads und Human Approval als einziges offenes
  Gate.
- **DRF-014:** Kein Produktverhalten, keine API und keine Abhängigkeit wird
  allein zur Angleichung an veraltete Dokumentation geändert; solche Befunde
  werden als separate Produktentscheidungen gestoppt.

## 5. Nicht-Ziele / Non-Goals

- Keine Level-1- oder nicht registrierte Repository-Flottenänderung.
- Keine blinde Dateikopie aus Home Baseline.
- Keine Vereinheitlichung fachlich unterschiedlicher Projekte.
- Keine automatische Produktkorrektur.
- Kein Überschreiben lokaler fremder Änderungen.
- Kein Sammel-PR über unabhängige Repositories.
- Kein automatisch gestarteter Folge-Intake.

## 6. Validierung / Validation

- vollständige Registry- und Remote-Freshness-Evidence;
- positive und negative Dokumentations-Fixtures je relevantem Projekttyp;
- repository-native Build-, Test-, Link-, A11Y- und Generierungsprüfungen;
- Preset- und Agent-Parität;
- Secret- und Supply-Chain-Scans nach Repository-Vertrag;
- Exact-Head-Prüfung pro PR;
- zentrale Konsolidierung mit Repo-, PR-, Check-, Review-, Merge- und
  Synchronisationsstatus;
- Nachweis sauberer Default-Branches nach Abschluss.

## 7. Akzeptanzkriterien / Acceptance Criteria

- **AC-DRF-001:** Jedes registrierte Level-2-Repository ist als geprüft,
  begründet blockiert oder ausdrücklich nicht anwendbar dokumentiert.
- **AC-DRF-002:** Kein unsicher klassifiziertes Repository wurde verändert.
- **AC-DRF-003:** Alle bearbeiteten Repositories verwenden den
  Documentation-Impact-Vertrag ohne Verlust projektspezifischer Inhalte.
- **AC-DRF-004:** Critical-/High-Dokumentationsfindings sind gelöst oder
  blockieren den Abschluss wahrheitsgemäß.
- **AC-DRF-005:** Alle ausgeführten nativen und Remote-Gates sind dem exakten
  PR-Head zugeordnet; fehlende Provider-Evidence wird nicht als Pass gewertet.
- **AC-DRF-006:** Es bestehen null umsetzbare Review-Threads.
- **AC-DRF-007:** Alle gemergten Repositories stehen lokal sauber und
  synchron auf ihrem Default-Branch.
- **AC-DRF-008:** Der Abschlussbericht enthält genaue Repository-, Finding-,
  PR-, Check-, Review- und Blockerzahlen.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Level-2-Dokumentations-Wirklichkeitsabgleich-Flotte.md` as mandatory documentation preflight D3. Verify the dependency on D2, runtime inventory instead of a fixed repository count, Remote Freshness Barrier, project-specific preservation, exact impact decisions, MSL and learner boundaries, native platform evidence, per-repository PR delivery, constrained parallelism, and the gate before existing Positions 1 through 17. Do not modify the intake or start downstream work.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Level-2-Dokumentations-Wirklichkeitsabgleich-Flotte.md` as the binding intake for mandatory documentation preflight D3 and the merged D2 Documentation Impact baseline as mandatory governance. Create the feature specification for a fleet-wide, evidence-based Level-2 documentation reality reconciliation. Preserve DRF-001 through DRF-014, AC-DRF-001 through AC-DRF-008, runtime registry inventory, Remote Freshness Barrier, project-specific ownership, exact impact decisions, native platform proof, per-repository PRs, constrained parallelism, learner accessibility, and no-product-change boundaries.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Level-2-Dokumentations-Wirklichkeitsabgleich-Flotte.md` with deliveryAuthority=MergeAndSync after documentation preflight D2 is complete. Inventory the current registered Level-2 fleet, enforce the Remote Freshness Barrier, audit each repository against its own reality, remediate only accepted documentation findings through separate non-empty PRs, preserve project-specific guidance and evidence, converge all required and optional checks and reviews, serialize central evidence and statistics, return every changed repository to a clean synchronized default branch, and do not start existing Position 1 or another intake automatically.
```

<!-- intake-authoring:end -->
