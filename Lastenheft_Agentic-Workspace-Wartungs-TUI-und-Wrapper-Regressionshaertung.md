<!-- intake-authoring:begin -->
# Lastenheft: Agentic-Workspace-Wartungs-TUI- und Wrapper-Regressionshaertung

**Repository:** `home-baseline`
**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** `ReadyForReview`
**Version:** 1.0
**Stand:** 2026-07-31
**Series:** `home-baseline-delivery`, bevorzugte Root vor D4, `Eligible`
**Bindende Vorgaenger:** keine; D4 bleibt eine unabhaengige Root
**Documentation Impact:** `UpdateRequired`

## 1. Zweck / Purpose

Dieses Lastenheft fordert eine gezielte Regressionshaertung der vorhandenen
Agentic-Workspace-Wartung. Zwei beobachtete Fehler werden gemeinsam behoben:
Der JSONL-Live-Status verliert Ereignisse und meldet dadurch einen falschen
`RESULT_MISMATCH`; der argumentlose Aufruf der Home-Runtime bricht unter dem
macOS-System-Bash 3.2 mit einer ungebundenen Array-Variable ab.

*This requirements document requests targeted regression hardening for the
existing Agentic Workspace maintenance flow. It addresses two observed defects:
the JSONL live-status channel loses events and reports a false
`RESULT_MISMATCH`, while the argumentless Home Runtime invocation fails under
macOS system Bash 3.2 because an empty array is treated as unbound.*

Die schlichte, lineare und barrierearme Darstellung bleibt erhalten. Dieses
Lastenheft fordert weder ein Dashboard noch einen Ausbau des
Spectre.Console-`LiveDisplay`.

*The simple, linear, accessibility-oriented presentation remains in place. A
dashboard or an expansion of Spectre.Console `LiveDisplay` is not requested.*

Das Erstellen dieses Dokuments startet weder Intake Review noch Specify,
Autonomous oder Parallel Autonomous.

*Creating this document starts no Intake Review, Specify, Autonomous, or
Parallel Autonomous run.*

## 2. Zielgruppen und Nutzungskontext / Audience and Usage Context

Das Ergebnis richtet sich an Personen, die die Level-0-Wartung auf macOS,
Linux oder Windows interaktiv oder headless ausfuehren, sowie an Maintainer und
Pruefende. Es werden keine Vorkenntnisse zu Spectre.Console oder zum internen
Ereigniskanal vorausgesetzt. Fachbegriffe werden bei der ersten Verwendung kurz
erklaert, und Status, Fehler, Entscheidungen sowie naechste Aktionen bleiben
als Text verfuegbar.

*The result serves people who run Level 0 maintenance interactively or
headlessly on macOS, Linux, or Windows, as well as maintainers and reviewers.
No prior knowledge of Spectre.Console or the internal event channel is assumed.
Terms are explained on first use, while status, errors, decisions, and next
actions remain available as text.*

## 3. Beobachtete Ausgangslage / Observed Current State

### 3.1 Degradierter Live-Status trotz erfolgreichem Engine-Lauf

Ein interaktiver Aufruf von `scripts/maintain-agentic-workspace.sh --tui` im
Modus `CheckOnly` zeigte den Befund `EVENT_STREAM_DEGRADED` mit dem Grund
`SequenceGap`. Ein `run-completed`-Ereignis fehlte. Anschliessend meldete die
Oberflaeche trotz Prozess-Exitcode `0` den Status `RESULT_MISMATCH` und einen
fehlenden finalisierten Bericht.

*An interactive `scripts/maintain-agentic-workspace.sh --tui` run in
`CheckOnly` mode reported `EVENT_STREAM_DEGRADED` with reason `SequenceGap`.
The `run-completed` event was missing. The UI then reported `RESULT_MISMATCH`
and a missing finalized report even though the process exit code was `0`.*

Die Wartungs-Engine und ihr Exitcode duerfen durch einen Darstellungsfehler
nicht umgedeutet werden. Ein ausgefallener normaler Live-Status ist ein
Implementierungsfehler und kein erwarteter Erfolgszustand.

*The maintenance engine and its exit code must not be reinterpreted by a
presentation defect. A failed normal live-status path is an implementation
error, not an expected successful state.*

### 3.2 Argumentloser Home-Runtime-Aufruf unter Bash 3.2

Der direkte Aufruf `scripts/maintain-agentic-workspace.sh` aus `~/` brach auf
macOS mit folgender Meldung ab:

```text
scripts/maintain-agentic-workspace.sh: line 559: ORIGINAL_ARGS[@]: unbound variable
```

Der Wrapper speichert die urspruenglichen Argumente in einem Array und reicht
sie bei der Delegation an die versionierte Level-0-Quelle weiter. Unter dem
macOS-System-Bash 3.2 ist die Expansion eines leeren Arrays zusammen mit
`set -u` nicht sicher.

*The direct `scripts/maintain-agentic-workspace.sh` invocation from the Home
Runtime fails on macOS while forwarding an empty original-argument array to the
versioned Level 0 source. Empty-array expansion is not safe with `set -u` under
macOS system Bash 3.2.*

## 4. Zielbild / Target State

Ein normaler TUI- oder Plain-UI-Lauf liest einen vollstaendigen, gueltigen und
lueckenlosen Ereignisstrom. Start-, Phasen- und Abschlussereignisse erscheinen
in der vorgesehenen Reihenfolge. Der finalisierte Bericht wird unabhaengig von
der Darstellungsqualitaet deterministisch gefunden und gegen Lauf-ID,
Gesamtstatus und Prozess-Exitcode geprueft.

*A normal TUI or plain-UI run reads a complete, valid, gap-free event stream.
Start, phase, and completion events appear in the required order. The finalized
report is located deterministically even if presentation quality degrades and
is reconciled with run ID, overall status, and process exit code.*

Der argumentlose Home-Runtime-Aufruf delegiert unter Bash 3.2 ohne Fehler an
genau einen Engine-Prozess. Null, ein oder mehrere Argumente werden unveraendert
weitergegeben.

*The argumentless Home Runtime invocation delegates safely under Bash 3.2 to
exactly one engine process. Zero, one, or multiple arguments are forwarded
without modification.*

## 5. Umfang / Scope

Im Umfang liegen:

- die Bash-Ereigniserzeugung und die Verarbeitung ihrer `details`-Objekte;
- die Sequenzierung und der Abschluss des JSONL-Ereignisstroms;
- die Berichtsermittlung und Ergebnisabstimmung im TUI-/Plain-UI-Wrapper;
- die Bash-3.2-sichere Delegation aus der Home Runtime;
- gezielte Wrapper-End-to-End- und Plattformregressionstests;
- erforderliche Bedienungs-, Wartungs- und Testdokumentation;
- die funktionale Paritaetspruefung der PowerShell-7-Variante.

*Scope includes Bash event generation and detail-object handling, JSONL
sequencing and completion, report discovery and result reconciliation in the
UI wrapper, Bash-3.2-safe Home Runtime delegation, focused wrapper end-to-end
and platform regression tests, required operational documentation, and
functional parity checks for PowerShell 7.*

## 6. Nicht-Ziele und harte Grenzen / Non-Goals and Hard Boundaries

- Kein Dashboard, keine mehrspaltige Prozessansicht und kein neuer
  Spectre.Console-`LiveDisplay`-Ausbau.
- Keine Aenderung der bestehenden CLI-Optionen oder ihrer Bedeutung.
- Keine neue Wartungsfunktion und keine duplizierte Wartungslogik in der UI.
- Keine Aenderung von Eventschema 1, ausser sie ist zur Korrektur eines bereits
  vertraglich vorgesehenen Feldes zwingend erforderlich und bleibt kompatibel.
- Keine Abschwaechung der Mutations-, Remote-Freshness-, Sicherheits- oder
  Bestaetigungsbarrieren.
- Kein zusaetzlicher Engine-Prozess und keine Shellauswertung durch `eval` oder
  zusammengesetzte Befehlsstrings.
- Keine Commit-, Push-, PR- oder Merge-Autoritaet fuer gewartete Ziel-Repositories.
- Kein automatischer Start eines nachfolgenden Spec-Kit-Laufs.

*The feature adds no dashboard, multi-column process view, new LiveDisplay,
maintenance behavior, duplicated engine logic, weakened safety barrier,
additional engine process, shell evaluation, or publication authority for
maintained target repositories. Existing CLI options and event schema 1 remain
compatible. No follow-on Spec Kit run starts automatically.*

## 7. Funktionale Anforderungen / Functional Requirements

### 7.1 Ereigniskanal

- **FR-EVT-001:** Jede geschriebene JSONL-Zeile MUSS ein einzelnes gueltiges
  JSON-Objekt sein. `details` MUSS ein gueltiges JSON-Objekt sein und darf weder
  angehaengte Zeichen noch ein zweites JSON-Dokument enthalten.
- **FR-EVT-002:** Die erste Sequenznummer MUSS `1` sein. Danach MUSS jede
  erfolgreich geschriebene Zeile die vorherige Sequenz exakt um `1` erhoehen.
- **FR-EVT-003:** Jeder gestartete Lauf MUSS bei normal verfuegbarem
  Ereigniskanal genau ein passendes `run-started` und genau ein abschliessendes
  `run-completed` enthalten.
- **FR-EVT-004:** `run-completed` MUSS Lauf-ID, finalisierten Berichtspfad,
  Logpfad, Gesamtstatus und Engine-Exitcode korrekt wiedergeben.
- **FR-EVT-005:** Ein normaler vollstaendiger Lauf DARF keinen falschen
  `EVENT_STREAM_DEGRADED`-Befund erzeugen.
- **FR-EVT-006:** Bei tatsaechlich ungueltigem JSON, einer Sequenzluecke oder
  nicht unterstuetztem Schema MUSS die UI sichtbar auf lineare Ausgabe
  degradieren, ohne die Engine abzubrechen oder ihren Exitcode zu veraendern.

*Every JSONL line is one valid object, details remain valid JSON, sequence
numbers are continuous from 1, and a normal run contains matching start and
completion events. A real stream defect degrades presentation visibly without
changing the engine process or exit code.*

### 7.2 Abschlussbericht und Ergebniswahrheit

- **FR-RES-001:** Der Wrapper MUSS den finalisierten Bericht anhand des
  festgelegten Run-ID- und Berichtspfadvertrags deterministisch laden koennen,
  auch wenn `run-completed` fehlt oder der Ereigniskanal degradiert ist.
- **FR-RES-002:** Ein erfolgreicher Bericht und Prozess-Exitcode `0` DUERFEN
  nicht allein wegen eines degradierten Darstellungskanals als
  `RESULT_MISMATCH` klassifiziert werden.
- **FR-RES-003:** `RESULT_MISMATCH` DARF nur erscheinen, wenn sich vorhandene
  kanonische Werte tatsaechlich widersprechen, zum Beispiel Prozess-Exitcode,
  finalisierter Bericht und gueltiges Abschlussereignis.
- **FR-RES-004:** Ein fehlender oder nicht finalisierter Bericht MUSS weiterhin
  wahrheitsgetreu sichtbar sein und darf nicht als Erfolg erfunden werden.
- **FR-RES-005:** Abschlussmeldung und naechste Aktion MUESSEN konkret zwischen
  Engine-Ergebnis, Ereigniskanal-Degradierung und echtem Ergebniswiderspruch
  unterscheiden.

*The wrapper deterministically recovers the finalized report even when the
event channel degrades. `RESULT_MISMATCH` is reserved for real contradictions
between canonical values. Missing evidence remains visible and is never
invented as success.*

### 7.3 Bash-3.2-sichere Argumentweitergabe

- **FR-ARG-001:** Der argumentlose Home-Runtime-Aufruf MUSS unter dem
  unveraenderten macOS-System-Bash 3.2 mit `set -euo pipefail` funktionieren.
- **FR-ARG-002:** Die Delegation MUSS null Argumente ohne Expansion einer unter
  `set -u` ungebundenen oder unsicheren leeren Array-Referenz weitergeben.
- **FR-ARG-003:** Ein einzelnes Argument und mehrere Argumente MUESSEN
  bytegetreu als getrennte Argumente weitergegeben werden; Leerzeichen und
  Shell-Metazeichen duerfen keine neue Auswertung ausloesen.
- **FR-ARG-004:** Die Delegation MUSS genau einen Engine-Prozess durch `exec`
  oder einen gleichwertig nachgewiesenen Prozessvertrag verwenden.
- **FR-ARG-005:** Direkter Aufruf aus der Level-0-Quelle und delegierter Aufruf
  aus der Home Runtime MUESSEN dieselben dokumentierten Optionen und Exitcodes
  behalten.

*The Home Runtime safely forwards zero, one, or multiple arguments under Bash
3.2 and `set -euo pipefail`. Argument boundaries remain exact, shell
metacharacters are not re-evaluated, and exactly one engine process is used.*

### 7.4 Plattformparitaet

- **FR-PAR-001:** Die PowerShell-7-Variante MUSS denselben fachlichen
  Ereignis-, Bericht- und Ergebnisvertrag behalten.
- **FR-PAR-002:** Bereits korrektes PowerShell-Verhalten DARF nicht allein zur
  mechanischen Angleichung veraendert werden.
- **FR-PAR-003:** Plattformunterschiede in Bash 3.2, neuerem Bash und
  PowerShell 7 MUESSEN durch gezielte Tests sichtbar bleiben.

*PowerShell 7 retains the same functional event, report, and result contract.
Correct behavior is not changed for cosmetic parity, while platform-specific
differences remain covered by focused tests.*

## 8. Qualitaets-, Sicherheits- und A11Y-Anforderungen / Quality, Security, and A11Y Requirements

- Die Ausgabe bleibt linear, textorientiert und ohne Farbabhaengigkeit
  verstaendlich. Status und naechste Aktion stehen als Klartext bereit.
- Tastatur, Screenreader, Braille-Zeile, Textbrowser und `TERM=dumb` behalten
  einen nutzbaren Pfad nach WCAG 2.2 Level AA, soweit auf Terminalausgabe
  anwendbar.
- Ereignisse, Logs und Abschlussmeldungen duerfen keine Secrets, Tokens,
  Verbindungszeichenketten oder unnoetigen absoluten privaten Pfade ausgeben.
- Datei- und Prozessargumente werden als getrennte Werte uebergeben. `eval`,
  `Invoke-Expression` und erneute Shellinterpretation bleiben verboten.
- Ereignis- und Berichtspfade bleiben laufkorreliert, benutzerprivat und gegen
  fremde Run-IDs fail-closed.
- Neue nicht triviale Logik wird auf didaktische Inline-Kommentare geprueft;
  Kommentare erklaeren den Bash-3.2-Randfall oder die Evidence-Grenze, nicht
  offensichtlichen Kontrollfluss.

*Output remains linear, text-first, understandable without color, and usable
with keyboard, screen readers, braille displays, text browsers, and `TERM=dumb`
where WCAG 2.2 AA applies. Logs avoid secrets and unnecessary private data.
Arguments are passed as distinct values, run evidence remains private and
correlated, and non-trivial compatibility logic receives explanatory comments
where useful.*

## 9. Erwartete Artefakte / Expected Artifacts

Die spaetere Umsetzung liefert mindestens:

1. die gezielte Bash-Korrektur im vorhandenen Wartungswrapper;
2. erforderliche Anpassungen im vorhandenen TUI-/Plain-UI-Hilfsprogramm;
3. plattformparitaetische Tests und Fixtures fuer Ereignisse, Bericht und
   Argumentweitergabe;
4. aktualisierte Bedienungs- und Wartungsdokumentation, soweit semantisch
   betroffen;
5. eine dokumentierte Documentation-Impact-Entscheidung mit Evidence;
6. aktualisierte Projektstatistik nach Abschluss der Implementierung.

*The later implementation supplies focused wrapper and UI-helper corrections,
cross-platform tests and fixtures, affected operational documentation, a
documented Documentation Impact decision, and updated project statistics.*

## 10. Verbindliche Verifikation / Required Verification

Die spaetere Implementierung MUSS mindestens folgende Nachweise ausfuehren:

1. einen isolierten Test mit `/bin/bash` auf macOS, der die Bash-3.2-Version
   nachweist und den argumentlosen Home-Runtime-Aufruf prueft;
2. Argumenttreue fuer null, ein und mehrere Argumente einschliesslich Werten
   mit Leerzeichen;
3. Wrapper-End-to-End-Tests ueber den tatsaechlichen Bash-Ereignispfad, nicht
   nur direkte Tests des Python-Ereignisschreibers;
4. einen vollstaendigen JSONL-Lauf mit `run-started`, Phasenereignissen,
   lueckenlosen Sequenzen ab `1` und genau einem `run-completed`;
5. einen absichtlich degradierten Ereignisstrom, bei dem der korrekte
   finalisierte Bericht dennoch gelesen und dargestellt wird;
6. einen echten Widerspruchstest, der `RESULT_MISMATCH` erwartet, sowie einen
   reinen Event-Degradierungstest, der ihn ausdruecklich nicht erwartet;
7. bestehende .NET-, Bash-, PowerShell-, A11Y- und vollstaendige
   Wartungsregressionstests;
8. Bash-Syntaxpruefung, PowerShell-Parser/PSScriptAnalyzer soweit verfuegbar,
   `git diff --check` und den Repository-Secret-Scan;
9. einen sicheren `--check-only`-Lauf vor jeder echten Wartungsvorschau.

*Verification covers macOS system Bash 3.2, exact zero/single/multiple argument
forwarding, wrapper end-to-end event production, complete and intentionally
degraded JSONL streams, real mismatch behavior, existing .NET/Bash/PowerShell/
A11Y/maintenance regressions, static checks, diff validation, secret scanning,
and a safe check-only run.*

## 11. Messbare Abnahmekriterien / Measurable Acceptance Criteria

- **AC-001:** Ein normaler Check-only-TUI-Lauf schreibt ausschliesslich
  gueltige JSON-Objekte mit lueckenloser Sequenz ab `1`.
- **AC-002:** Derselbe Lauf enthaelt genau ein `run-started`, mindestens die
  erwarteten Phasenereignisse und genau ein korrektes `run-completed`.
- **AC-003:** Der normale Lauf zeigt keinen `SequenceGap`, kein falsches
  `EVENT_STREAM_DEGRADED` und keinen falschen `RESULT_MISMATCH`.
- **AC-004:** Ein absichtlich beschaedigter Ereignisstrom meldet die
  Degradierung, laesst den Engineprozess weiterlaufen und zeigt den korrekt
  finalisierten Bericht samt Prozess-Exitcode.
- **AC-005:** `RESULT_MISMATCH` erscheint in Positivtests nur bei einem
  nachgewiesenen Widerspruch kanonischer Ergebniswerte.
- **AC-006:** `/bin/bash scripts/maintain-agentic-workspace.sh` funktioniert
  aus einer isolierten Home-Runtime-Kopie ohne Argumente und ohne
  `ORIGINAL_ARGS[@]: unbound variable`.
- **AC-007:** Null-, Einzel- und Mehrfachargumenttests beweisen unveraenderte
  Argumentgrenzen und genau einen Engine-Prozess.
- **AC-008:** Bestehende CLI-Optionen, Eventschema 1, Sicherheitsbarrieren und
  dokumentierte Exitcodes bleiben kompatibel.
- **AC-009:** Bash- und PowerShell-Validatoren sowie alle betroffenen
  Regressionstests sind gruen; ein Plattformtest darf nicht durch einen
  pauschalen Mock ersetzt werden.
- **AC-010:** Die lineare Darstellung bleibt ohne Farbe, Animation oder
  Dashboard vollstaendig verstaendlich und A11Y-geprueft.
- **AC-011:** Documentation Impact ist genau einmal entschieden; geaenderte
  Bedienungs- oder Wartungsvertraege sind zweisprachig nachgefuehrt.
- **AC-012:** Der Abschluss nennt getestete Plattformen, exakte Befehle,
  Ergebnisse, verbleibende Risiken und den naechsten sicheren Schritt.

*Acceptance requires valid continuous JSONL, truthful completion and report
recovery, mismatch only for real contradictions, a successful argumentless
Bash-3.2 Home Runtime invocation, exact argument forwarding, one engine
process, unchanged compatibility and safety contracts, green cross-platform
regressions, accessible linear output, and complete documentation evidence.*

## 12. Abhaengigkeiten, Risiken und Annahmen / Dependencies, Risks, and Assumptions

Abhaengigkeiten sind die vorhandenen Wartungswrapper, das interne
Spectre.Console-Hilfsprogramm, der Python-Standardbibliothekskern, die
finalisierten JSON-Berichte und die bestehenden Test-Harnesses. Externe neue
Abhaengigkeiten sind nicht vorgesehen.

*Dependencies are the existing maintenance wrappers, internal Spectre.Console
helper, Python standard-library core, finalized JSON reports, and current test
harnesses. No new external dependency is planned.*

Das groesste Risiko ist eine scheinbar kleine Wrapper-Korrektur, die nur den
direkten Event-Writer testet und den tatsaechlichen Bash-Aufrufpfad erneut
auslaesst. Ein weiteres Risiko ist, dass eine Fallback-Logik einen echten
fehlenden Bericht faelschlich als Erfolg kaschiert. Die End-to-End- und
Negativtests sind deshalb bindend.

*The main risk is a narrow wrapper correction that tests only the event writer
and again misses the real Bash path. Another risk is fallback logic hiding a
truly missing report. End-to-end and negative tests are therefore mandatory.*

Annahmen: Die vorhandenen CLI-Optionen und Eventschema 1 sind fachlich korrekt;
die beobachteten Fehler liegen in Erzeugung, Weitergabe oder Auswertung. Offene
Entscheidungen bestehen nicht.

*Assumptions: existing CLI options and event schema 1 are correct; the observed
defects are in generation, forwarding, or evaluation. No open decisions remain.*

## 13. Ausfuehrungsreihenfolge und Abschlussgrenze / Execution Order and Completion Boundary

Dieses Lastenheft ist die erste bevorzugte Root der aktiven
`home-baseline-delivery`-Serie und steht sichtbar vor D4. Zwischen diesem
Lastenheft und D4 besteht keine bindende fachliche Kante. Nach Abschluss wird
die Series erneut autorisiert aktualisiert, bevor ein anderer Kandidat als
bevorzugt deklariert wird.

*This intake is the first preferred root in the active
`home-baseline-delivery` series and appears before D4. No binding domain edge
connects it to D4. After completion, the series requires another authorized
update before another candidate becomes the declared preference.*

Die spaetere Implementierung ist erst abgeschlossen, wenn alle funktionalen,
Sicherheits-, A11Y-, Plattform-, Dokumentations- und Evidence-Gates bestanden
sind. `MergeAndSync` umfasst Commit, Push, nicht leeren PR, Review-Konvergenz,
Merge und Fast-forward-Synchronisierung von `main`. Ein Admin-Bypass ist nur
zulaessig, wenn alle technischen Gates gruen, keine umsetzbaren Review-Threads
offen und ausschliesslich die formale Human-Approval-Regel blockiert. Er ersetzt
keinen Test, Reviewbefund, Sicherheitsvertrag oder Hash-Gate.

*The later implementation completes only after all functional, security,
accessibility, platform, documentation, and evidence gates pass. `MergeAndSync`
includes commit, push, a non-empty pull request, review convergence, merge, and
fast-forward synchronization of `main`. Administrative bypass is limited to a
sole remaining formal human-approval rule after every technical gate is green
and no actionable review thread remains.*

<!-- intake-authoring:prompts -->
## 14. Spec-Kit-Startpunkte / Spec Kit Entry Points

### Specify

```text
$speckit-specify
Erstelle ausschliesslich die Spezifikation fuer Lastenheft_Agentic-Workspace-Wartungs-TUI-und-Wrapper-Regressionshaertung.md. Binde das aktuelle erfolgreiche Intake Review und den aktuellen Series-Status. Implementiere nichts, veraendere keine Wartungsskripte und fuehre keine Remote-Schreibaktion aus.
```

<!-- spec-kit-command-id: speckit.specify -->

### Autonomous

```text
$speckit-autonomous
Fuehre Lastenheft_Agentic-Workspace-Wartungs-TUI-und-Wrapper-Regressionshaertung.md mit DeliveryMode MergeAndSync aus. Binde das aktuelle erfolgreiche Intake Review und den aktuellen Series-Status. Der begrenzte Admin-Bypass ist nur zulaessig, wenn alle technischen, Sicherheits-, A11Y-, Validator- und CI-Gates gruen sind, keine umsetzbaren Review-Threads offen sind und ausschliesslich die formale Human-Approval-Regel das Merge verhindert. Starte kein weiteres Lastenheft.
```

<!-- spec-kit-command-id: speckit.autonomous -->
<!-- intake-authoring:end -->
