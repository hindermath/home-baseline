# Leere Auftragsvorlage: Preset-Praxistest / Blank request: preset end-to-end test

Diese Vorlage ist **kein erteilter Auftrag**. Vor einem Lauf alle Pflichtfelder ausfüllen, die aktuelle Repository-Guidance prüfen und den konkreten Start gesondert beauftragen. Für A, B, C und D jeweils einen eigenen Auftrag verwenden.

This template is **not an approved request**. Fill all required fields, check current repository guidance and separately authorize the exact start. Use a separate request for A, B, C and D.

| Pflichtfeld / Required field | Wert / Value |
|---|---|
| Verantwortlicher Maintainer / Responsible maintainer | _auszufüllen / to fill_ |
| Szenario A, B, C oder D / Scenario A, B, C or D | _auszufüllen / to fill_ |
| Neue Run-ID und neues Test-HOME / New run ID and test HOME | _auszufüllen / to fill_ |
| Ausführungsort Host oder Sandbox / Execution location Host or Sandbox | _auszufüllen / to fill_ |
| Host-Plattform, Version, Architektur / Host platform, version, architecture | _auszufüllen / to fill_ |
| Sprache bei A oder C / Language for A or C | _auszufüllen oder B/D: alle sechs / to fill or B/D: all six_ |
| Level-0-Revision und Preset-Matrix-Hash / Level 0 commit and preset matrix hash | _auszufüllen / to fill_ |
| Geprüftes Modell-/Runner-Profil / Checked model/runner profile | _auszufüllen / to fill_ |
| Shell und Version / Shell and version | _Bash oder PowerShell 7; [Beispiele](shell-examples.md) / Bash or PowerShell 7; [examples](shell-examples.md#english)_ |
| Laufzeitgrenze und Abbruchregel / Time limit and stop rule | _auszufüllen / to fill_ |
| Maximal gleichzeitige Worker / Maximum concurrent workers | _A/C: 1; B/D: höchstens 3 / A/C: 1; B/D: at most 3_ |
| Festgelegter DeliveryMode / Fixed delivery mode | `LocalImplementation` |
| Erlaubte Testdaten und lokale Ports / Allowed test data and local ports | _auszufüllen / to fill_ |
| Ergebnisbericht außerhalb des Test-HOME / Report outside test HOME | _auszufüllen / to fill_ |
| Übernommene Regeln für diesen Lauf / Adopted rules for this run | _ID, Szenario/Sprache und geplante Gegenprobe; falls keine passen: kurz begründen / ID, scenario/language and planned check; if none apply, briefly explain_ |
| Bereinigung beauftragt? / Cleanup authorized? | _Nein; eigener späterer Auftrag / No; separate later request_ |

**DE:** Lies die [Feldlehren](README.md#feldlehren-aus-szenario-a) und den letzten verfügbaren Laufbericht. Übernimm nur Regeln, die zu diesem Szenario, der Sprache und dem Ausführungsort passen. Übernimm keine alten Testergebnisse oder Freigaben. Ist eine Beobachtung noch offen, kannst du eine Gegenprobe einplanen, aber sie nicht als bestanden eintragen.

**EN:** Read the [field lessons](README.md#field-lessons-from-scenario-a) and the latest available run report. Carry forward only rules relevant to this scenario, language and execution location. Do not copy old results or approvals. For an open observation, plan a follow-up check without recording a pass.

## Startentscheidung / Start decision

**DE:** _Freigabe, Datum, genaue Run-ID und Startumfang eintragen. Fehlt ein Pflichtwert oder eine technische Vorprüfung, bleibt der Lauf blockiert. Dokumentationsreview allein erteilt keine Startberechtigung._

**EN:** _Record approval, date, exact run ID and start scope. A missing required field or technical preflight blocks the run. Documentation review alone does not authorize a start._
