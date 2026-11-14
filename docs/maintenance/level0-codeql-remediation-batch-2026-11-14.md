# Gebündelte Level-0-CodeQL-Bereinigung / Consolidated Level 0 CodeQL Remediation

## Zweck und Grenze / Purpose and Boundary

Dieses Paket bereinigt zuerst die gemeinsame Level-0-Quelle. Ein weiterer
Verbraucher-Rollout beginnt erst nach einem erfolgreichen CodeQL-Lauf auf dem
exakt geprüften Level-0-Head. Das Bedrohungsmodell setzt einen während des Laufs
unveränderten Worktree voraus; seine Inhalte bleiben nicht vertrauenswürdig.

*This batch remediates the shared Level 0 source first. No further consumer
rollout starts before CodeQL succeeds on the exact reviewed Level 0 head. The
threat model assumes an unchanged worktree during a run, while its contents
remain untrusted.*

## Bestätigte Fehler und Korrekturen / Confirmed Defects and Fixes

| Bereich / Area | Betroffene Level-0-Alerts | Korrektur / Fix |
|---|---|---|
| Lernpaket-Extraktion / Learning-package extraction | `#31` | Nur ein vom aktuellen Aufruf selbst erzeugtes Teilziel wird bei einem Fehler entfernt. Vorhandene Ziele bleiben erhalten. / Only a partial destination created by the current invocation is removed after failure. Existing destinations remain intact. |
| Feature-024-Mapping | `#130`–`#135`, `#138` | Kanonische Dateien werden physisch an das Repository gebunden. Der Review-Nachweis wird über eine reguläre temporäre Datei atomar ersetzt. / Canonical files are physically bound to the repository. Review evidence is replaced atomically through a regular temporary file. |
| Secure-Trader-Datensatz / Secure Trader dataset | `#27`, `#28` | Feste Ausgabegruppen dürfen keine Symlinks oder Reparse Points sein. CSV-Dateien werden atomar ersetzt, ohne externe Symlink-Ziele zu verändern. / Fixed output groups must not be symlinks or reparse points. CSV files are replaced atomically without modifying external symlink targets. |

Die zehn betroffenen bisherigen Datenflüsse werden nicht manuell geschlossen.
CodeQL muss ihre Behebung auf dem neuen Head selbst bestätigen. Dateimodi und
reproduzierbare Inhalte bleiben kompatibel: vorhandene reguläre Modi werden
bewahrt, neue Dateien verwenden `0644`, neue Datensatzverzeichnisse `0755`.

*The ten affected previous data flows are not closed manually. CodeQL must
confirm their remediation on the new head. File modes and reproducible content
remain compatible: existing regular modes are preserved, new files use `0644`,
and new dataset directories use `0755`.*

## Neu bewertete übrige Alerts / Reassessed Remaining Alerts

Die übrigen 92 Alerts wurden nach Regel, Pfad, Datenfluss und erreichbarer
Sicherheitsgrenze gruppiert. Sie belegen in diesem Bedrohungsmodell keinen
Produktfehler:

| Gruppe / Group | Anzahl / Count | Einordnung / Classification |
|---|---:|---|
| Maintenance TUI einschließlich Test-Fixtures / including test fixtures | 35 | Ausschließlich Testquellen oder lokal gewählte Pfade ohne zusätzliche Privileggrenze / Test sources only or locally selected paths without an added privilege boundary |
| Stage-B- und Review-Acceptance-Harnesses / acceptance harnesses | 14 | `used in tests` |
| Spec-Kit-Preset-Prüfer / Spec Kit preset validators | 15 | Physisch gebundene Repositorypfade oder ausdrückliche lokale Eingaben / Physically bound repository paths or explicit local inputs |
| Agentic-Workspace-Fleet | 13 | Begrenzte Repository-, Evidence- oder Testpfade ohne Shell-Datenfluss / Bounded repository, evidence, or test paths without a shell data flow |
| Home-Sync | 6 | Feste Wrapperpfade und geprüfte Home-Grenze / Fixed wrapper paths and checked home boundary |
| Linux-Härtung / Linux hardening | 2 | Explizites Berichtsziel und argv-basierte lokale Prozessprobe / Explicit report destination and argv-based local process probe |
| Wartungs-Ausführungskontext / Maintenance execution context | 1 | Fester Registrypfad des Wrappers / Fixed wrapper registry path |
| Storage-Bericht / Storage report | 2 | Explizites privates Berichtsziel mit atomarem Ersatz / Explicit private report destination with atomic replacement |
| Weitere Level-0-Werkzeuge / Other Level 0 tools | 4 | Explizite lokale Eingaben oder Ausgabeziele / Explicit local inputs or output destinations |

Diese Alerts bleiben offen, bis der neue Level-0-Head analysiert ist. Danach
wird eine einzige Liste mit Alert-ID, Regel, Pfad, Revision und Datei-Hash zur
ausdrücklichen Freigabe vorgelegt. Ohne diese Freigabe erfolgt keine
Fehlalarm-Schließung.

*These alerts remain open until the new Level 0 head has been analyzed. One
list containing alert ID, rule, path, revision, and file hash will then be
submitted for explicit approval. No false-positive dismissal occurs without
that approval.*

## Nachweise und nächste Aktion / Evidence and Next Action

- Lernpaket-Sicherheit: 20 fokussierte Tests einschließlich Eigentumsgrenzen.
- Feature-024-Mapping: 12 Tests einschließlich kanonischer Repository-,
  Symlink- und Modusgrenzen.
- Secure-Trader-Datensatz: 4 Sicherheitstests; der Stand `2026-07` ist für alle
  drei Ausgabegruppen byteidentisch zum eingecheckten Snapshot.
- Unabhängige Patch-Reviews bestätigen die drei Korrekturen.
- Praktische Screenreader- oder Braille-Prüfungen wurden für diesen
  textorientierten Wartungsnachweis nicht erneut durchgeführt.

*Learning-package security has 20 focused tests, Feature 024 has 12 tests, and
the dataset generator has four security tests. The regenerated `2026-07`
dataset is byte-identical to all three committed output groups. Independent
patch reviews confirmed the fixes. No new practical screen-reader or Braille
test was performed for this text-oriented maintenance evidence.*

Die nächste sichere Aktion ist ein PR-CodeQL-Lauf auf dem vollständigen
Level-0-Sammelhead. Erst danach werden Schließliste und gemeinsamer
Verbraucher-Rollout vorbereitet.

*The next safe action is a PR CodeQL run on the complete Level 0 batch head.
Only then are the dismissal list and consolidated consumer rollout prepared.*
