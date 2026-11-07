# Deep Security Scan: Nicht-Preset-Korrekturen / Non-preset Remediation

**Stand / Status:** 2026-11-07  
**Owner:** Thorsten Hindermann  
**Documentation Impact:** `UpdateRequired`  
**Distribution:** `homeRuntime`  
**Home-Sync:** nach Review und Commit erforderlich / required after review and commit

## Entscheidung und Umfang / Decision and scope

Die elf hohen, 84 nicht presetbezogenen mittleren und 27 nicht presetbezogenen
niedrigen Befunde des Deep Security Scans für `scripts/` sind korrigiert. Die
drei mittleren und der eine niedrige Preset-Befund bleiben außerhalb dieses
Arbeitspakets und werden separat bewertet. Der ausführbare Spec-Kit-Updater ist
als Skriptcode enthalten.

*All eleven high, 84 non-preset medium, and 27 non-preset low findings from the
`scripts/` Deep Security Scan are remediated. Three medium and one low preset
finding remain outside this work item and are assessed separately. The
executable Spec Kit updater remains in scope as script code.*

## Sicherheitsgrenzen / Security boundaries

- Teardown akzeptiert nur strukturell eindeutige GitHub- und GitLab-Remotes,
  zeigt das vollständige Ziel und verlangt vor Remote-Löschungen dessen exakte
  interaktive Bestätigung. Nicht-interaktive Läufe binden die Löschung mit
  `--expected-remote` beziehungsweise `-ExpectedRemoteTarget` an dasselbe Ziel
  oder verwenden `--keep-remote` beziehungsweise `-KeepRemote`.
- Ein angefordertes Backup ist eine zwingende Vorbedingung für jede nachfolgende
  Löschung. Ein fehlendes oder fehlschlagendes Archiv beendet das Teardown.
- Baseline-Synchronisation, Memory-Patches, Lernreihen-Propagation und der
  Legacy-Gemini-Cleanup lehnen Symlinks und physisch aus dem Zielbereich
  herausführende Pfade ab.
- Template- und Dokument-Renderer behandeln Namen und Manifestwerte als Daten.
  Das Manifest verlangt SemVer-Werte und ein ISO-Datum.
- Homogeneity-Prüfungen führen ausschließlich den vertrauenswürdigen Renderer
  aus Level 0 aus. Generierte GitHub-Prüfworkflows erhalten `contents: read`;
  Schreibrechte bleiben beim explizit berechtigten Release-Workflow.

*Teardown accepts only structurally unambiguous GitHub and GitLab remotes and
binds interactive or automated deletion to the displayed full target. A
requested backup becomes a hard prerequisite. Managed file operations reject
symlink and containment escapes. Renderers treat metadata as data. Homogeneity
checks execute the trusted Level-0 renderer, and generated validation workflows
use read-only repository permissions.*

## Leserpfad und Nachweis / Reader path and evidence

Zielgruppen sind Maintainer und Betreiber der Workspace-Infrastruktur. Die
kanonischen Quellen sind die betroffenen Skripte unter `scripts/`; der fokussierte
Regressionstests liegen unter `scripts/tests/` sowie im Maintenance-TUI-
Testprojekt.
Die Navigation erfolgt über den Deep-Scan-Bericht und dieses Dokument. Es gibt
keinen separaten Sprachpartner; Deutsch und Englisch stehen gemeinsam in dieser
Datei. Die Entscheidung ist bei Änderungen an Teardown, Pfadvalidierung,
Renderer-Ausführung, Workflow-Berechtigungen oder Distributionswegen neu zu
bewerten.

*The audiences are maintainers and workspace operators. The affected scripts
are canonical; focused regression suites live under `scripts/tests/` and in the
Maintenance TUI test project. This document is bilingual and must be
reevaluated when a remediated security boundary or distribution path changes.*

## CI-Nachprüfung / CI follow-up

Die erste PR-Matrix nach der Korrektur zeigte plattformspezifische
Nachlaufprobleme: Windows besitzt kein `os.fchmod`, lokale Skill-Lock-Daten
waren trotz Ignore-Regel noch versioniert, und die vollständige
Regression-Suite setzte `ripgrep` sowie `gitleaks` voraus. Die Windows-Pfade
verwenden nun den DACL-Schutz ohne den nicht verfügbaren POSIX-Aufruf, die
lokale Lock-Datei ist aus Git entfernt, und die Workflows stellen die
benötigten Prüfwerkzeuge versionsgebunden bereit. Generierte Skriptreferenz und
Projektstatistik werden über ihre kanonischen Renderer aktualisiert.

*The first post-remediation PR matrix exposed platform follow-up issues:
Windows has no `os.fchmod`, local skill-lock state was still tracked despite
the ignore policy, and the complete regression suite required `ripgrep` and
`gitleaks`. Windows now applies its DACL boundary without the unavailable
POSIX call, the local lock file is removed from Git, and CI provisions pinned
test tools. The canonical renderers update the script reference and project
statistics.*
