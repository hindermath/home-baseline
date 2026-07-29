# Feature Specification: Agentic-Workspace-Wartungs-TUI

**Feature Branch**: `018-agentic-workspace-tui`
**Created**: 2026-07-29
**Status**: Draft
**Binding Input**: `Lastenheft_Agentic-Workspace-Maintenance-TUI.md`
**Delivery Mode**: `MergeAndSync`

## User Scenarios & Testing

### User Story 1 - Sicherer interaktiver Einstieg (Priority: P1)

Als lernende oder wartende Person moechte ich bei einem interaktiven Aufruf
eine sichere Wartungsoberflaeche mit vorausgewaehlter Vorschau erhalten, damit
ich den Umfang verstehe, bevor das System Aenderungen ausfuehrt.

**Why this priority**: Der argumentlose Wartungsbefehl darf in interaktiven
Terminals nicht unbeabsichtigt sofort mutieren. Zugleich muss bestehende
Automatisierung ohne Terminal unveraendert funktionieren.

**Independent Test**: Ein Terminal-Fake prueft interaktive und nicht
interaktive Ein-/Ausgabe, explizite UI-Schalter und bestehende
Wartungsparameter. Nur der interaktive argumentlose Aufruf startet die TUI.

**Acceptance Scenarios**:

1. **Given** Standardeingabe und Standardausgabe sind interaktive Terminals,
   **When** der Wartungsbefehl ohne Argumente startet, **Then** erscheint die
   TUI mit `Dry-run / WhatIf` als Anfangsauswahl.
2. **Given** mindestens einer der beiden Standardkanaele ist nicht interaktiv,
   **When** der Wartungsbefehl ohne Argumente startet, **Then** bleibt der
   bisherige unbeaufsichtigte Komplettlauf erhalten.
3. **Given** ein bestehender Wartungsparameter ist vorhanden, **When** der
   Wrapper startet, **Then** wird der bestehende Headless-Pfad ohne TUI
   verwendet.
4. **Given** das Terminal unterstuetzt die erweiterte Darstellung nicht,
   **When** die TUI ausdruecklich angefordert wurde, **Then** wird mit
   sichtbarer Begruendung der lineare Plaintext-Assistent verwendet.

---

### User Story 2 - Nachvollziehbare und sichere Moduswahl (Priority: P1)

Als wartende Person moechte ich nur gueltige Wartungsmodi auswaehlen, den
aequivalenten Plattformbefehl sehen und schreibende Laeufe ausdruecklich
bestaetigen, damit die Oberflaeche keine schwaechere Sicherheitsgrenze als die
vorhandene Engine einfuehrt.

**Why this priority**: Eine zusaetzliche Oberflaeche darf weder verbotene
Parameterkombinationen erzeugen noch aus einer UI-Bestaetigung weitergehende
Repository- oder Administratorrechte ableiten.

**Independent Test**: Konsolentests pruefen jede erlaubte und verbotene
Kombination, den Standardwert `Nein`, einen Abbruch vor Engine-Start und die
nur zur Erklaerung gerenderte Befehlszeile.

**Acceptance Scenarios**:

1. **Given** die Modusauswahl ist neu geoeffnet, **When** keine Eingabe erfolgt,
   **Then** bleibt die Vorschau ausgewaehlt und ein echter Lauf startet nicht.
2. **Given** `Check-only`, Vorschau, `Scripts-only`, optionale Pakete und
   Drift-Reparatur stehen zur Wahl, **When** die Auswahl geaendert wird,
   **Then** sind nur Kombinationen moeglich, die auch der direkte CLI-Aufruf
   akzeptiert.
3. **Given** ein echter schreibender Lauf ist ausgewaehlt, **When** die
   Zusammenfassung erscheint, **Then** werden Modus, Ziel und aequivalenter
   Befehl gezeigt und die Bestaetigung steht standardmaessig auf `Nein`.
4. **Given** die Person bricht vor Engine-Start ab, **When** der Assistent
   endet, **Then** wurden keine Wartungsdaten veraendert und Exitcode `130`
   wird geliefert.

---

### User Story 3 - Ehrlicher Live- und Abschlussstatus (Priority: P1)

Als Maintainer moechte ich Phasen, Barrieren, Zielzustand und Abschluss aus
strukturierten Daten ablesen, damit stille Ausgabe, fehlerhafte Anzeige oder
partielle Ergebnisse nicht als Erfolg missverstanden werden.

**Why this priority**: Die bestehende Wartung besitzt sicherheitsrelevante
Zwischen- und Abschlusszustaende. Freitextparsing oder erfundener Fortschritt
koennte eine gesperrte Mutation als erfolgreich darstellen.

**Independent Test**: Eine deterministische Fake-Engine liefert gueltige,
partielle, widerspruechliche und fehlerhafte Ereignisfolgen sowie alle
kanonischen Exitcodes. Die UI bleibt lesbar und veraendert den Engine-Ausgang
nicht.

**Acceptance Scenarios**:

1. **Given** ein gueltiger Ereignisstrom, **When** Phasen und Findings
   eintreffen, **Then** zeigt die TUI ausschliesslich daraus den Live-Status
   und erfindet bei unbekanntem Nenner keinen Prozentwert.
2. **Given** ungueltiges JSON, eine Sequenzluecke oder eine unbekannte
   Schema-Version, **When** die TUI dies erkennt, **Then** meldet sie
   `EVENT_STREAM_DEGRADED`, wechselt zur linearen Logansicht und laesst den
   Engineprozess weiterlaufen.
3. **Given** `PARTIAL` und Exitcode `1`, **When** der Lauf endet, **Then** wird
   der Zustand weder als Erfolg noch als UI-Absturz dargestellt.
4. **Given** Ereignis, atomarer Abschlussbericht und Prozess-Exitcode
   widersprechen sich, **When** der Abschluss abgeglichen wird, **Then** hat
   der Prozess-Exitcode Vorrang und `RESULT_MISMATCH` wird sichtbar.
5. **Given** die Person drueckt nach Engine-Start `Ctrl+C`, **When** der
   kontrollierte Abbruch laeuft, **Then** wird genau ein Interrupt
   weitergereicht und keine unbestaetigte Bereinigung gestartet.

---

### User Story 4 - Plattformgleiche Verfuegbarkeit und Fallbacks (Priority: P1)

Als Nutzerin oder Nutzer moechte ich dieselbe fachliche Auswahl auf macOS,
Linux und Windows erhalten, auch wenn das .NET-SDK, das Netzwerk oder der
Build-Cache nicht verfuegbar ist, damit der Wartungszugang nicht von einer
fragilen UI-Voraussetzung abhaengt.

**Why this priority**: Die TUI ist eine zusaetzliche Bedienoberflaeche. Sie darf
den vorhandenen Wartungsweg weder ersetzen noch durch einen fehlgeschlagenen
Restore blockieren.

**Independent Test**: Wrapper-Fixtures pruefen Cache-Treffer, veraenderten
Quellfingerabdruck, fehlendes SDK, Offline-Restore, beschaedigten und nicht
schreibbaren Cache sowie macOS-, Linux- und Windows-Plattformnamen.

**Acceptance Scenarios**:

1. **Given** ein passender vollstaendiger Cache, **When** die TUI startet,
   **Then** wird genau dieser content-adressierte Build verwendet.
2. **Given** Quellinhalt, Lockdatei oder Wrapper-UI-Version hat sich geaendert,
   **When** der Cache geprueft wird, **Then** wird ein alter Build nicht
   wiederverwendet.
3. **Given** SDK, Restore, Build oder Cache ist nicht verfuegbar, **When** noch
   kein Engineprozess gestartet wurde, **Then** faellt der Aufruf sicher auf
   den funktional gleichwertigen Plaintext-Assistenten zurueck.
4. **Given** die Wartungs-Engine ist bereits gestartet und scheitert, **When**
   die UI den Fehler empfaengt, **Then** wird die Engine nicht implizit erneut
   gestartet.

---

### User Story 5 - Barrierearme Wartung fuer Lernende und Maintainer (Priority: P1)

Als Person ab dem ersten Ausbildungsjahr moechte ich Status, Auswahl,
Sperrgruende und naechste Aktionen ohne Farbwahrnehmung und ohne
Spec-Kit-Vorwissen verstehen, damit ich Wartung sicher begleiten und Evidence
kopieren kann.

**Why this priority**: `Programmierung #include<everyone>` ist verbindlich.
Terminalposition, Farbe, Animation und Fachjargon duerfen keine alleinigen
Informationstraeger sein.

**Independent Test**: Konsolen-Snapshots und textorientierte Reviews pruefen
Tastaturbedienung, `NO_COLOR`, `TERM=dumb`, schmale Terminals, stabile
Screenreader-Lesereihenfolge, ASCII-Status und bilinguale CEFR-B2-Texte.

**Acceptance Scenarios**:

1. **Given** Farbe ist deaktiviert, **When** eine Phase blockiert oder partiell
   endet, **Then** nennen ASCII-Text und kurze Erklaerung Status, Grund und
   naechste Aktion.
2. **Given** das Terminal ist schmaler als 80 Spalten, **When** das Dashboard
   rendert, **Then** wird automatisch eine lineare Kompaktansicht ohne
   Informationsverlust verwendet.
3. **Given** eine Person nutzt nur die Tastatur oder einen Screenreader,
   **When** sie Auswahl und Abschluss durchlaeuft, **Then** sind Fokus,
   Auswahl, Warnungen und Evidence in stabiler Reihenfolge erfassbar.

### Edge Cases

- `stdin` ist interaktiv, `stdout` jedoch umgeleitet oder umgekehrt.
- `TERM=dumb`, `NO_COLOR`, unbekannte Terminalfaehigkeit oder weniger als
  80 Spalten treffen zusammen.
- Der Cache passt zum Betriebssystem, aber nicht zur Architektur oder zum
  aktuellen Quellfingerabdruck.
- Ein Restore oder Build schreibt nur Teilartefakte und endet dann fehlerhaft.
- Der Ereignisstrom endet mit einer unvollstaendigen letzten Zeile.
- `run-completed` verweist auf einen fehlenden, nicht finalisierten oder
  lauf-fremden Bericht.
- Ein Pfad oder eine Fremdmeldung enthaelt Spectre-Markup-Zeichen.
- Ein echter Lauf endet mit `SUCCESS_WITH_WARNINGS`, `PARTIAL`, Exitcode `2`,
  repariertem Drift `3` oder Benutzerabbruch `130`.
- Die Freshness-Inventur findet blockierte Ziele, laeuft fuer die restliche
  Flotte aber weiter.
- Eine aktive, fremde, verwaiste oder manipulierte Worktree-Lease wird
  dargestellt, ohne dass die TUI selbst bereinigt.
- Ein zwoelftes Preset wird dem Profil hinzugefuegt, ohne TUI-Code zu aendern.

## Requirements

### Functional Requirements

- **FR-001**: Der argumentlose Aufruf MUSS genau dann die TUI starten, wenn
  Standardeingabe und Standardausgabe interaktive Terminals sind.
- **FR-002**: Der argumentlose nicht interaktive Aufruf MUSS den bisherigen
  unbeaufsichtigten Komplettlauf unveraendert ausfuehren.
- **FR-003**: Jeder bestehende Wartungsparameter MUSS den bisherigen
  Headless-Pfad ohne TUI verwenden.
- **FR-004**: `--tui`/`-Tui`, `--plain-ui`/`-PlainUi` und
  `--no-tui`/`-NoTui` MUESSEN gegenseitig exklusiv sein und die im Intake
  festgelegten Kombinationsgrenzen mit Exitcode `2` erzwingen.
- **FR-005**: Ein expliziter TUI-Aufruf MUSS bei ungeeignetem Terminal sichtbar
  auf den Plaintext-Assistenten zurueckfallen; ein impliziter nicht
  interaktiver Aufruf MUSS headless bleiben.
- **FR-006**: Die Modusauswahl MUSS `Dry-run / WhatIf` vorauswaehlen und alle
  Konflikte der kanonischen Engine abbilden.
- **FR-007**: Vor jedem echten schreibenden Lauf MUSS eine Zusammenfassung mit
  Modus, Ziel und erklaerendem Plattformbefehl erscheinen; die Bestaetigung
  MUSS standardmaessig `Nein` sein.
- **FR-008**: Abbruch vor Engine-Start MUSS ohne Wartungsmutation mit Exitcode
  `130` enden.
- **FR-009**: Bash und PowerShell MUESSEN die einzigen Wartungs-Engines
  bleiben. Die TUI DARF keine Git-, Sync-, Clone-, Registry-, Propagations-,
  Paketmanager-, Pull-, Lease- oder Bereinigungslogik duplizieren.
- **FR-010**: Der Kindprozess MUSS ueber typisierte Argumentlisten gestartet
  werden. Shell-Interpolation, `eval`, `Invoke-Expression` und die Ausfuehrung
  des angezeigten Befehlsstrings sind verboten.
- **FR-011**: Die Engine MUSS optional einen append-only JSONL-Ereigniskanal
  ueber `--event-stream PATH` beziehungsweise `-EventStream PATH` erzeugen,
  ohne Verhalten bestehender Aufrufe zu aendern.
- **FR-012**: Jedes Ereignis MUSS Schema-Version, Lauf-ID, streng steigende
  Sequenz, UTC-Zeit, Ereignistyp, Status, optionale stabile Phase und Ziel-ID,
  kurze deutsche und englische Meldung sowie secret-freie Details enthalten.
- **FR-013**: Schema 1 MUSS die Ereignisse `run-started`, `phase-started`,
  `phase-progress`, `finding`, `phase-completed` und `run-completed`
  unterstuetzen.
- **FR-014**: Die Phasen `fleet`, `level0`, `home-sync`, `registry`,
  `propagation`, `preset-profiles`, `toolchain` und `final` sowie die
  kanonischen Maschinenstatus der Engine MUESSEN unveraendert verwendet
  werden.
- **FR-015**: Unvollstaendige Schlusszeilen MUESSEN bis zur
  Vervollstaendigung ignoriert werden. Ungueltiges JSON, Sequenzluecken oder
  unbekannte Schemas MUESSEN `EVENT_STREAM_DEGRADED` ausloesen, ohne
  Engineprozess oder Exitcode zu veraendern.
- **FR-016**: Freie Konsolenausgabe DARF nicht als Statusprotokoll geparst
  werden und stille Ausgabe DARF keinen Erfolg erzeugen.
- **FR-017**: `run-completed`, der atomar finalisierte Bericht und der
  Prozess-Exitcode MUESSEN ueber Lauf-ID, Finalisierung, Gesamtstatus und
  Exitcode abgeglichen werden. Bei Widerspruch MUSS der Prozess-Exitcode
  gelten und `RESULT_MISMATCH` erscheinen.
- **FR-018**: Erzeugte Binaerdateien DUERFEN nicht eingecheckt werden.
  Quelltexte, Tests, Lockdatei und verifizierte Paketquellenkonfiguration
  MUESSEN getrackt bleiben.
- **FR-019**: Der Build-Cache MUSS Quellfingerabdruck und normalisierte
  OS-/Architektur-ID binden, nur vollstaendige Builds atomar sichtbar machen
  und bei jeder Abweichung einen alten Build ablehnen.
- **FR-020**: Fehlendes .NET-10-SDK, Restore-/Buildfehler oder ein nicht
  nutzbarer Cache MUESSEN vor Engine-Start auf den funktional gleichwertigen
  Plaintext-Assistenten zurueckfallen.
- **FR-021**: Spectre.Console und Spectre.Console.Testing MUESSEN auf `0.57.2`
  festgelegt und mit Locked Restore, Lizenz-, Herkunfts- und
  Schwachstellennachweis verwendet werden.
- **FR-022**: Das Dashboard MUSS Modus, Plattform, Quelle, Home-Verzeichnis,
  Phase, textuellen Status, Mutation Barrier, Zielzaehler, Pull- und
  Sperrklassen, Findings, Lease-/Profilstatus, letzte sichere Aktion sowie
  Abschluss-Evidence zeigen.
- **FR-023**: Live-Aktualisierungen DUERFEN hoechstens zehnmal pro Sekunde
  erfolgen; unbekannte Gesamtmengen DUERFEN nicht als Prozentwert erscheinen.
- **FR-024**: Die Oberflaeche MUSS vollstaendig per Tastatur, mit `NO_COLOR`,
  `TERM=dumb`, schmaler linearer Ausgabe und stabiler
  Screenreader-Lesereihenfolge funktionieren.
- **FR-025**: Farbe, Position, Balken oder Animation DUERFEN nie alleinige
  Bedeutung tragen. Status MUSS immer als ASCII-Text vorliegen.
- **FR-026**: Nutzertexte MUESSEN Deutsch zuerst, Englisch danach, auf
  CEFR-B2-Niveau und mit Erklaerung des ersten Fachbegriffs erscheinen.
- **FR-027**: Die TUI DARF keine Secrets, Administratorpasswoerter,
  Providerdaten oder Umgebungsvariablen-Dumps anfordern oder protokollieren.
- **FR-028**: Fremde Pfade, Remotes und Meldungen MUESSEN vor
  Spectre-Markup-Ausgabe maskiert werden; Ereignis-, Cache- und
  Temporaerdateien MUESSEN nur fuer den aktuellen Benutzer zugaenglich sein.
- **FR-029**: Die TUI MUSS die kanonische Pfadpruefung und
  Umgebungsbegrenzung der Engine erhalten und DARF keine schwaechere
  Parallelvalidierung einfuehren.
- **FR-030**: Ein Abbruch nach Engine-Start MUSS zuerst genau ein
  kontrolliertes Interruptsignal weiterreichen. Ein zweiter Abbruch darf die
  Anzeige beenden, aber keine destruktive Bereinigung ausloesen.
- **FR-031**: Engine-Exitcodes `0`, `1`, `2`, `3` und `130` MUESSEN
  unveraendert propagiert und textuell erklaert werden.
- **FR-032**: UI-Startfehler DUERFEN nur vor Engine-Start einen Fallback
  ausloesen. Enginefehler DUERFEN keinen automatischen zweiten Lauf starten.
- **FR-033**: Freshness Barrier, Mutation Barrier, sichere Pull-Entscheidungen,
  Worktree-Leases, dynamische Preset-Profile, Resume- und Abschlussvertraege
  aus Features 015 bis 017 MUESSEN dargestellt und regressionstested werden.
- **FR-034**: Die TUI und der Feature-Lauf DUERFEN der Wartungs-Engine keine
  Commit-, Push-, PR-, Merge-, Provider-, Secret-, Cleanup- oder
  Administratorautoritaet fuer Ziel-Repositories erteilen.
- **FR-035**: Dokumentation MUSS README, bestehende Wartungs-Manpage,
  PowerShell-Hilfe, Architektur-/Testbeschreibung und den
  Dokumentationsauswirkungsnachweis konsistent aktualisieren.

### Constitution and Governance Requirements

- **GR-001 - Security Governance v0.6.1**: C#/.NET ist eine
  speichersichere Primaersprache. NIST SSDF, CWE Top 25, sichere Prozess-,
  Datei-, Pfad-, Markup- und Eingabegrenzen sowie Dependency Audit sind
  anwendbar. SBOM und VEX sind fuer die zwei neuen Pakete anwendbar.
  AI-SBOM, SLSA, OpenSSF Scorecard, NIS2, CRA, EU AI Act und DORA sind fuer
  das interne lokale Hilfsprogramm `N/A`; sie werden bei Produktrelease,
  KI-Modell-, reguliertem Dienst- oder erweiterter Lieferkettenscope neu
  bewertet.
- **GR-002 - Architecture Governance v0.5.1**: STRIDE, CIA und CAPEC sind fuer
  Prozess-, Pfad-, Ereignis-, Cache- und Trust-Boundary-Risiken anwendbar.
  Ein S-ADR und arc42-nahe Laufzeit-/Querschnittsevidence sind anwendbar.
  SAMM wird als Prozessnachweis betrachtet. Zero Trust, BSI C3A und BSI C5
  sind ohne Identitaets-, Cloud- oder Providerarchitektur `N/A`.
- **GR-003 - iSAQB Architecture Governance v0.2.1**: Kontext,
  Bausteingrenzen, Laufzeitszenarien, Deployment/Fallback, Qualitaetsziele,
  Fehlergrenzen und technische Schulden MUESSEN im Plan nachvollziehbar sein.
- **GR-004 - A11Y Governance v0.4.2**: Terminaloberflaeche, Plaintext-
  Fallback, CLI-Hilfe, Dokumentation und Evidence sind anwendbar. WCAG 2.2 AA,
  Deutsch zuerst/Englisch danach, CEFR B2, text-first und didaktische
  Kommentarpruefung sind verbindlich.
- **GR-005 - Cross-Platform Governance v0.2.1**: Bash- und
  PowerShell-Wrapper, interne Parameter, Dry-run/WhatIf, Hilfe, Manpage und
  macOS-/Ubuntu-/Windows-Nachweise sind anwendbar und semantisch gleichwertig
  zu liefern.
- **GR-006 - Agent Parity Governance v0.4.1**: Gemeinsame Agent-Guidance und
  `.specify/templates/` sind nur bei einer neuen dauerhaften Agentenregel
  anwendbar. Ohne solche Vertragsaenderung lautet die Entscheidung
  `NoUpdateRequired`; bei Aenderung sind alle gepflegten Agentenflaechen
  gemeinsam zu aktualisieren.
- **GR-007 - Autonomous Run Governance v0.3.3**: `MergeAndSync`,
  Feature-State, Evidence, Gate-Anforderungen, Exact-Head-Nachweise,
  Review-Konvergenz und Retrospektive sind anwendbar. Der enge Admin-Bypass
  gilt nur bei vollstaendig gruenen technischen Gates, null umsetzbaren
  Threads und Human Approval als einzigem offenen Gate.
- **GR-008 - Intake Governance**: Intake Authoring v0.3.0, Intake Review
  v0.2.0 und Intake Sequencing v0.2.2 sind bindende, hashgepruefte
  Eingangsevidence. Ihre Presets werden durch Feature 018 nicht veraendert.
  Parallel Autonomous v0.2.4 ist mangels Kampagne `N/A`.

### Key Entities

- **UI Invocation**: Erkannter Terminalzustand, Plattform, expliziter
  UI-Schalter und vorhandene Wartungsargumente.
- **Maintenance Selection**: Genau ein Hauptmodus und die dazu erlaubten
  Optionen, Zielpfad, Vorschau und Bestaetigungszustand.
- **Equivalent Command**: Nur zur Erklaerung gerenderte, plattformgerecht
  maskierte Befehlsdarstellung.
- **Maintenance Event**: Versioniertes append-only Ereignis mit Lauf-,
  Sequenz-, Phasen-, Ziel- und Statusbezug.
- **Run Result**: Abgleich aus Prozess-Exitcode, atomarem Abschlussbericht und
  optionalem Abschlussereignis.
- **Source Fingerprint**: SHA-256 ueber sortierte Projektpfade und Inhalte,
  Lockdatei und Wrapper-UI-Version.
- **Cached UI Build**: Vollstaendiger frameworkabhaengiger Build fuer genau
  einen Fingerprint und eine normalisierte OS-/Architektur-ID.
- **Presentation State**: Erweiterte, kompakte oder lineare Darstellung mit
  immer vorhandenem ASCII-Status.
- **Engine Boundary**: Unueberschreitbare Grenze zwischen Auswahl/Darstellung
  und allen fachlichen Wartungsoperationen.

## Success Criteria

- **SC-001 (AC-01–AC-05)**: Alle TTY-, Headless-, Schalter-, Modus- und
  Bestaetigungsfixtures liefern exakt den festgelegten Pfad und Exitcode.
- **SC-002 (AC-06)**: Keine Git-, Sync-, Clone-, Registry-, Propagations-,
  Paketmanager-, Pull- oder Bereinigungsoperation ist in der TUI implementiert;
  alle nachweisbaren Wartungsaktionen stammen aus den vorhandenen Engines.
- **SC-003 (AC-07–AC-08)**: Gueltige Ereignisse steuern Live-Status; jede
  ungueltige oder unvollstaendige Ereignisfolge degradiert reproduzierbar zur
  linearen Ausgabe, ohne Engineergebnis zu veraendern.
- **SC-004 (AC-09, AC-15–AC-16)**: Exitcodes `0`, `1`, `2`, `3`, `130`,
  `PARTIAL/1` und jeder Ergebniswiderspruch werden korrekt und textuell
  unterscheidbar dargestellt.
- **SC-005 (AC-10)**: Cache-Treffer, geaenderter Fingerprint, fehlendes SDK,
  Offline-Restore, Buildfehler und nicht nutzbarer Cache besitzen
  deterministische, sichere Tests ohne eingecheckte Binaerdateien.
- **SC-006 (AC-11)**: Alle Bedienfunktionen bestehen Tastatur-, `NO_COLOR`-,
  `TERM=dumb`-, schmale-Terminal-, ASCII- und lineare
  Screenreader-Snapshotpruefungen.
- **SC-007 (AC-12)**: Der exakte Lieferkandidat besteht Restore, Build, Tests,
  Dependency Audit und Wrapper-Gates auf macOS, Ubuntu und Windows.
- **SC-008 (AC-13–AC-14)**: Feature 009 und Features 015 bis 017 bleiben
  nachweislich abgeschlossen; Intake Review und Series `38/3/45` bleiben
  hashkonsistent und Position 4 war beim Start der einzige `Eligible`-Kandidat.
- **SC-009 (AC-17–AC-21)**: Freshness-Reihenfolge, Mutation Barrier,
  Pull-Klassen, Lease-Zustaende, dynamische Profile sowie Preview-, Resume-,
  Eingabe-, Umgebungs- und Abschlussvertraege regressieren nicht.
- **SC-010 (AC-22)**: Weder Tests noch reale Laufpfade erzeugen in einem
  Ziel-Repository Commit, Push, PR, Merge, breite Bereinigung oder
  Administratoraktion.
- **SC-011**: Mindestens eine positive und jede benannte negative
  Fake-Engine-Grenze besitzt einen expliziten Test mit erwarteter
  Status-/Exitentscheidung.
- **SC-012**: Ein nicht leerer Feature-PR besteht alle lokalen und
  plattformspezifischen Gates am exakten Head, besitzt null umsetzbare Threads
  und endet nach Merge auf sauberem `main` mit `HEAD == origin/main`.

### Acceptance Traceability

| Intake criterion | Covered by |
|---|---|
| AC-01–AC-05 | FR-001–FR-008, SC-001 |
| AC-06 | FR-009–FR-010, SC-002 |
| AC-07–AC-08 | FR-011–FR-017, SC-003 |
| AC-09 | FR-030–FR-032, SC-004 |
| AC-10 | FR-018–FR-021, SC-005 |
| AC-11 | FR-022–FR-026, SC-006 |
| AC-12 | FR-021, FR-033, SC-007 |
| AC-13–AC-14 | GR-007–GR-008, SC-008 |
| AC-15–AC-16 | FR-016–FR-017, FR-031, SC-004 |
| AC-17–AC-21 | FR-022, FR-033, SC-009 |
| AC-22 | FR-027–FR-030, FR-034, SC-010 |

## Assumptions and Dependencies

- Feature 009 und Features 015 bis 017 bleiben unveraendert abgeschlossen.
- Die vorhandenen Bash- und PowerShell-Wartungs-Engines sind die kanonische
  fachliche Implementierung.
- .NET 10 ist nur fuer die erweiterte TUI erforderlich; der Plaintext- und
  Headless-Pfad bleibt ohne dieses SDK benutzbar.
- Die offizielle NuGet-Metadatenquelle, MIT-Lizenz und der gepinnte Upstream-
  Stand fuer Spectre.Console `0.57.2` bleiben bis zum Locked Restore
  verifizierbar.
- Nutzerseitige Dokumentation richtet sich an Fachinformatiker*innen,
  IT-System-Management und Digitalisierungsmanagement ab dem ersten
  Ausbildungsjahr und setzt keine Spec-Kit-Erfahrung voraus.

## Out of Scope

- Desktop- oder Weboberflaeche, Mauspflicht oder grafische Dashboards.
- Ersatz oder zweite Implementierung der Wartungs-Engines.
- Automatische Zielrepository-Commits, Pushes, PRs, Merges oder Admin-
  Elevation.
- Breites `git clean`, Reset, Stash oder rekursives Loeschen in
  Nutzer-Checkouts.
- Erneute Umsetzung der Features 015 bis 017.
- Start des naechsten Intake- oder Spec-Kit-Laufs.
