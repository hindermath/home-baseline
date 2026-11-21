# Preset-E2E: Szenario A · C# auf Mac B / Scenario A · C# on Mac B

## Deutsch

**Stand: manuell geprüft, keine Preset-Einreichung.** Der Lauf vom
21. November 2026 ist technisch abgeschlossen. Die **manuellen CLI- und
TUI-Stichproben** sind **bestanden**. Die manuellen Reviews des **Handbuchs**
und **dieser Referenzfassung** sind **bestanden**.

Der C#-Rechner wurde nativ auf macOS 27.2 (ARM64) mit .NET SDK 11.0.100 und
Runtime 11.0.0 geprüft. Ein isolierter Level-1-Workspace enthielt ein
Level-2-Testprojekt. Der Modus `LocalImplementation` bedeutete lokale Umsetzung
und Abnahme mit synthetischen Daten, ohne Commit, Push oder PR für die Features.
Die Serie und alle vier Feature-Läufe erreichten `Completed`. Der geprüfte
Stand enthielt uncommittierte Dateien; der Basiscommit allein reproduziert ihn
nicht. Der damalige Level-0-Commit und ein vollständiger Szenario-Preflight
sind aus den vier Originalberichten nicht eindeutig belegt.

- **[Feature 1 – CLI-Rechner](#feature-1-cli):** 12/12 Aufgaben, 3/3 lokale
  Pflichtprüfungen. Offline-Release-Build ohne Warnungen oder Fehler. 138/138
  echte CLI-Aufrufe in `C` und `de_DE.UTF-8`: 32 Erfolge und 106 erwartete
  Ablehnungen; Ausgabe, Fehlerausgabe und Exitcode getrennt verglichen.
- **[Feature 2 – Automatisierte CLI-Tests](#feature-2-cli-tests):** 26/26
  Aufgaben, 5/5 Pflichtprüfungen. Unabhängige Abnahme: 161/161 Pflichtfälle
  (23 direkte Rechentests und 69 CLI-Prozesse je Locale), ohne fehlende,
  übersprungene oder fehlerhafte Fälle. Separat: 7/7 Runner-Selbstprüfungen
  und 4/4 Ressourcenprüfungen. Ein zunächst ungültiger Prüfpfad (Exit 127)
  wurde korrigiert; maßgeblich ist die erneute Abnahme.
- **[Feature 3 – Terminal-Oberfläche](#feature-3-tui):** 18/18 Aufgaben,
  7/7 Pflichtprüfungen. 161/161 CLI-Fälle in einer isolierten Archivkopie
  erneut ausgeführt. Separat: 308/308 C#-Fälle, 2/2 erwartete Ablehnungen
  umgeleiteter Ein-/Ausgabe, 139/139 Beobachtungen in 14 nativen
  Pseudoterminals und eine unabhängige Gegenprobe mit 40/40 Prüfungen.
  Der Terminalmodus wurde exakt wiederhergestellt.
- **[Feature 4 – Zweisprachiges Handbuch](#feature-4-handbook):** 18/18
  Aufgaben, 7/7 Pflichtprüfungen. Geprüft wurden zehn PDF-Seiten (fünf je
  Sprache), 16 Überschriften, 30 interne Linkziele und acht Tabellen. 6/6
  Tastatursprünge und 6/6 Suchaufgaben bestanden. Die Stichprobe umfasste
  14 CLI-Aufrufe, eine native Terminal-Sitzung und vier Offline-Restore- und
  Build-Prüfungen. Keine erneute Vollsuite für Feature 4.

**Grenzen:** 74/74 Aufgaben sind keine 74 Tests. Wiederholungen und
unterschiedliche Prüfarten nicht zu einer Zahl eindeutiger Fälle addieren.
Kein Nachweis für Windows, Linux oder Container. Screenreader und Braille
wurden nicht geprüft; Terminal- und PDF-Prüfungen belegen keine allgemeine
WCAG- oder PDF/UA-Konformität. Die 14 installierten Preset-Deskriptoren im
lokalen Gesamtbericht belegen keine vollständige Funktionsabnahme. Die
[Verweisübersicht](#preset-submission-links) trennt Beleg und Aussagegrenze.

## English

**Status: manually reviewed, no preset submission.** The 21 November 2026
run is technically complete. The **manual CLI and TUI smoke checks passed**.
Manual review of the **handbook** and **this reference document** passed.

The C# calculator was tested natively on macOS 27.2 (ARM64) with .NET SDK
11.0.100 and runtime 11.0.0. One isolated Level 1 workspace contained one
Level 2 test project. `LocalImplementation` meant local implementation and
acceptance using synthetic data, with no feature commits, pushes or PRs. The
series and all four feature runs reached `Completed`. The tested state included
uncommitted files; the base commit alone cannot reproduce it. The four original
reports do not establish the exact Level 0 revision at run time or a complete
scenario preflight.

<a id="feature-1-cli"></a>

### Feature 1 · CLI calculator

12/12 tasks and 3/3 required local checks. The offline Release build had no
warnings or errors. All 138 real CLI invocations passed across `C` and
`de_DE.UTF-8`: 32 successes and 106 expected rejections. Output, error output
and exit status were compared separately.

<a id="feature-2-cli-tests"></a>

### Feature 2 · Automated CLI tests

26/26 tasks and 5/5 required checks. Independent acceptance covered all 161
required cases (23 direct calculation tests and 69 CLI processes per locale),
with no missing, skipped or failed cases. Separately: 7/7 runner self-checks
and 4/4 resource checks. An initially invalid check path (exit 127) was fixed;
the subsequent acceptance run establishes the result.

<a id="feature-3-tui"></a>

### Feature 3 · Terminal interface

18/18 tasks and 7/7 required checks. All 161 CLI cases were rerun in an
isolated archive copy. Separately: 308/308 C# cases, 2/2 expected redirected
input/output refusals, 139/139 observations in 14 native pseudoterminals,
and a separate independent check with 40/40 results. The terminal mode was
restored exactly.

<a id="feature-4-handbook"></a>

### Feature 4 · Bilingual handbook

18/18 tasks and 7/7 required checks. Review covered ten PDF pages (five per
language), 16 headings, 30 internal destinations and eight tables. All six
keyboard jumps and six lookup tasks passed. The smoke check covered 14 CLI
invocations, one native terminal session and four offline restore/build
checks. Full application suites were not rerun for Feature 4.

**Limits:** 74/74 tasks does not mean 74 tests. Do not sum reruns and different
check types as distinct cases. No evidence for Windows, Linux or containers.
Screen readers and Braille were not tested; terminal and PDF checks do not
establish general WCAG or PDF/UA conformance. The 14 installed preset
descriptors in the private consolidated report do not establish functional
acceptance. The [submission index](#preset-submission-links) separates observed
evidence from the limits of each claim.

<a id="manual-review"></a>

## Manuelle Stichproben und Reviews / Manual smoke checks and reviews

**DE:** Die CLI-Stichprobe in PowerShell auf Mac B ergab `8` für `6 add 2`
und einen zweisprachigen Fehler mit Exitcode 3 für `1 divide 0`. Die
TUI-Stichprobe in macOS Terminal mit PowerShell bestätigte die Eingabe von
`6` und `2`, den Fokuswechsel mit `Tab` und das Ergebnis `8` nach `Enter`
auf „Berechnen“. Beide Stichproben sind bestanden.

**Bedienbarkeitsbefund:** Ohne sichtbare Eingabemarke am aktiven Feld wirkte
die Startansicht zunächst wie eine reine Textausgabe. Empfehlung: das aktive
Feld direkt und ohne Farbe allein kennzeichnen und dort zum Tippen auffordern.
Die Verbesserung wurde nicht umgesetzt.

**Reviews bestanden:** Der Anwender hat das zweisprachige PDF-Handbuch und
diese bereinigte Referenzfassung jeweils manuell geprüft und bestätigt, dass
beides passt. Die vier übereinstimmenden Quellprüfsummen sind ein separater
technischer Nachweis.

**EN:** The CLI smoke check in PowerShell on Mac B returned `8` for
`6 add 2` and a bilingual error with exit code 3 for `1 divide 0`. The TUI
smoke check in macOS Terminal with PowerShell confirmed input of `6` and `2`,
focus changes with `Tab`, and the result `8` after pressing `Enter` on
“Calculate”. Both smoke checks passed.

**Usability finding:** Without a visible insertion marker in the active
field, the start screen initially looked like static output. Recommendation:
mark the active field directly without relying on color alone, and prompt the
user there to start typing. The improvement has not been implemented.

**Reviews passed:** The user manually reviewed the bilingual PDF handbook and
this sanitized reference document and confirmed that both were satisfactory.
The four matching source report digests are separate technical evidence.

<a id="preset-submission-links"></a>

## Abschnittslinks für Preset-Einreichungen / Section links for preset submissions

DE: Bei einer gesondert genehmigten Preset-Einreichung die zutreffende Rubrik
an einer **festen Commit-ID** verlinken. Die Links unten funktionieren
innerhalb dieses Dokuments.
Linkziele belegen die genannte Beobachtung, keinen pauschalen Preset-Pass.

EN: For any separately authorized preset submission, link the relevant section
at a **fixed commit ID**. The links below are internal to this document.
Each target supports the stated observation, not a blanket preset pass.

| Preset(s) | Abschnitt / Section | Beleggrenze / Claim boundary |
|---|---|---|
| `intake-authoring-governance`, `intake-review-governance`, `intake-sequencing-governance`, `autonomous-run-governance` | [Intake, Review und Serie / Intake, review and series](#evidence-intake-and-series) | Ein lokaler Serienlauf / One local series run |
| `model-routing-governance` | [Modellphase und Runner / Model phase and runner](#evidence-model-phase) | Lesende Phase und Runner-Abnahme; keine vollständige Routing-Matrix / Read-only phase and runner acceptance; not a full routing matrix |
| `a11y-governance` | [Tastatur und Dokumentstruktur / Keyboard and document structure](#evidence-accessibility) | Teilnachweis ohne Assistenztechnik / Partial evidence without assistive technology |
| `architecture-governance`, `isaqb-architecture-governance`, `security-governance`, `secure-development-assurance-governance` | [Featurebezogene Reviews / Feature-scoped reviews](#evidence-scoped-reviews) | Prüfspur, keine Gesamtfreigabe oder separate Abnahme jedes Presets / Review trail, not overall approval or separate acceptance of each preset |
| `cross-platform-governance`, `agent-parity-governance`, `project-statistics-governance`, `parallel-autonomous-run-governance` | [Offene oder nicht anwendbare Nachweise / Open or non-applicable evidence](#evidence-coverage-limits) | Nicht als Funktions-Pass einreichen / Do not submit as functional passes |

<a id="evidence-intake-and-series"></a>

### Intake, Review und Serie / Intake, review and series

Vier lokale Lastenhefte (Intakes) wurden erstellt, geprüft (`Ready`) und in
einer geordneten Serie umgesetzt. Serie und Einzelläufe endeten `Completed`;
es war kein weiteres Feature startberechtigt. Das belegt die beobachtete
Reihenfolge und den Abschluss im Modus `LocalImplementation`, keine
Remote-Lieferung und keinen vollständigen Test der negativen Gates.

*Four local feature briefs (intakes) were created, reviewed (`Ready`) and
implemented in an ordered series. The series and individual runs ended in
`Completed`, with no next eligible feature. This supports the observed ordering
and completion in `LocalImplementation`, not remote delivery or full negative
gate coverage.*

<a id="evidence-model-phase"></a>

### Modellphase und Runner / Model phase and runner

Bei Feature 4 speicherte der Runner das Ergebnis der lesenden Analyse im
korrigierten Versuch ohne zusätzliche Schreibrechte für die Analyse. Das
belegt die konkrete Übergabe, aber weder alle Modellzuordnungen noch die
Gleichwertigkeit der Agentenoberflächen.

*In Feature 4 the runner saved the read-only analysis result on retry without
granting write access to the analysis. This demonstrates the handoff, not all
model bindings or parity across agent surfaces.*

<a id="evidence-accessibility"></a>

### Tastatur und Dokumentstruktur / Keyboard and document structure

[Feature 3](#feature-3-tui) prüfte Tastaturbedienung und die Wiederherstellung
des Terminalmodus. [Feature 4](#feature-4-handbook) verband Strukturprüfung
und praktische Navigation mit derselben finalen PDF. Screenreader und Braille
blieben ungeprüft, ebenso die umfassende Konformität.

*[Feature 3](#feature-3-tui) checked keyboard operation and restoration of
terminal mode. [Feature 4](#feature-4-handbook) tied structural checks and
practical navigation to the same final PDF. Screen reader, Braille and overall
conformance remain unverified.*

<a id="evidence-scoped-reviews"></a>

### Featurebezogene Reviews / Feature-scoped reviews

Die Originalberichte dokumentieren unter anderem elf Security-, sechs
Architektur- und einen Barrierefreiheits-Prüfnachweis für Feature 1, lokale
Reviews für Feature 2 sowie Architektur und Werkzeugherkunft für Feature 4.
Das belegt lokale, auf Features begrenzte Reviews. Offene externe
Assurance-Punkte bleiben offen. Die Anzahl der Nachweise ersetzt keinen
separaten Funktionsnachweis für ein bestimmtes Preset.

*The original reports record, among other items, eleven security, six
architecture and one accessibility review record for Feature 1, local reviews
for Feature 2, and architecture and tool provenance for Feature 4. These are
local, feature-scoped reviews. External assurance follow-ups remain open.
Record counts do not substitute for a functional check of a specific preset.*

<a id="evidence-coverage-limits"></a>

### Offene oder nicht anwendbare Nachweise / Open or non-applicable evidence

Nur native macOS-Evidenz; kein Plattform- oder Agentenparitätsnachweis. Der
Statistik-Renderer wurde nur im Prüf-/Vorschaumodus beurteilt; kein Nachweis
für neu erzeugte, Commit-gebundene Statistik. Parallel Autonomous Run war in
A nicht anwendbar und gehört in die passenden Szenarien B und D.

*Native macOS evidence only; no platform or agent parity evidence. The
statistics renderer was assessed in check/preview mode only; there is no
evidence of newly generated commit-bound statistics. Parallel Autonomous Run
was not applicable in A and belongs in the relevant B and D scenarios.*

## Herkunft und Pflege / Provenance and maintenance

Die SHA-256-Prüfsummen identifizieren die vier lokalen Originalberichte.
Die Originale und lokalen Artefakte sind nicht Teil dieses Dokuments. Sie
bleiben die Detailquelle; diese Fassung enthält keine Host-Pfade,
Anmeldedaten, internen Lauf-IDs oder Rohprotokolle. Übertragbare Regeln
stehen in den [Feldbelegen des Runbooks](../README.md#field-evidence-refs).

*The SHA-256 digests identify the four local source reports. The originals
and local artifacts are not included here and remain the detailed source.
This version omits host paths, credentials, internal run IDs and raw logs.
See the [runbook's field evidence](../README.md#field-evidence-refs) for
reusable guidance.*

| Originalbericht / Source report | SHA-256 |
|---|---|
| Feature 1 · `specs/001-cli-rechner/completion-report.md` | `4ee13357042cb684ff83a2dd88745643e1e929b78a6ef4d898a503e9baaa7728` |
| Feature 2 · `specs/002-cli-tests/completion-report.md` | `bd4a3ea7bf0e294324181a8c1c6754a14eb6e8fc89ad147f013db23975bb480a` |
| Feature 3 · `specs/003-cli-tui/completion-report.md` | `75c0d1c15be49add8482f850a630b455fbf59b6b8bec1d9d522ca4dea65b1a51` |
| Feature 4 · `specs/004-cli-handbuch/completion-report.md` | `935a95168b22e9bbf4afedf7fa03e3de7d259b2dc6fb435a33a13fd5408e4012` |

**Dokumentationsauswirkung / Documentation impact: `UpdateRequired`.**
DE: Neue, zweisprachige `sourceOnly`-Referenz für Maintainer und Prüfende;
kein Home-Sync. Leserpfad: Verweisübersicht → Beleg → Aussagegrenze.
Verantwortlich: E2E-Maintainer. Wiedervorlage bei Änderungen am geprüften
Stand oder neuen unabhängigen Nachweisen. EN: New bilingual `sourceOnly` reference for
maintainers and reviewers; no Home sync. Reader path: submission index →
evidence → claim boundary. Owner: E2E maintainer. Revisit when the reviewed
state changes or new independent evidence is available.
