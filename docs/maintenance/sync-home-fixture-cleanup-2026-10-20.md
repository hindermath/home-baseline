# Home-Sync-Fixture: Merge-CI-Korrektur / Merge CI correction

Owner: Thorsten Hindermann. Datum / Date: 2026-10-20. Scope: Level 0/Home Runtime.

## Befund und Ursache / Finding and cause

Nach GSDB PR #337 scheiterte am Mergecommit
`44998ed527787491fcee4efc961bdf4a028573a2` der
[Ubuntu-Homogeneity-Lauf](https://github.com/hindermath/home-baseline/actions/runs/39466478600).
Von 335 Tests meldete einer einen Fehler beim Verlassen von
`TemporaryDirectory`: `.git` war beim Löschen nicht leer. Der macOS-Job wurde
wegen Matrix-Fail-fast abgebrochen. Das ist kein bestandener Plattformnachweis.
Die No-op-Assertions selbst waren nicht die Fehlerstelle.

Lokale Nachprüfung mit Git 2.54.0: die unveränderten fünf CLI-Tests und ein
zusätzlicher Lauf mit niedriger GC-Schwelle bestanden. Der intermittierende
Cleanup-Fehler wurde dabei nicht erneut reproduziert. Trace2 zeigt aber
`git maintenance run --auto --no-quiet --detach` sowie tatsächliches Repacking.
Diese Hintergrundschreiber können mit dem Löschen der Fixture konkurrieren;
der ursprüngliche CI-Trace benennt den konkreten Hintergrundprozess nicht.

EN: The original error occurred during fixture teardown, not in the no-op
assertions. Local unchanged runs passed, while Trace2 confirmed detached
maintenance and actual repacking. This identifies the concurrent-writer path;
the original CI log does not identify its individual background process.

## Korrektur und Regression / Correction and regression

Nur die temporäre Git-Konfiguration des echten Commit-/No-op-Tests erhält
`gc.auto=1`, `gc.autoDetach=false` und `maintenance.autoDetach=false`.
Git-Wartung bleibt aktiv, läuft aber synchron. Beide Detach-Schlüssel decken
ältere und neuere Git-Versionen ab. Die niedrige GC-Schwelle erzwingt den
Wartungspfad; ein erzeugtes Packfile ist verpflichtend. Zusätzlich muss HEAD
beim zweiten Sync identisch bleiben. Erfolgreicher No-op, sauberer Arbeitsbaum,
Runtime-only-, Konflikt-, Preview- und Shell-Paritätsassertionen bleiben erhalten.
Kein Sleep/Retry, kein unterdrückter Cleanup-Fehler und kein ignorierter Test.

[Git-Konfigurationsvertrag](https://git-scm.com/docs/git-config):
`maintenance.autoDetach` steuert Vorder-/Hintergrund; `gc.autoDetach` ist der
Fallback. `gc.auto=1` senkt die Schwelle für automatisches Packen, statt die
Wartung auszuschalten. Keine Benutzer-/Produktions-Git-Einstellung wird geändert.

EN: Keep real maintenance enabled but synchronous inside the disposable Home.
Require actual packing and unchanged HEAD on the second sync. Preserve all
existing checks and fail normally on teardown errors. Production sync scripts,
user Git configuration, GSDB sources and all fourteen preset packages are unchanged.

## Prüfung und Lieferung / Validation and delivery

Die fokussierte Suite, vollständige Wartungsregressionen und native
Homogeneity-CI müssen am aktuellen Head erfolgreich sein. Weitere bestehende
CI-Gates bleiben verpflichtend. Exakte Ergebnisse, PR-/Merge-/Sync-IDs und der
Post-Merge-Abschluss werden im Liefer-PR ergänzt; historische rote Läufe bleiben
sichtbar. Keine selbstreferenzielle Folgecommit-Schleife für diese IDs.

EN: Require the focused suite, complete maintenance regressions and native
homogeneity checks on the current head, plus all existing CI gates. Record
actual results and exact delivery/post-merge proof in the PR; retain failed history.

Lokaler fokussierter Lauf: 5/5 erfolgreich, einschließlich Bash-CLI und
PowerShell-Runtime-Parität. Trace2 zeigt nach der Korrektur `--no-detach` und
tatsächliches Repacking; Packfile- und unveränderte-HEAD-Assertions bestehen.
Documentation Impact: beide Entscheidungen erfolgreich validiert.

EN: The focused five-test suite passed. Trace2 confirmed foreground maintenance
and real repacking; packing and unchanged-HEAD assertions passed. Both
Documentation Impact decisions validated successfully.

## Documentation Impact und Distribution

UpdateRequired: Testfixture und dieser Bericht, kanonische Quelle
`scripts/tests/test_sync_home_cli.py`; Maintainer/Reviewer, Leserpfad
CI-Befund → Bericht → Test → aktueller PR-Nachweis. Dokumentklasse Review-Evidence,
DE zuerst/EN danach, beschreibende Links und textliche Ergebnisse.
GeneratedUpdate: getrennte Statistikfortschreibung aus unveränderter
Git-/Konfigurationsmethodik mit `render-project-statistics.*`.
Strukturierter Nachweis: [Documentation Impact](sync-home-fixture-cleanup-2026-10-20-impact.json).

Der Bericht ist sourceOnly. Das geänderte Testskript liegt unter dem bestehenden
homeRuntime-Präfix `scripts/` und wird nach autorisiertem Merge mit Syntaxcheck,
Check-only, Vorschau und Konfliktprüfung aus stabilem Level 0 verteilt.
Re-Evaluation bei Git-Lebenszyklus-, Fixture-, Sync- oder Distributionsänderungen.
Keine Pilot-Repositories, Images, Preset-Releases, Schedules oder Mails betroffen.

EN: Source-only review record and one manifest-selected Home runtime test file.
Sync only after successful exact-head delivery and stable-source preview.
No TinyCalc, Show-CommandTui400 or absdd-image-sandbox rollout or changes.
