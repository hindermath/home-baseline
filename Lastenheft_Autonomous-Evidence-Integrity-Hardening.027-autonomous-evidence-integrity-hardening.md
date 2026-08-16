<!-- intake-authoring:begin -->
# Lastenheft: Autonomous Evidence Integrity Hardening

**Status:** Ready for Intake Review  
**Series role:** G2A, globales Governance-Gate / global governance gate  
**Vorgesehene Feature-ID:** `027-autonomous-evidence-integrity-hardening`  
**Delivery Authority:** `MergeAndSync` nur bei aktuellem ausdruecklichem Aufruf  
**Zielrelease:** unveroeffentlichter Kandidat `autonomous-run-governance` v0.4.0

## 1. Zweck / Purpose

Dieses Lastenheft setzt die drei providerneutralen Findings `AR-038-01` bis
`AR-038-03` aus dem TuiVision-Feature-038-Handoff als geprueften
Preset-Kandidaten um. Der Lauf haertet Liefermengenpruefung, semantische
Phasenabschluesse und lebenszyklusgebundene Exact-Head-Evidence. Er
veroeffentlicht noch kein Release und aktualisiert keine Consumer-Flotte.

*This intake implements the three provider-neutral findings `AR-038-01`
through `AR-038-03` from the TuiVision Feature 038 handoff as a validated
preset candidate. It hardens delivery-set validation, semantic phase
completion, and lifecycle-bound exact-head evidence. It publishes no release
and updates no consumer fleet yet.*

## 2. Zielgruppe und Verstaendlichkeit / Audience and Readability

Zielgruppen sind Preset-Maintainer, Runner-Autoren, autonome Operatoren sowie
Lernende und Anwendungsentwickler ohne vorherige Spec-Kit-Erfahrung. Deutsch
steht zuerst, Englisch danach. Erklaerungen verwenden CEFR B2, erklaeren
Fachbegriffe beim ersten Auftreten und bleiben ohne Farbe oder rein visuelle
Diagramme verstaendlich. Anwendbare Inhalte erfuellen WCAG 2.2 AA.

*The audience includes preset maintainers, runner authors, autonomous
operators, learners, and application developers without prior Spec Kit
experience. German comes first, followed by English. Explanations use CEFR B2,
define terms on first use, remain understandable without colour-only or
diagram-only meaning, and meet applicable WCAG 2.2 AA requirements.*

## 3. Bindende Quellen und Reihenfolge / Binding Sources and Order

- `docs/work-items/2026-08-09-feature-038-autonomous-preset-followup.md`
- Home-Baseline PR #230 und Merge `6ec4ccf7593339f368f9bb3a1de799fcebd44869`
- TuiVision Feature 038 mit den im Workitem gebundenen PR-, Blob- und
  Exact-Head-Nachweisen
- aktueller kanonischer und publizierbarer Preset-Stand v0.3.6

G2A ist voruebergehend die einzige Root und der einzige bevorzugte
`Eligible`-Kandidat der aktiven Series. G2B folgt bindend. Die bisherigen Roots
Position 7, 9 und 10 bleiben bis zum Abschluss von G2B blockiert. `Eligible`
bezeichnet nur die Reihenfolge und erteilt keine Ausfuehrungs- oder
Remote-Berechtigung.

*G2A temporarily becomes the only root and preferred `Eligible` target. G2B
depends on it. Existing roots 7, 9, and 10 remain blocked until G2B completes.
Eligibility defines order only and grants no execution or remote authority.*

## 4. Scope und Nicht-Ziele / Scope and Non-Goals

### In Scope

- kanonischer Scaffold und Publikationskopie fuer den v0.4.0-Kandidaten;
- Bash-/PowerShell-Paritaet fuer alle neuen oder geaenderten Validatoren;
- Commands, Skills, Runbook, Readiness-Checklist, Evidence-Templates,
  Manpages, Agent-Addenda und Feldvalidierungsbericht;
- Rueckwaertskompatibilitaet fuer historische Evidence;
- synthetische positive und negative Tests sowie bestehende Regressionen.

### Nicht-Ziele / Non-Goals

- kein Tag, Release, GitHub-ZIP oder Community-Katalogupdate;
- keine Flotten- oder Consumer-Aktualisierung;
- keine TuiVision-spezifischen Zahlen, Gates, Branches oder PR-Kennungen als
  Preset-Defaults;
- keine automatische Staging-, Commit-, Push-, PR-, Merge- oder
  Admin-Bypass-Autoritaet;
- kein Start von G2B oder Position 7.

## 5. Atomare Anforderungen / Atomic Requirements

### AEI-001 - Explizite Liefermenge

Ein portabler Validator MUSS die ausdruecklich benannte beabsichtigte
Liefermenge pruefen. Er erfasst getrackte Aenderungen und benannte
unversionierte Lieferdateien, schliesst ignorierte Runtime-Evidence aus und
nimmt fremde unversionierte Dateien niemals stillschweigend auf.

### AEI-002 - Read-only Lieferpruefung

Die Liefermengenpruefung DARF Index, Arbeitsbaum, Ignore-Regeln oder Dateien
nicht aendern. Pfade ausserhalb des Repositorys, mehrdeutige Pfade und nicht
vorhandene beabsichtigte Dateien MUESSEN fail-closed abgelehnt werden.

### AEI-003 - Whitespace- und Scope-Vertrag

Getrackte und beabsichtigte unversionierte Dateien MUESSEN denselben
Whitespace- und Scope-Vertrag erfuellen. Ein positives Ergebnis von
`git diff --check` allein ist nicht hinreichend.

### AEI-004 - Strukturiertes Phasenergebnis

Jede geroutete Modellphase MUSS ein versioniertes maschinenlesbares Ergebnis
mit mindestens Phase-ID, Outcome, erwarteter und abgeschlossener Taskzahl,
Blocked-Grund, Gate-Aussage und Payload-Hash liefern. Der Wrapper bindet
zusaetzlich den normalisierten Hash des Ergebnisdokuments im Run-State.

### AEI-005 - Semantisches Completion-Predicate

`Completed` verlangt Prozess-Exitcode `0`, gueltiges und zur gestarteten Phase
passendes Schema, Outcome `Completed`, vollstaendige Taskzahlen, erfuellte
Gates und gueltige Hashbindungen. Fehlende, unklare oder widerspruechliche
Evidence ergibt `NeedsRevalidation` oder `Blocked`, niemals einen erratenen
Erfolg.

### AEI-006 - Unterbrechung und Resume

Vor dem Prozessstart bleibt die Operation `NeedsRevalidation`. Nach Abbruch,
fehlendem Ergebnis oder Drift MUSS Resume die Autoritaet und alle Hashes neu
pruefen. Sicher abgeschlossene Arbeit darf nicht blind wiederholt werden.

### AEI-007 - Lifecycle-Snapshots

Gate-Evidence-Schema 2.0 MUSS getrennte Snapshot-Typen `PreMerge` und
`PostMerge` mit Reviewed Head, Requirements-Hash, UTC-Zeit,
Providerreferenz und normalisiertem SHA-256 unterscheiden.

### AEI-008 - Pre-Merge-Grenze

Ein `PreMerge`-Snapshot darf nur zum Reviewed Head verfuegbare technische und
Review-Fakten enthalten. Er darf keinen Merge behaupten oder autorisieren.

### AEI-009 - Post-Merge-Bindung

Ein `PostMerge`-Snapshot MUSS den akzeptierten Pre-Merge-Hash und den
tatsaechlichen Merge-Commit binden. Er darf nur kausal spaeter verfuegbare
Providerfakten ergaenzen, kein Produktdelta aufnehmen und keine rekursive
Closeout-Kette verlangen.

### AEI-010 - Historische Kompatibilitaet

Historische Schema-1.0-Evidence bleibt pruefbar und wird nicht umgeschrieben.
Neue v0.4.0-Laeufe MUESSEN Schema 2.0 verwenden. Legacy-Akzeptanz benoetigt
einen expliziten historischen Modus und darf keine neue Merge-Freigabe liefern.

### AEI-011 - Oberflaechenparitaet

Alle gepflegten Agentenoberflaechen MUESSEN dieselben Regeln erhalten. Es
entstehen keine neuen Benutzer-Commands; jeder bestehende Command und Skill
erscheint weiterhin genau einmal.

### AEI-012 - Kandidatengrenze

Feature 027 endet mit einem gemergten, synthetisch validierten v0.4.0-Kandidaten.
Release, ZIP, Katalog und Flottenauslieferung bleiben G2B vorbehalten.

## 6. Testvertrag / Test Contract

### Liefermenge / Delivery Set

- getrackte Aenderung besteht;
- gueltige benannte unversionierte Datei besteht;
- benannte unversionierte Datei mit nachgestelltem Whitespace scheitert;
- ignorierte Runtime-Evidence bleibt ausgeschlossen;
- fremde unversionierte Datei wird gemeldet, aber nicht still aufgenommen;
- Repository-Ausbruch, fehlender Pfad und mehrdeutige Eingabe scheitern;
- Index- und Arbeitsbaumhash bleiben vor und nach der Pruefung identisch.

### Phasenergebnis / Phase Result

- gueltiges vollstaendiges Ergebnis besteht;
- Exitcode ungleich null scheitert;
- Exitcode null mit `Blocked` wird `Blocked`, nie `Completed`;
- unvollstaendige Taskzahlen werden `NeedsRevalidation` oder `Blocked`;
- fehlendes, leeres, abgeschnittenes, schemafremdes, hashfremdes und
  widerspruechliches Ergebnis scheitert;
- Resume akzeptiert bereits sicher abgeschlossene Evidence ohne Doppelstart.

### Lifecycle-Evidence

- gueltiger Pre-Merge-Snapshot besteht;
- Merge-Behauptung im Pre-Merge-Snapshot scheitert;
- gueltiger Post-Merge-Snapshot bindet exakt den Pre-Merge-Hash;
- falscher Head, Requirements-Hash, Pre-Merge-Hash oder Merge-Commit scheitert;
- veraenderte fruehere Evidence, vorzeitiger Merge und rekursiver Closeout
  scheitern.

### Paritaet und Regression

- Bash und PowerShell liefern identische Statusklassen und Exitcodes;
- LF, CRLF und eine UTF-8-BOM ergeben denselben normalisierten Hash;
- Stop, Status, Resume, Hard-Abort, LocalImplementation, PublishPR und
  MergeAndSync bleiben gruen;
- die aktuelle vollstaendige Preset-Komposition bleibt konfliktfrei.

## 7. Messbare Abnahmekriterien / Measurable Acceptance Criteria

- **AC-AEI-001:** Alle Liefermengen-Fixtures bestehen in Bash und PowerShell;
  kein Test veraendert den Index oder Arbeitsbaum.
- **AC-AEI-002:** Exitcode `0` plus `Blocked` oder unvollstaendige Tasks kann
  formal nie `Completed` ergeben.
- **AC-AEI-003:** Fehlende oder inkonsistente strukturierte Evidence erzeugt
  deterministisch `NeedsRevalidation` oder `Blocked`.
- **AC-AEI-004:** Pre- und Post-Merge-Snapshots bestehen getrennte positive
  Tests und alle negativen Bindungsfixtures.
- **AC-AEI-005:** Historische Schema-1.0-Evidence bleibt im historischen Modus
  lesbar, kann aber keine neue v0.4.0-Mergefreigabe erzeugen.
- **AC-AEI-006:** Bestehende Preset-Regressionen und Agent-Paritaet sind gruen.
- **AC-AEI-007:** Kanonischer Scaffold und Publikationskopie sind bytegleich.
- **AC-AEI-008:** Es existiert kein Release, Tag, ZIP-Rollout oder Consumer-PR.

## 8. Evidence, Risiken und Dokumentationsauswirkung

Der Lauf erzeugt Testberichte, Schema- und Hashnachweise, Bash-/PowerShell-
Paritaet, Diff-/Secret-/Homogeneity-Evidence und eine Retrospektive. Das groesste
Risiko ist ein falsch positives `Completed`, das Remote-Aktionen zu frueh
freigibt. Daher gilt fail-closed. Dokumentationsauswirkung ist
`UpdateRequired`; alle Bedien-, Lifecycle- und Evidence-Oberflaechen werden
gemeinsam aktualisiert.

## 9. Copy-Ready Spec Kit Prompts

<!-- intake-authoring:prompts -->

### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Autonomous-Evidence-Integrity-Hardening.md` as G2A of the active Home Baseline series. Verify AR-038-01 through AR-038-03 traceability, AEI-001 through AEI-012, AC-AEI-001 through AC-AEI-008, the unreleased v0.4.0 candidate boundary, explicit delivery-set validation, semantic completion predicates, lifecycle-bound pre/post-merge evidence, historical compatibility, Bash/PowerShell and agent parity, learner accessibility, and the prohibition on release, fleet rollout, G2B start, or Position 7 start.
```

### Specify

<!-- spec-kit-command-id: speckit.specify -->
```text
$speckit-specify Use `Lastenheft_Autonomous-Evidence-Integrity-Hardening.md` as the binding intake for Feature 027. Specify only the unreleased autonomous-run-governance v0.4.0 candidate implementing AEI-001 through AEI-012 and AC-AEI-001 through AC-AEI-008. Preserve provider neutrality, historical Schema-1.0 read compatibility, new-run Schema-2.0 enforcement, Bash/PowerShell parity, existing commands, agent parity, permission boundaries, and all negative fixtures. Do not implement during Specify, perform remote writes, publish a release, update consumers, start G2B, or start Position 7.
```

### Autonomous

<!-- spec-kit-command-id: speckit.autonomous -->
```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Autonomous-Evidence-Integrity-Hardening.md` as Feature 027 with deliveryAuthority=MergeAndSync. Implement and validate only the unreleased v0.4.0 candidate, including the exact delivery-set validator, structured phase-result completion predicate, lifecycle-bound Gate Evidence Schema 2.0, historical compatibility, complete negative fixtures, Bash/PowerShell parity, existing regression suites, documentation, and agent parity. Do not use the affected routed-phase wrapper as sole completion evidence during this bootstrap run. Commit, push, converge a non-empty PR, merge, and return to clean synchronized main. Do not tag, release, update the catalog or consumers, start G2B, or start Position 7.
```
<!-- intake-authoring:end -->
