# Feature Specification: Wartungs-TUI- und Wrapper-Regressionshärtung

**Feature Branch**: `019-agentic-workspace-regression-hardening`  
**Created**: 2026-08-01  
**Status**: Ready for Planning  
**Binding Intake**: `Lastenheft_Agentic-Workspace-Wartungs-TUI-und-Wrapper-Regressionshaertung.md`  
**Delivery Authority**: `MergeAndSync`

## User Scenarios & Testing

### User Story 1 - Vollständiger Live-Status (Priority: P1)

Als wartende Person möchte ich während einer normalen Prüfung einen
vollständigen und lückenlosen textorientierten Status sehen, damit ich den
Fortschritt und den Abschluss ohne Vermutungen nachvollziehen kann.

**Why this priority**: Der normale Ereigniskanal ist die primäre
Beobachtungsoberfläche der Wartungs-TUI. Falsche Sequenzlücken untergraben den
gesamten Statusnachweis.

**Independent Test**: Ein isolierter Check-only-Lauf erzeugt genau einen
Laufstart, fortlaufende Sequenznummern ab 1, die erwarteten Phasen und genau
einen passenden Abschluss, ohne Degradierungsbefund.

**Acceptance Scenarios**:

1. **Given** ein normal verfügbarer Ereigniskanal, **When** ein Check-only-Lauf
   vollständig endet, **Then** ist jede Zeile genau ein gültiges Ereignisobjekt
   und die Sequenz ist lückenlos.
2. **Given** ein normal abgeschlossener Lauf, **When** die Oberfläche den
   Abschluss verarbeitet, **Then** erscheinen weder `SequenceGap` noch ein
   falsches `EVENT_STREAM_DEGRADED`.
3. **Given** ein wirklich beschädigtes Ereignis, **When** es gelesen wird,
   **Then** wechselt nur die Darstellung nachvollziehbar in den linearen
   Fallback und die Wartungs-Engine läuft unbeeinflusst weiter.

---

### User Story 2 - Wahrheitsgemäßer Abschluss (Priority: P1)

Als prüfende Person möchte ich, dass Bericht, Prozess-Exitcode und vorhandenes
Abschlussereignis getrennt bewertet werden, damit eine reine
Darstellungsstörung nicht als Ergebniswiderspruch ausgegeben wird.

**Why this priority**: Der finalisierte Bericht und der Engine-Exitcode sind
kanonische Evidence. Eine UI darf diese Wahrheit weder überschreiben noch
erfinden.

**Independent Test**: Positive, degradierte und widersprüchliche Fixtures
beweisen getrennt Erfolg, Event-Degradierung und echten `RESULT_MISMATCH`.

**Acceptance Scenarios**:

1. **Given** ein erfolgreicher finalisierter Bericht und Exitcode 0, **When**
   das Abschlussereignis fehlt, **Then** bleibt das Engine-Ergebnis sichtbar
   und es entsteht kein `RESULT_MISMATCH` allein wegen des Ereigniskanals.
2. **Given** widersprechende kanonische Werte, **When** sie abgeglichen werden,
   **Then** erscheint `RESULT_MISMATCH` mit konkreter nächster Aktion.
3. **Given** kein vertrauenswürdiger finalisierter Bericht, **When** der Lauf
   endet, **Then** bleibt die fehlende Evidence sichtbar und Erfolg wird nicht
   angenommen.

---

### User Story 3 - Sichere argumentlose Home-Runtime-Delegation (Priority: P1)

Als macOS-Nutzer*in möchte ich die lokale Wartung ohne Argumente starten
können, damit die Home Runtime sicher an die versionierte Level-0-Quelle
delegiert, ohne unter System-Bash 3.2 abzubrechen.

**Why this priority**: Der argumentlose Aufruf ist der normale interaktive
Einstieg und muss auf der dokumentierten Mindestplattform funktionieren.

**Independent Test**: Eine isolierte Home-Runtime-Kopie delegiert mit null,
einem und mehreren Argumenten unter `/bin/bash`, erhält alle Argumentgrenzen
und startet genau einen Engine-Prozess.

**Acceptance Scenarios**:

1. **Given** macOS-System-Bash 3.2 und keine Argumente, **When** die Home Runtime
   delegiert, **Then** tritt kein Fehler wegen eines leeren Arrays auf.
2. **Given** Argumente mit Leerzeichen oder Shell-Metazeichen, **When** sie
   delegiert werden, **Then** bleiben sie getrennte unveränderte Werte und
   werden nicht erneut ausgewertet.
3. **Given** die Delegation, **When** der Prozessbaum geprüft wird, **Then**
   existiert genau ein kanonischer Engine-Prozess.

---

### User Story 4 - Plattformgleiche und zugängliche Evidence (Priority: P1)

Als lernende oder wartende Person möchte ich auf macOS, Linux und Windows
dieselben fachlichen Status- und Ergebnisgrenzen in verständlichem Text sehen,
damit Plattform und Darstellungsmodus die Bedeutung nicht verändern.

**Independent Test**: Plattformbezogene Regressionen sowie Plain-, TUI- und
textorientierte Fallback-Tests liefern dieselben semantischen Statusklassen und
verständliche nächste Aktionen.

**Acceptance Scenarios**:

1. **Given** TUI, Plain oder `TERM=dumb`, **When** ein Lauf abgeschlossen oder
   degradiert wird, **Then** sind Status, Grund und nächste Aktion ohne Farbe
   oder Layoutinterpretation verständlich.
2. **Given** korrektes bestehendes PowerShell-Verhalten, **When** die Änderung
   validiert wird, **Then** bleibt es funktional unverändert und wird nicht nur
   für mechanische Gleichheit umgebaut.
3. **Given** geänderte Bedienungs- oder Wartungsverträge, **When** das Feature
   abgeschlossen wird, **Then** sind die betroffenen deutschen und englischen
   Dokumentationsflächen synchron.

### Edge Cases

- Das Ereignisverzeichnis ist nicht verfügbar oder ein Ereignis kann nicht
  atomar geschrieben werden.
- Ein Ereignis ist gültiges JSON, aber `details` ist kein Objekt.
- Der Ereignisstrom endet mitten in einer Zeile oder enthält ein unbekanntes
  Schema.
- Das Abschlussereignis fehlt, ist doppelt oder gehört zu einer fremden Run-ID.
- Der Bericht existiert, ist aber nicht finalisiert, unlesbar oder gehört zu
  einer anderen Run-ID.
- Prozess-Exitcode, Bericht und Abschlussereignis widersprechen sich einzeln
  oder mehrfach.
- Null, ein oder mehrere Argumente enthalten Leerzeichen, leere Werte,
  Wildcards, Anführungszeichen oder Shell-Metazeichen.
- Ein Abbruch durch `Ctrl+C` darf weder ein zweites Abschlussereignis noch
  einen erfundenen Erfolgsbericht erzeugen.

## Requirements

### Functional Requirements

- **FR-001**: Jedes geschriebene Ereignis MUSS genau ein gültiges
  UTF-8-JSON-Objekt sein; `details` MUSS ein Objekt bleiben.
- **FR-002**: Die Sequenz MUSS bei 1 beginnen und für jedes erfolgreich
  geschriebene Ereignis exakt um 1 steigen.
- **FR-003**: Ein normaler Lauf MUSS genau ein passendes `run-started` und genau
  ein passendes `run-completed` enthalten.
- **FR-004**: Das Abschlussereignis MUSS Run-ID, Berichtspfad, Logpfad,
  Gesamtstatus und Engine-Exitcode wahrheitsgemäß wiedergeben.
- **FR-005**: Ein normaler vollständiger Lauf DARF keinen falschen
  Degradierungsbefund erzeugen.
- **FR-006**: Eine echte Ereignisstörung MUSS sichtbar degradieren, DARF aber
  weder Engine noch Exitcode verändern.
- **FR-007**: Der finalisierte Bericht MUSS über den laufgebundenen
  Berichtspfadvertrag auch ohne nutzbares Abschlussereignis auffindbar sein.
- **FR-008**: Ein erfolgreicher Bericht und Exitcode 0 DÜRFEN nicht allein
  wegen einer Ereignisstörung als `RESULT_MISMATCH` erscheinen.
- **FR-009**: `RESULT_MISMATCH` DARF nur bei einem nachgewiesenen Widerspruch
  vorhandener kanonischer Werte erscheinen.
- **FR-010**: Fehlende oder nicht finalisierte Evidence MUSS sichtbar bleiben;
  das System DARF daraus keinen Erfolg ableiten.
- **FR-011**: Abschlussstatus und nächste Aktion MÜSSEN Engine-Ergebnis,
  Ereignis-Degradierung und echten Widerspruch unterscheiden.
- **FR-012**: Der argumentlose Home-Runtime-Aufruf MUSS unter macOS-System-Bash
  3.2 und `set -euo pipefail` funktionieren.
- **FR-013**: Null, ein und mehrere Argumente MÜSSEN ohne erneute
  Shellauswertung und mit unveränderten Grenzen delegiert werden.
- **FR-014**: Die Delegation MUSS genau einen kanonischen Engine-Prozess
  verwenden.
- **FR-015**: Direkter Level-0- und delegierter Home-Runtime-Aufruf MÜSSEN
  dieselben Optionen und Exitcodes behalten.
- **FR-016**: PowerShell 7 MUSS denselben fachlichen Ereignis-, Bericht- und
  Ergebnisvertrag behalten.
- **FR-017**: Bereits korrektes PowerShell-Verhalten DARF nicht allein zur
  mechanischen Angleichung geändert werden.
- **FR-018**: Plattformunterschiede MÜSSEN durch reale oder klar begrenzte
  native Evidence sichtbar bleiben.
- **FR-019**: Textausgabe MUSS Status, Grund und nächste Aktion ohne Farbe,
  Animation oder Mehrspaltenlayout vermitteln.
- **FR-020**: Run-Evidence MUSS benutzerprivat, laufkorreliert und gegenüber
  fremden Run-IDs fail-closed bleiben.
- **FR-021**: Ereignisse, Logs und Meldungen DÜRFEN keine Secrets oder unnötigen
  persönlichen absoluten Pfade veröffentlichen.
- **FR-022**: CLI-Optionen, Eventschema 1, Sicherheits-, Bestätigungs- und
  Remote-Freshness-Barrieren MÜSSEN kompatibel bleiben.
- **FR-023**: Jede technische Änderung MUSS genau eine Documentation-Impact-
  Entscheidung erhalten.
- **FR-024**: Neue nicht triviale Kompatibilitäts- oder Evidence-Logik MUSS auf
  didaktischen Inline-Kommentarbedarf geprüft werden.

### Constitution and Governance Requirements

- **GOV-001 Security v0.6.1**: Eingaben, Pfade, Prozessargumente, Run-ID und
  Evidence sind sicher zu validieren. NIST SSDF und relevante CWE-Grenzen sind
  anwendbar. ASVS, SBOM, VEX, SLSA, AI-SBOM, CRA, NIS2, EU AI Act und DORA sind
  `N/A`, solange keine Webanwendung, Abhängigkeit, Lieferkette oder regulierte
  Produktgrenze geändert wird; jede Scope-Änderung löst Neubewertung aus.
- **GOV-002 Architecture v0.5.1**: Prozess-, Datei- und Run-ID-Grenzen sind
  Trust Boundaries. STRIDE/CAPEC ist begrenzt anwendbar; Cloud-, Zero-Trust-,
  BSI-C3A-/C5- und verteilte Deployment-Grenzen sind `N/A` ohne entsprechende
  Scope-Änderung.
- **GOV-003 iSAQB v0.2.1**: Bestehende Engine/UI-Verantwortungen und der
  kanonische Ergebnisvertrag bleiben erhalten. Kein ADR ist vorgesehen, sofern
  keine neue Architekturentscheidung entsteht.
- **GOV-004 A11Y v0.4.2**: WCAG 2.2 AA wird für Terminalausgabe angewendet;
  Deutsch steht vor Englisch, CEFR B2 gilt für lernendennahe Texte.
- **GOV-005 Cross-Platform v0.2.1**: Bash 3.2, aktuelles Bash und PowerShell 7
  erhalten semantisch gleichwertige Prüfungen. Manpage und PowerShell-Hilfe
  werden nur bei Vertragsänderung aktualisiert.
- **GOV-006 Agent Parity v0.4.1**: Gemeinsame Agentenflächen werden zusammen
  geprüft; ohne neue gemeinsame Regel lautet die Entscheidung
  `NoUpdateRequired`.
- **GOV-007 Intake Governance**: Der akzeptierte Review
  `1600a6c8-a818-4f02-8eda-1600b98b0f36` und Zielhash
  `b78cc1951eb34a9a52e3e6479a4b9f264c38d4eed393155f78ccb7031fadde2b`
  sind bindend.
- **GOV-008 Sequencing**: R-TUI ist der einzige bevorzugte Kandidat. D4 bleibt
  bis zum gemergten Abschluss und einer autorisierten Series-Aktualisierung
  blockiert.
- **GOV-009 Autonomous v0.3.3**: Zustands-, Gate- und Exact-Head-Evidence sind
  vor Remote-Abschluss zu validieren. Das Feature startet keinen Nachfolger.

### Key Entities

- **Maintenance Event**: Laufgebundene Statuszeile mit Sequenz, Typ, Status,
  Nachrichten und strukturierten Details.
- **Event Reader State**: Gelesene Sequenz und gegebenenfalls begründeter
  Degradierungszustand.
- **Atomic Run Report**: Finalisierte kanonische Lauf-Evidence mit Run-ID,
  Status, Exitcode und Artefaktpfaden.
- **Reconciled Result**: Nachvollziehbarer Abgleich von Prozess, Bericht und
  optionalem Abschlussereignis.
- **Home-Runtime Delegation**: Einwegübergang vom lokalen Wrapper zur
  versionierten Level-0-Quelle unter Erhalt aller Argumentgrenzen.

## Success Criteria

- **SC-001**: 100 % der Ereigniszeilen eines normalen Testlaufs sind gültige
  Einzelobjekte mit lückenloser Sequenz ab 1.
- **SC-002**: Jeder normale Testlauf enthält genau einen Laufstart und genau
  einen passenden Abschluss.
- **SC-003**: Kein normaler Lauf erzeugt `SequenceGap`, falsches
  `EVENT_STREAM_DEGRADED` oder falsches `RESULT_MISMATCH`.
- **SC-004**: Alle vorgesehenen Degradierungsfixtures lassen die kanonische
  Engine-Evidence unverändert und zeigen einen verständlichen Grund.
- **SC-005**: Alle echten Widerspruchsfixtures erzeugen `RESULT_MISMATCH`; alle
  reinen Event-Degradierungsfixtures tun dies nicht.
- **SC-006**: Null-, Einzel- und Mehrfachargumenttests bestehen unter
  macOS-System-Bash 3.2 und aktuellem Bash mit genau einem Engine-Prozess.
- **SC-007**: Betroffene .NET-, Bash-, PowerShell- und Wrapper-Regressionstests
  bestehen vollständig.
- **SC-008**: Status, Grund und nächste Aktion bleiben in TUI, Plain und
  `TERM=dumb` textorientiert verständlich.
- **SC-009**: Keine bestehende CLI-, Schema-, Sicherheits- oder
  Bestätigungsgrenze regressiert.
- **SC-010**: Dokumentation, Governance-Evidence und Projektstatistik sind am
  Abschluss aktuell und widerspruchsfrei.
- **SC-011**: Alle lokalen und Remote-Gates bestehen am exakten PR-Head und es
  bleiben null umsetzbare Review-Threads.
- **SC-012**: Nach Merge ist `main` sauber, entspricht `origin/main`, R-TUI ist
  archiviert und D4 wurde nicht automatisch gestartet.

### Acceptance Traceability

| Story | Requirements | Success Criteria |
|---|---|---|
| US1 | FR-001 bis FR-006 | SC-001 bis SC-004 |
| US2 | FR-007 bis FR-011 | SC-003 bis SC-005 |
| US3 | FR-012 bis FR-015 | SC-006, SC-009 |
| US4 | FR-016 bis FR-024 | SC-007 bis SC-012 |

## Assumptions and Dependencies

- Das bestehende Eventschema 1 und die CLI-Optionen sind fachlich korrekt.
- Die beobachteten Fehler liegen in Erzeugung, Weitergabe oder Auswertung.
- Bestehende Python-, Bash-, PowerShell- und .NET-Testharnesses bleiben die
  kanonischen Nachweisflächen.
- Es wird keine neue externe Abhängigkeit benötigt.

## Out of Scope

- Neue Wartungsfunktionen, Dashboards oder Mehrspaltenansichten.
- Änderungen in gewarteten Level-1-/Level-2-Ziel-Repositories.
- Abhängigkeits-, Paket- oder Eventschema-Upgrades.
- Breite Architekturrevision oder automatische Ausführung von D4.
