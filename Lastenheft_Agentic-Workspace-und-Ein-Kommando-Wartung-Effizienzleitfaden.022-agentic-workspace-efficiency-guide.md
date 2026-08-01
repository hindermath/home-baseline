<!-- intake-authoring:begin -->
# Lastenheft: Agentic-Workspace- und Ein-Kommando-Wartung-Effizienzleitfaden

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-08-01
**Reihenfolge:** Dokumentationsvorlauf D6, nach abgeschlossenem Feature 021 (D5)
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Lernende und Nutzende ohne Spec-Kit-Vorkenntnisse, Lehrende,
Maintainer, KI-Agenten, Systemintegrator*innen und Reviewer

## 1. Zweck / Purpose

D6 erstellt eine maximal verständliche, aber gestuft aufgebaute Anleitung für
die effiziente und sichere Nutzung des agentischen Workspace und der
plattformübergreifenden Ein-Kommando-Wartung. **Agentisch** bedeutet hier:
KI-Agenten bearbeiten klar begrenzte Aufgaben unter dokumentierter
Berechtigung, Evidence und menschlicher Verantwortung.

„Effizient“ bedeutet: unnötige Wiederholungen, unklare Zustände und vermeidbare
Agentenkontextkosten reduzieren, ohne Sicherheits-, Review- oder
Qualitätsgates abzukürzen. Aussagen wie „schnellster“ oder „vollautomatisch“
benötigen Mess- oder Feldevidence.

*D6 documents the safest evidenced efficient path for the agentic workspace and
one-command maintenance. It does not change maintenance behavior; missing
automation becomes a separate follow-up.*

## 2. Voraussetzungen und Scope / Preconditions and Scope

- Aktive Positionen 1 bis 4 sowie D4 und D5 sind abgeschlossen und durch ihre
  gemergten Feature- und Closeout-Nachweise gebunden.
- Die tatsächlich gemergten Befehle, Optionen, Exitcodes und Reports sind
  verbindliche Wahrheit.
- D6 verändert keine Wartungsskripte, Registry, Toolchain oder Runtime.
- Dokumentationsbezogene Test-Helfer sind nur zulässig, wenn sie kein
  Betriebsverhalten ändern.
- Nicht dokumentierbare Automatisierungslücken werden als eigene Follow-ups
  erfasst.

### 2.1 Verbindliche gemergte Baseline / Binding Merged Baseline

D6 arbeitet gegen den nach Feature 021 tatsächlich ausgelieferten Stand:

- Feature 018 und PR #160 liefern die Maintenance-TUI und ihre Betriebsmodi.
- Feature 019 und PR #192 liefern Wrapper- und Regressionshärtung.
- Feature 020 und PR #194 liefern das read-only Dokumentationsaudit mit
  `DIA001` als einzigem Remediation-Finding.
- Feature 021 und PR #197 schließen `DIA001` durch das deutsche Root-Portal,
  `README.en.md`, vier getrennte Leserpfade, Sprachpartner und den erweiterten
  Documentation-Impact-Vertrag. Der geprüfte Head ist
  `663807ef0cd19c245fb171bc017dda5d5f84209a`, der Merge-Commit ist
  `468924a261996dd245f8f21e4e6693fd2cbe513c`.

Die Leitfäden prüfen Aussagen gegen diese gemergten Oberflächen, die
kanonischen Skripte, Manpages und Reports. Frühere README-Inhalte dienen nur
als historische Migrations-Evidence und dürfen die aktuelle Navigation nicht
erneut zur zweiten Wahrheit machen.

*D6 documents the merged operating surface after Features 018 through 021.
The new reader portals and the canonical scripts, manpages, and reports are the
current truth; the former monolithic README remains migration evidence only.*

## 3. Verbindliche Leserpfade / Binding Reader Paths

Der Leitfaden bietet getrennte Einstiege für:

1. **Erster sicherer Lauf:** Voraussetzungen, Begriffe, `--check-only` und
   Ergebnislesen.
2. **Regelmäßiger Betrieb:** Vorschau, echter Lauf, Reports und nächste Aktion.
3. **Maintainer und KI-Agenten:** Quellen, Berechtigungen, Drift-Reparatur,
   Branch-/PR-Handoff und Evidence.
4. **Fehleranalyse und Audit:** Exitcodes, Locks, Unterbrechung, Wiederanlauf,
   Providergrenzen und reproduzierbare Diagnose.

## 4. Verbindlicher Betriebsablauf / Binding Operating Flow

```text
Quelle und Autorität prüfen
  -> Remote-Freshness- und Arbeitsbaumstatus prüfen
  -> schreibfreien Check ausführen
  -> Vorschau der erlaubten Änderungen ausführen
  -> Befunde und Risiken bewerten
  -> echten Lauf ausdrücklich autorisieren
  -> Logs, Reports und Exitcode prüfen
  -> Repository-Änderungen getrennt über Branch und PR liefern
```

Jeder Schritt erhält Zweck, Voraussetzungen, erwartetes Ergebnis, Fehlergrenze
und exakte nächste Aktion. Keine Bedeutung wird ausschließlich durch Farbe,
Symbol oder visuelle Position vermittelt.

## 5. Verbindliches Source-/Home-Runtime-Betriebsmodell

Der Leitfaden verwendet folgende Begriffe und Grenzen:

| Klasse | Bedeutung | Kanonischer Änderungsort | Sync-/Remote-Grenze |
|---|---|---|---|
| Level-0-Quelle | Dauerhafter Git-Checkout `~/home-baseline-source` | im Checkout auf Branch und über PR | besitzt die dokumentierte Remote-Autorität |
| `homeRuntime` | Manifestgesteuerte Betriebsdateien unter `~/`, insbesondere Skripte, gemeinsame Agenten-Guidance und ausgewählte Spec-Kit-Oberflächen | zuerst in der Level-0-Quelle | nach gemergter Änderung über geprüften Home-Sync; lokaler Home-Commit ohne Push |
| `sourceOnly` | Dokumentation, Specs, Lastenhefte, Preset-Quellen und Evidence | ausschließlich in der Level-0-Quelle | direkt aus dem Checkout lesen; kein Home-Sync nur wegen dieser Änderung |
| `machineLocal` | Registry, Logs, Audit-State, `STATS.md` und anderer maschinengebundener Zustand | lokal nach dem jeweiligen Zustandsvertrag | keine implizite Übernahme in Source oder Remote |

**Home-Baseline Runtime**, kurz **Home Runtime**, bezeichnet nur die
manifestgesteuerte `homeRuntime`-Auswahl mit Wurzel `~/`. Das übrige persönliche
Home-Verzeichnis gehört nicht automatisch dazu. Die Runtime ist eine
abgeleitete Betriebskopie und weder ein zweiter Level-0-Checkout noch ein
Ersatz für Source-Commits und PRs.

Der Leitfaden erklärt die Vorteile dieser Trennung:

- nachvollziehbare Versions-, Review- und Veröffentlichungshistorie in der
  Quelle;
- stabile betriebliche Skript- und Agentenoberflächen im Home-Kontext;
- kleinere Sync-, Konflikt- und Fehlerfläche durch minimale Verteilung;
- Schutz von maschinenlokalem Zustand vor unbeabsichtigtem Push;
- reproduzierbare Aktualisierung aus Manifest, Check, Vorschau und
  Zustandsnachweis;
- klare Entscheidung, wann ein Source-only-Stand ohne Home-Sync abgeschlossen
  ist und wann ein Home-Runtime-Sync zum Delivery-Closeout gehört.

Direkte Änderungen unter `~/` gelten nicht als kanonische Reparatur. Ein
schreibender Sync läuft nur auf dem Host, nach `--check-only`/`-CheckOnly` und
Vorschau; `--force`/`-Force` benötigt eine konkrete Konfliktprüfung. In der
Sandbox wird die eingebundene Source-Referenz direkt gelesen. Exakte Pfade der
Runtime werden aus dem Manifest oder dem Source-Resolver abgeleitet und nicht
in einer zweiten statischen Liste gepflegt.

## 6. Inhaltliche Mindestabdeckung / Required Content

- dauerhafte Level-0-Quelle gegenüber manifestgesteuerter Home-Baseline
  Runtime und maschinenlokalem Zustand;
- Remote-Freshness-Barriere für Level 0/1/2;
- Clean, Dirty, Ahead, Behind, Diverged, Detached und Non-Default;
- `--check-only`, `--dry-run`/`-WhatIf` und echter Lauf;
- `--scripts-only`, `--repair-drift`, optionale Pakete und Admin-Prompts;
- gewünschter Flottenzustand, Registry und Preset-Profile;
- Grenzen automatischer Pulls und lokale Änderungen;
- Delivery Authority: LocalImplementation, PublishPR, MergeAndSync;
- KI-Agenten-Prompt mit Ziel, Scope, Authority, Evidence und Stop-Grenzen;
- gemeinschaftlich beschriebene Dateien und Serialisierungsgrenzen;
- Logs, JSON-Reports, Run-ID, Statusklassen und Exitcodes;
- Lock, unerwartete Unterbrechung, Statusprüfung und sichere Wiederaufnahme;
- Drift-Reparatur sowie anschließender Commit-/PR-Handoff;
- macOS-, Linux-/Ubuntu- und Windows-Pfade;
- Secrets, Administratorrechte, Sandbox und Providerfehler;
- Troubleshooting mit textorientierter Ursache und nächster Aktion.

## 7. Effizienzregeln für KI-Agenten / AI-Agent Efficiency Rules

- Der Agent erhält exakte Repository-, Branch-, Intake- und Evidence-Pfade.
- Vorhandene Skripte und Check-Modi werden genutzt, statt gleiche Prüfungen
  ad hoc neu zu implementieren.
- Read-only Inventarisierung wird gebündelt; schreibende gemeinsame Dateien
  werden serialisiert.
- Ein bereits valides Ergebnis wird verifiziert und nicht blind wiederholt.
- Logs und Reports werden über Run-ID referenziert, nicht vollständig in
  Prompts kopiert.
- Agenten dürfen fehlende Authority nicht aus früheren Sitzungen ableiten.
- Ein Wartungslauf committet oder pusht Ziel-Repositories nicht automatisch.
- Admin-Bypass ist kein Wartungsskriptmodus und wird nicht implizit erteilt.
- Geschwindigkeit ist ein Sekundärindikator; überprüfbare Arbeit pro
  vollständigem Qualitätszyklus bleibt maßgeblich.

## 8. Anforderungen / Requirements

- **AEG-001:** Es entstehen synchron gepflegte deutsche und englische
  Betriebs- und Effizienzleitfäden.
- **AEG-002:** Jeder Leitfaden beginnt mit Zielgruppe, Vorwissen, Begriffen,
  Sicherheitsgrenzen und einem sicheren Schnellstart.
- **AEG-003:** Alle tatsächlich unterstützten Optionen und Exitcodes werden
  gegen die gemergte Implementierung geprüft.
- **AEG-004:** Check, Vorschau und echter Lauf werden klar unterschieden.
- **AEG-005:** Jeder Befehl nennt Plattform, Arbeitsverzeichnis,
  Voraussetzungen, Nebenwirkung und erwarteten Exitcode.
- **AEG-006:** Die Remote-Freshness-Barriere und alle Arbeitsbaumklassen werden
  textorientiert erklärt.
- **AEG-007:** Source-Checkout, Home-Runtime und Sync-Grenze werden ohne
  vorausgesetztes Level-Modell-Wissen erklärt.
- **AEG-008:** KI-Agenten erhalten eine wiederverwendbare Prompt- und
  Authority-Checkliste.
- **AEG-009:** Serielle und parallele Arbeit wird anhand gemeinsamer
  Schreibflächen und Evidence erklärt.
- **AEG-010:** Logs, Reports und Run-IDs erhalten einen Diagnose- und
  Aufbewahrungsleitfaden.
- **AEG-011:** Unterbrechung, Lock und Wiederanlauf werden ohne Annahme eines
  erfolgreichen Endzustands beschrieben.
- **AEG-012:** Drift-Reparatur endet mit einem klaren separaten
  Branch-/Review-/PR-Handoff.
- **AEG-013:** Administrator-, Secret-, Sandbox- und Providergrenzen bleiben
  fail-closed.
- **AEG-014:** Alle Beispiele verwenden sichere Test- oder Vorschaumodi, soweit
  die jeweilige Aussage damit belegbar ist.
- **AEG-015:** Nicht sicher automatisierbare Schritte werden als menschliche
  Entscheidung gekennzeichnet.
- **AEG-016:** Effizienzbehauptungen besitzen Mess-, Feld- oder
  Ablauf-Evidence; unbelegte Superlative sind unzulässig.
- **AEG-017:** Lernende erhalten Fachbegriffe beim ersten Auftreten auf CEFR-B2-
  Niveau erklärt.
- **AEG-018:** Inhalte erfüllen anwendbare WCAG-2.2-AA- und Text-first-Regeln.
- **AEG-019:** Technische Automatisierungslücken erhalten getrennte,
  nicht leere Follow-up-Intakes statt stiller Skriptänderungen.
- **AEG-020:** D6 verändert kein ausführbares Wartungsverhalten und startet D7
  nicht automatisch.
- **AEG-021:** Der Leitfaden definiert Level-0-Quelle, Home-Baseline Runtime,
  `homeRuntime`, `sourceOnly` und `machineLocal` ohne das gesamte `~/` zur
  Runtime zu erklären.
- **AEG-022:** Inhalt, Zweck, Vorteile und Nicht-Ziele der Home Runtime werden
  für Lernende, tägliche Nutzende, Maintainer/KI-Agenten und Audit jeweils in
  geeigneter Tiefe erklärt.
- **AEG-023:** Für jede Distributionsklasse werden kanonischer Änderungsort,
  Leseort, Sync-Trigger, lokaler Commit und Remote-/Push-Grenze dokumentiert.
- **AEG-024:** Source-only-, Home-Runtime-, Runtime-Drift- und
  maschinenlokale Änderungen erhalten je einen sicheren Entscheidungs- und
  Abschlussablauf.
- **AEG-025:** Direkte Home-Änderungen, lokale Home-Commits und Force-Sync
  werden ausdrücklich von kanonischer Source-Lieferung getrennt.
- **AEG-026:** Der Leitfaden leitet die aktuelle Runtime-Menge aus Manifest und
  Resolver ab und behauptet keine dauerhaft vollständige manuelle Dateiliste.
- **AEG-027:** Host-Sync, Sandbox-Referenz und Container-Pfad werden mit ihren
  Schreib- und Autoritätsgrenzen erklärt.
- **AEG-028:** Der `MergeAndSync`-Closeout unterscheidet Source-only-Änderungen
  ohne Home-Sync von Änderungen an `homeRuntime`, deren gemergter Stand
  anschließend geprüft synchronisiert wird.
- **AEG-029:** Jede Betriebsbehauptung wird auf Feature 018 bis 021, die
  kanonische Skriptreferenz, Manpages oder reproduzierbare Reports
  zurückgeführt; veraltete README-Texte gelten nicht als aktuelle Wahrheit.
- **AEG-030:** Der Leitfaden integriert sich in die vier mit Feature 021
  eingeführten Leserpfade und hält deutsche und englische Navigation synchron.
- **AEG-031:** Reine `sourceOnly`-Dokumentation löst keinen Home-Sync aus;
  ändert D6 wider Erwarten `homeRuntime`, muss der MergeAndSync-Closeout den
  gemergten Stand zuerst prüfen und anschließend kontrolliert synchronisieren.

## 9. Akzeptanzkriterien / Acceptance Criteria

- **AC-AEG-001:** Ein Lernender kann aus der Dokumentation einen sicheren
  schreibfreien Erstlauf auswählen und dessen Ergebnis erklären.
- **AC-AEG-002:** Ein täglicher Nutzer kann aus einem Exitcode und Report die
  genaue nächste Aktion bestimmen.
- **AC-AEG-003:** Ein Maintainer kann eine lokale Drift-Reparatur kontrolliert
  in einen separaten PR überführen.
- **AC-AEG-004:** Ein KI-Agenten-Prompt enthält Ziel, Scope, Authority,
  Evidence, Stop-Grenzen und Abschlusszustand.
- **AC-AEG-005:** Deutsche und englische Fassungen besitzen denselben
  Informationsumfang und funktionierende Querverweise.
- **AC-AEG-006:** Sichere Beispiele bestehen im passenden Check- oder
  Vorschaumodus.
- **AC-AEG-007:** Manpage, README, Leitfaden und tatsächliche Optionen
  widersprechen sich nicht.
- **AC-AEG-008:** Keine Automatisierungslücke wurde durch eine undokumentierte
  funktionale Änderung verdeckt.
- **AC-AEG-009:** Semantischer, A11Y-, Link-, Secret- und Plattformreview sind
  nachgewiesen.
- **AC-AEG-010:** D7 wurde nicht automatisch gestartet.
- **AC-AEG-011:** Ein Lernender kann Quelle, Home Runtime und
  maschinenlokalen Zustand anhand eines Beispiels korrekt unterscheiden.
- **AC-AEG-012:** Ein täglicher Nutzer kann für eine geänderte Datei bestimmen,
  ob sie direkt aus der Quelle gelesen oder nach `~/` synchronisiert wird.
- **AC-AEG-013:** Ein Maintainer kann erklären, warum ein lokaler Home-Commit
  keinen Source-PR und keine Remote-Autorität ersetzt.
- **AC-AEG-014:** Ein KI-Agent kann aus Distributionsklasse und Delivery Mode
  den korrekten Arbeitsort, Sync-Schritt und Stop-Zustand ableiten.
- **AC-AEG-015:** Manifest, Manpage, Resolver, Host-/Container-Grenze und beide
  Sprachfassungen widersprechen dem Betriebsmodell nicht.
- **AC-AEG-016:** Eine maschinenlesbare Quellenmatrix ordnet jede dokumentierte
  Option, Statusklasse, Evidence-Datei und nächste Aktion genau einer aktuellen
  Quelle oder einer ausdrücklich historischen Grenze zu.
- **AC-AEG-017:** Root-Portale, vier Leserpfade, Leitfäden, Manpages und
  Skriptreferenz widersprechen sich weder auf Deutsch noch auf Englisch.
- **AC-AEG-018:** D6 erzeugt keine Änderung an ausführbarem
  Wartungsverhalten und startet D7 nicht automatisch.

## 10. Nicht-Ziele / Non-Goals

- Keine Änderung von Wartungs-, Sync-, Registry- oder Toolchain-Skripten.
- Keine Garantie einer absoluten maximalen Laufzeit oder Agentengeschwindigkeit.
- Keine implizite Remote-, Admin- oder Bypass-Autorität.
- Keine Umklassifizierung des gesamten persönlichen Home-Verzeichnisses als
  Home Runtime.
- Keine zweite kanonische Dateiliste neben dem Home-Sync-Manifest.
- Kein Ersatz für Ausbildung, Review oder menschliche Betriebsentscheidung.

<!-- intake-authoring:prompts -->
## 11. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.md` as documentation preflight D6. Bind the review to Features 018 through 021, PR #197, reviewed head `663807ef0cd19c245fb171bc017dda5d5f84209a`, and merge commit `468924a261996dd245f8f21e4e6693fd2cbe513c`. Verify AEG-001 through AEG-031, AC-AEG-001 through AC-AEG-018, four reader paths, evidenced safe operating flow, the source/home-runtime operating model with `homeRuntime`, `sourceOnly`, and `machineLocal`, exact maintenance options and exit-code boundaries, AI-agent authority and prompt guidance, interruption and recovery, platform parity, source traceability, criteria for efficiency claims, separate automation follow-ups, learner accessibility, and strict no-runtime-change scope. Do not modify the intake or start D6.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.md` as the binding intake for documentation preflight D6 after Features 018 through 021 are complete. Create the feature specification for synchronized German and English learner, operator, maintainer/AI-agent, and audit guidance for the agentic workspace and one-command maintenance. Preserve AEG-001 through AEG-031, AC-AEG-001 through AC-AEG-018, the four Feature-021 reader paths, the source/home-runtime operating model and distribution-class decisions, current-source traceability, evidenced efficiency claims, safe command validation, authority and interruption boundaries, separate automation follow-ups, and no executable behavior changes. Do not start D7.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Agentic-Workspace-und-Ein-Kommando-Wartung-Effizienzleitfaden.md` with deliveryAuthority=MergeAndSync after Features 018 through 021 and the Feature-021 causal closeout are merged. Use the current root portals, four reader paths, scripts, manpages, reports, and Documentation Impact contract as binding evidence. Document only the actual supported workspace and maintenance behavior, including the manifest-derived source/home-runtime model, distribution classes, benefits, sync triggers, source traceability, and authority boundaries; validate safe examples and both language paths; create separate follow-up intakes for evidenced automation gaps; preserve all executable behavior; converge required and useful optional checks and reviews; merge one non-empty Level-0 PR; return to clean synchronized main; and do not start D7 automatically.
```

<!-- intake-authoring:end -->
