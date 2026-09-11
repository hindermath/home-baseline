# Foundation-Reparatur und Home-Slice / Foundation Repair and Home Slice

Status: `Blocked`, 24 von 35 Aufgaben in T004–T038 abgeschlossen. Die
Foundation T004–T025 ist nach Parent-Review vollständig grün; T026 und T027
sind umgesetzt. T028–T038 bleiben offen.

*Status: `Blocked`, 24 of 35 tasks in T004–T038 completed. Foundation
T004–T025 is fully green after parent review; T026 and T027 are implemented.
T028–T038 remain open.*

## Foundation-Nachweis / Foundation evidence

Die Presetliste nennt nun korrekt Parallel Autonomous Run in der zentralen
Achterbasis und Intake Sequencing im Zusatzprofil. Alle 14 Gateeinträge
behalten ihren vollständigen Scope und ihre Plattformanforderungen; ihre 17
Command-Tokens sind Teil realer ausführbarer Befehlszeilen. Der Hashvertrag
entspricht dem installierten Core: optionale UTF-8-BOM entfernen, strikt
dekodieren, NUL ablehnen und CRLF/CR nach LF normalisieren; JSON-Schlüssel und
Whitespace bleiben signifikant.

*The preset list now correctly places Parallel Autonomous Run in the central
eight and Intake Sequencing in the additional profile. All 14 gate entries
retain their complete scope and platform requirements; their 17 command tokens
belong to real executable command lines. The hash contract now matches the
installed core: remove an optional UTF-8 BOM, decode strictly, reject NUL, and
normalize CRLF/CR to LF; JSON key order and whitespace remain significant.*

Der positive Vertrag enthält keine unbekannten Endpoints, einen eigenen Fall
mit genau einer eingehenden Kante und genau einen Fall
`manifestIndex: 1`/`displayPosition: 39`. Beide erwarteten Output-Hashes wurden
aus den korrigierten Bytes neu berechnet. Die frische Evidence
`foundational-revalidation.json` supersediert die erste Selbstvalidierung,
ohne den hashgebundenen ersten Fortschrittsbericht oder Analyze-Berichte zu
ändern. Ihr Delivery-Set-Beleg nutzt ehrlich nur eine temporäre Indexkopie;
die native Parent-Indexprüfung bleibt maßgeblich.

*The positive contract has no unknown endpoints, one dedicated single-incoming
edge case, and exactly one `manifestIndex: 1`/`displayPosition: 39` case. Both
expected output hashes were recomputed from the corrected bytes. Fresh
`foundational-revalidation.json` evidence supersedes the initial
self-validation without changing the hash-bound initial progress or Analyze
reports. Its delivery-set proof honestly uses only a temporary index copy; the
parent's native index check remains authoritative.*

## Home-Fortschritt / Home progress

T026 materialisiert die positiven Fünf-Spalten-Fixtures samt root- und
series-relativen erwarteten Links unter `scripts/tests/linked-intake-evidence/`.
T027 materialisiert Feature-Proof-Zustände sowie Null-, Ein- und
Mehrkantenfälle mit literalem `kind`, literalem `binding` und exaktem
Root-Fallback. Kanonisches Manifest, acht akzeptierte Eingabehashes und alle
sechs Downstream-Repositories blieben unverändert.

*T026 materializes the positive five-column fixtures with root- and
series-relative expected links under `scripts/tests/linked-intake-evidence/`.
T027 materializes feature-proof states and zero-, one-, and multiple-edge cases
with literal `kind`, literal `binding`, and the exact root fallback. The
canonical manifest, all eight accepted input hashes, and all six downstream
repositories remained unchanged.*

## Ausgeführte Prüfungen / Executed checks

- `validate-foundation-repair.ps1`: Pass; 14 Gates, 17 Command-Tokens, alle
  reparierten Fixture-Kardinalitäten, 2 Output-Hashes, 20 Negativfälle und 12
  Diagnosefamilien, Writes 0.
- Delivery-Set-Validator: Pass; 8 geänderte getrackte Pfade, 19 beabsichtigte
  ungetrackte Foundation-Pfade, 4 unveränderte Parent-Resume-Pfade, Writes 0.
- Run-State-Validator: Pass; Run, Feature, Autorität und 8/8 akzeptierte Hashes
  gültig; `autonomous-run-state.json` wurde nicht geschrieben.
- UTF-8/NUL/JSON/Identifier-Prüfung: Pass; 39 Textdateien, 6 JSON-Dateien und
  vollständige 35/14/10/14/44-Identifierabdeckung.
- `git diff --check`: Pass. Statistik-Fixturetests: Pass, 146 Assertions.
- T026/T027-Fixtureprüfung: Pass; erwartete Hashes, fünf Felder, Linkformen,
  Proof-Zustände und Kantenkardinalitäten stimmen.
- Statistik-Check-only meldet `DRIFT`, weil die Phase nicht abgeschlossen ist;
  es wurde kein vorzeitiger Statistik-Write ausgeführt.
- T028/T029 wurden nicht gestartet; daher existiert noch kein behaupteter
  Rotnachweis gegen den Vier-Spalten-Renderer.

*The same checks passed with the stated counts. Statistics check-only reports
`DRIFT` because the phase is incomplete, so no premature statistics write was
performed. T028/T029 were not started and no red result is claimed.*

Nächste exakte Aktion: T028 und T029 als semantisch identische Bash- und
PowerShell-Vertragstests implementieren und beide gegen den bestehenden
Vier-Spalten-Renderer tatsächlich rot ausführen. Erst danach dürfen T030 und
T031 die typisierte Fünf-Felder-Projektion ändern.

*Next exact action: implement T028 and T029 as semantically identical Bash and
PowerShell contract tests and actually run both red against the existing
four-column renderer. Only then may T030 and T031 change the typed five-field
projection.*
