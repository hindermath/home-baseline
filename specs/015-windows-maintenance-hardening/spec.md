# Feature Specification: Windows-Härtung der Ein-Kommando-Wartung

**Feature Branch**: `015-windows-maintenance-hardening`
**Created**: 2026-07-28
**Status**: In Review
**Binding Intake**: `Lastenheft_Windows-Ein-Kommando-Wartung-Haertung.md` v1.2
**Accepted Review**: `9a538f3b-3a27-400a-88b6-7bf2db43e340` (`Ready`)

## User Scenarios & Testing

### User Story 1 - Deterministische Windows-Vorschau (Priority: P1)

Als Maintainer möchte ich Check-only, WhatIf und echte Wartung mit derselben
geordneten Zielauflösung ausführen, damit die Vorschau vollständig und
verlässlich ist.

**Independent Test**: Ein isoliertes Fixture führt alle drei Modi aus und
vergleicht Ziel-IDs, Reihenfolge und Ausschlussgründe. Check-only und WhatIf
verändern keine Datei.

**Acceptance Scenarios**:

1. **Given** dieselbe Flotte, **When** alle drei Modi inventarisieren, **Then**
   stimmen Ziele, Reihenfolge und Ausschlussgründe überein.
2. **Given** ein WhatIf-Lauf, **When** Home-Sync verschachtelt wird, **Then**
   wird genau ein Preview-Modus und nie zusätzlich Check-only weitergereicht.
3. **Given** ein fachlich partieller Abschluss, **When** das Skript endet,
   **Then** stimmen Bericht, Terminalstatus und Prozess-Exitcode überein.

### User Story 2 - Sicher fortsetzbare Reparatur (Priority: P1)

Als Maintainer möchte ich nach einer vom Orchestrator erzeugten Reparatur
fortsetzen können, ohne unbekannte lokale Änderungen zu akzeptieren.

**Independent Test**: Ein Fixture schreibt atomare Resume-Evidence, unterbricht
nach der Reparatur und beweist, dass nur vollständig passende Hashes akzeptiert
werden; fremde oder nachträglich geänderte Dateien blockieren.

**Acceptance Scenarios**:

1. **Given** exakt passende Resume-Evidence, **When** der Lauf fortgesetzt
   wird, **Then** wird die belegte Phase sicher wiederaufgenommen.
2. **Given** unbekannte oder nur teilweise passende Dirty-Dateien, **When**
   Resume geprüft wird, **Then** stoppt der Lauf fail-closed.
3. **Given** reine CRLF-/LF-Rohabweichungen ohne Git-Diff, **When** Drift
   klassifiziert wird, **Then** zählen sie nicht als aktionsfähiger Drift.

### User Story 3 - Begrenzte externe Prozesse (Priority: P1)

Als Maintainer möchte ich, dass Python-, GitHub-, WinGet- und UAC-bezogene
Unterprozesse begrenzt und klassifiziert werden, damit kein Wartungslauf
unbegrenzt hängt.

**Independent Test**: Mocks bilden defekte Python-Launcher, zwei transiente
Git-Timeouts, einen hängenden WinGet-Prozessbaum und einen Admin-Installer ab.

**Acceptance Scenarios**:

1. **Given** ein defekter `python3`-Alias und ein gültiger alternativer
   Launcher, **When** der Lauf startet, **Then** wird der gültige Python-3-
   Launcher ohne privaten Installationspfad protokolliert.
2. **Given** zwei transiente Fetch-Timeouts, **When** ein dritter Versuch
   gelingt, **Then** wird das Ziel erfolgreich und mit drei Versuchen gemeldet.
3. **Given** ein hängender WinGet-Prozess, **When** die Grenze abläuft,
   **Then** wird der Prozessbaum beendet und `DEFERRED_ADMIN_REQUIRED` oder ein
   stabiler Timeout-Fehler zurückgegeben.

### User Story 4 - Widerspruchsfreie Toolchain-Evidence (Priority: P2)

Als Maintainer möchte ich frühe Toolchain-Gates und genau einen finalen Status
je Paket, damit der Abschlussbericht keine widersprüchlichen Befunde enthält.

**Independent Test**: Fixtures prüfen PSScriptAnalyzer 1.25.0 vor Mutation,
kanonische Paket-IDs, Windows-Pfade und Bash-/PowerShell-JSON-Parität.

**Acceptance Scenarios**:

1. **Given** PSScriptAnalyzer 1.25.0 fehlt, **When** ein schreibender Lauf
   startet, **Then** wird vor der ersten Mutation mit exakter nächster Aktion
   beendet oder fortsetzbar deferred.
2. **Given** ein installiertes Paket, **When** Erkennung und Zusammenfassung
   laufen, **Then** erscheint genau ein finaler, nicht widersprüchlicher Status.
3. **Given** Windows-Pfade mit Laufwerksbuchstaben und Backslashes, **When**
   die Test-Harnesses laufen, **Then** bleiben die Pfade byte- und
   bedeutungstreu.

### Edge Cases

- Alle Python-Kommandonamen existieren, aber nur einer startet Python 3.
- Ein Git-Fehler ist Auth-, Dirty-, Ahead- oder Diverged-Fehler und damit nicht
  retryfähig.
- Ein WinGet-Elternprozess endet, während ein Installer-Kindprozess weiterläuft.
- Ein früherer Report liegt im Zielverzeichnis, gehört aber zu einer anderen
  Run-ID.
- Resume-Evidence ist syntaktisch gültig, aber ein Nachher-Hash stimmt nicht.
- Paket-IDs unterscheiden sich nur durch Groß-/Kleinschreibung oder Alias.
- PSScriptAnalyzer ist installiert, aber nicht in der geforderten Version.

## Requirements

### Functional Requirements

- **FR-001 / WEM-001**: Das System MUST `python3`, `python` und `py -3`
  nacheinander durch begrenzte Versionsaufrufe validieren und nur Python 3
  akzeptieren.
- **FR-002 / WEM-002**: Fehlendes Python MUST vor Python-abhängigem Home-Sync
  als früher, fortsetzbarer Gate-Status mit vollständigem Report erscheinen;
  WhatIf darf nichts installieren.
- **FR-003 / WEM-003**: Repository-Ermittlung MUST read-only und unabhängig von
  `ShouldProcess` sein und in allen Modi dieselbe geordnete Zielmenge liefern.
- **FR-004 / WEM-004**: Jede mutierende Phase MUST atomare lokale
  Resume-Evidence mit Run-ID, Phase, relativen Pfaden, Vorher-/Nachher-Hashes
  und Ergebnis verwalten; nur exakt passende Zwischenstände dürfen fortsetzen.
- **FR-005 / WEM-005**: Registry und Reparatur MUST das explizite Profil
  `intake-sequencing-eleven-governance-presets` mit Quelle und erwarteter
  Anzahl 11 bewahren; unbekannte Profile scheitern fail-closed.
- **FR-006 / WEM-006**: Drift MUST Git-normalisiert klassifiziert werden und
  Rohabweichungen getrennt von aktionsfähigem Drift zählen.
- **FR-007 / WEM-007**: Transiente GitHub-/Fetch-/Pull-Fehler MUST begrenzte
  Retries mit begrenztem Backoff und Jitter erhalten; nicht-transiente Fehler
  dürfen nicht wiederholt werden.
- **FR-008 / WEM-008**: Jeder WinGet-Unterprozess MUST eine harte
  Laufzeitgrenze haben; Timeout/Abbruch beendet und wartet den Prozessbaum ab.
  Nicht unbeaufsichtigt abschließbare Admin-Installer werden
  `DEFERRED_ADMIN_REQUIRED`.
- **FR-009 / WEM-009**: Paket-Erkennung, Entscheidung und Zusammenfassung MUST
  dieselbe kanonische ID und Statuspriorität verwenden und genau einen finalen
  Status je ID liefern.
- **FR-010 / WEM-010**: Verschachtelte Skriptparameter MUST aus genau einem
  kanonischen Modus abgeleitet werden; Check-only und WhatIf dürfen nie
  gemeinsam weitergereicht werden.
- **FR-011 / WEM-011**: JSON-Status, sichtbarer Abschluss und Top-Level-
  Exitcode MUST dieselbe Run-ID und Erfolgsklassifikation verwenden.
- **FR-012 / WEM-012**: Windows-Harnesses MUST Laufwerksbuchstaben,
  Backslashes, verwaltete Dirty-Dateien und semantische JSON-Parität korrekt
  behandeln.
- **FR-013 / WEM-013**: Erforderliche CLI- und PSScriptAnalyzer-
  Voraussetzungen MUST vor der ersten Mutation geprüft und vollständig
  berichtet werden.
- **FR-014**: Sicherheits-, Test- und Review-Gates MUST unabhängig von
  administrativer Freigabe bestehen; UAC wird nicht technisch umgangen.
- **FR-015**: Das Feature MUST keine Zielrepository-Commits/-Pushes, keinen
  Force-Push, Hard Reset oder automatisches Verwerfen fremder Änderungen
  ausführen.
- **FR-016**: Logs und Reports MUST text-first, DE-first/EN-second und frei von
  Secrets sowie privaten absoluten Interpreterpfaden sein.

### Constitution Requirements

- **CR-001**: Dieses Feature implementiert Level 0; kein Level-2-
  Registry-Eintrag ist Entwicklungsumgebung.
- **CR-002**: PowerShell-7-CLI, Hilfe, Manpage und JSON-Evidence werden
  text-first und nach anwendbaren WCAG-2.2-AA-Grundsätzen geprüft.
- **CR-003**: Nutzertexte sind DE-first/EN-second bei CEFR B2.
- **CR-004**: `docs/project-statistics.md` wird aktualisiert. Die gemeinsamen
  Agentenoberflächen bleiben unverändert, sofern keine neue dauerhafte Regel
  entsteht.
- **CR-005**: Primärsprache ist PowerShell 7/.NET und damit MSL. Python 3
  Standardbibliothek bleibt der bestehende providerneutrale Vertragskern.
- **CR-006**: NIST SSDF, CWE Top 25, CAPEC für Prozess-/Pfad-/Argument- und
  Supply-Chain-Grenzen sowie OWASP SAMM sind anwendbar.
- **CR-007**: ASVS, SBOM, VEX, SLSA, AI-SBOM, Zero Trust, BSI C3A/C5 sowie
  NIS2/CRA/EU AI Act/DORA sind ohne Web-, neue Abhängigkeits-, Release-,
  Runtime-KI-, Cloud- oder regulierten Produktscope `N/A`.
- **CR-008**: Feature-lokale Plan-, Checklisten-, Gate- und PR-Evidence ist
  der begründete Governance-Ort; dauerhafte `docs/security/`-Dateien ändern
  sich nur bei einem neuen Projektvertrag.
- **CR-009**: Das aktuelle Elf-Preset-Profil ist bindend. Autonomous Run ist
  anwendbar; Parallel Autonomous ist für diesen seriellen Einzellauf `N/A`.
- **CR-010**: Documentation Impact ist `UpdateRequired` für PowerShell-Hilfe,
  Wartungs-Manpage, Feature-Artefakte und Statistik.

### Key Entities

- **Maintenance Mode**: Genau einer aus `CheckOnly`, `Preview` oder `Update`.
- **Resume Evidence**: Atomarer lokaler Laufnachweis mit Run-ID, Phase,
  relativen Pfaden, Hashpaaren, Status und nächster Aktion.
- **Process Result**: Unterprozess, Dauergrenze, Exitcode, Klassifikation,
  Versuchszahl und bereinigter Abschlusszustand.
- **Package Result**: Kanonische Paket-ID mit genau einem finalen Status und
  zugehöriger Evidence.
- **Run Report**: Run-ID-korrelierter Gesamtstatus, Exitcode, Stufen,
  Zielentscheidungen und nächste Aktionen.

## Success Criteria

- **SC-001 / AC-001**: Defektes `python3` plus gültige Alternative wählt die
  Alternative und meldet Python 3 ohne privaten Pfad.
- **SC-002 / AC-002**: Ohne Python endet der Lauf vor Python-abhängiger
  Mutation mit Report und exakter nächster Aktion.
- **SC-003 / AC-003**: Alle Modi liefern identische Ziel-IDs, Reihenfolge und
  Ausschlussgründe.
- **SC-004 / AC-004**: Exakte Resume-Evidence setzt fort; jede Hashabweichung
  blockiert.
- **SC-005 / AC-005**: Registry-Neuanlage und -Reparatur bewahren das
  Elf-Preset-Profil und melden Quelle sowie Anzahl 11.
- **SC-006 / AC-006**: 90 reine Zeilenendenabweichungen plus drei echte
  Änderungen ergeben 90 Rohabweichungen und genau drei aktionsfähige Drifts.
- **SC-007 / AC-007**: Zwei transiente Timeouts und anschließender Erfolg
  ergeben Erfolg mit drei protokollierten Versuchen; Authfehler hat einen.
- **SC-008 / AC-008**: Ein hängender WinGet-Mock endet innerhalb der Grenze
  plus Bereinigungsfrist ohne verwaisten Kindprozess.
- **SC-009 / AC-009**: Jede kanonische Paket-ID besitzt genau einen finalen
  Status; `OK` und `missing` schließen sich aus.
- **SC-010 / AC-010**: PowerShell-Tests, PSScriptAnalyzer und geänderte
  Verträge bestehen.
- **SC-011 / AC-011**: Ein zweiter Lauf ist idempotent und erzeugt keine neue
  Resume-Evidence oder Drift.
- **SC-012 / AC-012**: Erfolg, Drift, Teilfehler, Fatalfehler und Deferred
  erzeugen jeweils korrelierte Logs und JSON-Berichte.
- **SC-013 / AC-013**: Jeder verschachtelte Aufruf erhält genau einen Modus.
- **SC-014 / AC-014**: Report und Prozess liefern für alle Abschlussklassen
  denselben kanonischen Exitcode.
- **SC-015 / AC-015**: Windows-Pfade, verwaltete `AGENTS.md`-Fixtures und
  Bash-/PowerShell-JSON-Projektionen bleiben korrekt.
- **SC-016 / AC-016**: Fehlendes PSScriptAnalyzer 1.25.0 wird vor der ersten
  Mutation mit exakter nächster Aktion gemeldet.

## Assumptions

- Feature 009 ist die historische, bereits gemergte Implementierungsbasis.
- `origin` bleibt der kanonische Level-0-Remote.
- Laufzeitevidence bleibt unter `~/.home-baseline/` und wird nicht getrackt.
- Die Flottenzusammensetzung bleibt unverändert; nur das Sollprofil wird
  korrekt gebunden.
- Kein Folgefeature wird durch diesen Lauf gestartet.
