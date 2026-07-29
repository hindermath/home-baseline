# Feature Specification: Preset-Profil-, Default-Branch- und Worktree-Härtung

**Feature Branch**: `017-preset-profile-worktree-hardening`
**Created**: 2026-07-29
**Status**: Draft
**Binding Input**: `Lastenheft_Preset-Profil-Default-Branch-und-Worktree-Haertung.md` v1.3
**Delivery Mode**: `MergeAndSync`

## User Scenarios & Testing

### User Story 1 - Vollständige Remote-Freshness-Barriere (Priority: P1)

Als Workspace-Maintainer möchte ich vor jeder fachlich mutierenden
Wartungsphase einen vollständigen Überblick über Level 0, alle registrierten
Git-Ziele und die getrennte Collection erhalten, damit keine Reparatur auf
veralteten oder nur teilweise geprüften Remote-Ständen beginnt.

**Why this priority**: Ein unvollständiger Flottenstand kann nachfolgende
Home-, Preset-, Registry-, Propagation- oder Toolchain-Änderungen auf einer
falschen Grundlage ausführen.

**Independent Test**: Ein Mehr-Repository-Szenario mit sicheren und
blockierten Zielen belegt, dass alle Fetch-Versuche und Statuszeilen vor der
ersten fachlichen Mutation abgeschlossen werden und ein Einzelbefund die
Bestandsaufnahme der übrigen Flotte nicht beendet.

**Acceptance Scenarios**:

1. **Given** Level 0, 43 aktive Git-Ziele und eine Collection, **When** der
   Wartungslauf beginnt, **Then** erhält jedes Git-Ziel einen begrenzten
   Fetch-Versuch und die Collection eine getrennte read-only Inventur.
2. **Given** das erste Ziel ist nicht synchronisierbar, **When** weitere Ziele
   geprüft werden, **Then** werden deren Fetches und Befunde trotzdem
   vollständig erfasst, während fachliche Mutationen gesperrt bleiben.
3. **Given** Kontroll-Evidence wie Lock, Log oder Bericht wurde angelegt,
   **When** die Freshness-Barriere noch offen ist, **Then** gilt diese
   Evidence nicht als Freigabe für Home-, Repository- oder Toolchain-Mutation.

---

### User Story 2 - Sichere Branch- und Pull-Entscheidung (Priority: P1)

Als Maintainer möchte ich den kanonischen Default-Branch unabhängig von seinem
Namen bestimmen und nur eindeutig sichere Fast-forward-Fälle aktualisieren,
damit weder ein Branch geraten noch ein lokaler Zustand überschrieben wird.

**Why this priority**: Falsch aufgelöste Branches und unsichere Pulls können
Nutzerarbeit verändern oder eine Preset-Prüfung fälschlich als aktuell
ausweisen.

**Independent Test**: Repositories mit `trunk`, fehlendem lokalem
`origin/HEAD`, Dirty, Ahead, Behind, Diverged, Detached, fehlendem Upstream und
nicht erreichbarem Remote ergeben jeweils die festgelegte Pull- oder
Sperrentscheidung, ohne Index oder Arbeitsdateien unzulässig zu verändern.

**Acceptance Scenarios**:

1. **Given** der lokale Remote-HEAD fehlt und der Remote meldet `trunk`,
   **When** die Branch-Auflösung läuft, **Then** wird `origin/trunk` am
   erwarteten Commit belegt und kein bekannter Branchname geraten.
2. **Given** ein sauberer kanonischer Default-Branch ist nur Behind,
   **When** die Pull-Entscheidung erfolgt, **Then** wird ausschließlich
   Fast-forward verwendet und der Zustand endet bei Ahead/Behind `0/0`.
3. **Given** ein Ziel ist Dirty, Ahead, Diverged, Detached, auf einem anderen
   Branch oder ohne eindeutigen Upstream, **When** es inventarisiert wird,
   **Then** darf der Fetch stattfinden, Pull und Folgeaktionen bleiben jedoch
   mit genauer Begründung gesperrt.

---

### User Story 3 - Eigentumsgebundene Worktree-Wiederherstellung (Priority: P1)

Als Maintainer möchte ich temporäre Prüf-Worktrees nach normalem Ende oder
hartem Abbruch gezielt bereinigen, damit verwaiste eigene Ressourcen
verschwinden, ohne aktive, fremde oder manipulierte Pfade zu gefährden.

**Why this priority**: Eine breite Bereinigung in Nutzer-Checkouts oder bei
unklarer Eigentümerschaft kann Datenverlust verursachen.

**Independent Test**: Eigene aktive und verwaiste Leases sowie fremde,
manipulierte, außerhalb des reservierten Bereichs liegende und durch
PID-Wiederverwendung mehrdeutige Leases werden reproduzierbar unterschieden.

**Acceptance Scenarios**:

1. **Given** ein normal beendeter Prüflauf, **When** der Abschluss erfolgt,
   **Then** bleiben weder Lease, temporärer Pfad noch zusätzliche
   Git-Worktree-Registrierung zurück.
2. **Given** ein eigener, konsistenter und verwaister Lease, **When** der
   nächste Lauf startet, **Then** wird genau dieser Worktree entfernt und ein
   zweiter Lauf ist ein No-op.
3. **Given** eine aktive, fremde, manipulierte oder mehrdeutige Lease,
   **When** die Wiederherstellung prüft, **Then** bleibt sie unangetastet und
   erzeugt einen textorientierten Sperrgrund.
4. **Given** eine Zustandsänderung macht weitere unversionierte Pfade sichtbar,
   **When** eine alte Kandidatenliste vorliegt, **Then** wird nicht bereinigt,
   bis eine neue exakte Inventur die einzelnen Pfade freigibt.

---

### User Story 4 - Dynamische Profile und ehrliche Registry-Befunde (Priority: P1)

Als Governance-Maintainer möchte ich Presets aus dem Profilkatalog statt aus
einer festen Anzahl auflösen und widersprüchliche MSL-Angaben sichtbar machen,
damit neue optionale Presets ohne Codeänderung funktionieren und kuratierte
Registry-Daten nicht still überschrieben werden.

**Why this priority**: Eine feste Preset-Anzahl und stille Registry-Reparaturen
lassen Flottenprüfungen altern oder verändern Governance-Entscheidungen ohne
Owner-Freigabe.

**Independent Test**: Das aktuelle Elf-Preset-Profil und ein synthetisch
erweitertes Profil bestehen unverändert; bekannte MSL- und Nicht-MSL-Konflikte
werden gemeldet, während korrekte und begründete Einträge bytegleich bleiben.

**Acceptance Scenarios**:

1. **Given** ein gültiger Profilkatalog mit elf oder mehr Presets, **When** die
   Profilprüfung läuft, **Then** wird die tatsächliche Katalogmenge vollständig
   verwendet, ohne fest eincodierte Obergrenze.
2. **Given** `cc65`, C oder C++ ist als `msl` eingetragen, **When** die Registry
   geprüft wird, **Then** entsteht ein Governance-Befund ohne automatische
   Änderung.
3. **Given** `cc65/non-msl`, `C#/msl` oder ein begründeter
   `msl-mixed-tooling`-Eintrag, **When** dieselbe Prüfung läuft, **Then** bleibt
   der Wert akzeptiert und bytegleich.

---

### User Story 5 - Plattformgleiche und zugängliche Evidence (Priority: P1)

Als ausführende oder lernende Person möchte ich auf macOS, Linux und Windows
dieselben Statusklassen, Grenzen und nächsten Aktionen in verständlicher
Textform erhalten, damit Wartung ohne Farbwahrnehmung oder Vorwissen über
Spec Kit nachvollziehbar bleibt.

**Why this priority**: Abweichende Plattformsemantik oder nur visuelle
Signale machen Sicherheits- und Wiederanlaufentscheidungen unzuverlässig.

**Independent Test**: Semantisch gleiche Bash- und PowerShell-Fixtures ergeben
dieselben Statusklassen und Exitcodes; Nutzertexte sind Deutsch zuerst,
Englisch danach, CEFR B2, textorientiert und ohne private absolute Pfade.

**Acceptance Scenarios**:

1. **Given** identische positive und negative Fixtures, **When** Bash und
   PowerShell sie auswerten, **Then** stimmen semantische Statusklassen,
   Barriereentscheidungen und Exitcodes überein.
2. **Given** ein Netzwerkversuch endet durch Timeout oder ausgeschöpfte
   Retries, **When** der Bericht entsteht, **Then** nennt er Versuchszahl,
   Dauer, finalen Status und nächste Aktion und meldet niemals implizit Erfolg.
3. **Given** ein technischer Befund, **When** er ausgegeben oder dokumentiert
   wird, **Then** ist seine Bedeutung vollständig durch Text erfassbar und
   enthält keine veröffentlichbaren persönlichen absoluten Pfade.

### Edge Cases

- Der Remote-HEAD verweist auf einen Ref, der nach dem Fetch fehlt oder einen
  anderen Commit besitzt.
- Ein Fetch endet ohne verwertbare Ausgabe, läuft in ein Timeout oder scheitert
  erst nach einem Retry.
- Ein Repository wechselt während der Inventur seinen Zustand oder Default-Head.
- Ein PID-Wert wurde wiederverwendet, obwohl der alte Lease noch existiert.
- Lease, Repository, registrierter Worktree und Pfad stimmen nur teilweise
  überein oder verlassen den reservierten State-Bereich.
- Nach einem Zustandswechsel werden zusätzliche unversionierte Dateien sichtbar.
- Ein Profil wird um ein weiteres optionales Preset ergänzt.
- Ein kuratierter Registry-Eintrag widerspricht der bekannten Sprachklasse.
- Ein geprüfter Exact Head wird durch Integration oder einen neuen Commit
  überholt.

## Requirements

### Functional Requirements

- **FR-001 (PWH-001)**: Vor jeder Preset-Profilprüfung MUSS `origin` sicher
  aktualisiert werden; ein schmutziger Arbeitsbaum darf Fetch, aber weder Pull
  noch eine Worktree-Mutation erlauben.
- **FR-002 (PWH-002)**: Freshness-Evidence MUSS Remote, Default-Ref, exakten
  Commit und aktuelles Fetch-Ergebnis binden; ein fehlgeschlagener Fetch darf
  keinen alten Ref als aktuell ausweisen.
- **FR-003 (PWH-003)**: Default-Branches MÜSSEN zuerst aus einem gültigen
  lokalen `origin/HEAD`, sonst read-only aus dem Remote-HEAD bestimmt und nach
  Fetch am erwarteten Commit belegt werden.
- **FR-004 (PWH-004)**: Fehlender oder uneindeutiger Remote-HEAD MUSS
  fail-closed enden; Branchnamen dürfen nicht geraten werden.
- **FR-005 (PWH-005)**: Jeder temporäre Prüf-Worktree MUSS durch einen
  maschinenlokalen Lease mit Schema, Lauf-ID, PID, Repository, Remote-Ref,
  Commit, reserviertem Pfad und UTC-Startzeit gebunden sein.
- **FR-006 (PWH-006)**: Eine Hard-Abort-Bereinigung DARF nur eigene,
  konsistente und verwaiste Leases entfernen und MUSS aktive, fremde,
  manipulierte oder mehrdeutige Leases erhalten.
- **FR-007 (PWH-007)**: Normale Bereinigung und Wiederanlauf MÜSSEN idempotent
  sein und dürfen keine eigene verwaiste Registrierung hinterlassen.
- **FR-008 (PWH-008)**: Bash und PowerShell MÜSSEN semantisch identische
  positive, negative und Wiederanlauf-Fixtures mit gleichen Statusklassen und
  Exitcodes besitzen.
- **FR-009 (PWH-009)**: Bekannte MSL- und Nicht-MSL-Sprachen MÜSSEN gegen
  widersprüchliche Registry-Werte geprüft werden.
- **FR-010 (PWH-010)**: Registry-Widersprüche MÜSSEN sichtbar werden, dürfen
  kuratierte Werte aber nicht automatisch überschreiben.
- **FR-011 (PWH-011)**: Evidence MUSS den geprüften Ref, Commit, Freshness,
  Lease- oder Konfliktzustand, Folgeaktionsbarriere und nächste Aktion
  textorientiert dokumentieren.
- **FR-012 (PWH-012)**: Vor jeder fachlichen Mutation MUSS ein vollständiger
  Freshness-Preflight Level 0 und alle 43 aktiven Manifest-Git-Ziele
  einschließlich Preset-Repositories prüfen; die Collection bleibt getrennt.
- **FR-013 (PWH-013)**: `pull --ff-only` DARF nur bei sauberem kanonischem
  Default-Branch, eindeutigem Upstream, `ahead=0` und reinem Behind-Zustand
  ausgeführt werden.
- **FR-014 (PWH-014)**: Home Sync, Registry- oder Preset-Reparatur,
  Propagation, Paketmanager-, Toolchain- und sonstige fachliche Mutationen
  MÜSSEN bis zum vollständigen und erfolgreichen Preflight fail-closed
  gesperrt bleiben.
- **FR-015 (PWH-015)**: Der Flottenbericht MUSS Repository, Branch,
  Remote-Ref, Commit, Fetch, Ahead/Behind, Pull-Entscheidung, Sperrgrund,
  Versuchszahl, Dauer und nächste Aktion enthalten.
- **FR-016 (PWH-016)**: Presets MÜSSEN dynamisch aus dem Profilkatalog
  aufgelöst werden; elf Presets sind Evidence, keine Code-Obergrenze.
- **FR-017 (PWH-017)**: Preview, einmalige Ergebnisbewertung,
  Required-Drift-Aggregation, Eingabe- und Umgebungsisolation,
  Plattformgrenzen und Exact-Head-Verträge aus Features 015/016 DÜRFEN nicht
  regressieren.
- **FR-018 (PWH-018)**: Breite Checkout-Bereinigung, Reset, Stash und
  rekursives Löschen sind unzulässig; nach Zustandsänderungen MUSS die exakte
  Kandidatenmenge neu inventarisiert werden.
- **FR-019 (PWH-019)**: Netzwerkoperationen MÜSSEN begrenzte Versuche und Dauer
  sowie finalen Status dokumentieren; Timeout oder stille Ausgabe dürfen
  niemals als Erfolg gelten.
- **FR-020 (PWH-020)**: Der Wartungslauf DARF in Ziel-Repositories weder
  committen, pushen, Pull Requests erstellen noch mergen.

### Constitution and Governance Requirements

- **GR-001**: NIST SSDF, CWE Top 25 und sichere Datei-, Prozess-, Netzwerk- und
  Git-Grenzen sind anwendbar. OWASP ASVS, SBOM, VEX, AI-SBOM, SLSA, OpenSSF
  Scorecard, NIS2, CRA, EU AI Act und DORA sind mangels Webanwendung,
  Lieferkettenänderung, Produktrelease oder reguliertem Dienst `N/A`; sie
  werden neu bewertet, falls dieser Scope entsteht.
- **GR-002**: STRIDE/CIA/CAPEC sind begrenzt auf Remote-, Pfad-, Prozess-,
  Lease- und Trust-Boundary-Risiken anwendbar. S-ADR und arc42-Evidence werden
  im Plan aktualisiert. Zero Trust, BSI C3A und BSI C5 sind ohne Identitäts-,
  Cloud- oder Providerarchitektur `N/A`; SAMM wird als Prozessnachweis
  berücksichtigt.
- **GR-003**: Die Architekturplanung MUSS Laufzeitkontext, Sequenz der
  Freshness-Barriere, Qualitätsziele, Fehlergrenzen und technische Schulden
  nachvollziehbar dokumentieren.
- **GR-004**: CLI, Help, Manpages und Evidence MÜSSEN Deutsch zuerst, Englisch
  danach, CEFR B2, WCAG 2.2 AA, textorientiert und ohne ausschließlich visuelle
  Bedeutung bereitstellen.
- **GR-005**: Jede geänderte Skriptfunktion MUSS in Bash und PowerShell
  semantisch gleichwertig sein; Unix-Manpage, bilinguale PowerShell-Hilfe,
  `--check-only`, `--dry-run` und `-WhatIf` werden gemeinsam geprüft.
- **GR-006**: Gemeinsame Guidance, Constitution und Spec-Kit-Templates werden
  nur bei tatsächlicher Vertragsänderung synchron auf allen gepflegten
  Agentenflächen geändert; andernfalls wird `NoUpdateRequired` begründet.
- **GR-007**: Intake Authoring, Intake Review und Intake Sequencing sind
  bindende Eingabe-Evidence, werden aber durch Feature 017 nicht
  weiterentwickelt. Parallel Autonomous ist mangels Kampagne `N/A`.
- **GR-008**: `MergeAndSync` autorisiert nur die Feature-017-Lieferung in Home
  Baseline. Der enge Admin-Bypass ist nur bei grünen technischen Gates, null
  umsetzbaren Threads und Human Approval als einzigem offenen Gate zulässig.

### Key Entities

- **Fleet Target**: Registriertes Git-Ziel mit Pfad, Rolle, Remote, Branch,
  Upstream, Commit, Ahead/Behind und Freshness-Status.
- **Collection Target**: Nicht als Git-Repository behandeltes Ziel mit eigener
  read-only Inventur.
- **Freshness Attempt**: Begrenzter Netzwerkversuch mit Nummer, Dauer, Ergebnis
  und nächster Aktion.
- **Mutation Barrier**: Flottenweiter Zustand, der fachliche Folgephasen erst
  nach vollständigem erfolgreichen Preflight freigibt.
- **Default Branch Evidence**: Symbolischer Remote-HEAD, Tracking-Ref und
  exakter Commit als zusammengehöriger Nachweis.
- **Worktree Lease**: Maschinenlokaler Eigentumsnachweis für einen temporären
  Prüf-Worktree.
- **Cleanup Authorization**: Nach aktuellem Zustand neu berechnete Menge
  ausdrücklich eigener, einzeln freigegebener Pfade.
- **Preset Profile**: Dynamisch aus dem Profilkatalog aufgelöste Preset-Menge.
- **Registry Consistency Finding**: Sichtbarer, nicht automatisch reparierter
  Widerspruch zwischen Sprache und MSL-Status.

## Success Criteria

- **SC-001 (AC-001–AC-003)**: Dirty-Worktree-Fetch, `trunk`-Auflösung sowie
  alle Remote-Fehler- und Mehrdeutigkeitsfälle sind reproduzierbar,
  hashbewahrend und fail-closed nachgewiesen.
- **SC-002 (AC-004–AC-006)**: Normale, hart abgebrochene, aktive, fremde,
  manipulierte und außerhalb liegende Leases ergeben exakt die erwartete
  Bereinigung oder Sperre; ein Wiederholungslauf ist idempotent.
- **SC-003 (AC-007)**: Alle gemeinsamen Bash-/PowerShell-Fixtures liefern
  dieselben semantischen Statusklassen und Exitcodes.
- **SC-004 (AC-008–AC-010)**: Alle geforderten MSL-Konflikte werden ohne
  Registry-Mutation gemeldet; korrekte und begründete Werte bleiben akzeptiert.
- **SC-005 (AC-011–AC-012)**: Syntax-, Parser-, Analyzer-, Homogeneity-,
  Diff- und Secret-Prüfungen bestehen; Evidence erfüllt die festgelegten
  Sprach- und A11Y-Regeln.
- **SC-006 (AC-013–AC-017)**: Der Mehr-Repository-Nachweis belegt vollständige
  Fetch-Reihenfolge, sichere Fast-forward-Aktualisierung, vollständige
  Bestandsaufnahme, fail-closed Folgeaktionen und Plattformparität.
- **SC-007 (AC-018–AC-021)**: Level 0 und exakt 43 aktive Manifest-Git-Ziele
  erhalten vor Fachmutation einen Fetch-Versuch, die Collection wird getrennt
  ausgewiesen und jeder unsichere Zustand blockiert Mutation, nicht Inventur.
- **SC-008 (AC-022–AC-023)**: Neu sichtbare Pfade sowie aktive, fremde,
  manipulierte und PID-mehrdeutige Leases werden nicht mit veralteter
  Freigabe gelöscht; eigene verwaiste Leases werden idempotent entfernt.
- **SC-009 (AC-024–AC-026)**: Aktuelles und synthetisch erweitertes Profil,
  alle Feature-015/016-Regressionsfixtures sowie Timeout- und Retry-Grenzen
  bestehen ohne Code-Obergrenze oder impliziten Erfolg.
- **SC-010 (AC-027)**: Jede Änderung des geprüften Heads verwirft frühere
  Exact-Head-Evidence und erzwingt vollständige Revalidierung vor Merge.
- **SC-011**: Der Wartungsbefehl erzeugt in keinem Ziel-Repository Commit,
  Push, Pull Request oder Merge.
- **SC-012**: Feature 017 wird über einen nicht leeren, vollständig geprüften
  PR gemergt; danach ist der lokale Default-Branch sauber und exakt mit
  `origin/main` synchron, ohne Position 4 zu starten.

### Acceptance Traceability

| Intake criterion | Specification outcome |
|---|---|
| `AC-001` | `SC-001`: Dirty Fetch preserves index, files and status hash |
| `AC-002` | `SC-001`: arbitrary `trunk` default branch is resolved read-only |
| `AC-003` | `SC-001`: unreachable, absent, ambiguous or mismatched remote evidence fails closed |
| `AC-004` | `SC-002`: normal validation leaves no lease or worktree residue |
| `AC-005` | `SC-002`: owned hard-abort residue is removed once and idempotently |
| `AC-006` | `SC-002`: active, foreign, manipulated or escaped leases remain untouched |
| `AC-007` | `SC-003`: Bash and PowerShell fixture semantics and exits agree |
| `AC-008` | `SC-004`: contradictory MSL declarations become findings without mutation |
| `AC-009` | `SC-004`: correct and justified MSL declarations pass |
| `AC-010` | `SC-004`: preview modes preserve tracked files, registry and foreign worktrees |
| `AC-011` | `SC-005`: syntax, parser, analyzer, fixture, homogeneity, diff and secret gates pass |
| `AC-012` | `SC-005`: bilingual, text-first and path-safe evidence is complete |
| `AC-013` | `SC-006`: all fleet fetch attempts precede downstream mutation |
| `AC-014` | `SC-006`: safe behind-only default branch reaches `0/0` by fast-forward |
| `AC-015` | `SC-006`: all unsafe repository states block mutation without checkout changes |
| `AC-016` | `SC-006`: one early failure cannot suppress later inventory |
| `AC-017` | `SC-006`: fleet preflight and barrier semantics agree across shells |
| `AC-018` | `SC-007`: Level 0 plus 43 Git targets are attempted and the collection is separate |
| `AC-019` | `SC-007`: dirty repositories refresh refs but remain mutation-blocked |
| `AC-020` | `SC-007`: ordered operations evidence proves the full barrier |
| `AC-021` | `SC-007`: blocked states stop mutation but not later read-only audit |
| `AC-022` | `SC-008`: newly visible paths invalidate stale cleanup authority |
| `AC-023` | `SC-008`: PID reuse and ownership ambiguity preserve leases safely |
| `AC-024` | `SC-009`: current and synthetically extended profiles work without code changes |
| `AC-025` | `SC-009`: Feature 015/016 behavior and parity remain intact |
| `AC-026` | `SC-009`: timeout and exhausted retries are explicit blocking results |
| `AC-027` | `SC-010`: a changed reviewed head invalidates all prior gate evidence |

## Assumptions

- `origin` ist der kanonische Remote-Name.
- Level 0 plus 43 aktive Manifest-Git-Ziele bilden die aktuelle Menge von
  44 Git-Repositories; eine Collection ist kein Git-Ziel.
- Fetch ist bei Dirty zulässig, Worktree-Mutation bleibt dort verboten.
- Maschinenlokale Leases und temporäre Lauf-Evidence werden nicht committed.
- Der Profilkatalog ist bindend und darf künftig mehr als elf Presets enthalten.
- PWH-001 bis PWH-020 und AC-001 bis AC-027 sind vollständig und ohne offene
  materielle Klärungsfrage akzeptiert.
- Hash-Caching, pauschale Analyzer-Timeouts, Wartungs-TUI und Folgefeatures
  bleiben außerhalb dieses Features.
