# Leere Berichtsvorlage: Preset-Praxistest / Blank report: preset end-to-end test

Diese Vorlage bleibt leer, bis ein Maintainer einen konkreten Lauf beauftragt. Der ausgefüllte Bericht wird **außerhalb des Test-HOME** gespeichert. Vor öffentlicher Veröffentlichung werden Personen-, Geräte- und lokale Pfadangaben sowie Logs geprüft und bereinigt. Nach einer gesondert beauftragten Bereinigung bleibt nur dieser selbstständig lesbare Bericht.

Keep this template blank until a maintainer requests an exact run. Save the completed report **outside the test HOME**. Before public release, review and remove personal, device and local-path details and unsafe log content. After separately requested cleanup, only this self-contained report remains.

## Deutsch: Auftrag und Quellenstand

| Feld | Eintrag |
|---|---|
| Run-ID, Szenario, Start und Abschluss | _auszufüllen_ |
| Maintainer und Startfreigabe | _auszufüllen_ |
| Host oder Sandbox; OS, Architektur, Image falls benutzt | _auszufüllen_ |
| Level-0-Commit und 14-Preset-Matrix-Hash | _auszufüllen_ |
| Modell-/Runner-Profil und Vorprüfung | _auszufüllen_ |
| Laufzeitgrenze, Abbruchregel, tatsächliche Dauer | _auszufüllen_ |
| Isoliertes Test-HOME und Hash der echten Home-Dateien vorher/nachher | _nur geschützte Fassung: Pfad; öffentlich: abstrakter Nachweis_ |
| DeliveryMode und Remote-Prüfung | `LocalImplementation`; _keine Remotes belegen_ |
| Verwendete synthetische Testdaten | _auszufüllen_ |

## Deutsch: Level-1/2-Aufbau

| Ebene | Sprache | Commit oder Stand | 14 Presets: Versionen und Hashes | Ergebnis |
|---|---|---|---|---|
| Level 1 – genau ein Repo | Koordination | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| Level 2 – eine Zeile je Sprache | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |

## Deutsch: Features und Tests

Für **jede Sprache** und jede der vier Positionen eine eigene Zeile anlegen. Befehle, Zahlen, Fehler und Skips stammen aus diesem Lauf; alte Berichte sind keine Datenquelle.

| Sprache | Position und Lastenheft | Feature-Commit | Testbefehl und Anzahl | Bestanden / Fehlgeschlagen / Blockiert | Wichtiger Belegauszug und Hash |
|---|---|---|---|---|---|
| _auszufüllen_ | 1 – Anwendung | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| _auszufüllen_ | 2 – Tests | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| _auszufüllen_ | 3 – Oberfläche | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| _auszufüllen_ | 4 – Handbuch | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |

## Deutsch: Preset-Abdeckung

Die 14 ausgefüllten Zeilen aus dem [Abdeckungsblatt](preset-coverage-template.md) **hier vollständig einfügen**: Preset, Version/Hash, Aufruf, Wirkung, Status und wesentlicher Beleg. Keine bloßen Links in das löschbare Test-HOME. Für Negativ-Gates den getrennten Fixture-Nachweis ergänzen. Offene oder blockierte Zeilen getrennt nennen.

## Deutsch: Menschliche Prüfung und A11Y

| Prüfpunkt | Tatsächliche Beobachtung, Hilfsmittel und Grenze |
|---|---|
| Lernprüfung: Person/Rolle, geprüfte Schritte und Abweichungen | _auszufüllen_ |
| CLI/TUI oder HTTP/Web: Tastatur, Text und Fehler | _auszufüllen_ |
| Screenreader, Braille oder Textbrowser, soweit verfügbar | _auszufüllen oder begründet nicht geprüft_ |
| PDF: Quelle, Hash, Struktur, Sprache, Reihenfolge, Links, Textalternativen | _auszufüllen_ |
| Nicht geprüfte WCAG-2.2-AA-Kriterien und Grund | _auszufüllen_ |

## Deutsch: Bewertung und Bereinigung

**Nachgewiesen:** _auszufüllen_

**Fehlgeschlagen, blockiert oder nicht anwendbar:** _auszufüllen und begründen_

**Vergleich mit anderem Ausführungsort:** _separate Run-ID und Unterschiede angeben oder N/A_

**Nächste vorgeschlagene Aktion:** _auszufüllen; keine automatische Autorisierung_

**Bereinigung:** _Nicht beauftragt / beauftragt mit Datum und Identität; nur nach abgeschlossener Lernprüfung und gesichertem Bericht. Echte Home-Dateien/Registry/Volumes unverändert? Beleg eintragen._

**Nach einer Bereinigung:** Der damalige Quellstand und Rohbelege sind nicht mehr vorhanden und können nicht erneut geprüft werden. Die versionierten Vorlagen ermöglichen nur einen **neuen** Lauf.

---

## English: request and source state

| Field | Entry |
|---|---|
| Run ID, scenario, start and finish | _to fill_ |
| Maintainer and start approval | _to fill_ |
| Host or Sandbox; OS, architecture, image if used | _to fill_ |
| Level 0 commit and 14-preset matrix hash | _to fill_ |
| Model/runner profile and preflight | _to fill_ |
| Time limit, stop rule, actual duration | _to fill_ |
| Isolated test HOME and real home-file hashes before/after | _protected copy: path; public copy: abstract evidence_ |
| Delivery mode and remote check | `LocalImplementation`; _prove no remotes_ |
| Synthetic test data used | _to fill_ |

## English: Level 1/2 layout

| Level | Language | Commit or state | 14 presets: versions and hashes | Result |
|---|---|---|---|---|
| Level 1 – exactly one repository | Coordination | _to fill_ | _to fill_ | _to fill_ |
| Level 2 – one row per language | _to fill_ | _to fill_ | _to fill_ | _to fill_ |

## English: features and tests

Add a separate row for **every language** and all four positions. Commands, counts, errors and skips come from this run, never an older report.

| Language | Position and intake | Feature commit | Test command and count | Passed / Failed / Blocked | Key evidence excerpt and hash |
|---|---|---|---|---|---|
| _to fill_ | 1 – application | _to fill_ | _to fill_ | _to fill_ | _to fill_ |
| _to fill_ | 2 – tests | _to fill_ | _to fill_ | _to fill_ | _to fill_ |
| _to fill_ | 3 – UI | _to fill_ | _to fill_ | _to fill_ | _to fill_ |
| _to fill_ | 4 – handbook | _to fill_ | _to fill_ | _to fill_ | _to fill_ |

## English: preset coverage

Insert **all 14 completed rows** from the [coverage sheet](preset-coverage-template.md) here: preset, version/hash, invocation, behavior, status and key evidence. Do not rely only on links into the removable test HOME. Add separate fixture evidence for negative gates. Name open or blocked rows.

## English: human review and accessibility

| Check | Observed result, assistive tools and limit |
|---|---|
| Learner review: person/role, steps reviewed and differences | _to fill_ |
| CLI/TUI or HTTP/web: keyboard, text and errors | _to fill_ |
| Screen reader, Braille or text browser when available | _to fill or justified not tested_ |
| PDF: source, hash, structure, language, order, links, alternatives | _to fill_ |
| Untested WCAG 2.2 AA criteria and reason | _to fill_ |

## English: assessment and cleanup

**Proved:** _to fill_

**Failed, blocked or not applicable:** _to fill with reasons_

**Comparison with another execution location:** _give separate run ID and differences or N/A_

**Proposed next action:** _to fill; no automatic authority_

**Cleanup:** _Not requested / requested with date and identity; only after learner review and report preservation. Record evidence that real home files, registry and volumes are unchanged._

**After cleanup:** That source state and raw evidence no longer exist and cannot be rechecked. The versioned templates permit only a **new** run.
