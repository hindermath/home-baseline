<!-- intake-authoring:begin -->
# Lastenheft: Sprachbewusste Requirements-Intake-Konsolidierungs-Governance

## Identitaet und Zielgruppe / Identity and Audience

- Vorgesehenes Feature: `014-requirements-intake-consolidation-governance`
- Verbindliche Quelle:
  `docs/work-items/2026-07-27-requirements-intake-consolidation-field-handoff.md`
- Liefermodus: `MergeAndSync`
- Zielgruppe: Fachinformatiker*innen, Kaufleute fuer IT-System-Management,
  Kaufleute fuer Digitalisierungsmanagement und Maintainer ab dem ersten
  Ausbildungsjahr
- Leitsatz: `Programmierung #include<everyone>`

Dieses Lastenheft beschreibt einen globalen Requirements-Vorlauf. Requirements
sind nachvollziehbare fachliche Anforderungen; ein Intake ist ein begrenzter,
pruefbarer Arbeitsauftrag fuer einen spaeteren Spec-Kit-Lauf. Der Vorlauf muss
abgeschlossen sein, bevor die bisherige aktive Reihenfolge mit der
Windows-Haertung fortgesetzt wird.

*This intake defines a global requirements preflight. Requirements are
traceable functional needs; an intake is a bounded, reviewable input for a
later Spec Kit run. The preflight must finish before the existing active order
continues with Windows hardening.*

## Anlass / Motivation

TuiVision, TinyCalc und TinyPl0 haben verteilte Pflichtenhefte, Lastenhefte und
Reihenfolgedokumente bereits in ein gemeinsames Requirements-Modell ueberfuehrt.
Die Feldnachweise zeigen wiederverwendbare Rollen, aber bestehende Preset- und
Migrationsoberflaechen verwenden teilweise weiterhin deutsche Dateinamen als
technische Vorgabe.

Die Konsolidierung muss deshalb die Dokumentationssprache von
Programmiersprache und Betriebssystem-Locale trennen. Sie muss bestehende
deutsche Strukturen ohne stilles Umbenennen erhalten und zugleich
deterministische deutsche, englische und explizit konfigurierte Namensprofile
ermöglichen.

*The consolidation must separate documentation language from implementation
language and operating-system locale. It preserves existing German structures
without implicit renaming while supporting deterministic German, English, and
explicitly configured naming profiles.*

## Ausgangslage / Current State

Die folgenden Feldnachweise sind verbindlich:

| Repository | Reconciliation | Consolidation | Nachgewiesener Bestand |
|---|---|---|---|
| `hindermath/TuiVision` | PR #127, Merge `664304a89b85b8d7c8f119bd2867580d51759852` | PR #128, Merge `38e0c1cb271322302742c1c0b70420e3c2cb3441` | Umfangreiche aktive, archivierte und zurueckgestellte Historie |
| `hindermath/TinyCalc` | PR #39, Merge `7a485268cdf2ad716acd309c8d8064ab2a9e5b16` | PR #40, Merge `71148636c191b0a70203a0286d270a4d9f694660` | Eine Baseline und neun aktive Intakes |
| `hindermath/TinyPl0` | PR #51, Merge `f18d89ced41a4e6f1aae62884e3ad479ef90c324` | PR #52, Merge `38488d30c5c109f0bacc01879573594ea83e42d0` | Drei Baselines, 14 aktive und zwei archivierte Intakes |

Die lokalen Alignment-Skripte dieser Repositories sind Feld-Evidence, aber
keine gemeinsame Preset-Quelle. Projektspezifische Zahlen, Slugs, Produktnamen
und Abhaengigkeiten duerfen nicht als allgemeine Preset-Regel uebernommen
werden.

## Zielzustand / Target State

Ein gemeinsamer Vertrag unter
`requirements/intake-governance-config.json` mit Schema 2.0 beschreibt:

- `documentationLanguage` als BCP-47-Sprachwert;
- ein Namensprofil `de`, `en` oder eine explizite Konfiguration;
- die Rollen `requirements-index`, `requirements-intake`, `intake-order` und
  `requirements-baseline`;
- aufgeloeste Pfade fuer Baselines, aktive, archivierte, zurueckgestellte und
  historische Intakes sowie das Series-Manifest;
- eine begrenzte Liste `legacyArtifactNames`;
- Bestandszahlen, die aus Dateien und Manifesten ermittelt und nicht dauerhaft
  von Hand gepflegt werden.

Ein schlanker Requirements-Index verweist auf Baselines, aktive Intakes,
Status und Reihenfolge. Historische Baselines bleiben unveraenderlich.
Aktive, archivierte, zurueckgestellte und historische Intakes bleiben getrennt.
Das Series-Manifest ist die kanonische Quelle fuer Reihenfolge,
Abhaengigkeiten und Zustaende. Genau ein nachweisbarer Kandidat darf
`Eligible` sein; dieser Zustand erteilt keine Implementierungs- oder
Remote-Berechtigung.

*Schema 2.0 defines language-neutral roles and resolved paths. The series
manifest remains the canonical source for order, dependencies, and state.
Exactly one evidenced candidate may be `Eligible`, but eligibility grants no
implementation or remote authority.*

## Umfang / Scope

### Preset-Weiterentwicklung

Genau drei bestehende Presets werden koordiniert weiterentwickelt:

1. `intake-authoring-governance` von `0.2.1` auf `0.3.0`;
2. `intake-review-governance` von `0.1.2` auf `0.2.0`;
3. `intake-sequencing-governance` von `0.1.1` auf `0.2.0`.

Es entsteht kein viertes Preset und kein neuer Command.

### Feldvalidierung

Sieben Repositories erhalten jeweils einen eigenen, nicht leeren PR:

- Migration bestehender konsolidierter Strukturen:
  `TuiVision`, `TinyCalc`, `TinyPl0`;
- neue Adoption:
  `home-baseline-source`, `InventarWorkerService`, `cc65`,
  `absdd-image-sandbox`.

Nur diese sieben Pilot-Repositories erhalten eine fachliche
Requirements-Migration. Die anschliessende Flottenverteilung aktualisiert nur
die drei optionalen Preset-Versionen.

### Veröffentlichung

Die drei kanonischen Scaffolds und Publikationskopien werden synchron
aktualisiert. Die drei Veröffentlichungsrepositories erhalten normale PRs,
Tags und Releases. Die versionierten GitHub-ZIP-Dateien und ihre
SHA-256-Pruefsummen werden geprüft. Katalogupdates werden seriell ueber das
offizielle Spec-Kit-Verfahren eingereicht.

## Nicht-Ziele / Non-Goals

- kein Produktcode, keine Runtime- oder API-Aenderung;
- keine neue Abhaengigkeit in den Pilotprodukten;
- keine freie KI-Uebersetzung von Dateinamen;
- keine automatische Umbenennung durch Spracherkennung;
- keine nachtraegliche Umbenennung historischer Dateien ohne Bedarf;
- keine Uebernahme projektspezifischer Mengen oder Produktbegriffe;
- kein automatischer Start der Windows-Haertung oder eines anderen Folgelaufs;
- kein externer Community-Katalog-Merge als lokale Abschlussbedingung.

## Fachliche Anforderungen / Functional Requirements

- **RIK-001:** Die Konfiguration MUSS Schema 2.0 und einen eindeutigen
  Repository-relativen Pfad besitzen.
- **RIK-002:** `documentationLanguage` MUSS ein gueltiger BCP-47-Wert sein und
  DARF NICHT aus Programmiersprache, Betriebssystem- oder Benutzer-Locale
  abgeleitet werden.
- **RIK-003:** Profile `de` und `en` MUESSEN deterministische sichtbare Namen
  aufloesen:
  - `de`: `Pflichtenheft.md`, `Lastenheft_<slug>.md`,
    `Lastenheft_Abarbeitungsreihenfolge.md`;
  - `en`: `RequirementsIndex.md`, `RequirementsIntake_<slug>.md`,
    `RequirementsIntakeOrder.md`.
- **RIK-004:** Explizite Felder DUERFEN nur den betreffenden Profilwert
  ueberschreiben.
- **RIK-005:** Nicht unterstuetzte oder mehrdeutige Sprachen MUESSEN
  schreibende Migrationen blockieren.
- **RIK-006:** Die vier Artefaktrollen MUESSEN sprachneutral bleiben und auf
  genau einen aktiven Pfadvertrag aufloesen.
- **RIK-007:** Baseline-, Aktiv-, Archiv-, Backlog-, Historien- und
  Series-Pfade MUESSEN getrennt konfigurierbar und validierbar sein.
- **RIK-008:** `legacyArtifactNames` MUSS begrenzt sein und DARF keine zweite
  kanonische Struktur erzeugen.
- **RIK-009:** Bestandszahlen MUESSEN aus dem aktuellen Dateisystem und dem
  Manifest ermittelt werden.
- **RIK-010:** `$speckit-intake-create-status` MUSS read-only genau
  `Aligned`, `MigrationRequired`, `NeedsClarification` oder `Blocked` melden.
- **RIK-011:** `$speckit-intake-update` DARF eine Migration nur mit aktueller,
  ausdruecklicher Scope- und Schreibautoritaet ausfuehren.
- **RIK-012:** Eine Migration MUSS Index, Manifest, Receipts, Prompts,
  Guidance und Links atomar aktualisieren.
- **RIK-013:** Jede Migration MUSS ein Operationsjournal mit Vorher- und
  Nachher-Hashes, Dateibewegungen, Referenzaktualisierungen und
  Reparaturgrenze erzeugen.
- **RIK-014:** Teilfehler MUESSEN vollstaendig zurueckgerollt oder als
  `NeedsRepair` ausgewiesen werden.
- **RIK-015:** `$speckit-intake-review` MUSS Sprache, Rollen, aufgeloeste
  Pfade, Hashes und Referenzen gemeinsam pruefen.
- **RIK-016:** `$speckit-intake-series-status` und
  `$speckit-intake-series-next` MUESSEN Manifest, Zustände und genau einen
  `Eligible`-Kandidaten pruefen.
- **RIK-017:** `Eligible` MUSS nur Reihenfolge ausdruecken und DARF keine
  Delivery Authority erteilen.
- **RIK-018:** Historische und archivierte Dateien MUESSEN ohne begruendeten
  Migrationsbedarf unveraendert bleiben.
- **RIK-019:** Alle drei Presets MUESSEN Bash-/PowerShell-Paritaet und genau
  eine Command-/Skill-Anzeige pro gepflegter Agentenoberflaeche erhalten.
- **RIK-020:** Die sieben Pilotmigrationen MUESSEN Inhalte und Produktcode
  bewahren und jeweils ueber einen eigenen nicht leeren PR geliefert werden.
- **RIK-021:** Genau ein `Eligible`-Kandidat DARF nur aus der bestehenden,
  belegbaren Reihenfolge abgeleitet werden.
- **RIK-022:** Nach den Piloten MUESSEN die drei neuen Preset-Versionen in
  allen registrierten Profilen verteilt werden, ohne weitere fachliche
  Requirements-Migrationen auszufuehren.
- **RIK-023:** Community-Katalogupdates MUESSEN seriell eingereicht werden;
  `@mnriem` darf ueber alle drei Updates hoechstens einmal freundlich
  angesprochen werden.
- **RIK-024:** Nach dem Feature-Closeout MUSS dieses Lastenheft archiviert und
  aus der aktiven Series entfernt werden; die sechs bisherigen Roots werden
  wieder freigegeben.

## Migrations- und Sprachregeln / Migration and Language Rules

Die Sprache wird in dieser Reihenfolge bestimmt:

1. explizite Repository- oder Intake-Policy;
2. Constitution oder gemeinsame Agent-Guidance;
3. dominante Sprache der kanonischen Requirements-Dokumente;
4. andernfalls `Undetermined`.

Eine bilinguale Regel verwendet die zuerst genannte Sprache als primaere
Dokumentationssprache. Automatische Erkennung muss Quelle und Vertrauenswert
dokumentieren. Unterhalb der festgelegten Vertrauensgrenze wird weder ein
lokalisiertes Artefakt erzeugt noch eine Datei umbenannt.

Bestehende deutsche Namen bleiben ohne Rename-Autoritaet unveraendert.
Historische Dateien muessen nicht rueckwirkend umbenannt werden. Nach einer
ausdruecklich abgeschlossenen Migration muessen neue Intakes das aktive Profil
verwenden. Mehrere kanonische Indizes und gemischte neue Praefixe sind
unzulässig.

## Pilotvertraege / Pilot Contracts

- **TuiVision:** Konfiguration ergaenzen; vorhandene umfangreiche Historie,
  Namen und Inhalte unveraendert lassen.
- **TinyCalc:** Schema 1.0 auf 2.0 migrieren; eine Baseline und neun aktive
  Intakes bewahren.
- **TinyPl0:** Schema 1.0 auf 2.0 migrieren; drei Baselines, 14 aktive, zwei
  archivierte Intakes und Abhaengigkeiten bewahren.
- **home-baseline-source:** aktive Series, historische Lastenhefte und
  Receipts atomar auf das Rollenmodell abbilden.
- **InventarWorkerService:** groessere flache deutschsprachige Sammlung
  konsolidieren.
- **cc65:** kleine Sammlung auf `master` konsolidieren; Nicht-MSL-Begruendung
  und Upstream-Fork-Grenzen bewahren.
- **absdd-image-sandbox:** Sandbox-, Secure-Development- und archivierte
  Public-Readiness-Evidence bewahren.

## Governance und Qualität / Governance and Quality

- Deutsch zuerst, Englisch danach; CEFR B2.
- Fachbegriffe werden beim ersten Auftreten erklärt.
- Abhaengigkeiten, Status, Entscheidungen und naechste Aktionen bleiben
  textorientiert verständlich.
- WCAG 2.2 AA wird angewendet, soweit das Artefakt betroffen ist.
- Sicherheits-, Architektur-, A11Y-, Plattform- und Agent-Paritaets-Presets
  bleiben wirksam.
- Die enge Admin-Ausnahme gilt nur bei gruener technischer Evidence oder
  nachgewiesener Provider-Zero-Step-Abweisung, null umsetzbaren
  Review-Threads und Human Approval als einzigem offenen Gate.

## Positive Prüffälle / Positive Test Cases

1. Deutsche, englische, bilinguale und explizit angepasste Profile werden
   korrekt aufgeloest.
2. Schema 1.0 wird mit nachvollziehbarer Evidence auf 2.0 migriert.
3. Bestehende deutsche Namen bleiben ohne Rename-Autoritaet unveraendert.
4. Genau ein Index, ein Manifesteintrag je aktivem Intake und ein `Eligible`
   werden bestätigt.
5. Manifest, Receipts, Prompts, Guidance und Links werden atomar aktualisiert.
6. LF, CRLF und eine UTF-8-BOM liefern dieselbe normalisierte Bedeutung.

## Negative Prüffälle / Negative Test Cases

1. Programmiersprache wird faelschlich als Dokumentationssprache verwendet.
2. Sprache ist mehrdeutig oder nicht unterstuetzt.
3. Gemischte Praefixe oder doppelte kanonische Indizes bestehen.
4. Eine unautorisierte oder kollidierende Umbenennung wird angefordert.
5. Hashes, Links oder Receipts sind nach einer Migration veraltet.
6. Mehrere Eintraege sind `Eligible`.
7. Ein Teilfehler besitzt weder Rollback- noch Reparaturnachweis.

## Abnahmekriterien / Acceptance Criteria

- **AC-001:** Alle Anforderungen RIK-001 bis RIK-024 sind durch Spec, Plan,
  Tasks und Evidence abgedeckt.
- **AC-002:** Positive und negative Tests bestehen in Bash und PowerShell mit
  denselben Ergebnis- und Fehlerklassen.
- **AC-003:** PSScriptAnalyzer, Homogeneity, Secret-Scan und Agent-Paritaet
  bestehen.
- **AC-004:** Alle elf Presets lassen sich gemeinsam installieren, aufloesen,
  deaktivieren, reaktivieren, entfernen und erneut installieren.
- **AC-005:** Jede Command- und Skill-Anzeige erscheint pro gepflegter
  Agentenoberflaeche genau einmal.
- **AC-006:** Die sieben Pilot-Repositories besitzen gemergte, nicht leere PRs
  auf ihrem jeweiligen kanonischen Default-Branch.
- **AC-007:** Die Presets sind als `v0.3.0`, `v0.2.0` und `v0.2.0` mit
  gueltigen Tag-ZIPs und dokumentierten SHA-256-Pruefsummen veröffentlicht.
- **AC-008:** Die neuen Versionen sind in allen registrierten Profilen
  installiert; nur die sieben Piloten besitzen fachliche Migrationen.
- **AC-009:** Die drei Community-Aktualisierungen sind seriell eingereicht;
  ihr externer Merge blockiert den lokalen Abschluss nicht.
- **AC-010:** Der Feature-Head besteht alle lokalen, Remote- und
  Exact-Head-Gates ohne offene Critical-/High-Befunde oder umsetzbare
  Review-Threads.
- **AC-011:** Das Lastenheft ist nach Abschluss archiviert, die aktive Series
  besitzt wieder ihre sechs bisherigen Roots und
  `Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md` ist der einzige
  naechste serielle Intake.
- **AC-012:** Kein Folgelauf wurde automatisch gestartet.

## Risiken und Stop-Grenzen / Risks and Stop Boundaries

Der Lauf stoppt bei mehrdeutiger Dokumentationssprache, Namenskollision,
nicht rekonstruierbarer Reihenfolge, fehlerhafter atomarer Migration,
unerklaerter Inhaltsdrift, fehlender Pilotautoritaet oder einem
providerneutralen Preset-Defekt ohne sichere Reparaturgrenze. Produktinhalte
werden nicht zur Anpassung an den neuen Vertrag umgeschrieben.

## Erwartete Artefakte und Evidence / Expected Artifacts and Evidence

- Feature-Spezifikation, Plan, Research, Datenmodell, Contracts, Tasks und
  Checklists unter `specs/014-requirements-intake-consolidation-governance/`;
- `pr-evidence.md`, Run-State und Exact-Head-Gate-Evidence;
- Schema-2.0-Konfiguration, Templates, Validatoren, Fixtures, README,
  Runbooks, Manpages und Feldvalidierungsberichte in drei Presets;
- sieben Pilot-PRs, drei Veröffentlichungs-PRs und drei Release-Nachweise;
- flottenweite Installations-Evidence und serielle Community-Einreichungen;
- archivierter Intake und kausaler Closeout, falls Post-Merge-Fakten nicht
  wahrheitsgemäß im Feature-Head stehen koennen.

<!-- intake-authoring:prompts -->
## Kopierbare Spec-Kit-Prompts / Copy-Ready Spec Kit Prompts

### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Requirements-Intake-Konsolidierungs-Governance.md` as the single binding intake for Feature 014. Verify the field-evidence provenance, language-neutral role contract, schema-2.0 migration boundaries, seven-pilot scope, coordinated three-preset versioning, measurable acceptance criteria, MergeAndSync authority, learner-facing language and accessibility rules, and the explicit prohibition on product-code changes or automatic successor execution. Do not start Specify or Autonomous. Finish only with Ready when no material ambiguity remains.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Requirements-Intake-Konsolidierungs-Governance.md` as the binding intake and create Feature 014 exactly as `014-requirements-intake-consolidation-governance`. Preserve the accepted scope: coordinate Intake Authoring 0.3.0, Intake Review 0.2.0, and Intake Sequencing 0.2.0; implement schema-2.0 language-aware requirements governance; validate seven named pilot repositories through separate non-empty PRs; publish and distribute the three preset versions; and restore the six prior roots after closeout. Do not create a fourth preset, change product behavior, rename historical artifacts without authority, or start the Windows hardening successor. Delivery authority is MergeAndSync.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete autonomous Spec Kit run for Feature 014 using `Lastenheft_Requirements-Intake-Konsolidierungs-Governance.md` as the binding intake. Delivery mode: MergeAndSync. Run Specify, repeated Clarify, relevant checklists, Plan, Tasks, repeated Analyze, Implement, validation, delivery, and retrospective to convergence. Upgrade exactly the three existing intake presets to 0.3.0, 0.2.0, and 0.2.0; implement and test the shared schema-2.0 language-aware contract; deliver separate non-empty migration PRs for TuiVision, TinyCalc, TinyPl0, home-baseline-source, InventarWorkerService, cc65, and absdd-image-sandbox; publish three releases and validate their GitHub ZIPs; distribute only the preset versions fleet-wide; submit community updates serially; and perform any required causal closeout. Keep product code and intake content unchanged, preserve historical evidence, require exact-head gates, and use the authorized narrow admin bypass only under its documented conditions. End on clean synchronized main with Feature 014 archived, the six previous roots restored, Windows hardening identified as next, and no successor started.
```

## Naechste Aktion / Next Action

`$speckit-intake-review Lastenheft_Requirements-Intake-Konsolidierungs-Governance.md`

<!-- intake-authoring:end -->
