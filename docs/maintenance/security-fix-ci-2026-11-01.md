# Security-Fix-CI / Security fix CI

## PR 350

DE: Die macOS-CI zeigte ungueltiges UTF-8: Bash 3.2 schnitt die deutsche
Beschreibung im C-Locale mitten in einem Zeichen ab. Die Zusammenfassung gibt
jetzt die vollstaendige Beschreibung aus; der Regressionstest dekodiert streng
als UTF-8 und verwendet ausdruecklich das C-Locale.

EN: macOS CI exposed invalid UTF-8 when Bash 3.2 sliced the German description
inside a character in the C locale. The summary now prints the complete
description; the regression test uses strict UTF-8 decoding and the C locale.

DE: Die Windows-Fixtures setzten ausfuehrbare POSIX-Shebang-Dateien und einen
beliebigen `python3`-Alias voraus. Ein PowerShell-Command-Stub prueft dieselben
Argumentgrenzen plattformuebergreifend. Der zusaetzliche native POSIX-Prozesstest
bleibt auf macOS/Linux aktiv. Die Hook-Fixture verwendet den laufenden
Python-Interpreter und erhaelt Windows-Executable-Endungen. Ein echter
Windows-WSL-Lauf bleibt ein eigener Nachweis.

EN: Windows fixtures assumed executable POSIX shebang files and an arbitrary
`python3` alias. A PowerShell command stub checks the same argument boundaries
on every platform. The additional native POSIX process test remains active on
macOS/Linux. The hook fixture uses the running Python interpreter and preserves
Windows executable suffixes. A real Windows WSL run remains separate evidence.

## PR 349

DE: Die CI erkannte zu Recht eine Payload-Abweichung: Der gepruefte Fix aus
`9cc31012` aenderte drei Dateien des installierten Parallel-Run-Presets, ohne
dessen separate Integritaetsbindung fortzuschreiben. Nach Abgleich der drei
Dateien mit diesem Commit und erneuter Koordinator-/Paritaetspruefung wird
nur die Payload-Bindung dieses Presets aktualisiert. Version, Manifest-Hash,
Registry-Hash, Release-Quellen und die 13 anderen Payload-Bindungen bleiben
unveraendert. Der neue Baseline-Commit benennt den gesicherten Security-Fix;
der vorherige Installationsstand war `bd84dd7e807ff05887f54f6fccfadcf8d31fe7f6`.

EN: CI correctly detected payload drift: the reviewed fix at `9cc31012`
changed three installed parallel-run preset files without updating its
separate integrity binding. After comparing all three files with that commit
and rerunning coordinator/parity checks, only this preset's payload binding
is updated. Version, manifest hash, registry hash, release sources and the
other 13 payload bindings remain unchanged. The new baseline identifies the
saved security fix; the prior installation baseline was
`bd84dd7e807ff05887f54f6fccfadcf8d31fe7f6`.

DE: Dokumentationsauswirkung: `UpdateRequired` fuer die gepruefte
Installed-Lock-Evidence (`docs/maintenance/preset-installed-lock.json`) und
diesen Wartungsnachweis. Quelle: die drei Preset-Dateien aus Commit
`9cc31012`; Owner: Thorsten Hindermann / Preset Maintainer. Leserpfad:
PR 349 → Payload-Pruefung → Installationsbindung. Dokumentklasse: Security
Evidence; DE/EN gemeinsam, `sourceOnly`, Navigation unveraendert. Kein
Preset-Release oder Flottenrollout. Erneute Pruefung bei jeder Payload- oder
Manifestaenderung; Koordinatorlauf auf macOS und PR-CI auf allen drei Hosts.

EN: Documentation impact: `UpdateRequired` for the verified installed-lock
evidence and this record. Source: the three preset files at `9cc31012`;
owner: Thorsten Hindermann / Preset Maintainer. Reader path: PR 349 → payload
check → installation binding. Class: Security Evidence; German/English
together, `sourceOnly`, navigation unchanged. No preset release or fleet
rollout. Reevaluate on any payload/manifest change; coordinator run on macOS
and PR CI on all three hosts.

## Dokumentationsauswirkung PR 350 / PR 350 documentation impact

- `NoUpdateRequired` fuer Beschreibungsausgabe und Test-Fixtures: Parameter,
  Sicherheitsregeln und dokumentierte Aufrufe bleiben unveraendert. Geprueft:
  Bootstrap-Hilfe, Wrapper-Hilfe und `docs/man/scan-agent-secrets.1.md`.
  / For summary output and fixtures: parameters, security rules and documented
  invocations remain unchanged; bootstrap/wrapper help and the scanner manpage
  were reviewed.
- `GeneratedUpdate` fuer `docs/scripts/reference.md`: kanonische Quelle sind
  Git-getrackte Skripte und `scripts/config/script-catalog.json`; Renderer:
  `bash scripts/render-script-reference.sh`.
  / The script reference is regenerated from tracked scripts and the catalog.
- `GeneratedUpdate` fuer den Profil-2-Block in `docs/project-statistics.md`:
  Quellen sind Git-Historie, getrackte Texte und
  `docs/project-statistics.config.json`; Renderer:
  `bash scripts/render-project-statistics.sh`.
  / Profile 2 is regenerated from Git history, tracked text and its config.

DE: Owner: Thorsten Hindermann / Script Maintainer. Zielgruppe und Leserpfad:
Maintainer, PR-CI → Fehlerursache → Regression → Merge. Dokumentklasse:
Wartungsnachweis; DE/EN gemeinsam, Navigation unveraendert. Plattformnachweis:
fokussierte und vollstaendige lokale macOS-Regressionen sowie die PR-CI-Matrix.
Die geaenderte Bootstrap-Ausgabe und Tests sind `homeRuntime`; Referenz,
Statistik und dieser Nachweis sind `sourceOnly`. Home-Sync nach Lieferung.
Re-Evaluation bei Aenderung der Argumentuebergabe, Python-/Shell-Runtime,
Skriptinventur oder Statistikmethodik. Dieser CI-Nachtrag ist kein neuer
Security-Diff-Scan.

EN: Owner: Thorsten Hindermann / Script Maintainer. Audience and reader path:
maintainers, PR CI → cause → regression → merge. Document class: maintenance
evidence; German/English together, navigation unchanged. Platform evidence:
focused and full local macOS regressions and the PR CI matrix. The changed
bootstrap output and tests are `homeRuntime`; reference, statistics and this
record are `sourceOnly`. Sync Home after delivery. Reevaluate on argument,
Python/shell runtime, inventory or statistics methodology changes. This CI
follow-up is not a new Security Diff Scan.
