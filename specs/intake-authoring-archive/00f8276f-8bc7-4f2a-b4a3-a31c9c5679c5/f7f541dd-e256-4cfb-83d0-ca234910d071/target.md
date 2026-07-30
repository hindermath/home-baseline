<!-- intake-authoring:begin -->
# Lastenheft: Agentic-Workspace- und Ein-Kommando-Wartung-Effizienzleitfaden

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Dokumentationsvorlauf D6, nach abgeschlossenem D5
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Lernende und Nutzende ohne Spec-Kit-Vorkenntnisse, Lehrende,
Maintainer, KI-Agenten, Systemintegrator*innen und Reviewer

## 1. Zweck / Purpose

D6 erstellt eine maximal verständliche, aber gestuft aufgebaute Anleitung für
die effiziente und sichere Nutzung des agentischen Workspace und der
plattformübergreifenden Ein-Kommando-Wartung. **Agentisch** bedeutet hier:
KI-Agenten bearbeiten klar begrenzte Aufgaben unter dokumentierter
Berechtigung, Evidence und menschlicher Verantwortung.

„Effizient“ bedeutet: unnötige Wiederholungen, unklare Zustände und vermeidbare
Agentenkontextkosten reduzieren, ohne Sicherheits-, Review- oder
Qualitätsgates abzukürzen. Aussagen wie „schnellster“ oder „vollautomatisch“
benötigen Mess- oder Feldevidence.

*D6 documents the safest evidenced efficient path for the agentic workspace and
one-command maintenance. It does not change maintenance behavior; missing
automation becomes a separate follow-up.*

## 2. Voraussetzungen und Scope / Preconditions and Scope

- Aktive Positionen 1 bis 4 sowie D4 und D5 sind abgeschlossen.
- Die tatsächlich gemergten Befehle, Optionen, Exitcodes und Reports sind
  verbindliche Wahrheit.
- D6 verändert keine Wartungsskripte, Registry, Toolchain oder Runtime.
- Dokumentationsbezogene Test-Helfer sind nur zulässig, wenn sie kein
  Betriebsverhalten ändern.
- Nicht dokumentierbare Automatisierungslücken werden als eigene Follow-ups
  erfasst.

## 3. Verbindliche Leserpfade / Binding Reader Paths

Der Leitfaden bietet getrennte Einstiege für:

1. **Erster sicherer Lauf:** Voraussetzungen, Begriffe, `--check-only` und
   Ergebnislesen.
2. **Regelmäßiger Betrieb:** Vorschau, echter Lauf, Reports und nächste Aktion.
3. **Maintainer und KI-Agenten:** Quellen, Berechtigungen, Drift-Reparatur,
   Branch-/PR-Handoff und Evidence.
4. **Fehleranalyse und Audit:** Exitcodes, Locks, Unterbrechung, Wiederanlauf,
   Providergrenzen und reproduzierbare Diagnose.

## 4. Verbindlicher Betriebsablauf / Binding Operating Flow

```text
Quelle und Autorität prüfen
  -> Remote-Freshness- und Arbeitsbaumstatus prüfen
  -> schreibfreien Check ausführen
  -> Vorschau der erlaubten Änderungen ausführen
  -> Befunde und Risiken bewerten
  -> echten Lauf ausdrücklich autorisieren
  -> Logs, Reports und Exitcode prüfen
  -> Repository-Änderungen getrennt über Branch und PR liefern
```

Jeder Schritt erhält Zweck, Voraussetzungen, erwartetes Ergebnis, Fehlergrenze
und exakte nächste Aktion. Keine Bedeutung wird ausschließlich durch Farbe,
Symbol oder visuelle Position vermittelt.

## 5. Inhaltliche Mindestabdeckung / Required Content

- dauerhafte Level-0-Quelle gegenüber lokaler Home-Runtime;
- Remote-Freshness-Barriere für Level 0/1/2;
- Clean, Dirty, Ahead, Behind, Diverged, Detached und Non-Default;
- `--check-only`, `--dry-run`/`-WhatIf` und echter Lauf;
- `--scripts-only`, `--repair-drift`, optionale Pakete und Admin-Prompts;
- gewünschter Flottenzustand, Registry und Preset-Profile;
- Grenzen automatischer Pulls und lokale Änderungen;
- Delivery Authority: LocalImplementation, PublishPR, MergeAndSync;
- KI-Agenten-Prompt mit Ziel, Scope, Authority, Evidence und Stop-Grenzen;
- gemeinschaftlich beschriebene Dateien und Serialisierungsgrenzen;
- Logs, JSON-Reports, Run-ID, Statusklassen und Exitcodes;
- Lock, unerwartete Unterbrechung, Statusprüfung und sichere Wiederaufnahme;
- Drift-Reparatur sowie anschließender Commit-/PR-Handoff;
- macOS-, Linux-/Ubuntu- und Windows-Pfade;
- Secrets, Administratorrechte, Sandbox und Providerfehler;
- Troubleshooting mit textorientierter Ursache und nächster Aktion.

## 6. Effizienzregeln für KI-Agenten / AI-Agent Efficiency Rules

- Der Agent erhält exakte Repository-, Branch-, Intake- und Evidence-Pfade.
- Vorhandene Skripte und Check-Modi werden genutzt, statt gleiche Prüfungen
  ad hoc neu zu implementieren.
- Read-only Inventarisierung wird gebündelt; schreibende gemeinsame Dateien
  werden serialisiert.
- Ein bereits valides Ergebnis wird verifiziert und nicht blind wiederholt.
- Logs und Reports werden über Run-ID referenziert, nicht vollständig in
  Prompts kopiert.
- Agenten dürfen fehlende Authority nicht aus früheren Sitzungen ableiten.
- Ein Wartungslauf committet oder pusht Ziel-Repositories nicht automatisch.
- Admin-Bypass ist kein Wartungsskriptmodus und wird nicht implizit erteilt.
- Geschwindigkeit ist ein Sekundärindikator; überprüfbare Arbeit pro
  vollständigem Qualitätszyklus bleibt maßgeblich.

## 7. Anforderungen / Requirements

- **AEG-001:** Es entstehen synchron gepflegte deutsche und englische
  Betriebs- und Effizienzleitfäden.
- **AEG-002:** Jeder Leitfaden beginnt mit Zielgruppe, Vorwissen, Begriffen,
  Sicherheitsgrenzen und einem sicheren Schnellstart.
- **AEG-003:** Alle tatsächlich unterstützten Optionen und Exitcodes werden
  gegen die gemergte Implementierung geprüft.
- **AEG-004:** Check, Vorschau und echter Lauf werden klar unterschieden.
- **AEG-005:** Jeder Befehl nennt Plattform, Arbeitsverzeichnis,
  Voraussetzungen, Nebenwirkung und erwarteten Exitcode.
- **AEG-006:** Die Remote-Freshness-Barriere und alle Arbeitsbaumklassen werden
  textorientiert erklärt.
- **AEG-007:** Source-Checkout, Home-Runtime und Sync-Grenze werden ohne
  vorausgesetztes Level-Modell-Wissen erklärt.
- **AEG-008:** KI-Agenten erhalten eine wiederverwendbare Prompt- und
  Authority-Checkliste.
- **AEG-009:** Serielle und parallele Arbeit wird anhand gemeinsamer
  Schreibflächen und Evidence erklärt.
- **AEG-010:** Logs, Reports und Run-IDs erhalten einen Diagnose- und
  Aufbewahrungsleitfaden.
- **AEG-011:** Unterbrechung, Lock und Wiederanlauf werden ohne Annahme eines
  erfolgreichen Endzustands beschrieben.
- **AEG-012:** Drift-Reparatur endet mit einem klaren separaten
  Branch-/Review-/PR-Handoff.
- **AEG-013:** Administrator-, Secret-, Sandbox- und Providergrenzen bleiben
  fail-closed.
- **AEG-014:** Alle Beispiele verwenden sichere Test- oder Vorschaumodi, soweit
  die jeweilige Aussage damit belegbar ist.
- **AEG-015:** Nicht sicher automatisierbare Schritte werden als menschliche
  Entscheidung gekennzeichnet.
- **AEG-016:** Effizienzbehauptungen besitzen Mess-, Feld- oder
  Ablauf-Evidence; unbelegte Superlative sind unzulässig.
- **AEG-017:** Lernende erhalten Fachbegriffe beim ersten Auftreten auf CEFR-B2-
  Niveau erklärt.
- **AEG-018:** Inhalte erfüllen anwendbare WCAG-2.2-AA- und Text-first-Regeln.
- **AEG-019:** Technische Automatisierungslücken erhalten getrennte,
  nicht leere Follow-up-Intakes statt stiller Skriptänderungen.
- **AEG-020:** D6 verändert kein ausführbares Wartungsverhalten und startet D7
  nicht automatisch.

## 8. Akzeptanzkriterien / Acceptance Criteria

- **AC-AEG-001:** Ein Lernender kann aus der Dokumentation einen sicheren
  schreibfreien Erstlauf auswählen und dessen Ergebnis erklären.
- **AC-AEG-002:** Ein täglicher Nutzer kann aus einem Exitcode und Report die
  genaue nächste Aktion bestimmen.
- **AC-AEG-003:** Ein Maintainer kann eine lokale Drift-Reparatur kontrolliert
  in einen separaten PR überführen.
- **AC-AEG-004:** Ein KI-Agenten-Prompt enthält Ziel, Scope, Authority,
  Evidence, Stop-Grenzen und Abschlusszustand.
- **AC-AEG-005:** Deutsche und englische Fassungen besitzen denselben
  Informationsumfang und funktionierende Querverweise.
- **AC-AEG-006:** Sichere Beispiele bestehen im passenden Check- oder
  Vorschaumodus.
- **AC-AEG-007:** Manpage, README, Leitfaden und tatsächliche Optionen
  widersprechen sich nicht.
- **AC-AEG-008:** Keine Automatisierungslücke wurde durch eine undokumentierte
  funktionale Änderung verdeckt.
- **AC-AEG-009:** Semantischer, A11Y-, Link-, Secret- und Plattformreview sind
  nachgewiesen.
- **AC-AEG-010:** D7 wurde nicht automatisch gestartet.

## 9. Nicht-Ziele / Non-Goals

- Keine Änderung von Wartungs-, Sync-, Registry- oder Toolchain-Skripten.
- Keine Garantie einer absoluten maximalen Laufzeit oder Agentengeschwindigkeit.
- Keine implizite Remote-, Admin- oder Bypass-Autorität.
- Kein Ersatz für Ausbildung, Review oder menschliche Betriebsentscheidung.

<!-- intake-authoring:prompts -->
## 10. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.md` as documentation preflight D6. Verify its dependencies on active positions 1 through 4 and D5, four reader paths, evidenced safe operating flow, exact maintenance options and exit-code boundaries, AI-agent authority and prompt guidance, interruption and recovery, platform parity, criteria for efficiency claims, separate automation follow-ups, learner accessibility, and strict no-runtime-change scope. Do not modify the intake or start D6.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.md` as the binding intake for documentation preflight D6 after active positions 1 through 4 and D5 are complete. Create the feature specification for synchronized German and English learner, operator, maintainer/AI-agent, and audit guidance for the agentic workspace and one-command maintenance. Preserve AEG-001 through AEG-020, AC-AEG-001 through AC-AEG-010, evidenced efficiency claims, safe command validation, authority and interruption boundaries, separate automation follow-ups, and no executable behavior changes. Do not start D7.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.md` with deliveryAuthority=MergeAndSync after active positions 1 through 4 and D5 are merged. Document only the actual supported workspace and maintenance behavior, validate safe examples and both language paths, create separate follow-up intakes for evidenced automation gaps, preserve all executable behavior and authority boundaries, converge required and useful optional checks and reviews, merge one non-empty Level-0 PR, return to clean synchronized main, and do not start D7 automatically.
```

<!-- intake-authoring:end -->
