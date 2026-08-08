# Datenmodell: RL-SE-Checklisten-Selbstprüfung

## Zweck und Darstellungsform

Dieses logische Datenmodell beschreibt die Markdown-Evidenz, nicht eine Datenbank oder neue Laufzeit. Die späteren Tabellen bleiben für Menschen linear lesbar; die festen Felder und Wertemengen ermöglichen zugleich deterministische Konsistenzprüfungen.

## Entität 1: Prüfgrundlage

Eine **Prüfgrundlage** beschreibt den vollständigen, versionierten Scope einer Selbstprüfung.

| Feld | Typ | Pflicht | Regel |
|---|---|---:|---|
| `assessmentId` | semantische ID | ja | Für diesen Lauf `2026-08-05-home-baseline-rl-se-self-assessment`. |
| `repositoryLevel` | Enum | ja | `Level0`. |
| `repositoryState` | Git-Commit oder Arbeitsbaum-Bindung | ja | Commit-SHA oder dokumentierter Diff-/Statusnachweis. |
| `assessedAt` | ISO-8601-Zeitpunkt | ja | Zeitpunkt der fachlichen Entscheidung. |
| `baselineManifest` | Pfad, Version, Hash | ja | Repository-relativer Pfad; Baseline 3.2.0 beim geprüften Ausgangsstand. |
| `policySource` | Pfad und Version | ja | Richtlinie Sichere Entwicklung. |
| `checklistSources` | geordnete Menge | ja | Exakt zwölf kanonische Quelldateien. |
| `stableCheckpointIds` | Menge | ja | Exakt die aus den Quelldateien extrahierten 157 eindeutigen `CL-NN-NN`-IDs. |
| `relatedDocuments` | Menge | ja | Exakt 15 Manifest-Einträge; Lern- und Managed-Reference-Dateien werden getrennt geführt. |
| `presetProfile` | Menge | ja | Exakt elf installierte Presets mit ID, Version und Priorität. |
| `evidenceBoundary` | Text DE/EN | ja | Erklärt, was die Prüfung beweist und nicht beweist. |

### Beziehungen

- Eine Prüfgrundlage besitzt genau 157 stabile Prüfpunkte und null oder mehr deklarierte Zusatzprüfpunkte.
- Jeder Prüfpunkt verweist auf mindestens eine Quelle der Prüfgrundlage.
- Jeder der 15 Dokument- und elf Preset-Einträge ist von mindestens einem Prüfpunkt oder einer expliziten Abdeckungszeile referenziert.

## Entität 2: Zusatz-ID-Registereintrag

Ein **Zusatz-ID-Registereintrag** deklariert einen eigenständigen Prüfpunkt, für den keine stabile Checklisten-ID fachlich zuständig ist.

| Feld | Typ | Pflicht | Regel |
|---|---|---:|---|
| `id` | semantische ID | ja | Entspricht `^HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)*$`; disjunkt zu allen `CL-*`-IDs. |
| `titleDe`, `titleEn` | Text | ja | Semantisch gleichwertig. |
| `primarySource` | Pfad plus Abschnitt | ja | Repository-relativ. |
| `needRationaleDe`, `needRationaleEn` | Text | ja | Begründet, warum keine stabile Checklisten-ID ausreicht. |
| `crossReferences` | Menge | nein | Darf Quellen ergänzen, aber keine zweite Kontrollentscheidung erzeugen. |

### Validierung

- Keine zwei Registereinträge haben dieselbe ID.
- Jeder Eintrag erzeugt genau eine zusätzliche Matrixzeile.
- Ein Prüfschritt mit bestehendem `CL-*`-Owner wird nur querverwiesen und nicht erneut registriert.
- Gesamtzahl der Matrixzeilen ist `157 + Anzahl(Registereinträge)`.

## Entität 3: Prüfpunkt

Ein **Prüfpunkt** ist die kleinste eigenständig entschiedene Matrixeinheit.

| Feld | Typ | Pflicht | Regel |
|---|---|---:|---|
| `id` | `CL-NN-NN` oder `HB-RLSE-*` | ja | Eindeutig; stabile CL-IDs genau einmal. |
| `kind` | Enum | ja | `Checklist` oder `Additional`. |
| `titleDe`, `titleEn` | Text | ja | Vollständig und semantisch gleichwertig. |
| `primarySource` | Pfad plus Abschnitt | ja | Repository-relativ, kein `..`, kein absoluter Pfad. |
| `crossReferences` | Menge | nein | Mitgeltende Dokumente, Presets, Constitution oder bestehende Evidence. |
| `workflowStatus` | Enum | ja | `Applicable`, `AlreadySatisfied`, `N/A`, `Open` oder `FollowUp`. |
| `applicability` | Enum | bedingt | `Applicable`, `N/A` oder `Open`, wenn Baseline/Preset die Achse verlangt. |
| `implementationStatus` | Enum | bedingt | `Fulfilled`, `Partly Fulfilled`, `Not Fulfilled` oder `Not Assessed`. |
| `rationaleDe`, `rationaleEn` | Text | ja | Erklärt die Entscheidung, nicht nur den Status. |
| `evidenceRecords` | Liste | bedingt | Für `AlreadySatisfied` mindestens ein aktueller, aussagegleicher Nachweis. |
| `owner` | Rolle | ja | Verantwortliche Rolle, keine private Kontaktinformation. |
| `reviewer` | Rolle | ja | Fachliche Review-Rolle. |
| `priority` | Enum | ja | `High`, `Medium` oder `Low`. |
| `risk` | Risikoentscheidung | ja | Auswirkung und Eintrittsbegründung. |
| `residualRisk` | Enum plus Begründung | ja | `High`, `Medium` oder `Low`, auch bei positivem Status. |
| `nextActionDe`, `nextActionEn` | Text | bedingt | Für `Open` und `FollowUp` zwingend; für andere Status optional. |
| `dueOrReviewDate` | Datum oder `NotScheduled` | bedingt | Für `FollowUp` zwingend; `Open` mindestens mit Trigger. |
| `reEvaluationTriggerDe`, `reEvaluationTriggerEn` | Text | ja | Konkrete Zustandsänderung, kein vages „regelmäßig“. |

## Entität 4: Evidenznachweis

Ein **Evidenznachweis** stützt genau die Aussage eines oder mehrerer Prüfpunkte innerhalb einer benannten Proof-Grenze.

| Feld | Typ | Pflicht | Regel |
|---|---|---:|---|
| `evidenceId` | lokale ID | ja | Innerhalb der Selbstprüfung eindeutig. |
| `evidenceType` | Enum | ja | `RepositoryFile`, `CommandResult`, `ExternalSource` oder `ReviewDecision`. |
| `source` | Pfad, Befehl oder URL-Bezeichnung | ja | Repository-Pfade relativ; keine Secrets oder privaten lokalen Pfade. |
| `stateBinding` | Commit/Arbeitsbaum-Bindung | ja | Für positive Repository-Evidenz verpflichtend. |
| `observedAt` | ISO-8601-Zeitpunkt | ja | Wann die Evidenz geprüft wurde. |
| `result` | Text/Enum | ja | Konkretes Ergebnis statt bloßer Quellenangabe. |
| `retrievedAt` | ISO-Datum | bedingt | Für veränderliche externe Quellen verpflichtend. |
| `proofBoundaryDe`, `proofBoundaryEn` | Text | ja | Aussage, die belegt wird, und ausgeschlossene Verallgemeinerung. |

### Frische-Regeln

- `RepositoryFile`: State-Bindung, Pfad und semantische Aussage müssen vorhanden sein.
- `CommandResult`: Befehl, Zeitpunkt, Exit-/Ergebnisstatus und State-Bindung sind Pflicht.
- `ExternalSource`: Quelle, Abrufdatum, Zeitpunkt und Ergebnis sind Pflicht.
- `ReviewDecision`: Reviewer-Rolle, Zeitpunkt, Grundlage und begrenzte Aussage sind Pflicht.
- Ist ein Pflichtfeld leer, darf der Nachweis `AlreadySatisfied` nicht stützen.

## Entität 5: Risikoentscheidung

Eine **Risikoentscheidung** erklärt die Priorisierung eines Prüfpunkts.

| Feld | Typ | Pflicht | Regel |
|---|---|---:|---|
| `riskLevel` | Enum | ja | `High`, `Medium` oder `Low`. |
| `impactDe`, `impactEn` | Text | ja | Konkreter möglicher Schaden. |
| `likelihoodRationaleDe`, `likelihoodRationaleEn` | Text | ja | Kontextbezogene Begründung, keine erfundene Kennzahl. |
| `acceptedBy` | Rolle oder `NotAccepted` | ja | Keine stillschweigende Risikoakzeptanz. |
| `acceptanceEvidence` | Evidenzverweis | bedingt | Bei akzeptiertem Restrisiko zwingend. |

## Entität 6: Folgeaktion

Eine **Folgeaktion** beschreibt Arbeit, die bewusst nicht innerhalb dieser Selbstprüfung umgesetzt wird.

| Feld | Typ | Pflicht | Regel |
|---|---|---:|---|
| `actionId` | lokale ID | ja | Eindeutig und vom Prüfpunkt referenziert. |
| `checkpointId` | Fremdschlüssel | ja | Verweist auf genau einen `Open`- oder `FollowUp`-Prüfpunkt. |
| `actionDe`, `actionEn` | Text | ja | Konkretes Ergebnis, nicht nur „prüfen“. |
| `owner` | Rolle | ja | Zuständige Rolle. |
| `risk` | Enum plus Begründung | ja | Risiko des Aufschubs. |
| `dueDate` | Datum oder `NotScheduled` | ja | Bei fehlendem Datum muss der Trigger konkret sein. |
| `triggerDe`, `triggerEn` | Text | ja | Ereignis für Wiedervorlage. |
| `scopeRationaleDe`, `scopeRationaleEn` | Text | ja | Warum die Aktion außerhalb des Features bleibt. |
| `evidenceNeeded` | Text | ja | Nachweis für späteren Abschluss. |

## Entität 7: Abschlusszusammenfassung

Die **Abschlusszusammenfassung** aggregiert Entscheidungen, ohne sie zu ersetzen.

| Feld | Typ | Pflicht | Regel |
|---|---|---:|---|
| `assessmentId` | Referenz | ja | Verweist auf genau eine Prüfgrundlage. |
| `rowCounts` | exakte Zahlen | ja | 157 stabile plus deklarierte Zusatzzeilen; Summe je Workflowstatus. |
| `coverageCounts` | exakte Zahlen | ja | 12/12 Checklisten, 15/15 Dokumente, 11/11 Presets. |
| `highestRisks` | geordnete Liste | ja | Mindestens alle High-Risk-Entscheidungen. |
| `openEvidenceGaps` | Liste | ja | Open-Punkte mit Owner und Trigger. |
| `followUps` | Liste | ja | FollowUp-Punkte mit Owner, Risiko, Frist/Trigger und Scope-Grund. |
| `proofBoundaryDe`, `proofBoundaryEn` | Text | ja | Keine Zertifizierungs-, Rechts- oder Vollständigkeitsbehauptung außerhalb des Scopes. |
| `documentationImpact` | Literal | ja | Genau `UpdateRequired`. |
| `distribution` | Literal | ja | `sourceOnly`; `homeSyncRequired=false`. |
| `statisticsState` | Enum plus Evidence | ja | `CURRENT`, erwarteter `DRIFT` oder begrenztes Follow-up; niemals unbelegt. |
| `seriesCloseoutState` | Enum | ja | `NotStarted`, `Prepared`, `Validated` oder `BlockedByAuthority`; kein Nachfolgestart. |

## Statusübergänge und Invarianten

1. Zuerst wird fachliche Nichtanwendbarkeit geprüft. Trifft sie zu, folgt `N/A` / `N/A` / `Not Assessed`.
2. Andernfalls wird aktuelle, aussagegleiche Evidenz geprüft. Reicht sie aus, folgt `AlreadySatisfied` / `Applicable` / `Fulfilled`.
3. Ist notwendige Arbeit bewusst außerhalb des Scopes terminiert, folgt `FollowUp` mit vollständiger Folgeaktion.
4. Besteht Unsicherheit, Widerspruch oder Evidenzlücke, folgt `Open`.
5. Nur wenn der Prüfpunkt anwendbar und ein geplanter Behandlungspfad ohne offene Unklarheit dokumentiert ist, folgt `Applicable`.
6. Ein Wechsel zu `AlreadySatisfied` ist erst nach neuer Evidence zulässig; ein Status darf nicht allein durch Textänderung hochgestuft werden.
7. Ein externer Ausfall ändert nur betroffene Prüfpunkte zu `Open`; die übrige Matrix bleibt bewertbar.
8. Die deutsche und englische Hälfte enthalten dieselben IDs, Statuswerte, Zahlen, Owner, Risiken, Trigger und Evidence-Verweise.

---

# Data Model: RL-SE Checklist Self-Assessment

## Purpose and Representation

This logical model describes Markdown evidence, not a database or new runtime. Later tables remain linearly readable to people; fixed fields and value sets also support deterministic consistency checks.

## Entity 1: Assessment Baseline

An **Assessment Baseline** defines the complete, versioned scope of one self-assessment.

| Field | Type | Required | Rule |
|---|---|---:|---|
| `assessmentId` | semantic ID | yes | `2026-08-05-home-baseline-rl-se-self-assessment` for this run. |
| `repositoryLevel` | enum | yes | `Level0`. |
| `repositoryState` | Git commit or working-tree binding | yes | Commit SHA or documented diff/status evidence. |
| `assessedAt` | ISO-8601 timestamp | yes | Time of the professional decision. |
| `baselineManifest` | path, version, hash | yes | Repository-relative; baseline 3.2.0 in the inspected starting state. |
| `policySource` | path and version | yes | Secure Development Policy. |
| `checklistSources` | ordered set | yes | Exactly twelve canonical source files. |
| `stableCheckpointIds` | set | yes | Exactly the 157 unique `CL-NN-NN` identifiers extracted from source files. |
| `relatedDocuments` | set | yes | Exactly 15 manifest entries; learning and managed-reference files are separate. |
| `presetProfile` | set | yes | Exactly eleven installed presets with ID, version, and priority. |
| `evidenceBoundary` | DE/EN text | yes | Explains what the assessment proves and does not prove. |

### Relationships

- One baseline owns exactly 157 stable checkpoints and zero or more declared additional checkpoints.
- Every checkpoint references at least one baseline source.
- Every one of the 15 document and eleven preset entries is referenced by at least one checkpoint or explicit coverage row.

## Entity 2: Additional-ID Register Entry

An **Additional-ID Register Entry** declares an independent checkpoint for which no stable checklist identifier is the responsible owner.

| Field | Type | Required | Rule |
|---|---|---:|---|
| `id` | semantic ID | yes | Matches `^HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)*$`; disjoint from all `CL-*` IDs. |
| `titleDe`, `titleEn` | text | yes | Semantically equivalent. |
| `primarySource` | path plus section | yes | Repository-relative. |
| `needRationaleDe`, `needRationaleEn` | text | yes | Explains why no stable checklist ID is sufficient. |
| `crossReferences` | set | no | May add sources but must not create a second control decision. |

### Validation

- No two entries share an ID.
- Each entry creates exactly one additional matrix row.
- A checkpoint with an existing `CL-*` owner is cross-referenced rather than registered again.
- Total matrix rows equal `157 + register-entry count`.

## Entity 3: Assessment Checkpoint

An **Assessment Checkpoint** is the smallest independently decided matrix unit.

| Field | Type | Required | Rule |
|---|---|---:|---|
| `id` | `CL-NN-NN` or `HB-RLSE-*` | yes | Unique; stable checklist IDs exactly once. |
| `kind` | enum | yes | `Checklist` or `Additional`. |
| `titleDe`, `titleEn` | text | yes | Complete and semantically equivalent. |
| `primarySource` | path plus section | yes | Repository-relative, no `..`, no absolute path. |
| `crossReferences` | set | no | Related documents, presets, constitution, or existing evidence. |
| `workflowStatus` | enum | yes | `Applicable`, `AlreadySatisfied`, `N/A`, `Open`, or `FollowUp`. |
| `applicability` | enum | conditional | `Applicable`, `N/A`, or `Open` when the baseline/preset requires the axis. |
| `implementationStatus` | enum | conditional | `Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`, or `Not Assessed`. |
| `rationaleDe`, `rationaleEn` | text | yes | Explains the decision, not merely the status. |
| `evidenceRecords` | list | conditional | At least one current, semantically matching record for `AlreadySatisfied`. |
| `owner` | role | yes | Responsible role, not private contact data. |
| `reviewer` | role | yes | Professional review role. |
| `priority` | enum | yes | `High`, `Medium`, or `Low`. |
| `risk` | risk decision | yes | Impact and likelihood rationale. |
| `residualRisk` | enum plus rationale | yes | `High`, `Medium`, or `Low`, including positive states. |
| `nextActionDe`, `nextActionEn` | text | conditional | Required for `Open` and `FollowUp`; optional otherwise. |
| `dueOrReviewDate` | date or `NotScheduled` | conditional | Required for `FollowUp`; `Open` requires at least a trigger. |
| `reEvaluationTriggerDe`, `reEvaluationTriggerEn` | text | yes | Concrete state change, not vague “periodically”. |

## Entity 4: Evidence Record

An **Evidence Record** supports the precise claim of one or more checkpoints within a stated proof boundary.

| Field | Type | Required | Rule |
|---|---|---:|---|
| `evidenceId` | local ID | yes | Unique within the assessment. |
| `evidenceType` | enum | yes | `RepositoryFile`, `CommandResult`, `ExternalSource`, or `ReviewDecision`. |
| `source` | path, command, or URL label | yes | Repository paths are relative; no secrets or private local paths. |
| `stateBinding` | commit/working-tree binding | yes | Mandatory for positive repository evidence. |
| `observedAt` | ISO-8601 timestamp | yes | When the evidence was inspected. |
| `result` | text/enum | yes | Concrete outcome rather than source citation alone. |
| `retrievedAt` | ISO date | conditional | Mandatory for mutable external sources. |
| `proofBoundaryDe`, `proofBoundaryEn` | text | yes | Claim proved and excluded generalization. |

### Freshness Rules

- `RepositoryFile`: state binding, path, and semantic claim are required.
- `CommandResult`: command, timestamp, exit/result status, and state binding are required.
- `ExternalSource`: source, retrieval date, timestamp, and result are required.
- `ReviewDecision`: reviewer role, timestamp, basis, and bounded claim are required.
- If a required field is empty, the record cannot support `AlreadySatisfied`.

## Entity 5: Risk Decision

A **Risk Decision** explains checkpoint prioritization.

| Field | Type | Required | Rule |
|---|---|---:|---|
| `riskLevel` | enum | yes | `High`, `Medium`, or `Low`. |
| `impactDe`, `impactEn` | text | yes | Concrete potential harm. |
| `likelihoodRationaleDe`, `likelihoodRationaleEn` | text | yes | Contextual rationale, no invented metric. |
| `acceptedBy` | role or `NotAccepted` | yes | No silent risk acceptance. |
| `acceptanceEvidence` | evidence reference | conditional | Mandatory for accepted residual risk. |

## Entity 6: Follow-Up Action

A **Follow-Up Action** describes work intentionally not implemented during this self-assessment.

| Field | Type | Required | Rule |
|---|---|---:|---|
| `actionId` | local ID | yes | Unique and referenced by the checkpoint. |
| `checkpointId` | foreign key | yes | References exactly one `Open` or `FollowUp` checkpoint. |
| `actionDe`, `actionEn` | text | yes | Concrete outcome, not merely “review”. |
| `owner` | role | yes | Responsible role. |
| `risk` | enum plus rationale | yes | Risk of postponement. |
| `dueDate` | date or `NotScheduled` | yes | A missing date requires a concrete trigger. |
| `triggerDe`, `triggerEn` | text | yes | Event for reconsideration. |
| `scopeRationaleDe`, `scopeRationaleEn` | text | yes | Why the action remains outside this feature. |
| `evidenceNeeded` | text | yes | Proof needed for later completion. |

## Entity 7: Assessment Summary

The **Assessment Summary** aggregates decisions without replacing them.

| Field | Type | Required | Rule |
|---|---|---:|---|
| `assessmentId` | reference | yes | Refers to exactly one baseline. |
| `rowCounts` | exact numbers | yes | 157 stable plus declared additional rows; totals by workflow status. |
| `coverageCounts` | exact numbers | yes | 12/12 checklists, 15/15 documents, 11/11 presets. |
| `highestRisks` | ordered list | yes | At least every High-risk decision. |
| `openEvidenceGaps` | list | yes | Open checkpoints with owner and trigger. |
| `followUps` | list | yes | FollowUps with owner, risk, due date/trigger, and scope rationale. |
| `proofBoundaryDe`, `proofBoundaryEn` | text | yes | No certification, legal, or completeness claim beyond scope. |
| `documentationImpact` | literal | yes | Exactly `UpdateRequired`. |
| `distribution` | literal | yes | `sourceOnly`; `homeSyncRequired=false`. |
| `statisticsState` | enum plus evidence | yes | `CURRENT`, expected `DRIFT`, or bounded follow-up; never unsupported. |
| `seriesCloseoutState` | enum | yes | `NotStarted`, `Prepared`, `Validated`, or `BlockedByAuthority`; no successor start. |

## State Transitions and Invariants

1. Evaluate professional non-applicability first. If true, select `N/A` / `N/A` / `Not Assessed`.
2. Otherwise evaluate current, semantically matching evidence. If sufficient, select `AlreadySatisfied` / `Applicable` / `Fulfilled`.
3. If necessary work is intentionally scheduled outside scope, select `FollowUp` with a complete follow-up action.
4. If uncertainty, contradiction, or an evidence gap exists, select `Open`.
5. Select `Applicable` only when the checkpoint applies and a treatment path is documented without unresolved uncertainty.
6. A transition to `AlreadySatisfied` requires new evidence; status cannot be upgraded by wording alone.
7. External failure changes only affected checkpoints to `Open`; the remaining matrix remains assessable.
8. German and English halves contain identical IDs, statuses, numbers, owners, risks, triggers, and evidence references.
