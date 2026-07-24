# Feature Specification: Plattformübergreifende Ein-Kommando-Wartung

**Feature Branch**: `009-platform-maintenance`
**Created**: 2026-07-24
**Status**: Draft
**Binding Intake**: `Lastenheft_Plattformuebergreifende-Ein-Kommando-Wartung.009-platform-maintenance.md` (archived after implementation)
**Accepted Review**: `5ce575e0-90a0-4946-b183-b8c3e1d83a71` (`Ready`)

## User Scenarios & Testing

### User Story 1 - Sichere vollständige Wartung (Priority: P1)

Als Workspace-Maintainer möchte ich die registrierte Entwicklungsumgebung mit
einem Aufruf warten, damit Level 0, Home-Baseline, vorhandene Repositories,
fehlende aktive Repositories und die lokale Toolchain kontrolliert in den
gewünschten Zustand gelangen.

**Why this priority**: Der vollständige, nicht-destruktive Ablauf ist der
Hauptnutzen des Features und die Grundlage aller weiteren Betriebsarten.

**Independent Test**: Ein isoliertes Mehr-Repository-Fixture enthält vorhandene,
fehlende und unveränderte Ziele. Der Lauf aktualisiert nur sichere Ziele, klont
fehlende Ziele über einen geprüften temporären Pfad und liefert einen
vollständigen Abschlussbericht.

**Acceptance Scenarios**:

1. **Given** eine gültige Sollflotte und ausschließlich sichere Zielzustände,
   **When** die Wartung ausgeführt wird, **Then** werden alle erforderlichen
   Aktionen einmal ausgeführt und der Lauf endet mit `SUCCESS`.
2. **Given** ein fehlendes aktives Repository mit gültiger Sollbeschreibung,
   **When** die Wartung ausgeführt wird, **Then** wird ein geprüfter Checkout
   atomar am Ziel bereitgestellt.
3. **Given** ein kollidierender, schmutziger, vorausliegender oder divergierter
   Zielzustand, **When** die Wartung ausgeführt wird, **Then** bleibt dieser
   Zustand unverändert, wird zielbezogen blockiert und unabhängige Arbeit läuft
   weiter.

---

### User Story 2 - Vollständige Prüfung ohne Mutation (Priority: P1)

Als Maintainer möchte ich denselben Soll-/Ist-Vergleich im Prüf- und
Vorschaumodus ausführen, damit ich Drift, geplante Klone, Aktualisierungen und
Toolchain-Aktionen vor einer Mutation vollständig bewerten kann.

**Why this priority**: Sichere Vorschau und überprüfbare Verweigerung sind
gleichrangige Voraussetzungen für unbeaufsichtigte Wartung.

**Independent Test**: Check-only und Dry-run/WhatIf werden gegen identische
Fixtures ausgeführt. Sie melden alle Folgeschritte und hinterlassen
Arbeitsdateien, Registry und Zielpfade bytegleich.

**Acceptance Scenarios**:

1. **Given** ein fehlendes Ziel, **When** Check-only läuft, **Then** wird
   `CLONE_REQUIRED` ohne Dateisystemmutation gemeldet.
2. **Given** mehrere geplante Änderungen, **When** Dry-run/WhatIf läuft,
   **Then** werden alle sicheren Aktionen als Vorschau gemeldet und keine davon
   ausgeführt.
3. **Given** frühe Registry-Drift, **When** ein read-only Modus läuft, **Then**
   werden die übrigen unabhängigen Prüfungen trotzdem vollständig ausgewertet.

---

### User Story 3 - Fortsetzbarer Teilfehler (Priority: P2)

Als Maintainer möchte ich nach einem isolierten Unterprozessfehler weiterhin
alle unabhängigen Ergebnisse und einen sicheren Wiedereinstieg erhalten, damit
ein einzelner Fehler nicht den Zustand der übrigen Flotte verdeckt.

**Why this priority**: Der Vorgängerlauf verlor nach einem späten No-op-Fehler
die restliche Flotten- und Toolchain-Evidence.

**Independent Test**: Ein Fixture lässt genau einen abhängigen Wartungsschritt
fehlschlagen. Der Lauf klassifiziert ihn, setzt unabhängige Stufen fort und
schreibt Log und JSON-Bericht mit einer exakten nächsten Aktion.

**Acceptance Scenarios**:

1. **Given** ein fehlschlagender Home-Sync, **When** der Lauf fortgesetzt werden
   kann, **Then** werden Repository- und Toolchain-Prüfungen weiterhin
   ausgewertet.
2. **Given** ein teilweise abgeschlossener Lauf, **When** er erneut gestartet
   wird, **Then** werden abgeschlossene Zustände validiert und nicht blind
   dupliziert.
3. **Given** ein fataler Schema- oder Aufruffehler, **When** der Lauf endet,
   **Then** lautet das Ergebnis `FAILED`, Exitcode ist `2` und erreichbare
   Berichtsartefakte bleiben verfügbar.

---

### User Story 4 - Plattformgleiche Bedienung (Priority: P2)

Als Maintainer auf macOS, Linux oder Windows möchte ich dieselben Betriebsarten,
Statusklassen und Sicherheitsgrenzen nutzen, damit die Wartung nicht von der
Hostplattform abhängt.

**Why this priority**: Die Workspace-Flotte wird auf allen drei Plattformen
genutzt; abweichende Semantik würde die Automatisierung unzuverlässig machen.

**Independent Test**: Bash- und PowerShell-Fixtures erhalten denselben
Soll-/Ist-Zustand und erzeugen dieselben Zielentscheidungen, Exitcodes und
semantisch äquivalenten Berichtsfelder.

**Acceptance Scenarios**:

1. **Given** ein semantisch identisches Fixture, **When** beide
   Plattformvarianten laufen, **Then** stimmen Zielstatus, Aktionsklassen,
   Gesamtstatus und Exitcode überein.
2. **Given** ein echter No-op, **When** er unter Bash 3.2, modernem Bash und
   PowerShell 7 läuft, **Then** tritt keine leere-Array- oder
   Nullsammlungsdiagnose auf.
3. **Given** eine administratorpflichtige optionale Aktualisierung, **When**
   keine interaktive Freigabe vorliegt, **Then** wird sie auf allen Plattformen
   als `DEFERRED_ADMIN_REQUIRED` behandelt.

### Edge Cases

- Der Zielpfad existiert als Datei, Symlink oder fremdes Verzeichnis.
- Ein temporärer Klon schlägt vor oder nach der Remote-Prüfung fehl.
- Remote, Standardbranch oder Upstream weichen von der Sollbeschreibung ab.
- Der Arbeitsbaum ist dirty, ahead, diverged oder detached.
- Eine Collection ist vorhanden, enthält aber nur einen Teil der deklarierten
  Mitglieder.
- Die operative Registry enthält zusätzliche, fehlende oder ungültige Ziele.
- Ein optionales Werkzeug fehlt, während erforderliche Werkzeuge aktuell sind.
- Administratorinteraktion ist erforderlich, aber nicht freigegeben.
- Log- oder Reportverzeichnis ist nicht schreibbar.
- Dateinamen enthalten Leerzeichen oder plattformspezifische Trenner.
- Ein Unterprozess liefert Exitcode `0`, aber einen fatalen strukturierten
  Fehlerkanal.

## Requirements

### Functional Requirements

- **FR-001**: Das System MUST eine versionierte, schema-validierte Sollquelle
  für Collections und Git-Ziele verwenden.
- **FR-002**: Die Sollquelle MUST 32 aktive `canonical-fleet`-Repositories,
  zehn gewünschte `preset`-Repositories und die Collection
  `SpecKitPresetProjects` unterscheidbar abbilden.
- **FR-003**: Level 0 MUST über den gemeinsamen Source-Resolver bestimmt und
  darf nicht als zweiter Flottencheckout dupliziert werden.
- **FR-004**: Aktive fehlende Git-Ziele MUST über ein eindeutiges temporäres
  Geschwisterverzeichnis geklont und erst nach Remote-, Branch- und
  Checkout-Prüfung an den Zielpfad verschoben werden.
- **FR-005**: Vorbestehende Pfadkonflikte MUST unverändert bleiben und als
  `PathConflict` berichtet werden.
- **FR-006**: Vorhandene Repositories MUST vor einer Aktualisierung auf
  Worktree-Typ, Remote, Branch, Upstream, Arbeitsbaum, aktive Git-Operation und
  aktuelle Ahead/Behind-Werte geprüft werden.
- **FR-007**: Nur ein sauberer, ausschließlich zurückliegender Checkout mit
  eindeutigem Upstream darf per Fast-forward aktualisiert werden.
- **FR-008**: Dirty-, Ahead-, Diverged-, Detached-, Remote- und
  Branch-Abweichungen MUST die Mutation des betroffenen Ziels verhindern, ohne
  unabhängige Zielprüfungen abzubrechen.
- **FR-009**: Collections MUST als Verzeichnisgrenzen behandelt werden; ihre
  Mitglieder werden ausschließlich über eigene Zieldefinitionen gewartet.
- **FR-010**: Kanonische Wartungsartefakte dürfen nur an
  `canonical-fleet`-Ziele propagiert werden; Preset-Repositories bleiben von
  dieser Propagation ausgeschlossen.
- **FR-011**: Check-only MUST den vollständigen Soll-/Ist-Zustand ermitteln,
  darf aber weder klonen, pullen, Registry oder Arbeitsdateien schreiben noch
  Pakete aktualisieren.
- **FR-012**: Dry-run/WhatIf MUST alle zulässigen Aktionen vollständig
  prognostizieren und ohne persistente Mutation enden.
- **FR-013**: Der Update-Modus MUST nur validierte, nicht-destruktive Aktionen
  ausführen und unabhängige Stufen nach isolierten Fehlern fortsetzen.
- **FR-014**: Jeder Abschnitt MUST Exitcode, Status, Dauer und Abhängigkeiten
  erfassen, bevor die Orchestrierung über Folgeschritte entscheidet.
- **FR-015**: Das Gesamtergebnis MUST zwischen `SUCCESS`,
  `SUCCESS_WITH_WARNINGS`, `DRIFT`, `PARTIAL` und `FAILED` unterscheiden.
- **FR-016**: Exitcodes MUST `0` für Erfolg oder ausschließlich optionale
  Warnungen, `1` für Drift oder unvollständige erforderliche Arbeit und `2`
  für fatale Aufruf-, Schema-, Source- oder Orchestrierungsfehler verwenden.
- **FR-017**: Ein unerwarteter Unterprozessfehler darf weder den finalen
  JSON-Bericht noch die Logreferenz verhindern, soweit deren Ausgabe technisch
  noch möglich ist.
- **FR-018**: Der JSON-Bericht MUST Run-, Plattform-, Modus-, Stufen-, Ziel-,
  Toolchain-, Findings- und Artefaktdaten mit einer gemeinsamen Run-ID
  enthalten.
- **FR-019**: Die Terminalausgabe MUST auf Start, höchstens eine Ergebniszeile
  je Ziel/Abschnitt und eine Abschlusszusammenfassung begrenzt bleiben.
- **FR-020**: Vollständige Unterprozessausgaben MUST in einer lokalen Logdatei
  verbleiben und dürfen keine Secrets oder unnötigen personenbezogenen Daten
  enthalten.
- **FR-021**: Wiederholte Läufe MUST idempotent sein, bereits erreichte Zustände
  erneut validieren und pro Blocker eine sichere nächste Aktion nennen.
- **FR-022**: Required-Werkzeuge MUST blockierend, optionale Werkzeuge nur bei
  ausdrücklicher Option installierbar sein.
- **FR-023**: MongoDB Community 8.0, Mono, SQLite und Telnet MUST ihre bestehende
  optionale Klassifikation behalten.
- **FR-024**: Administratorpflichtige optionale Aktualisierungen MUST ohne
  aktuelle Freigabe als `DEFERRED_ADMIN_REQUIRED` übersprungen werden.
- **FR-025**: Eine ausdrückliche Admin-Prompt-Option darf nur interaktive
  Eingabe für den aktuellen Lauf erlauben und niemals Zugangsdaten speichern
  oder protokollieren.
- **FR-026**: Bash und PowerShell MUST dieselben Betriebsarten, Entscheidungen,
  Statusklassen, Exitcodes und semantisch äquivalenten Berichtsfelder liefern.
- **FR-027**: Die bestehende Bash-3.2-No-op-Korrektur aus PR #90 MUST integriert
  und durch deterministische No-op- und Änderungstests geschützt bleiben.
- **FR-028**: Neue oder geänderte nicht-triviale Orchestrierungslogik MUST auf
  didaktischen Kommentarbedarf geprüft werden; Kommentare erklären Gründe,
  Trade-offs, Randbedingungen oder Proof-Grenzen.
- **FR-029**: Das Feature MUST kompatible Schnittstellen und Evidence für das
  spätere Position-4-Hardening bereitstellen, darf dessen Remote-Freshness-,
  Default-Branch-, Worktree- oder Hard-Abort-Scope aber nicht vorwegnehmen.
- **FR-030**: Der aktuelle Lauf MUST ausschließlich das Level-0-Repository
  ausliefern; Änderungen an den 32 Ziel-Repositories bleiben ein gesondert
  freizugebender Folgeauftrag.

### Constitution Requirements

- **CR-001**: Dieses Feature betrifft Level 0; kein Level-2-Registry-Eintrag ist
  als Implementierungsumgebung bindend.
- **CR-002**: CLI-Ausgaben, Hilfe, Manpages und JSON-Evidence MUST text-first
  sowie nach anwendbaren WCAG-2.2-AA-Grundsätzen geprüft werden.
- **CR-003**: Nutzerseitige Dokumentation und Hilfe MUST DE-first/EN-second bei
  CEFR B2 bereitgestellt werden.
- **CR-004**: `docs/project-statistics.md` MUST nach der Implementierung
  aktualisiert werden. Gemeinsame Agent-Guidance wird nur bei einer geänderten
  dauerhaften Regel synchron auf allen fünf gepflegten Oberflächen geändert.
- **CR-005**: Primäre Implementierungssprachen sind PowerShell 7 und Bash.
  PowerShell/.NET ist speichersicher; Bash ist nicht Teil der MSL-Erlaubnisliste,
  bleibt aber wegen der nativen macOS/Linux-Shellschnittstelle erforderlich
  und folgt den verbindlichen Shell-Sicherheitsregeln.
- **CR-006**: NIST SSDF und die für Pfad-, Prozess-, Argument- und
  Dateiverarbeitung relevanten CWE-Top-25-Klassen sind anwendbar.
- **CR-007**: OWASP ASVS ist `N/A`, weil kein Web-, HTTP-, API-, Auth- oder
  Sessiondienst geändert wird. Neu bewerten, sobald ein solcher Dienst
  hinzukommt.
- **CR-008**: SBOM und VEX sind `N/A`, solange weder Abhängigkeiten noch
  paketierte Binärartefakte geändert werden. SLSA ist `N/A`, solange kein neuer
  Build- oder Release-Artefaktfluss entsteht. Bei entsprechendem Scope neu
  bewerten.
- **CR-009**: AI-SBOM ist `N/A`, weil KI nur Entwicklungswerkzeug ist und kein
  Modell, Datensatz oder Inferenzdienst ausgeliefert wird.
- **CR-010**: Lokales Dateisystem, Git-Remotes, Paketmanager und Unterprozesse
  bilden Trust Boundaries. STRIDE/CIA und relevante CAPEC-Muster für
  Pfadmanipulation, Argumentinjektion und Supply-Chain-Manipulation sind
  anwendbar; Zero Trust ist mangels neuem Remote-Dienst `N/A`.
- **CR-011**: Sicherheits-, Architektur-, A11Y-, Plattform- und
  Governance-Evidence wird feature-lokal in `pr-evidence.md`, Plan,
  Checklisten und Gate-Artefakten geführt. Dauerhafte Dokumente unter `docs/`
  werden nur bei tatsächlich geänderter Projektregel aktualisiert.
- **CR-012**: Alle zehn installierten Presets werden geprüft. Die acht
  Governance-Presets bleiben die bindende Kernmatrix; Intake Authoring und
  Intake Review liefern akzeptierte Eingabe-Evidence, Autonomous Run steuert
  die Lieferung. Parallel Autonomous ist `N/A`, weil genau ein Feature läuft.

### Key Entities

- **Fleet Target**: Eindeutiges Git-Ziel oder Collection mit ID, Ebene, Pfad,
  Aktivstatus, Wartungsklasse und gegebenenfalls Remote/Branch.
- **Maintenance Stage**: Abhängiger oder unabhängiger Wartungsabschnitt mit
  Status, Exitcode, Dauer und Folgeschritt.
- **Run Report**: Maschinenlesbarer Abschluss mit Run-ID, Gesamtstatus,
  Ziel-/Toolchain-Ergebnissen, Findings und Artefaktpfaden.
- **Finding**: Stabil klassifizierter Blocker oder Warnhinweis mit Ziel,
  Schweregrad, Kurzursache und sicherem Wiedereinstieg.

## Governance Applicability

| Preset / Checkpoint | State | Evidence and re-evaluation trigger |
|---|---|---|
| Security Governance v0.6.1 | Applicable | Pfad-, Prozess-, Git- und Paketmanagergrenzen; neu bewerten bei Abhängigkeits-, Auth- oder Release-Scope |
| Architecture Governance v0.5.1 | Applicable | Stufengraph, Trust Boundaries, partielle Fehler und sichere Defaults |
| iSAQB Architecture Governance v0.2.1 | Applicable | Wartbarkeit, Zuverlässigkeit, Plattformparität und Wiederanlauf sind Qualitätsattribute |
| A11Y Governance v0.4.1 | Applicable | CLI, Hilfe, Manpages, JSON-Textparität und didaktische Kommentare |
| Cross-Platform Governance v0.2.1 | Applicable | Bash/macOS/Linux und PowerShell/Windows mit Check-/Preview-Parität |
| Agent Parity Governance v0.4.0 | Applicable | Fünf Agentenoberflächen nur bei dauerhafter Guidance-Änderung gemeinsam prüfen |
| Intake Authoring Governance v0.2.0 | Applicable | Schema-2.0-Receipt `ee971b7c-65b3-4160-932d-0657e4e73fa8` ist akzeptiert |
| Intake Review Governance v0.1.1 | Applicable | Series Review `5ce575e0-90a0-4946-b183-b8c3e1d83a71` ist `Ready` |
| Autonomous Run Governance v0.3.2 | Applicable | `MergeAndSync`, Run-State, Gate-Evidence, Stop/Resume und Retrospektive |
| Parallel Autonomous Run Governance v0.2.3 | N/A | Einzelner serialisierter Feature-Lauf; neu bewerten bei genehmigter Kampagne |
| OpenSSF Scorecard | Applicable | Öffentliches Repository und GitHub-Workflow-Gates; keine neue Abhängigkeit |
| NIS2, CRA, EU AI Act, DORA | N/A | Lokale Entwicklungsinfrastruktur ohne Marktprodukt, KI-Runtime oder Finanz-ICT-Lieferung; bei geändertem Betriebs-/Kundenscope neu bewerten |
| BSI C3A / BSI C5 | N/A | Keine Cloud-Service-Auswahl oder neue Providerabhängigkeit; bei Cloud-Scope neu bewerten |
| OWASP SAMM | Applicable | Verbesserung des sicheren, messbaren Wartungsprozesses |
| S-ADR / arc42 | Applicable | Manifest-, Stufen- und Trust-Boundary-Entscheidungen werden im Feature-Plan nachvollziehbar festgehalten |

## Autonomous-run Applicability

- **Delivery mode**: `MergeAndSync`, ausdrücklich im aktuellen Benutzerauftrag
  erteilt.
- **Run state**:
  `specs/009-platform-maintenance/autonomous-run-state.json`.
- **Accepted inputs**: Lastenheft, Schema-2.0-Receipt, Schema-1.1-Series-Request,
  `Ready`-Result, Review-Bericht und Constitution mit gespeicherten SHA-256.
- **Scope boundary**: Nur Level 0 wird remote ausgeliefert; kein Flottenrollout,
  keine Provider-Administration und kein Folgefeature.
- **Causal closeout**: Nur falls Post-Merge-Fakten nicht wahrheitsgemäß im
  geprüften Feature-Head stehen können.
- **Mutable validation tokens**: `N/A`; das Feature verwendet keine manuell
  inkrementierten Build- oder Testversionszähler.
- **Interruption**: Ein absichtlicher Stop wechselt am sicheren Grenzpunkt zu
  `PausedByUser`; ein unerwarteter Abbruch erfordert Statusprüfung und
  ausdrückliches Resume mit erneuter `MergeAndSync`-Authority.
- **Bypass**: Nur der aktuell genehmigte enge Human-Approval-Bypass bei grünen
  technischen Gates und null umsetzbaren Threads.

## Success Criteria

### Measurable Outcomes

- **SC-001**: Alle deklarierte Sollziele erhalten in jedem Lauf genau eine
  nachvollziehbare Zielentscheidung.
- **SC-002**: Check-only und Dry-run/WhatIf verändern in den negativen und
  positiven Fixtures keine Arbeitsdatei, Registry und keinen Zielcheckout.
- **SC-003**: Bash und PowerShell erzeugen für dieselben Fixtures identische
  Statusklassen und Exitcodes sowie semantisch äquivalente JSON-Daten.
- **SC-004**: No-op, Einzeländerung und Mehrfachänderung bestehen unter
  macOS-Bash 3.2, modernem Bash und PowerShell 7 ohne leere-Sammlungsfehler.
- **SC-005**: Jedes fehlende sichere Ziel wird höchstens einmal bereitgestellt;
  ein Teilfehler hinterlässt keinen als vollständig akzeptierten Checkout.
- **SC-006**: Jeder absichtliche negative Zielzustand bleibt unverändert und
  besitzt im Bericht einen stabilen Befundcode sowie eine exakte nächste Aktion.
- **SC-007**: Ein isolierter Unterprozessfehler verhindert weder die Ergebnisse
  unabhängiger Stufen noch den finalen Report, sofern dieser technisch
  geschrieben werden kann.
- **SC-008**: Terminalausgabe enthält höchstens eine Ergebniszeile pro Ziel und
  Abschnitt; vollständige Unterprozessausgaben stehen im Log.
- **SC-009**: Sämtliche lokalen Pflichtprüfungen und macOS-/Linux-/Windows-Gates
  bestehen auf dem exakten PR-Head.
- **SC-010**: Der Feature-PR wird ohne umsetzbare Review-Threads gemergt und der
  lokale Default-Branch endet sauber mit `HEAD == origin/main`.

## Assumptions

- `origin` bleibt für dieses Feature der kanonische Remote-Name.
- Die aktuelle operative Registry enthält sieben Level-1- und 25
  Level-2-Repositories.
- Das bestehende Profil `intake-authoring-ten-governance-presets` bleibt die
  Sollquelle für zehn optionale Preset-Pakete.
- Die drei aktuell vorhandenen Preset-Repositories sind keine Garantie für
  spätere Hostzustände; das Manifest bleibt die Sollquelle.
- Feature 009 ändert keine Abhängigkeiten, Providerrechte oder
  Repository-Rulesets.
- Der Flottenrollout nach dem Level-0-Merge ist ein separater Auftrag.
