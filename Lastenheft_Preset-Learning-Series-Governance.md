<!-- intake-authoring:begin -->
# Lastenheft: Preset Learning Series Governance

**Dokumenttyp:** Spec-Kit Intake / Lastenheft  
**Status:** bereit für Intake Review  
**Stand:** 2026-07-28  
**Reihenfolge:** Position 35, nach Position 34  
**Delivery Mode:** `MergeAndSync`  
**Zielgruppe:** Maintainer von Lernreihen, Lehrende, Ausbildende,
Bildungsplanende und Preset-Reviewer  
**Vorausgesetztes Wissen:** keine Vorkenntnisse zum neuen Preset; die Begriffe
Lernreihe, Kompetenzmodell, Evidence und Agentenautorität werden erklärt

## 1. Zweck / Purpose

Es entsteht das optionale Preset `learning-series-governance` `v0.1.0` mit
Priorität `45`. Es konkretisiert den generischen Drei-Ebenen-Vertrag für
Lernreihen in dualen IHK-Ausbildungsgängen und vergleichbaren strukturierten
Berufsbildungsprogrammen.

Das Preset hilft, Lernziele, Aufgaben, Lernbegleiter, Lehrjahre,
Berufskompetenzen, amtliche Quellen, KI-Kompetenzen, Evidence und Rollouts
nachvollziehbar zu prüfen. Es ersetzt weder Ausbildungsordnung, Rahmenlehrplan,
Berufsschule, Betrieb, Ausbilderentscheidung noch Prüfungsvorbereitung.

*The optional preset specializes the generic three-level consistency contract
for structured vocational learning series without replacing official
curricula or human educational responsibility.*

## 2. Komposition und Priorität / Composition and Priority

- Preset-ID: `learning-series-governance`
- Version: `v0.1.0`
- Priorität: `45`, nach A11Y Governance `40` und vor Cross-Platform
  Governance `50`
- Spec Kit: `>=0.8.3`
- fachliche Voraussetzung:
  `intake-review-governance >=0.3.0`
- öffentlich optional;
- verpflichtend nur in ausdrücklich ausgewählten Lernreihenprofilen;
- Standard-Achtermatrix bleibt unverändert;
- optionales Zwölferprofil:
  acht Standard-Presets, drei Intake-Governance-Presets und dieses Preset.

## 3. Öffentliche Commands / Public Commands

### `$speckit-learning-series-status`

Strikt read-only. Der Command prüft:

- Profil, Quellen, Reihen, Lehrjahre, Berufe und Rolloutziele;
- Drei-Ebenen-Review-Aktualität;
- KI-Kompetenz-, Evidence-, Sicherheits- und A11Y-Abdeckung;
- Hash-, Link-, Reihenfolge- und Quellenstatusdrift.

### `$speckit-learning-series-review`

Erzeugt oder aktualisiert einen nachvollziehbaren Lernreihen-Review. Er
akzeptiert keine Risiken stellvertretend für Menschen, verändert keine
Lernmaterialien und startet weder Specify noch Autonomous.

## 4. Portabler Vertrag / Portable Contract

Der Vertrag unterstützt beliebige duale IHK-Berufe, ohne die vorhandenen
IT-Berufe fest einzubauen. Ein Profil definiert mindestens:

- Berufs-ID, offizielle Bezeichnung, Dauer und Zielgruppe;
- amtliche Quellen mit Version, URL, Gültigkeitsbereich und Hash/Evidence;
- Lernfelder oder gleichwertige Kompetenzbereiche;
- Ausbildungsjahre und Übergänge;
- Aufgaben-, Lernbegleiter-, Evidence- und Bewertungsrollen;
- gemeinsame und berufsspezifische Kompetenzen;
- Rolloutziele und lokale Abweichungen;
- KI-Kompetenzen `AIK001` bis `AIK008`;
- Lernphasen `Orientieren`, `Anwenden`, `Delegieren`, `Bewerten`;
- Quellenstatus `OfficiallyRequired`, `Supported`, `ProjectSupplement`,
  `FutureSkillAssumption`.

Die drei Konsistenzebenen heißen `InternalConsistency`,
`NormativeConsistency` und `EcosystemConsistency`.

## 5. Sicherheits- und Lernvertrag / Safety and Learning Contract

- KI-Einsatz bleibt an Datenschutz, Informationssicherheit, Urheberrecht,
  Fairness, betriebliche Regeln und menschliche Verantwortung gebunden.
- Agentenautorität ist minimal, aktuell und widerrufbar. Commit, Push, PR,
  Merge, Secrets, Provider- oder Adminrechte werden niemals aus einer
  Lernaufgabe abgeleitet.
- Container-/Sandbox-Regeln gelten, wenn das Projektprofil sie verlangt.
- Lernende müssen Ausgaben prüfen und eine eigene fachliche Entscheidung
  begründen.
- Evidence trennt Eigenleistung, KI-Unterstützung, Agentenaktion,
  Simulation und reale betriebliche Freigabe.
- Nutzerseitige Inhalte folgen Deutsch-zuerst/Englisch-danach, CEFR B2,
  Ersterklärung, textorientierter Darstellung und WCAG 2.2 AA.

## 6. Anforderungen / Requirements

- **LSG-001:** Constitution-, Spec-, Plan-, Tasks- und Agent-Addenda bilden
  alle drei Konsistenzebenen ab.
- **LSG-002:** Profil-, Source-, Series-, Competency-, Evidence-, Review- und
  Statusvorlagen sind domänenübergreifend und schema-validierbar.
- **LSG-003:** `AIK001` bis `AIK008`, vier Lernphasen und vier Quellenstatus
  werden exakt und ohne Prüfungsbehauptung umgesetzt.
- **LSG-004:** Gemeinsame Kompetenzen können kanonisch referenziert werden;
  berufsspezifische Varianten bleiben getrennt.
- **LSG-005:** Review-Ergebnisse sind
  `Ready`, `ReadyWithAcceptedRisks`, `NeedsRemediation` oder `Blocked`.
- **LSG-006:** Risikoakzeptanz benötigt menschlichen Owner, Begründung,
  Datum, Evidence und Re-Evaluation-Trigger.
- **LSG-007:** Bash- und PowerShell-Validatoren prüfen Quellen, Hashes,
  Reihenfolge, Kardinalität, Übergänge, Achsen, Kompetenzabdeckung,
  Evidence und Statuskombinationen paritätisch.
- **LSG-008:** README, Runbook, Manpages und Beispiele sind bilingual,
  CEFR B2 und ohne vorherige Spec-Kit-Erfahrung verständlich.
- **LSG-009:** Alle unterstützten Agentenoberflächen zeigen beide Commands
  und Skills genau einmal.
- **LSG-010:** Kanonischer Scaffold und Publikationskopie bleiben bytegleich.
- **LSG-011:** Ein öffentliches MIT-Repository, Tag, Release und ZIP-Smoke
  entstehen erst nach bestandenem Pilot in Position 36.
- **LSG-012:** Die Community-Einreichung erfolgt erst nach Release-Smoke über
  das offizielle Template; ein externer Merge ist keine lokale
  Abschlussbedingung.
- **LSG-013:** Keine bestehende Lernreihe wird in diesem Lauf migriert.
- **LSG-014:** Position 36 wird nicht automatisch gestartet.

## 7. Testvertrag / Test Contract

Positive Fixtures:

- IT-Beruf mit Lernfeldern und drei Ausbildungsjahren;
- kaufmännischer und technischer Nicht-IT-Beruf mit abweichender Struktur;
- gemeinsame Kompetenz mit berufsspezifischer Vertiefung;
- begründete lokale KI-Zukunftskompetenz;
- LF-/CRLF-/UTF-8-BOM- und Bash-/PowerShell-Parität.

Negative Fixtures:

- fehlende oder veraltete amtliche Quelle;
- Projektziel fälschlich als offizielle Pflicht;
- Lernreihe ohne Aufgabe, Lernbegleiter, Evidence oder Bewertung;
- ungesicherte Agentenautorität oder Secret-Nutzung;
- `Ready` trotz Finding, `NotAssessed` oder ungeklärter Quelle;
- unzugängliche rein visuelle Abhängigkeit;
- doppelte Kompetenz-ID, Kreisbezug oder widersprüchlicher Lehrjahresübergang.

## 8. Akzeptanzkriterien / Acceptance Criteria

- **AC-LSG-001:** Der Scaffold besteht alle positiven und negativen Fixtures
  in Bash und PowerShell.
- **AC-LSG-002:** Das Zwölferprofil löst sich ohne Prioritäts- oder
  Command-Duplikate auf.
- **AC-LSG-003:** Das Preset ist außerhalb der bestehenden IT-Berufe
  konfigurierbar.
- **AC-LSG-004:** Sicherheits-, Lernenden- und A11Y-Grenzen sind in Templates,
  Commands und Validatoren konsistent.
- **AC-LSG-005:** Es wurde noch kein Release oder Community-Issue erstellt.
- **AC-LSG-006:** Keine Lernreihe wurde migriert und Position 36 wurde nicht
  gestartet.

## 9. Nicht-Ziele / Non-Goals

- Kein allgemeines Learning-Management-System.
- Keine automatische Unterrichtsplanung oder Benotung.
- Keine ISO-, IHK- oder Prüfungszertifizierung.
- Keine Änderung amtlicher Rahmenlehrpläne.
- Keine verpflichtende Aufnahme in das Standard-Acht-Preset-Profil.

<!-- intake-authoring:prompts -->
## 10. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Preset-Learning-Series-Governance.md` as position 35. Verify optional preset identity v0.1.0, priority 45, intake-review >=0.3.0 composition, domain-neutral IHK profile, exact three consistency axes, AIK001-AIK008, learning phases, source statuses, human authority and evidence boundaries, Bash/PowerShell and agent parity, deferred release until position 36, and no automatic migration or successor start.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Preset-Learning-Series-Governance.md` as the binding intake for position 35. Specify the optional learning-series-governance v0.1.0 scaffold at priority 45 with two read-only/review commands, generic vocational profiles, three consistency axes, AIK001-AIK008, four learning phases, four source statuses, portable validators, documentation, and twelve-preset composition. Preserve LSG-001 through LSG-014 and AC-LSG-001 through AC-LSG-006. Do not publish, migrate learning series, or start position 36.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Preset-Learning-Series-Governance.md` with deliveryAuthority=MergeAndSync after position 34 is complete. Build and validate only the unreleased v0.1.0 scaffold and publication copy, create one non-empty PR, return to clean synchronized main, and do not publish, migrate learning series, or start position 36.
```

<!-- intake-authoring:end -->
