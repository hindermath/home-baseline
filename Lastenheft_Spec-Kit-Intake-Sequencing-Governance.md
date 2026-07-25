<!-- intake-authoring:begin -->
# Lastenheft: Spec Kit Intake Sequencing Governance

**Status:** Verbindlicher Bootstrap-Intake / Binding bootstrap intake
**Version:** 1.0
**Datum / Date:** 2026-07-25

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt das optionale Spec-Kit-Preset
`intake-sequencing-governance` v0.1.0. Es verwaltet die fachliche
Abarbeitungsreihenfolge bereits vorhandener Intakes als nachvollziehbaren,
azyklischen Graphen. Das Preset erzeugt keine Intake-Inhalte, fuehrt keinen
Review aus und startet weder Specify noch autonome Laeufe.

*This intake defines the optional `intake-sequencing-governance` v0.1.0
preset. It manages the processing order of existing intakes as a traceable,
acyclic graph. It does not author intake content, perform reviews, or start
Specify or autonomous execution.*

## 2. Zielgruppe / Audience

- Lernende und Ausbildende, die Reihenfolgen und Abhaengigkeiten ohne
  Graphentheorie-Vorkenntnisse verstehen muessen.
- Anwendungsentwicklerinnen, Anwendungsentwickler und Maintainer, die mehrere
  Intakes sicher planen und pflegen.
- Intake Review sowie autonome und parallele Orchestrierung als nachgelagerte,
  getrennt autorisierte Verbraucher.

## 3. Ausgangslage und Zielzustand / Current And Target State

Reihenfolgen werden heute in Markdown, Review-Requests und projektspezifischen
Konventionen gepflegt. Dadurch koennen sichtbare Position, bindende
Abhaengigkeit, bevorzugte Serialisierung und Lifecycle-Status auseinanderlaufen.

Der Zielzustand ist eine portable, maschinenpruefbare Serie mit genau
identifizierten Zielen, Roots, typisierten Kanten, stabiler Reihenfolge,
Lifecycle-Evidence und einer sicheren Bestimmung des naechsten ausfuehrbaren
Intakes.

## 4. Scope

Das Preset liefert diese kanonischen Commands:

1. `speckit.intake-series-create`
2. `speckit.intake-series-read`
3. `speckit.intake-series-update`
4. `speckit.intake-series-delete`
5. `speckit.intake-series-status`
6. `speckit.intake-series-next`

Es liefert Manifest-, Receipt-, Operation-, Tombstone-, Reihenfolge-,
Policy-, Checklist-, Runbook-, Agent-Guidance- und
Feldvalidierungs-Templates sowie Bash-/PowerShell-Validatoren.

## 5. Nicht-Ziele / Non-Goals

- keine Erstellung oder inhaltliche Aenderung von Intakes;
- kein Intake Review und keine automatische Reparatur;
- kein Start von Specify, Autonomous oder Parallel Autonomous;
- keine implizite Commit-, Push-, PR-, Merge-, Bypass- oder
  Administratorberechtigung;
- keine Aenderung bestehender Acht-, Neun- oder Zehn-Preset-Profile;
- kein Erraten fachlicher Abhaengigkeiten oder Lifecycle-Entscheidungen.

## 6. Funktionale Anforderungen / Functional Requirements

- **ISR-001:** Eine Serie besitzt eine stabile ID, einen repository-relativen
  Manifestpfad, eine geordnete Zielmenge und normalisierte SHA-256-Evidence.
- **ISR-002:** Jeder Zielpfad kommt genau einmal vor. Absolute oder das
  Repository verlassende Pfade sind unzulaessig.
- **ISR-003:** Roots entsprechen exakt den Zielen ohne eingehende bindende
  Kante.
- **ISR-004:** Kanten sind referenzgueltig, frei von Selbstkanten und
  Duplikaten, mit der sichtbaren Reihenfolge vereinbar und insgesamt azyklisch.
- **ISR-005:** Erlaubte Kantentypen sind `HardCompletionGate`,
  `AssessmentBaseline`, `SandboxBaseline`,
  `DocumentationSurfaceBaseline`, `CommentSurfaceBaseline`,
  `FinalAuditInput`, `PreferredSerialOrder` und
  `SharedWriterSerialization`.
- **ISR-006:** Bindende Kanten blockieren einen Nachfolger bis zum
  nachgewiesenen Abschluss aller bindenden Vorgaenger.
- **ISR-007:** `PreferredSerialOrder` und `SharedWriterSerialization`
  dokumentieren Liefer- oder Schreibkonfliktgrenzen, ohne eine fachliche
  Abhaengigkeit vorzutäuschen.
- **ISR-008:** Create legt genau eine neue Serie transaktional an und
  ueberschreibt keine aktive Serie.
- **ISR-009:** Read fasst Serie, Roots, Kanten, blockierte Ziele und naechste
  Kandidaten read-only in textorientierter Form zusammen.
- **ISR-010:** Update benoetigt aktuelle ausdrueckliche Autoritaet, archiviert
  den Vorgaenger und verknuepft das neue Receipt mit `supersedes`.
- **ISR-011:** Delete ist logisch: Manifest und Evidence werden bytegleich
  archiviert und durch einen Tombstone ersetzt. Fachliche Intakes werden nicht
  geloescht.
- **ISR-012:** Status prueft Manifest, Receipt, Zielhashes, Graph und
  Lifecycle-Evidence read-only.
- **ISR-013:** Next liefert alle aktuell startfaehigen Ziele oder einen
  eindeutigen Blockiergrund. Es startet keinen nachgelagerten Command.
- **ISR-014:** Materielle Graph-, Scope- oder Lifecycle-Unklarheiten werden
  nicht geraten. Der Zustand bleibt `NeedsClarification`.
- **ISR-015:** Jede schreibende Mehrdatei-Operation wird vorbereitet,
  vollstaendig validiert und erst danach gemeinsam veroeffentlicht.
- **ISR-016:** Bash und PowerShell verwenden dieselben Statusklassen,
  Fehlerklassen und Exitcodes.
- **ISR-017:** Das Preset verwendet Prioritaet `66`, benoetigt Spec Kit
  `>=0.8.3`, ist MIT-lizenziert und bleibt optional.
- **ISR-018:** Ein separates Elf-Preset-Profil ergaenzt Authoring `64`, Review
  `65`, Sequencing `66`, Autonomous `70` und Parallel Autonomous `80`.
- **ISR-019:** Die vorhandene Home-Baseline-Serie mit 13 Zielen, 6 Roots und
  15 Kanten dient als `LegacyAdoption`-Feldnachweis, ohne ihren Inhalt zu
  veraendern.
- **ISR-020:** Jede unterstuetzte Agentenoberflaeche zeigt jeden der sechs
  Commands genau einmal.

## 7. Daten- und Lifecycle-Vertrag / Data And Lifecycle Contract

Das Serienmanifest enthaelt mindestens Schema-Version, Serien-ID, Titel,
Policy, geordnete Ziele mit Rolle und Hash, Roots, typisierte Kanten,
Lifecycle-Status und Evidence-Pfade. Das Receipt bindet Manifest, Operation,
Authority, vorherigen Zustand und normalisierte Hashes.

Zulaessige Serienzustaende sind `Draft`, `NeedsClarification`, `Ready`,
`Active`, `Completed` und `Deleted`. Ein Ziel besitzt einen nachvollziehbaren
Status wie `Pending`, `Blocked`, `Eligible`, `Active`, `Completed` oder
`Withdrawn`. Unbekannte Werte werden fail-closed abgelehnt.

## 8. Komposition / Composition

Die vorgesehene optionale Reihenfolge lautet:

| Prioritaet | Preset | Aufgabe |
|---:|---|---|
| 64 | Intake Authoring | Intake-Inhalte erstellen oder aktualisieren |
| 65 | Intake Review | Inhalt und Serienkontext unabhaengig pruefen |
| 66 | Intake Sequencing | Reihenfolge, Graph und naechsten Kandidaten verwalten |
| 70 | Autonomous Run | Einen freigegebenen Feature-Lauf ausfuehren |
| 80 | Parallel Autonomous | Mehrere autorisierte Laeufe koordinieren |

Eine niedrigere Prioritaetszahl bedeutet fruehere Aufloesung. Sie erteilt
keine Ausfuehrungs- oder Remote-Autoritaet.

## 9. Sicherheit, Datenschutz und Barrierefreiheit

- Manifest- oder Intake-Inhalte werden niemals als Code ausgefuehrt.
- Secrets, private absolute Pfade und unnoetige personenbezogene Daten sind
  unzulaessig.
- Schreiboperationen benoetigen aktuelle, begrenzte Autoritaet.
- Ausgaben bleiben ohne Farbe, Maus oder grafischen Graphen vollstaendig
  verstaendlich.
- Deutsche Erklaerungen stehen vor englischen Erklaerungen und verwenden
  CEFR B2; WCAG 2.2 AA gilt, soweit anwendbar.

## 10. Abnahmekriterien / Acceptance Criteria

- **AC-001:** Eine synthetische Drei-Ziel-Serie besteht mit einer Root und zwei
  bindenden Kanten in Bash und PowerShell.
- **AC-002:** Die bestehende Home-Baseline-Serie besteht als Legacy-Adoption
  mit exakt 13 Zielen, 6 Roots und 15 Kanten.
- **AC-003:** Fehlende oder doppelte Ziele, unbekannte Referenzen,
  Selbstkanten, Duplikate, Zyklen, falsche Roots und Reihenfolgewidersprueche
  werden in beiden Shells gleich abgelehnt.
- **AC-004:** Receipt-, Manifest-, Ziel- oder Lifecycle-Drift fuehrt
  fail-closed zu einem ungueltigen Status.
- **AC-005:** Read, Status und Next aendern weder Git-Arbeitsbaum noch
  Evidence.
- **AC-006:** Update archiviert den Vorgaenger und benoetigt nachweisliche
  aktuelle Autoritaet.
- **AC-007:** Delete entfernt keinen fachlichen Intake und hinterlaesst eine
  validierbare Archiv- und Tombstone-Kette.
- **AC-008:** Das Elf-Preset-Profil besteht Add, List, Info, Resolve,
  Disable/Enable, Remove und Reinstall.
- **AC-009:** Alle sechs Commands erscheinen je Agentenoberflaeche genau
  einmal.
- **AC-010:** Intake Review, Autonomous und Parallel Autonomous werden nicht
  implizit gestartet.
- **AC-011:** Das Release `v0.1.0` ist per versionierter GitHub-ZIP-Datei
  installierbar und besitzt eine dokumentierte SHA-256-Pruefsumme.
- **AC-012:** Die optionale Flotteninstallation verwendet `required: false`
  und veraendert das Standard-Acht-Preset-Profil nicht.

<!-- intake-authoring:prompts -->
## 11. Kopierbare Spec-Kit-Prompts / Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### `$speckit-specify`

```text
$speckit-specify Nutze Lastenheft_Spec-Kit-Intake-Sequencing-Governance.md als verbindliche Eingabedatei. Erstelle die Feature-Spezifikation fuer das optionale Preset intake-sequencing-governance v0.1.0 mit Prioritaet 66 und den sechs Commands speckit.intake-series-create, speckit.intake-series-read, speckit.intake-series-update, speckit.intake-series-delete, speckit.intake-series-status und speckit.intake-series-next. Uebernimm den typisierten DAG-, Lifecycle-, Receipt-, Authority-, Bash-/PowerShell-Paritaets- und LegacyAdoption-Vertrag. Aendere keine bestehenden Preset-Profile und starte keine Implementierung oder Remote-Aktion.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### `$speckit-autonomous`

```text
$speckit-autonomous Nutze Lastenheft_Spec-Kit-Intake-Sequencing-Governance.md als verbindliche Eingabedatei und liefere intake-sequencing-governance v0.1.0 vollstaendig aus.

Delivery mode: MergeAndSync fuer Home Baseline, das eigene Preset-Repository und die registrierte optionale Flotteninstallation. Kein Admin-Bypass ist erteilt.

Erstelle Bootstrap- und Review-Evidence, Spec, Plan, Tasks, Analyze-Nachweis, kanonischen Scaffold und Publikationskopie. Implementiere die sechs Commands, Templates, Bash-/PowerShell-Validatoren, Tests, Manpages, bilinguale README, Feldvalidierung und das getrennte Elf-Preset-Profil. Verwende die bestehende 13-Ziel-/6-Root-/15-Kanten-Serie nur read-only als LegacyAdoption-Evidence. Veroeffentliche hindermath/spec-kit-preset-intake-sequencing-governance als v0.1.0, pruefe die versionierte GitHub-ZIP-Datei, installiere das optionale Profil mit required:false in der registrierten Flotte und reiche das Preset danach ueber das offizielle Community-Template ein. Starte keine fachlichen Folgefeatures.
```

## 12. Abschlussgrenze / Completion Boundary

Der Auftrag ist abgeschlossen, wenn Home Baseline und alle veraenderten eigenen
Repositories sauber synchronisiert sind, das Preset als `v0.1.0` installierbar
ist, das optionale Elf-Preset-Profil flottenweit nachgewiesen wurde und die
Community-Einreichung veroeffentlicht ist. Ein externer Upstream-Merge ist
keine lokale Abschlussbedingung.

<!-- intake-authoring:end -->
