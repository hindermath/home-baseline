<!-- intake-authoring:begin -->
# Lastenheft: Autonomous Evidence Integrity Field Validation and Rollout

**Status:** Ready for Intake Review  
**Series role:** G2B, Release- und Freigabe-Gate / release and enablement gate  
**Vorgesehene Feature-ID:** `028-autonomous-evidence-integrity-field-validation`  
**Vorgaenger:** G2A / Feature 027 vollstaendig gemergt  
**Delivery Authority:** `MergeAndSync` nur bei aktuellem ausdruecklichem Aufruf

## 1. Zweck / Purpose

Dieses Lastenheft validiert den in G2A gemergten
`autonomous-run-governance`-v0.4.0-Kandidaten in einem unabhaengigen,
evidence-only Home-Baseline-`MergeAndSync`-Lauf. Nur nach bestandenem Feldtest
werden Release, GitHub-ZIP, Community-Update und kontrollierte
Consumer-Auslieferung freigegeben.

*This intake validates the v0.4.0 candidate merged by G2A in an independent,
evidence-only Home Baseline `MergeAndSync` run. Release, GitHub ZIP, community
update, and controlled consumer rollout are allowed only after the field test
passes.*

## 2. Zielgruppe und Verstaendlichkeit / Audience and Readability

Die Zielgruppen- und Sprachregeln aus G2A gelten unveraendert: Deutsch zuerst,
Englisch danach, CEFR B2, Erklaerung neuer Begriffe beim ersten Auftreten,
textorientierte Evidence und WCAG 2.2 AA. Der Feldbericht muss auch ohne
Kenntnis von TuiVision oder Feature 038 verstaendlich sein.

## 3. Reihenfolge und Autoritaet / Order and Authority

G2B darf erst starten, wenn G2A gemergt, der Kandidat synthetisch gruen und
`main == origin/main` sauber ist. G2B blockiert die bisherigen Roots Position
7, 9 und 10. Weder `Ready` noch `Eligible` erteilt Remote-, Release-,
Katalog-, Bypass- oder Consumer-Autoritaet. Diese Autoritaet entsteht nur durch
den ausdruecklichen aktuellen Autonomous-Aufruf.

## 4. Scope und Nicht-Ziele / Scope and Non-Goals

### In Scope

- unabhaengiger evidence-only Feature-Lauf in Home Baseline;
- kontrollierte Reproduktion und Aufloesung aller drei AR-038-Findings;
- Resume-Nachweis nach `NeedsRevalidation` ohne manuelle State-Korrektur;
- finales Preset-Paket, Publikationsrepository, v0.4.0-Tag und Release;
- versionierter ZIP-Smoke und SHA-256;
- dynamisch inventarisierte Consumer-Aktualisierung fuer Repositories, deren
  aktives Profil das Autonomous-Preset enthaelt;
- serielles Community-Katalogupdate und Abschluss des Workitems.

### Nicht-Ziele / Non-Goals

- kein Produktcode- oder fachliches Consumer-Delta;
- keine Neuinterpretation historischer Evidence;
- keine automatische Admin-, Secret-, Provider- oder Bypass-Autoritaet;
- kein Start von Position 7 oder eines anderen Folgefeatures;
- kein externer Katalog-Merge als lokale Abschlussbedingung.

## 5. Atomare Anforderungen / Atomic Requirements

### AEV-001 - Unabhaengiger Feldlauf

Der Feldlauf MUSS auf einem neuen Feature-Branch nach dem G2A-Merge beginnen,
einen eigenen Run-State und eigene Evidence besitzen und darf keine
G2A-Completion-Behauptung wiederverwenden.

### AEV-002 - Liefermengen-Feldnachweis

Eine beabsichtigte unversionierte Datei mit nachgestelltem Whitespace MUSS
kontrolliert abgelehnt werden. Nach ausdruecklicher Korrektur MUSS dieselbe
Liefermenge bestehen. Ignorierte Evidence und fremde unversionierte Dateien
bleiben ausserhalb der Lieferung.

### AEV-003 - Semantischer Feldnachweis

Ein instrumentierter Modellphasenversuch liefert Exitcode `0`, aber Outcome
`Blocked` und unvollstaendige Tasks. Der Run-State MUSS `Blocked` oder
`NeedsRevalidation`, niemals `Completed`, ausweisen.

### AEV-004 - Resume-Feldnachweis

Ein ausdruecklicher Resume prueft Authority, Phase, Tasks, Hashes und Git neu.
Nach gueltiger vollstaendiger Evidence darf der Lauf fortfahren. Keine Datei
und kein State wird manuell passend gemacht.

### AEV-005 - Lifecycle-Feldnachweis

Vor Merge entsteht ein gueltiger `PreMerge`-Snapshot fuer den exakten Head.
Nach Merge entsteht genau ein `PostMerge`-Snapshot, der dessen Hash und den
tatsaechlichen Merge bindet. Der Closeout bleibt evidence-only und nicht
rekursiv.

### AEV-006 - Release-Entscheidung

v0.4.0 darf nur veroeffentlicht werden, wenn alle synthetischen und realen
Nachweise gruen, alle Pflichtchecks bestanden und keine Critical-/High-Findings
oder umsetzbaren Review-Threads offen sind.

### AEV-007 - Paket und ZIP

Kanonischer Scaffold und Publikationskopie MUESSEN bytegleich sein. Das
Publikationsrepository erhaelt einen normalen PR, anschliessend Tag und Release
`v0.4.0`. Die versionierte GitHub-ZIP wird neu installiert und ihre SHA-256
dokumentiert.

### AEV-008 - Kompositionsnachweis

Ein temporaeres Spec-Kit-Projekt prueft die aktuelle vollstaendige
Preset-Matrix mit Add, List, Info, Resolve, Disable, Enable, Remove und
Reinstall. Commands und Skills erscheinen pro Agentenoberflaeche genau einmal.

### AEV-009 - Dynamischer Flottenumfang

Der Rollout inventarisiert zum Laufzeitpunkt alle registrierten Git-Ziele und
aktualisiert nur Repositories, deren aktives Profil das Autonomous-Preset
enthaelt. Collection-Ziele werden separat ausgewiesen. Feste historische
Repository-Zahlen sind keine Steuerungslogik.

### AEV-010 - Consumer-Grenze

Jeder Consumer-PR enthaelt nur die Preset-Aktualisierung, erzeugte
Agentenparitaet und zwingende Evidence. Produktcode und bestehende
projektspezifische Guidance bleiben unveraendert, sofern kein belegter
Kompatibilitaetsbefund vorliegt.

### AEV-011 - Remote-Konvergenz

Alle veraenderten Repositories MUESSEN technische Gates und Review-Threads am
exakten Head konvergieren. Fehlende Reviewer gelten nicht als Pass. Ein enger
Admin-Bypass ist nur mit gesonderter aktueller Autoritaet und ausschliesslich
fuer Human Approval zulaessig.

### AEV-012 - Community-Update

Nach Release-Smoke wird das offizielle Preset-Updateverfahren seriell genutzt.
Ein freundlicher englischer Kommentar beschreibt Version, drei Findings,
Feldtest, ZIP und Kompatibilitaet. `@mnriem` wird hoechstens einmal
angesprochen. Externer Merge blockiert den lokalen Abschluss nicht.

### AEV-013 - Workitem-Abschluss

Das Feature-038-Workitem wird auf `Implemented` gesetzt und bindet Feature-PR,
Feldlauf, Preset-PR, Release, ZIP, Flotten-Evidence und Community-Referenz.

### AEV-014 - Series-Closeout

Nach erfolgreichem G2B-Closeout werden G2A und G2B aus der aktiven Series
archiviert. Die vorherigen Roots Position 7, 9 und 10 werden wiederhergestellt;
Position 7 wird alleiniger bevorzugter `Eligible`-Kandidat. Kein Folgelauf
startet automatisch.

## 6. Test- und Gatevertrag / Test and Gate Contract

- alle G2A-Fixtures werden gegen den gemergten Kandidaten erneut ausgefuehrt;
- kontrollierte reale Negativ-/Positivsequenz fuer AR-038-01;
- Exitcode-0-`Blocked`-Sequenz und anschliessender Resume fuer AR-038-02;
- ehrliche Pre-/Post-Merge-Sequenz fuer AR-038-03;
- Bash-/PowerShell-Paritaet, PSScriptAnalyzer, Bash-Syntax, Diff-, Secret- und
  Homogeneity-Pruefung;
- Stop-/Status-/Resume-/Hard-Abort-Regressionen;
- aktuelle Preset-Komposition und Agent-Paritaet;
- Tag-ZIP-Installation in einem frischen temporaeren Projekt;
- Exact-Head-Provider-Evidence vor jedem Merge;
- flottenweiter Abschlussbericht mit Ziel, PR, Head, Checks, Review,
  Merge-Commit, Sync-Status und Ausnahmegrund.

## 7. Messbare Abnahmekriterien / Measurable Acceptance Criteria

- **AC-AEV-001:** Der Feldlauf reproduziert und schliesst alle drei Findings
  ohne Produktdelta.
- **AC-AEV-002:** Exitcode `0` plus `Blocked` erscheint in keiner Evidence als
  `Completed`.
- **AC-AEV-003:** Resume erfolgt einmal, authority- und hashgebunden, ohne
  manuelle State-Korrektur.
- **AC-AEV-004:** Pre- und Post-Merge-Snapshots bestehen die v0.4.0-Validatoren
  und bilden eine nicht rekursive Kette.
- **AC-AEV-005:** Release v0.4.0 und GitHub-ZIP sind installierbar; SHA-256 und
  Release-Evidence sind dokumentiert.
- **AC-AEV-006:** Alle dynamisch anwendbaren Consumer sind aktualisiert oder
  besitzen einen expliziten blockierenden Befund; kein Erfolg verschweigt ein
  Ziel.
- **AC-AEV-007:** Jeder gemeldete Merge besitzt gruene technische Gates, null
  umsetzbare Threads und exakte Head-Evidence.
- **AC-AEV-008:** Das Workitem ist `Implemented`; G2A/G2B sind archiviert und
  Position 7 ist wieder alleiniger bevorzugter Kandidat.

## 8. Copy-Ready Spec Kit Prompts

<!-- intake-authoring:prompts -->

### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Autonomous-Evidence-Integrity-Field-Validation-and-Rollout.md` as G2B of the active Home Baseline series. Verify its binding dependency on merged G2A, independent evidence-only field run, controlled reproduction of AR-038-01 through AR-038-03, resume without manual state repair, lifecycle-bound pre/post-merge snapshots, conditional v0.4.0 release, ZIP and composition proof, dynamic consumer inventory, exact-head remote convergence, community-update boundary, workitem closeout, series restoration, learner accessibility, and no automatic Position 7 start.
```

### Specify

<!-- spec-kit-command-id: speckit.specify -->
```text
$speckit-specify Use `Lastenheft_Autonomous-Evidence-Integrity-Field-Validation-and-Rollout.md` as the binding intake for Feature 028 after Feature 027 is merged. Specify the independent evidence-only field validation, conditional autonomous-run-governance v0.4.0 release, tag-ZIP proof, dynamic consumer rollout, community update, workitem closure, and G2 series closeout. Preserve AEV-001 through AEV-014 and AC-AEV-001 through AC-AEV-008. Do not implement during Specify, change product code, infer bypass authority, or start Position 7.
```

### Autonomous

<!-- spec-kit-command-id: speckit.autonomous -->
```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Autonomous-Evidence-Integrity-Field-Validation-and-Rollout.md` as Feature 028 with deliveryAuthority=MergeAndSync after G2A is merged and main is clean. Run the independent evidence-only field test for all three AR-038 findings, prove semantic Resume and lifecycle-bound pre/post-merge evidence, and release autonomous-run-governance v0.4.0 only after every gate passes. Validate the versioned ZIP and full preset composition, update every dynamically applicable registered consumer through non-empty exact-head-reviewed PRs, submit the serial community update, close the workitem, restore the original 32-target/3-root/36-edge series with Position 7 as sole preferred Eligible, and return every changed repository to clean synchronized default branch. Do not change product behavior or start Position 7 automatically. Any admin bypass requires separate explicit current authority and may replace only Human Approval after all technical gates are green and actionable threads are zero.
```
<!-- intake-authoring:end -->
