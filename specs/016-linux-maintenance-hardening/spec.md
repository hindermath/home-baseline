# Feature Specification: Linux-/Ubuntu-Härtung der Ein-Kommando-Wartung

**Feature Branch**: `016-linux-maintenance-hardening`
**Created**: 2026-07-28
**Status**: Ready
**Binding Intake**:
`Lastenheft_Linux-Ubuntu-Ein-Kommando-Wartung-Haertung.md` v1.2
**Accepted Reviews**:
`48ca0b20-22e0-47f0-bee0-a19672c48b42` (`Single`, `Ready`) und
`0005ff81-a7a4-4803-ad33-12a25393ae8b` (`Series`, `Ready`)
**Current Delivery Authority**: `MergeAndSync`, ausdrücklich durch den
aktuellen Benutzerauftrag; technische Sicherheits- und Admin-Grenzen bleiben
unverändert.

## User Scenarios & Testing

### User Story 1 - Vollständige Paketverarbeitung (Priority: P1)

Als Maintainer möchte ich, dass jeder ausgewählte Registry-Eintrag genau einmal
und in stabiler Reihenfolge verarbeitet wird, damit interaktive
Paketmanager-Unterprozesse keine späteren Einträge verschlucken.

**Independent Test**: Ein isoliertes Fixture stellt mindestens drei fehlende
Einträge bereit. Der erste simulierte Installationsprozess liest seinen
Standardeingabekanal vollständig. Trotzdem erhalten alle Einträge genau einen
geordneten Endstatus.

**Acceptance Scenarios**:

1. **Given** drei fehlende Pflichtpakete, **When** der erste Installer bis EOF
   liest, **Then** wird jedes Paket genau einmal in Registry-Reihenfolge
   verarbeitet.
2. **Given** ein erfolgreicher erster Lauf, **When** derselbe Lauf wiederholt
   wird, **Then** werden alle Einträge als vorhanden erkannt und keine
   Installation erneut gestartet.
3. **Given** Erfolg, Fehler und verbleibender Drift, **When** der Lauf endet,
   **Then** besitzt jeder ausgewählte Eintrag genau einen nachvollziehbaren
   Endstatus.

### User Story 2 - Wahrheitsgetreuer Required-Abschluss (Priority: P1)

Als Maintainer möchte ich, dass fehlende Pflichtwerkzeuge den Abschlussstatus
und Exitcode zuverlässig bestimmen, damit sichtbare Ausgabe und
Automatisierungsstatus dieselbe Wahrheit wiedergeben.

**Independent Test**: Fixtures prüfen eine leere und eine nicht leere
Required-Menge, ausschließlich optionalen Drift und die Aggregation bis zum
obersten Wartungsbericht.

**Acceptance Scenarios**:

1. **Given** zwei weiterhin fehlende Pflichtwerkzeuge, **When** die
   Abschlussprüfung läuft, **Then** werden beide vollständig ausgegeben und
   der Lauf endet mit dokumentiertem Nicht-Erfolg.
2. **Given** nur ein fehlendes optionales Werkzeug, **When** die
   Abschlussprüfung läuft, **Then** bleibt der Drift sichtbar, aber nicht
   allein fatal.
3. **Given** ein nicht erfolgreicher Toolchain-Abschluss, **When** der
   Orchestrator finalisiert, **Then** stimmen Terminal, Log, Bericht und
   Prozess-Exitcode überein.

### User Story 3 - Sichere Swift-Bereitstellung (Priority: P1)

Als Maintainer möchte ich Swift auf unterstützten Ubuntu-Profilen im
autorisierten Wartungslauf sicher bereitstellen können, damit der
Ein-Kommando-Sollzustand ohne unkontrollierte Nacharbeit erreichbar ist.

**Independent Test**: Lokale Fixtures simulieren unterstützte und nicht
unterstützte Plattformen, korrekte und manipulierte Integritätsnachweise,
Installationsfehler sowie die Verfügbarkeit im selben Prozesskontext.

**Acceptance Scenarios**:

1. **Given** ein unterstütztes Ubuntu-Profil ohne Swift und aktuelle
   Admin-Prompt-Autorität, **When** die Bereitstellung läuft, **Then** werden
   Plattform, Herkunft und Integrität vor Mutation geprüft und Swift ist
   anschließend im selben Lauf nutzbar.
2. **Given** eine unbekannte Plattform oder Architektur, **When** die
   Bereitstellung bewertet wird, **Then** endet sie vor Mutation mit einer
   sichtbaren nächsten Aktion.
3. **Given** ein veränderter Integritätsnachweis oder Installationsfehler,
   **When** der Pfad ausgeführt wird, **Then** findet keine unsichere
   Folgeausführung statt und der Abschluss ist Nicht-Erfolg.

### User Story 4 - Bewahrte Privilegiengrenze und nutzbare CLI (Priority: P1)

Als Maintainer möchte ich Admin-Prompt-Autorität, tatsächliche Privilegien und
erreichten Sollzustand getrennt sehen, damit weder ein Deferred-Zustand noch
ein lediglich auffindbarer, aber defekter Launcher als Erfolg gilt.

**Independent Test**: Ein Fixture ohne Admin-Prompt-Autorität beweist, dass
keine Privilegieneskalation erfolgt. Weitere Fixtures simulieren einen
Capability-gesperrten und einen hängenden Launcher.

**Acceptance Scenarios**:

1. **Given** fehlende Admin-Prompt-Autorität und installierbarer
   Required-Drift, **When** die Toolchain-Stufe startet, **Then** erfolgt kein
   privilegierter Aufruf und der offene Zustand lautet
   `DEFERRED_ADMIN_REQUIRED`.
2. **Given** ein auffindbarer Launcher mit Capability-Fehler, **When** die
   begrenzte Funktionsprobe läuft, **Then** wird er als
   `CapabilityBlocked` oder `Unusable` klassifiziert und keine abhängige
   Mutation gestartet.
3. **Given** ein hängender Launcher, **When** seine Zeitgrenze abläuft,
   **Then** wird er deterministisch als `TimedOut` klassifiziert.

### User Story 5 - Abbruchfester, barrierefreier Abschluss (Priority: P1)

Als Maintainer möchte ich bei Erfolg, spätem Fehler und Signalabbruch genau
einen atomaren Abschluss erhalten, damit Bericht, Log, Terminal und Exitcode
nicht widersprüchlich oder unvollständig bleiben.

**Independent Test**: Fixtures erzwingen nach mindestens zwei erfolgreichen
Stufen einen späten Fehler sowie separat `INT` und `TERM` und prüfen den
finalen strukturierten Bericht.

**Acceptance Scenarios**:

1. **Given** ein früher Teilbericht mit Erfolg, **When** eine spätere Stufe
   scheitert, **Then** wird der Erfolg atomar durch den tatsächlichen
   Nicht-Erfolgsstatus ersetzt.
2. **Given** `INT` oder `TERM`, **When** die Abschlussbehandlung läuft,
   **Then** nennt sie letzte Stufe, Signal, Exitcode und nächste Aktion genau
   einmal.
3. **Given** beliebige Abschlussklassen, **When** ein Mensch oder Screenreader
   die Ausgabe liest, **Then** sind Status ohne Farbe, linear und auf Deutsch
   zuerst unterscheidbar.

### Edge Cases

- Der erste Installationsprozess liest stdin bis EOF und beendet sich dennoch
  erfolgreich.
- Ein Eintrag ist auffindbar, seine Funktionsprobe liefert aber Fehlertext,
  Timeout oder eine Container-Capability-Sperre.
- Admin-Prompt-Autorität fehlt, obwohl ein sicherer automatisierter
  Installationsvertrag vorhanden ist.
- Die Plattform ist unterstützt, aber die Architektur oder Distribution-
  Version nicht.
- Ein Integritätsnachweis ist syntaktisch gültig, passt aber nicht zum
  heruntergeladenen Artefakt.
- Ein optionales Werkzeug fehlt gemeinsam mit einem Pflichtwerkzeug.
- Nach mehreren erfolgreichen Stufen tritt ein ungefangener Fehler oder ein
  Signal während des Berichtsschreibens auf.
- Eine alte Erfolgsdatei liegt bereits vor Beginn des aktuellen Laufs vor.
- Check-, Compare- oder Vorschau-Modus trifft auf denselben Drift wie ein
  schreibender Lauf.

## Requirements

### Functional Requirements

- **FR-001 / LUM-001**: Die geordnete Registry-Verarbeitung MUST von der
  Standardeingabe jedes gestarteten Unterprozesses entkoppelt sein. Ein bis EOF
  lesender Installer darf keine späteren Einträge konsumieren.
- **FR-002 / LUM-002**: Jeder ausgewählte Registry-Eintrag MUST genau einen
  finalen Status erhalten: vorhanden, installiert, vorgesehen,
  fehlgeschlagen oder nach Abschluss weiterhin fehlend. Reihenfolge und
  Required-/Optional-Scope bleiben erhalten.
- **FR-003 / LUM-003**: Eine nicht leere Missing-Menge für `required` MUST
  fehlschlagen und vollständig ausgegeben werden. Eine leere Required-Menge
  gelingt; ausschließlich optionaler Drift bleibt nicht fatal.
- **FR-004 / LUM-004**: Einzelstatus MUST bis zum obersten Wartungsabschluss
  so aggregiert werden, dass weiterhin fehlende Pflichtwerkzeuge einen
  Nicht-Null-Exitcode sowie denselben Nicht-Erfolgsstatus in Terminal, Log und
  strukturiertem Bericht erzeugen.
- **FR-005 / LUM-005**: Swift MUST für die unterstützten Linux-/Ubuntu-Profile
  einen automatisierten, versionierten Installationsvertrag besitzen, der
  Distribution, Version, Architektur, Herkunft und Integrität vor Mutation
  prüft und die Nutzbarkeit im selben Lauf ermöglicht.
- **FR-006 / LUM-006**: Nicht unterstützte Plattformen, unbekannte
  Installationsverträge, Integritätsabweichungen und Bereitstellungsfehler
  MUST vor unsicherer Folgeausführung mit begrenzter Evidence, nächster Aktion
  und Nicht-Null-Exitcode enden.
- **FR-007 / LUM-007**: Nach Bereitstellung MUST der Required-Sollzustand im
  selben Prozesskontext erneut geprüft werden. Ein zweiter Lauf MUST
  idempotent sein und vorhandene Werkzeuge nicht verändern.
- **FR-008 / LUM-008**: Check-, Compare- und Vorschau-Modi MUST ohne
  Paketmutation oder Profiländerung funktionieren, vollständigen Drift
  ausgeben und eine dokumentierte Exitcode-Matrix verwenden.
- **FR-009 / LUM-009**: Administratorgeschützte Toolchain-Mutation MUST
  aktuelle ausdrückliche Admin-Prompt-Autorität voraussetzen. Ohne sie erfolgt
  keine Privilegieneskalation; `DEFERRED_ADMIN_REQUIRED`, Restdrift und nächste
  Aktion bleiben als offener Nicht-Sollzustand sichtbar.
- **FR-010 / LUM-010**: Externe Pflichtwerkzeuge MUST durch begrenzte,
  seiteneffektarme Funktionsproben mindestens als `Missing`, `Unusable`,
  `TimedOut` oder `CapabilityBlocked` unterscheidbar sein. Fehlerausgabe bleibt
  begrenzt und secret-frei.
- **FR-011 / LUM-011**: Normaler Abschluss, ungefangener Stufenfehler sowie
  relevante Signale MUST genau eine atomare Finalisierung auslösen. Bericht,
  Log, Terminal und Prozessstatus nennen tatsächlichen Gesamtstatus, letzte
  Stufe, Exitcode und nächste Aktion konsistent.
- **FR-012**: Die Implementierung MUST ohne reale Netzwerk- oder
  Paketmanagermutation durch isolierte Positiv-, Negativ-, Vorschau-,
  Idempotenz-, Timeout-, Capability-, Fehler- und Signal-Fixtures prüfbar sein.
- **FR-013**: Sicherheits- und Qualitätsgates MUST unabhängig von
  administrativer Freigabe bestehen. Weder `sudo`, Paketmanager-Sperren,
  Container-Capabilities noch Repository-Regeln dürfen technisch umgangen
  werden.
- **FR-014**: Nutzerseitige Ausgaben und Dokumentation MUST text-first,
  DE-first/EN-second, ohne ausschließlich farbliche Statusinformation und frei
  von Secrets oder privaten absoluten Pfaden sein.
- **FR-015**: Root-Position 2, die separate nachfolgende Position-3-Härtung
  und das Hard-Completion-Gate der Wartungs-TUI MUST unverändert bleiben.
- **FR-016**: Bei Änderungen gemeinsamer Registry- oder Berichtsschemas MUST
  die bestehende Bash-/PowerShell-Parität nachgewiesen werden. Eine
  PowerShell-Verhaltensänderung ohne betroffenen gemeinsamen Vertrag ist nicht
  Teil dieses Features.

### Constitution Requirements

- **CR-001**: Das Feature arbeitet ausschließlich in Level 0. Die
  Level-2-Umgebungsregistry ist für diesen Repository-Wartungsscope `N/A`;
  Re-Evaluation erfolgt bei Änderungen eines registrierten Level-2-Projekts.
- **CR-002**: Bash ist für die bestehende Paketmanager- und
  Prozessintegrationsgrenze technisch vorgegeben und keine MSL. Die
  Nicht-MSL-Nutzung bleibt auf diese Shell-Grenze beschränkt; strukturierte
  Verarbeitung und Tests verwenden bevorzugt das bestehende speichersichere
  Python-3-Modell. Sichere Bash-Quoting-, Options- und Temp-Datei-Regeln sind
  bindend.
- **CR-003**: NIST SSDF, CWE Top 25 und CAPEC sind für Eingabe-, Prozess-,
  Pfad-, Privilegien- und Supply-Chain-Grenzen anwendbar. OWASP SAMM ist für
  den Entwicklungsnachweis anwendbar.
- **CR-004**: OWASP ASVS ist ohne Webanwendung `N/A`. SBOM, VEX, AI-SBOM und
  SLSA sind ohne neue Abhängigkeit oder Release-Artefakt `N/A`; Re-Evaluation
  erfolgt bei einer neuen Abhängigkeit, Distribution oder Release-Pipeline.
- **CR-005**: Trust Boundaries bestehen an Registry-Eingaben, stdin,
  Unterprozessen, Paketmanager-/Admin-Grenzen, Download-/Integritätsprüfung,
  temporären Dateien sowie Berichtspfaden. Ein feature-lokales Threat- und
  Risikomodell ist erforderlich; ein allgemeiner ADR ist ohne neue
  Repository-Architektur `N/A`.
- **CR-006**: Zero-Trust-, BSI-C3A/C5-, NIS2-, CRA-, EU-AI-Act- und
  DORA-Bewertungen sind ohne Cloud-, Produkt-, Runtime-KI- oder regulierten
  Dienstescope `N/A`; Re-Evaluation erfolgt bei entsprechender
  Scope-Erweiterung.
- **CR-007**: WCAG 2.2 AA gilt soweit auf Textterminals und Dokumentation
  anwendbar. Status, Entscheidungen, Restdrift und nächste Aktionen bleiben
  linear, textuell und DE-first/EN-second auf CEFR-B2-Niveau.
- **CR-008**: Bestehende öffentliche Bash- und PowerShell-Wartungsoberflächen
  sowie Manpages und PowerShell-Hilfe werden gemeinsam geprüft. Neue
  Skriptvarianten oder Cmdlets sind nicht vorgesehen; falls dies im Plan
  notwendig wird, gelten vollständige Parität, Unix-Manpage,
  zweisprachige Comment-Based Help und `Verb-Noun`.
- **CR-009**: Gemeinsame Agenten-Guidance wird nur bei einer neuen dauerhaften
  Regel gemeinsam in allen gepflegten Agentenflächen geändert. Ohne neue Regel
  ist Agent-Parity mit dokumentierter `N/A`-Entscheidung erfüllt.
- **CR-010**: Documentation Impact ist `UpdateRequired` für betroffene Hilfe,
  Manpage, README, Skriptinventur, Feature-Evidence und Projektstatistik.
  Dauerhafte `docs/security/`, `docs/architecture/` oder
  `docs/accessibility/`-Artefakte ändern sich nur bei einem neuen
  Projektvertrag; ansonsten bleibt Evidence feature-lokal.
- **CR-011**: Autonomous Run ist für den seriellen Einzellauf anwendbar.
  Parallel Autonomous ist `N/A`; Re-Evaluation erfolgt nur bei mehreren
  voneinander unabhängigen, ausdrücklich autorisierten Features.
- **CR-012**: Die aktuelle Nutzerautorität ist `MergeAndSync`. Sie umfasst
  Commit, Push, PR, policy-konformen Admin-Merge und Default-Branch-Sync, aber
  keinen technischen Bypass, keine Secret-Nutzung und kein Folgefeature.

### Key Entities

- **Registry Item Result**: Geordneter Registry-Eintrag mit Scope, Versuch und
  genau einem finalen Status.
- **CLI Probe Result**: Werkzeug-ID, begrenzte Probe, Dauer,
  `Missing`/`Unusable`/`TimedOut`/`CapabilityBlocked`, bereinigte Evidence und
  nächste Aktion.
- **Swift Install Contract**: Unterstützte Plattform, Version, Architektur,
  Artefaktherkunft, Integritätsnachweis, Installationsziel und
  Aktivierungsgrenze.
- **Maintenance Stage Result**: Stufen-ID, Start-/Endstatus, Exitcode,
  Restdrift und nächste Aktion.
- **Run Report**: Atomarer, run-korrelierter Gesamtstatus mit letzter Stufe,
  Exitcode, Signalinformation und Abschlussaktion.

## Success Criteria

- **SC-001 / AC-001**: Drei geordnete fehlende Pflichtformeln werden trotz
  stdin-lesendem ersten Installer jeweils genau einmal und in Reihenfolge
  aufgerufen.
- **SC-002 / AC-002**: Jeder Eintrag besitzt genau einen Endstatus; der zweite
  Lauf erkennt alle zuvor erfolgreichen Einträge als vorhanden und startet
  keine Installation.
- **SC-003 / AC-003**: Zwei fehlende Pflichtwerkzeuge werden vollständig
  ausgegeben und führen zu Nicht-Erfolg; eine leere Required-Menge gelingt.
- **SC-004 / AC-004**: Verbleibender Required-Drift erzeugt im Paketlauf und
  Orchestrator einen dokumentierten Nicht-Null-Exitcode; Terminal, Log und
  Bericht stimmen überein.
- **SC-005 / AC-005**: Ausschließlich optionaler Drift bleibt sichtbar, aber
  nicht allein fatal.
- **SC-006 / AC-006**: Ein unterstütztes Ubuntu-Fixture ohne Swift prüft
  Herkunft und Integrität vor Bereitstellung und besteht die Nutzbarkeitsprobe
  im selben Prozesskontext.
- **SC-007 / AC-007**: Unbekannte Plattform oder Architektur, manipulierte
  Integrität und Installationsfehler enden jeweils vor unsicherer
  Folgeausführung mit sichtbarer nächster Aktion und Nicht-Null-Exitcode.
- **SC-008 / AC-008**: Check-, Compare- und Vorschau-Modi verändern weder
  Pakete noch Profile; Required-Drift und Exitcode-Matrix bleiben vollständig.
- **SC-009 / AC-009**: Das stdin-/Paketmanager-Fixture nutzt ausschließlich
  temporäre Registry-, PATH- und Logpfade, kein Netzwerk und keinen echten
  Paketmanager und ist deterministisch wiederholbar.
- **SC-010 / AC-010**: Gemeinsame macOS-Paketpfade sowie betroffene
  Bash-/PowerShell-Verträge bestehen ihre Paritätsprüfungen.
- **SC-011 / AC-011**: Syntaxprüfung aller geänderten Bash-Dateien,
  fokussierte Regressionstests, Intake-Receipt-Validator und betroffene
  Homogenitätsprüfungen bestehen.
- **SC-012 / AC-012**: Keine Ausgabe oder Evidence enthält Secrets oder private
  absolute Pfade; Status sind ohne Farbe und linear unterscheidbar.
- **SC-013 / AC-013**: Ohne `--allow-admin-prompts` erfolgt kein
  privilegierter Aufruf; Stufe und Bericht enthalten
  `DEFERRED_ADMIN_REQUIRED`, Restdrift und nächste Aktion.
- **SC-014 / AC-014**: Ein auffindbarer Capability-gesperrter Launcher wird
  begrenzt als `CapabilityBlocked` oder `Unusable` klassifiziert; ein hängender
  Launcher als `TimedOut`; in beiden Fällen finalisiert der Bericht.
- **SC-015 / AC-015**: Später Fehler, `INT` und `TERM` ersetzen jeden früheren
  Erfolg atomar. Bericht, Log, Terminal und Prozess-Exitcode nennen konsistent
  die letzte Stufe und hinterlassen keine teilweise JSON-Datei.

## Assumptions

- Feature 009 ist die historische, bereits gemergte Implementierungsbasis.
- Die aktive Serie führt Linux-Härtung als einzigen `Eligible`-Kandidaten auf
  Root-Position 2; die Windows-Härtung ist abgeschlossen.
- Das unterstützte Linux-Profil und vorhandene Paketmanagerverhalten werden aus
  Repository-Verträgen abgeleitet, nicht aus dem zufälligen Zustand dieses
  Rechners.
- Regressionsevidence verwendet Mocks und temporäre Verzeichnisse; reale
  Downloads oder Paketinstallationen sind keine Testvoraussetzung.
- Die aktuelle Benutzerautorität erweitert nur den Delivery-Ausgang auf
  `MergeAndSync`; die im Intake festgelegten Sicherheits-, Admin- und
  Scope-Grenzen bleiben bindend.
- Nach Abschluss wird kein Folgefeature gestartet.
