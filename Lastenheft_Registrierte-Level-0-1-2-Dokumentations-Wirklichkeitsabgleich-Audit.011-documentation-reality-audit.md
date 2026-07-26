<!-- intake-authoring:begin -->
# Lastenheft: Dokumentations-Wirklichkeitsabgleich der registrierten Level-0/1/2-Flotte

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-26
**Reihenfolge:** verbindlicher Vorlauf D1
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Fachinformatiker*innen, Kaufleute für IT-System-Management,
Kaufleute für Digitalisierungsmanagement, Lehrende, Maintainer und Reviewer
ab dem ersten Ausbildungsjahr

## 1. Zweck / Purpose

Dieser Intake beschreibt einen vollständigen, zunächst read-only ausgeführten
Abgleich der repository-eigenen Dokumentation mit der tatsächlichen
Implementierung in Level 0 und allen zum Ausführungszeitpunkt registrierten
Level-1- und Level-2-Repositories. **Read-only** bedeutet: Der Audit liest und
bewertet, ändert aber noch keine fachlichen Dokumente, Skripte oder
Konfigurationen.

Der **Wirklichkeitsabgleich** prüft, ob dokumentierte Aussagen zu Pfaden,
Befehlen, Versionen, Presets, Repositorys, Plattformen, Workflows,
Sicherheitsgrenzen und Bedienung im aktuellen Git-Stand nachweisbar stimmen.

*This intake defines a complete read-only reconciliation of repository-owned
documentation with the actual implementation in Level 0 and every registered
Level 1 and Level 2 repository. It records evidence and findings without
changing documentation or executable behavior.*

## 2. Reihenfolge und Voraussetzungen / Order and Prerequisites

Der Intake ist die Root des verbindlichen Dokumentationsvorlaufs D1 bis D3.
Dieser Vorlauf wird vor den bestehenden Positionen 1 bis 17 abgeschlossen,
damit alle späteren Änderungen bereits den geprüften
Documentation-Impact-Vertrag verwenden. D1 liefert die bindende Finding- und
Ownership-Basis für Vorlauf D2
`Lastenheft_Level-0-Dokumentations-Konsistenz-Remediation-und-Flotten-Governance.md`.

Die Zielmenge wird nicht aus einer historischen Zahl abgeleitet. Verbindlich
sind das Level-0-Repository und das bei Laufbeginn validierte zentrale Register
für Level 1 und Level 2. Jeder registrierte Eintrag wird geprüft oder mit einem
konkreten Blocker und einer nächsten Aktion ausgewiesen.

## 3. Dokumentationsumfang / Documentation Scope

„Gesamte Dokumentation“ umfasst in jedem Ziel-Repository alle
repository-eigenen, Git-getrackten Informationsflächen:

- Root-README, Constitution und gemeinsame Agenten-Guidance;
- alle Markdown-, Text-, AsciiDoc- und Manpage-Dateien unter `docs/`;
- Lastenhefte, Specs, Pläne, Tasks, Checklists, Contracts und Evidence;
- Spec-Kit-Templates, Commands, Skills und Preset-Dokumentation;
- skript- und cmdletnahe Hilfe, Usage-Texte und PowerShell
  Comment-Based Help;
- Workflow-, Registry-, Profil- und Konfigurationsdokumentation;
- generierte Dokumente und ihre repository-eigenen Quelldateien;
- Dokumentationsverweise in READMEs, Templates und Lernmaterialien.

Das Inventar erfasst zusätzlich pro Repository Registry-ID, Level, lokalen
Pfad, kanonischen Remote, Default-Branch, exakten Commit, Erreichbarkeit und
Dokumentations-Owner. Level-1-Workspaces werden nicht als bloße Container
übersprungen: Ihre eigenen READMEs, Governance-, Wartungs- und
Lernendeninformationen sind ein selbstständiger Prüfumfang.

Historische Archive und unveränderliche Fremdinhalte werden nicht
umgeschrieben. Der Audit prüft jedoch, ob sie klar als historisch oder extern
gekennzeichnet sind, eine Beweisgrenze besitzen und nicht als aktuelle
Anleitung erscheinen.

## 4. Bewertungsmodell / Assessment Model

Jede geprüfte Datei oder klar benannte Aussagegruppe erhält genau eine
Hauptentscheidung:

- `Accurate`: aktuell und durch Repository-Evidence bestätigt;
- `Stale`: früher richtig, heute überholt;
- `Contradictory`: widerspricht einer anderen maßgeblichen Quelle;
- `Orphaned`: besitzt keinen erkennbaren aktuellen Zweck oder Eigentümer;
- `Missing`: notwendige Dokumentation fehlt;
- `GeneratedDrift`: generiertes Dokument weicht von seinen Quellen ab;
- `HistoricalContext`: bewusst unverändert und korrekt als historisch markiert;
- `N/A`: nicht anwendbar, mit Begründung und Re-Evaluation-Trigger.

Findings erhalten stabile `DOC###`-IDs, Schweregrad, Owner, Evidence,
Restrisiko, Korrekturgrenze und Wiedervorlage.

## 5. Verbindliche Prüffragen / Binding Review Questions

- Stimmen dokumentierte Dateien und Verzeichnisse mit dem getrackten Baum
  überein?
- Existieren alle genannten Befehle, Parameter, Exitcodes und Beispiele?
- Stimmen Preset-Anzahl, IDs, Versionen, Prioritäten und Profile?
- Stimmen Repository-Register, Level-Zuordnung, Default-Branches und Remotes?
- Stimmen Plattform-, Runtime-, Build-, Test- und Toolchain-Aussagen?
- Stimmen Workflow-Namen, Pflichtchecks, Review- und Delivery-Grenzen?
- Sind Sicherheits-, A11Y-, Lernenden-, Sprach- und Evidence-Regeln
  widerspruchsfrei?
- Sind generierte Dokumente aus ihren Quellen reproduzierbar?
- Werden historische Aussagen klar von aktueller Handlungsanleitung getrennt?
- Fehlen Nutzer-, Betriebs-, Wartungs-, Fehler- oder Wiederanlaufhinweise?

## 6. Anforderungen / Requirements

- **DRA-001:** Der Audit erzeugt ein vollständiges Repository-Inventar für
  Level 0 und alle aktuell registrierten Level-1-/Level-2-Repositories sowie
  darin ein Inventar aller repository-eigenen Dokumentationsflächen mit Pfad,
  Typ, Owner-Kategorie, Aktualitätsquelle und normalisiertem SHA-256.
- **DRA-002:** Jede Datei oder benannte Aussagegruppe erhält genau eine
  zulässige Hauptentscheidung.
- **DRA-003:** Behauptungen über Code, Skripte, Commands, Presets, Workflows,
  Registry und Plattformen werden gegen konkrete Repository-Evidence geprüft.
- **DRA-004:** Doppelte normative Aussagen werden auf eine maßgebliche Quelle
  und abgeleitete Kopien zurückgeführt.
- **DRA-005:** Constitution, `.specify/memory/constitution.md` und alle
  gepflegten Agentenflächen werden auf Parität geprüft.
- **DRA-006:** Spec-, Plan-, Tasks-, Checklist- und PR-Templates werden auf
  fehlende Documentation-Impact-Prüfpunkte untersucht.
- **DRA-007:** Generierte Dokumente werden mit ihren kanonischen Build- oder
  Renderbefehlen geprüft.
- **DRA-008:** Lernendeninhalte werden auf Deutsch-zuerst/Englisch-danach,
  CEFR B2, Begriffserklärung, fehlende Vorkenntnisannahmen und textorientierte
  Alternativen geprüft.
- **DRA-009:** Anwendbare WCAG-2.2-AA-Kriterien werden für Markdown, HTML,
  CLI-Hilfe und Templates dokumentiert.
- **DRA-010:** Secrets, personenbezogene Daten, private absolute Pfade und
  maschinenlokale Zustände werden nicht in veröffentlichbare Evidence kopiert.
- **DRA-011:** Der Audit bewertet, ob bestehende Governance-Presets und
  Repository-Gates für die dauerhafte Regel ausreichen oder ein portables
  Preset-Follow-up fachlich gerechtfertigt ist.
- **DRA-012:** Der Lauf bleibt gegenüber Dokumentation, Produktcode, Skripten,
  Workflows, Presets und Remotes read-only; nur Feature- und Audit-Evidence
  darf entstehen.
- **DRA-013:** Findings unterscheiden ihre Ziel- und Ownership-Ebene
  ausdrücklich als `Level0`, `Level1` oder `Level2`; ein Finding darf nicht
  allein wegen ähnlicher Dateinamen mehreren Repositories zugeordnet werden.
- **DRA-014:** D1 ordnet jedes bestätigte Finding entweder der zentralen
  Level-0-Remediation in D2 oder der repository-spezifischen Level-1/2-
  Remediation in D3 zu, ohne die Korrektur bereits auszuführen.

## 7. Nicht-Ziele / Non-Goals

- Keine Dokumentationskorrektur innerhalb des Audits.
- Keine Runtime-, API-, Toolchain-, Preset- oder Workflow-Änderung.
- Keine Dokumentationskorrektur oder automatische Propagation auf irgendeiner
  Ebene.
- Kein vorab festgelegtes neues Preset.
- Keine pauschale Löschung historischer Dokumente.
- Kein automatischer Start von Vorlauf D2.

## 8. Ergebnisartefakte / Result Artifacts

- Dokumentationsinventar;
- Repository-Inventar für die registrierte Level-0/1/2-Zielmenge;
- Claim-to-Evidence-Matrix für überprüfbare Aussagen;
- Finding-Liste mit `DOC###`-IDs;
- Source-of-Truth- und Ownership-Matrix;
- Liste generierter Dokumente und ihrer Build-Verträge;
- Empfehlung für Constitution, Templates, Agentenflächen, CI und mögliche
  Preset-Follow-ups;
- textorientierter Abschlussbericht.

## 9. Akzeptanzkriterien / Acceptance Criteria

- **AC-DRA-001:** Level 0 und jeder beim Laufbeginn registrierte
  Level-1-/Level-2-Eintrag sind als geprüft, begründet blockiert oder
  ausdrücklich nicht anwendbar erfasst; alle erreichbaren
  repository-eigenen Dokumentationsflächen sind ohne stille Auslassung
  inventarisiert.
- **AC-DRA-002:** Jede geprüfte Einheit besitzt genau eine Hauptentscheidung.
- **AC-DRA-003:** Jede positive Aussage verweist auf konkrete Evidence.
- **AC-DRA-004:** Jedes Finding besitzt Owner, Schweregrad, Korrekturgrenze und
  Re-Evaluation-Trigger.
- **AC-DRA-005:** Generierte Dokumente sind als aktuell oder als
  `GeneratedDrift` nachgewiesen.
- **AC-DRA-006:** Normative Quelle, abgeleitete Kopien und historische
  Evidence sind klar getrennt.
- **AC-DRA-007:** Es verbleibt keine ungeklärte Critical-/High-Ambiguität für
  den Remediation-Plan.
- **AC-DRA-008:** Vorlauf D2 kann ausschließlich aus den Audit-Findings
  geplant werden und wurde nicht automatisch gestartet.
- **AC-DRA-009:** Die Finding-Matrix weist für jedes `DOC###` genau eine
  Ziel- und Ownership-Ebene sowie genau einen Handoff nach D2, D3 oder einen
  begründeten Nicht-Remediation-Ausgang aus.

<!-- intake-authoring:prompts -->
## 10. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Registrierte-Level-0-1-2-Dokumentations-Wirklichkeitsabgleich-Audit.md` as mandatory documentation preflight D1 and the root of the active ordered series. Verify complete coverage of Level 0 and every currently registered Level 1 and Level 2 repository, exact decision vocabulary, claim-to-evidence proof, level-specific ownership, generated-document boundaries, learner and A11Y requirements, read-only scope, and measurable acceptance criteria. Do not change the intake or start downstream work.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Registrierte-Level-0-1-2-Dokumentations-Wirklichkeitsabgleich-Audit.md` as the binding intake for mandatory documentation preflight D1. Create the feature specification for a complete read-only documentation reality audit of Level 0 and every currently registered Level 1 and Level 2 repository. Preserve DRA-001 through DRA-014, AC-DRA-001 through AC-DRA-009, the exact eight decision values, stable DOC### findings, level-specific ownership and handoff, registry-derived scope, historical and generated-content boundaries, learner accessibility, evidence, security, and no-remediation constraints. Do not implement corrections, create a new preset, or start preflight D2.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Registrierte-Level-0-1-2-Dokumentations-Wirklichkeitsabgleich-Audit.md` with deliveryAuthority=MergeAndSync as mandatory documentation preflight D1. Inventory Level 0 and every currently registered Level 1 and Level 2 repository. Keep all fleet documentation, product code, scripts, workflows, presets, and remotes read-only except for accepted Level-0 feature artifacts, deterministic audit tooling, audit evidence, ordering/archive/statistics updates, and delivery evidence. Converge required and optional quality steps, merge one non-empty Level-0 PR, return to clean synchronized main, and do not start preflight D2 automatically.
```

<!-- intake-authoring:end -->
