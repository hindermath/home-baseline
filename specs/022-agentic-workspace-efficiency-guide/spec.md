# Feature Specification: Agentic Workspace Efficiency Guide

**Feature Branch**: `022-agentic-workspace-efficiency-guide`
**Created**: 2026-08-01
**Status**: Ready for Planning
**Binding Intake**: `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.md`
**Delivery Mode**: `MergeAndSync`

## User Scenarios & Testing *(mandatory)*

### User Story 1 - Sicherer erster Wartungslauf (Priority: P1)

Lernende und neue Nutzende finden ohne Spec-Kit-Vorwissen einen kurzen,
textorientierten Einstieg. Sie verstehen die Begriffe Quelle, Home Runtime,
Pruefung und Vorschau und koennen einen schreibfreien Wartungscheck auswaehlen,
ausfuehren und dessen Ergebnis erklaeren.

**Why this priority**: Ein sicherer Erstlauf verhindert ungewollte Mutationen
und bildet die Grundlage fuer alle weiteren Leserpfade.

**Independent Test**: Eine Person aus dem ersten Ausbildungsjahr folgt nur dem
Einstiegspfad, waehlt den passenden Plattformbefehl und benennt Ergebnis,
Nebenwirkung und naechste Aktion korrekt.

**Acceptance Scenarios**:

1. **Given** ein sauberer Level-0-Checkout, **When** eine lernende Person den
   ersten Leserpfad nutzt, **Then** erreicht sie einen schreibfreien Check vor
   jeder Vorschau oder Mutation.
2. **Given** ein blockierender Befund, **When** die Person Report und Exitcode
   liest, **Then** kann sie den Sperrgrund und die exakte naechste Aktion ohne
   farb- oder symbolabhaengige Information nennen.

---

### User Story 2 - Regelmaessiger sicherer Betrieb (Priority: P2)

Taegliche Nutzende koennen Check, Vorschau und echten Wartungslauf klar
unterscheiden, die Remote-Freshness- und Arbeitsbaumgrenzen bewerten und den
kanonischen Report mit Exitcode und Run-ID verbinden.

**Why this priority**: Der wiederholte Betrieb benoetigt einen kurzen,
reproduzierbaren Ablauf ohne Umgehung von Sicherheits- oder Qualitaetsgates.

**Independent Test**: Der Betriebsleitfaden reicht aus, um fuer Clean, Dirty,
Ahead, Behind, Diverged, Detached und Non-Default die erlaubte Aktion zu
bestimmen.

**Acceptance Scenarios**:

1. **Given** ein ausschliesslich zurueckliegendes, sauberes Default-Branch-
   Repository, **When** die Klassifikation gelesen wird, **Then** ist nur ein
   Fast-forward-Pull als zulaessige Aktualisierung beschrieben.
2. **Given** ein Dirty- oder Diverged-Zustand, **When** der Ablauf angewendet
   wird, **Then** bleiben Pull und Folge-Mutationen gesperrt, waehrend der
   Flottenbefund weiter vollstaendig erfasst wird.

---

### User Story 3 - Maintainer- und KI-Agenten-Handoff (Priority: P3)

Maintainer und KI-Agenten bestimmen aus Distributionsklasse, Authority und
Evidence den kanonischen Arbeitsort, serialisieren gemeinsame Schreibflaechen
und uebergeben Drift-Reparaturen getrennt an Branch, Review und PR.

**Why this priority**: Effizienz entsteht nur, wenn bereits gueltige Evidence
weiterverwendet und fehlende Berechtigung nicht geraten wird.

**Independent Test**: Ein wiederverwendbarer Prompt enthaelt Ziel, Scope,
Authority, Evidence, Stop-Grenzen und Abschlusszustand und erlaubt keine
implizite Remote-, Admin- oder Secret-Autoritaet.

**Acceptance Scenarios**:

1. **Given** eine `sourceOnly`-Aenderung, **When** der Abschlussweg bestimmt
   wird, **Then** ist kein Home-Sync erforderlich.
2. **Given** eine `homeRuntime`-Aenderung, **When** `MergeAndSync` abgeschlossen
   wird, **Then** wird erst der gemergte Source-Stand geprueft und danach
   kontrolliert lokal synchronisiert.

---

### User Story 4 - Fehleranalyse und Audit (Priority: P4)

Reviewer und Auditierende koennen Logs, Reports, Run-ID, Lock, Unterbrechung,
Fallback und Wiederaufnahme bis zur aktuellen Quelle zurueckverfolgen.

**Why this priority**: Ein gruenes Gesamtsignal allein beweist weder den
ausgefuehrten Befehl noch die Plattform- oder Proof-Grenze.

**Independent Test**: Die Quellenmatrix ordnet jede dokumentierte Option,
Statusklasse, Evidence-Datei und naechste Aktion genau einer aktuellen Quelle
oder einer ausdruecklich historischen Grenze zu.

**Acceptance Scenarios**:

1. **Given** eine unterbrochene Wartung, **When** der Diagnosepfad genutzt wird,
   **Then** wird kein erfolgreicher Endzustand angenommen und die sichere
   Wiederaufnahme beginnt mit Status- und Evidence-Pruefung.
2. **Given** widerspruechliche Dokumentation und Skriptoberflaeche, **When** die
   Quellenrangfolge angewendet wird, **Then** gilt die aktuelle kanonische
   Implementierung und der Widerspruch blockiert die Freigabe.

### Edge Cases

- Eine Option ist in einem alten README-Abschnitt vorhanden, aber nicht in der
  aktuellen Skriptoberflaeche: Sie wird nicht als unterstuetzt dokumentiert.
- Bash und PowerShell verwenden unterschiedliche Schreibweisen, aber gleiche
  Semantik: Die Plattformbeispiele bleiben getrennt und der Vertrag wird
  gemeinsam beschrieben.
- Ein Report fehlt, der Prozess liefert aber Exitcode 0: Die fehlende erwartete
  Evidence verhindert einen dokumentierten Erfolg.
- Live-Evidence ist unvollstaendig oder `EVENT_STREAM_DEGRADED`: Der kanonische
  Abschlussreport und dessen Proof-Grenze bleiben massgeblich.
- Die Quelle ist nicht erreichbar oder der Arbeitsbaum ist nicht sicher
  aktualisierbar: Der Leitfaden beschreibt einen fail-closed Abschluss.
- Eine behauptete Effizienzsteigerung besitzt keine Mess- oder Feldevidence:
  Die Behauptung wird entfernt oder als unbelegt gekennzeichnet.
- Eine Automatisierungsluecke erfordert Skriptaenderungen: Sie wird als eigener,
  nicht leerer Follow-up-Intake erfasst und nicht in Feature 022 behoben.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Das Feature MUST synchron gepflegte deutsche und englische
  Leitfaeden mit vier getrennten Leserpfaden bereitstellen.
- **FR-002**: Jeder Leserpfad MUST Zielgruppe, benoetigtes Vorwissen,
  Erstbegriffe, Sicherheitsgrenze und sichere erste Aktion nennen.
- **FR-003**: Jede dokumentierte Option, Statusklasse und jeder Exitcode MUST
  gegen eine aktuelle kanonische Quelle geprueft sein.
- **FR-004**: Check, Vorschau und echter Lauf MUST nach Nebenwirkung,
  Autorisierung, Ergebnis und naechster Aktion unterscheidbar sein.
- **FR-005**: Jeder ausfuehrbare Beispielbefehl MUST Plattform,
  Arbeitsverzeichnis, Voraussetzung, Nebenwirkung und erwartetes Ergebnis
  nennen oder unmittelbar auf diese Angaben verweisen.
- **FR-006**: Remote-Freshness und die Klassen Clean, Dirty, Ahead, Behind,
  Diverged, Detached und Non-Default MUST textorientiert erklaert werden.
- **FR-007**: Die Begriffe Level-0-Quelle, Home Runtime, `homeRuntime`,
  `sourceOnly` und `machineLocal` MUST ohne vorausgesetztes Level-Modell-Wissen
  definiert werden.
- **FR-008**: Fuer jede Distributionsklasse MUST kanonischer Aenderungsort,
  Leseort, Sync-Trigger, lokaler Commit und Remote-Grenze dokumentiert sein.
- **FR-009**: Direkte Aenderungen unter `~/`, lokale Home-Commits und Force-Sync
  MUST von kanonischer Source-Lieferung getrennt werden.
- **FR-010**: Die aktuelle Runtime-Menge MUST aus Manifest und Resolver
  abgeleitet werden; eine zweite statische Vollstaendigkeitsliste ist
  unzulaessig.
- **FR-011**: Host-Sync, Sandbox-Referenz und Containerpfad MUST mit ihren
  Schreib- und Autoritaetsgrenzen erklaert werden.
- **FR-012**: Die drei Delivery-Modi MUST mit ihren jeweiligen Remote-Grenzen
  beschrieben werden; fehlende Autoritaet darf nicht aus Historie abgeleitet
  werden.
- **FR-013**: Eine wiederverwendbare KI-Agenten-Checkliste MUST Ziel, Scope,
  Authority, Evidence, Stop-Grenzen und Abschlusszustand abdecken.
- **FR-014**: Serielle und parallele Arbeit MUST anhand gemeinsamer
  Schreibflaechen, Evidence und Versionsdateien erklaert werden.
- **FR-015**: Logs, JSON-Reports, Run-ID, Live-Evidence und Exitcodes MUST einen
  Diagnose- und Aufbewahrungsweg erhalten.
- **FR-016**: Lock, unerwartete Unterbrechung, genau einmaliges `Ctrl+C`,
  Statuspruefung und sichere Wiederaufnahme MUST ohne Erfolgsannahme beschrieben
  werden.
- **FR-017**: Enhanced-, Plain- und Headless-Modus sowie
  `EVENT_STREAM_DEGRADED` MUST mit ehrlichen Fallback- und Proof-Grenzen
  beschrieben werden.
- **FR-018**: Drift-Reparatur MUST in einem getrennten Branch-/Review-/PR-
  Handoff enden; der Wartungslauf selbst committet oder pusht Ziel-Repositories
  nicht.
- **FR-019**: Administrator-, Secret-, Sandbox- und Providergrenzen MUST
  fail-closed dokumentiert sein.
- **FR-020**: Effizienzbehauptungen MUST Mess-, Feld- oder Ablauf-Evidence
  besitzen; Geschwindigkeit bleibt ein Sekundaerindikator.
- **FR-021**: Nicht sicher dokumentierbare Automatisierungsluecken MUST als
  getrennte Follow-ups mit Owner, Risiko, Evidence und Wiedervorlage erfasst
  werden.
- **FR-022**: Root-Portale, vier Leserpfade, Leitfaeden, Manpages und
  Skriptreferenz MUST in beiden Sprachen widerspruchsfrei navigierbar sein.
- **FR-023**: Eine maschinenlesbare Quellenmatrix MUST jede betriebliche
  Behauptung einer aktuellen Quelle oder historischen Grenze zuordnen.
- **FR-024**: Ein deterministischer Validator MUST Vollstaendigkeit,
  Eindeutigkeit, aktuelle Hashes, Sprachpartner und erlaubte Statuswerte der
  Quellenmatrix pruefen.
- **FR-025**: Der Validator MUST negative Fixtures fuer fehlende, doppelte,
  veraltete und widerspruechliche Zuordnungen ablehnen.
- **FR-026**: Nutzertexte MUST Deutsch zuerst, Englisch danach, CEFR B2,
  Erklaerung von Fachbegriffen beim ersten Auftreten und WCAG 2.2 AA erfuellen.
- **FR-027**: Status, Abhaengigkeiten und Entscheidungen MUST ohne
  ausschliesslich visuelle Darstellung verstaendlich sein.
- **FR-028**: Das Feature MUST dokumentieren, welche Dateien `sourceOnly` sind
  und ob Home-Sync beim Closeout erforderlich ist.
- **FR-029**: Das Feature MUST alle Aussagen gegen Features 018 bis 021, die
  aktuelle Skriptreferenz, Manpages oder reproduzierbare Reports pruefen.
- **FR-030**: Das Feature MUST genau eine Documentation-Impact-Entscheidung je
  gepruefter Dokumentfamilie mit Owner, Evidence und Re-evaluation Trigger
  erfassen.
- **FR-031**: Das Feature MUST ohne Aenderung an Skript-, Runtime-, Registry-,
  Toolchain-, Preset- oder Flottenverhalten abgeschlossen werden und darf D7
  nicht automatisch starten.

### Constitution Requirements *(mandatory)*

- **CR-001**: Documentation Impact ist `UpdateRequired` fuer Lernenden-,
  Nutzenden-, Maintainer-/Agenten- und Auditpfade; kanonische Quellen sind die
  D6-Leitfaeden und die Quellenmatrix, Owner ist der Level-0-Maintainer.
- **CR-002**: A11Y Governance ist anwendbar; WCAG 2.2 AA, text-first Evidence,
  Tastatur-/Screenreader-/Braille-/Textbrowser-Nutzbarkeit und bilinguale
  Sprachpartner werden geprueft.
- **CR-003**: Security Governance ist fuer sichere Befehls-, Secret-, Admin-,
  Sandbox- und Providergrenzen anwendbar. NIST SSDF und CWE Top 25 werden als
  Dokumentationspruefpunkte behandelt; OWASP ASVS ist `N/A`, weil kein Web-,
  API-, Auth- oder Laufzeitdienst geaendert wird.
- **CR-004**: SBOM, VEX, AI-SBOM, SLSA und OpenSSF-Produktnachweise sind `N/A`,
  weil keine Abhaengigkeit, kein Release-Artefakt und keine AI-Runtime
  entsteht; bei Scope-Aenderung ist neu zu bewerten.
- **CR-005**: NIS2, CRA, EU AI Act und DORA sind fuer dieses reine
  Dokumentationsfeature `N/A`; Sicherheits- oder Produktgrenzenaenderungen
  loesen eine Neubewertung aus.
- **CR-006**: Architecture und iSAQB Governance pruefen Informationsarchitektur,
  Leserpfade und Source-of-truth-Beziehungen. STRIDE/CIA/CAPEC, Zero Trust,
  S-ADR, arc42, SAMM, BSI C3A und BSI C5 sind mangels Runtime-, Cloud-,
  Deployment- oder Trust-Boundary-Aenderung `N/A`.
- **CR-007**: Cross-Platform Governance ist fuer plattformspezifische
  Dokumentationsbeispiele und Evidence anwendbar, fuer neue oder geaenderte
  Skriptpaare jedoch `N/A`.
- **CR-008**: Agent Parity prueft alle gepflegten Agentenoberflaechen; eine
  Aenderung ist nur erforderlich, wenn eine neue gemeinsame normative Regel
  entsteht. `.specify/templates/` sind ohne Regel- oder Workflowaenderung `N/A`.
- **CR-009**: Die primaere Implementationsform ist Markdown und JSON-Evidence;
  MSL-Bewertung ist `N/A`, weil kein ausfuehrbarer Produktcode erzeugt wird.
- **CR-010**: Projektstatistik wird nach Implementierung und Delivery
  deterministisch aktualisiert; `sourceOnly`-Dokumentation allein loest keinen
  Home-Sync aus.

### Key Entities

- **Reader Path**: Zielgruppenbezogener Einstieg mit Zweck, Voraussetzungen,
  sicherer erster Aktion und weiterfuehrenden Quellen.
- **Operational Claim**: Dokumentierte Aussage zu Option, Status, Exitcode,
  Evidence oder naechster Aktion mit genau einer aktuellen Quelle.
- **Source Matrix Entry**: Maschinenlesbare Zuordnung aus Claim-ID, Leserpfad,
  Plattform, Quelle, Hash, Proof-Grenze und Re-evaluation Trigger.
- **Distribution Class**: `homeRuntime`, `sourceOnly` oder `machineLocal` mit
  Aenderungs-, Sync-, Commit- und Remote-Grenzen.
- **Documentation Impact Decision**: Genau eine Entscheidung pro gepruefter
  Dokumentfamilie mit Owner, Evidence, Restrisiko und Wiedervorlage.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: Alle vier Leserpfade existieren in synchronen deutschen und
  englischen Fassungen und sind von beiden Root-Portalen mit funktionierenden
  Links erreichbar.
- **SC-002**: 100 Prozent der dokumentierten Optionen, Statusklassen,
  Exitcodes, Evidence-Dateien und naechsten Aktionen besitzen genau eine
  gueltige primaere Quellenmatrix-Zeile.
- **SC-003**: Eine Erstlernenden-Pruefung kann Check, Vorschau und echten Lauf
  sowie deren Nebenwirkungen ohne Spec-Kit-Vorwissen korrekt unterscheiden.
- **SC-004**: Alle sieben Arbeitsbaumklassen besitzen eine eindeutige erlaubte
  oder gesperrte Aktion mit textlichem Grund und naechstem Schritt.
- **SC-005**: Deutsche und englische Inhalte weisen null materielle
  Informations- oder Navigationsabweichungen auf.
- **SC-006**: Positive Quellenmatrix-Validierung besteht; jede definierte
  negative Fixture scheitert mit der erwarteten Fehlerklasse.
- **SC-007**: Link-, A11Y-, Secret-, Homogeneity-, Plattform- und
  Documentation-Impact-Pruefungen melden null offene Critical- oder High-
  Befunde.
- **SC-008**: Der finale Diff enthaelt null Aenderungen an ausfuehrbarem
  Wartungsverhalten, Abhaengigkeiten, Registry, Presets oder Ziel-Repositories.
- **SC-009**: Jede nicht im Dokumentationsscope behebbare Luecke besitzt einen
  getrennten Follow-up-Nachweis oder es ist explizit belegt, dass keine solche
  Luecke gefunden wurde.
- **SC-010**: Feature 022 endet auf sauberem, synchronem `main`; D7 wurde im
  Produktlauf nicht automatisch gestartet.

## Assumptions

- Features 018 bis 021 und deren Merge-Evidence bilden die verbindliche
  technische und dokumentarische Baseline.
- Die installierte Elf-Preset-Matrix bleibt unveraendert.
- Aktuelle Skripte, `--help`-Ausgaben, Manpages und reproduzierbare Reports
  haben Vorrang vor historischer README-Evidence.
- Eine kleine, test-only Quellenmatrix-Pruefung ist zulaessig, sofern sie kein
  Betriebsverhalten veraendert.
- Dokumentationsbeispiele verwenden nur sichere Check-, Vorschau- oder
  kontrollierte Testpfade.
- Der kausale Closeout nach dem Produkt-Merge darf D6 archivieren, D7 gegen die
  tatsaechliche Merge-Evidence aktualisieren und als naechsten Kandidaten
  freigeben; er startet Feature 023 nicht innerhalb des Feature-022-Laufs.

## Out of Scope

- Aenderungen an Wartungs-, Sync-, Registry-, Toolchain- oder TUI-Code.
- Paket-, Preset-, Workflow- oder Flottenverteilung.
- Absolute Laufzeit- oder Produktivitaetsgarantien.
- Implizite Remote-, Admin-, Secret- oder Providerrechte.
- Automatischer Start von D7 oder eines anderen Folgefeatures.
