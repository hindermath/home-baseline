# Spezifikationsanalyse: Resume 2026-09-09 / Specification Analysis: Resume 2026-09-09

**Phase:** `analyze-resume-20260909`  
**Feature:** `specs/032-linked-intake-evidence`  
**Ergebnis / Result:** `Blocked`  
**Umfang / Scope:** Frischer, eng begrenzter Delta-Abgleich nach
`resume-governance-delta-2026-09-09.md`. Die erfolgreiche Analyse vom
2026-09-08 dient nur als Vergleich. Keine Planung wurde neu erzeugt, keine
Implementierung gestartet und kein Core-/Run-State-Artefakt geändert.

*Fresh, narrowly bounded delta review after the 2026-09-09 governance update.
The successful 2026-09-08 analysis is comparison evidence only. No planning,
implementation, core-artifact, or run-state mutation was performed.*

## Befunde / Findings

| ID | Kategorie / Category | Schwere / Severity | Fundstelle(n) / Location(s) | Befund / Finding | Minimale Abhilfe / Minimum remediation |
|---|---|---:|---|---|---|
| I3 | Ausführungsreihenfolge / Execution order | HIGH | `tasks.md:201-203`, `215-217`, `229-231`, `246-248`, `260-262`, `279-281`; `plan.md:231-240`, `437-443`; `scripts/render-project-statistics.ps1:1246-1250` | Sechs Downstream-Slots ändern zuerst Statistikquelle und weitere Dateien und verlangen dann noch vor dem ersten Commit einen schreibenden Statistiklauf. Der normal installierte Renderer verweigert bei Drift jeden Write im dirty Worktree. Die akzeptierten Baselines binden in allen sechs Zielen denselben Rendererhash. Anders als Home T071 besitzt keiner dieser Slots einen ausführbaren sauberen Quellcheckpoint vor dem Rendern. Damit sind Statistik-Gate und nachfolgender lokaler Gateabschluss so nicht ausführbar. | Innerhalb der vorhandenen IDs die Paare T084/T086, T095/T097, T106/T108, T120/T122, T131/T133 und T147/T149 analog zu T069/T071 präzisieren: Quelle plus übrigen Kandidaten check-only vorbereiten, begrenzt committen, erst im wirklich sauberen Checkout rendern, den Ledger fokussiert nachcommitten, alle betroffenen lokalen Gates am finalen Head wiederholen, dann pushen und native Proofs ausführen. Keine neue Task und kein Guard-Bypass. |
| I4 | Vertragswiderspruch / Contract inconsistency | HIGH | `spec.md:160-162`; `plan.md:399-401`; `contracts/linked-intake-view.md:22-29` | LAF-003 und der Plan verlangen den vollständigen tatsächlichen Markdown-Dateinamen als Linktext. Der bindende View-Vertrag erlaubt dagegen alternativ ein „established display label“ und damit einen verkürzten Titel. Das lässt einen Kernoutput trotz fünf korrekter Spalten vertragskonform falsch erscheinen. | In `contracts/linked-intake-view.md` ausschließlich den vollständigen Basename von `intakePath` einschließlich `.md` als sichtbaren Linktext zulassen; danach vorhandene Fixtures/Hashes und T028/T029-Abnahmetests gegen diese eine Regel revalidieren. |
| I5 | Aktuelle Bindung / Current binding | MEDIUM | `tasks.md:3`; `.specify/memory/constitution.md:1179` und identisch `constitution.md:1179` | Der aktuelle Task-Header bindet weiterhin Constitution v1.21.0, obwohl beide verbindlichen Spiegel nach der genehmigten Korrektur v1.21.1 sind. Die alten Planbeobachtungen sind als datiert gekennzeichnet; diese aktuelle Input-Zeile ist es nicht. | Nur die aktuelle Task-Input-Bindung auf v1.21.1 beziehungsweise „current Constitution“ berichtigen und den parent-owned Taskhash anschließend durch den Parent neu binden. |
| I6 | Traceability | MEDIUM | `acceptance-mapping.md:55`; `tasks.md:15-19` | Die CHK013-CHK016-Zuordnung enthält den nicht existierenden Token `T65` statt `T065`. Alle 169 definierten Task-IDs sind zwar eindeutig, doch diese Mapping-Zeile verletzt ihre eigene Bedingung „kein nicht existierender Identifier“. | `T033–T65` zu `T033–T065` korrigieren und die bestehende T024/T025-Identifierprüfung erneut ausführen; IDs, Anzahl und Checkboxen bleiben unverändert. |

## Abdeckung / Coverage

| Familie / Family | Bestand / Present | Task-Abdeckung / Task coverage | Aktuelle Disposition / Current disposition |
|---|---:|---:|---|
| `LAF-001`–`LAF-035` | 35/35 | 35/35 | Vorhanden; I4 blockiert die eindeutige Ausführbarkeit von LAF-003. |
| `CR-001`–`CR-014` | 14/14 | 14/14 | Vorhanden; I3 blockiert die verpflichtende Statistik-Ausführung, I5 bindet eine alte Verfassungsrevision. |
| `SC-001`–`SC-010` | 10/10 | 10/10 | Vorhanden; I3 verhindert derzeit den planmäßigen Nachweis von SC-008 in sechs Slots. |
| `AC-LAF-001`–`AC-LAF-014` | 14/14 | 14/14 | Vorhanden; I4 betrifft AC-LAF-003, I3 AC-LAF-012. |
| `CHK001`–`CHK044` | 44/44 | 44/44 beabsichtigt / intended | I6 macht die konkrete CHK013-CHK016-Referenz syntaktisch falsch. |

Die frühere Zuordnung wird nicht als neue Coverage erfunden: 59/59 baubare
Anforderungen und 14/14 Acceptance-Gates besitzen weiterhin geplante Tasks.
Coverage bedeutet hier Vorhandensein, nicht bestandenes Gate. Es gibt keine
unmapped Taskdefinition. `tasks.md` enthält genau 169 eindeutige Definitionen
T001-T169; genau 27 sind tatsächlich `[x]`, 142 bleiben offen. Der rohe
`tasks.md`-SHA-256 `c9fe1330f5b5eec217413c9f96d50d1d5fdbe83164f43f3b3bacb91e9423869b`
stimmt mit dem parent-owned Run-State überein.

*The prior mapping is reused, not invented: all 59 buildable requirements and
14 acceptance gates still have planned task coverage. Coverage is presence,
not a passed gate. There are 169 unique task definitions, 27 genuinely checked
and 142 open; the task hash matches the parent-owned state.*

## Verfassungs- und Pflichtregelabgleich / Constitution and mandatory-rule delta

- **Akzeptierte Eingaben:** `8/8 MATCH`; alle rohen SHA-256 stimmen mit dem
  Run-State überein. Der Run-State wurde nur gelesen.
- **Assurance v0.1.3:** `Applicable/Fulfilled` für den aktuellen Home-Profilcheck;
  der exakte 13-Preset-Check bestand in diesem Lauf mit Exit 0. Exakte,
  case-sensitive Kontextwahl, `contextId`/`mode`-Bindung und Array-typisierte
  `acceptedRisks` sind korrekt dispositioniert. Die aktuellen Home-/AOC-Kontexte
  enthalten kein `acceptedRisks`; es wurde keine Risikoannahme erfunden.
- **AOC:** `Open` als spätere Ausführungsvoraussetzung, nicht als fehlender
  Planschritt. T079 enthält Fast-forward, frische Inventur, lokalen `0/0`- und
  exakten 13-Preset-Nachweis vor AOC-Writes. Remote-Evidence ist kein lokaler
  Pass.
- **Native Reihenfolge:** `Closed/Planned`. T071/T086/T097/T108/T122/T133/T149
  committen und pushen den Checkpoint vor exact-head Linux-/Windows-Proofs.
  Noch nicht ausgeführte native Gates bleiben ehrlich `Open`, sind aber kein
  Analyze-Befund, weil ausführbare Zukunftstasks existieren.
- **Statistik:** Home besitzt mit T069/T071 und T158/T161 einen echten
  Clean-Worktree-Pfad. Die sechs Downstream-Lücken sind separat I3; ein bloß
  noch nicht erreichter Gatezustand wurde nicht als Fehler gewertet.
- **Fünf Felder und Position:** Die fünf Spalten sowie die Trennung von aktivem
  Manifestplatz 1 und sichtbarer Position 39 bleiben in Spec, Tasks und Fixture
  erhalten. I4 betrifft ausschließlich die widersprüchlich erlaubte
  Linkbeschriftung.
- **Human-only-Grenze:** Technische `Ready`-/`Fulfilled`-Evidence erteilt keine
  Pilot-, Projektabnahme-, Release-, Rollout- oder Zertifizierungsfreigabe.
- **Liefergrenze:** Der lokale Integrationsmerge ist Baseline-Integration, keine
  Feature-Payload-Lieferung. Die historischen Analyze-Berichte bleiben
  bytegenau; ihre spätere exakte `.gitattributes`-Klassifikation ist geplant und
  kein heutiger Blocker.

*Accepted inputs remain 8/8 exact. Home's v0.1.3 thirteen-preset profile passes;
AOC local proof remains a correctly tasked future prerequisite. Native proof is
ordered after checkpoint push. Human decisions remain separate. The integration
merge is baseline context, not feature delivery. Only the six missing clean
statistics transitions are an execution-plan defect.*

## Metriken / Metrics

- Anforderungen / Requirements: 59
- Acceptance-Gates: 14
- Geplante Coverage / Planned coverage: 73/73 (100%)
- Tasks: 169 (27 checked, 142 open)
- Unmapped tasks: 0
- Critical: 0
- High: 2
- Medium: 2
- Low: 0
- Ambiguity findings: 0
- Duplication findings: 0

## Gate-Entscheidung und nächste Aktion / Gate decision and next action

`Blocked`. I3 und I4 sind ungelöste High-Befunde; I5 und I6 sind ungelöste
Medium-Befunde ohne dokumentierte Owner-Akzeptanz. Vor T028/T029 sind nur die
vier minimalen Artefaktkorrekturen vorzunehmen und task-/hashgebunden zu
revalidieren; danach genügt ein neuer eng begrenzter `/speckit.analyze`-Lauf.
Keine Implementierung, Fleet-Neuinventur oder neue Task-ID ist erforderlich.

*Blocked by two unresolved High and two unresolved Medium findings. Apply only
the four bounded artifact remediations, rebind/revalidate the task evidence, and
then run one fresh narrow Analyze. Do not start implementation.*

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired` ausschließlich für diesen featurelokalen Analyze-Nachweis.
Owner: Feature-032-Analyze-Reviewer. Zielgruppe: Parent-Orchestrator und nächster
Runner. Leserpfad: Resume-Audit -> Governance-Delta -> dieser Bericht.
Dokumentklasse/Distribution: `sourceOnly`; kein Home-Sync. Wiedervorlage nach
den vier Korrekturen oder bei Input-, Constitution-, Profil-, Scope-, Head- oder
Authority-Drift.

*This report is the source-only Analyze result; no Home sync. Re-evaluate after
the four corrections or any relevant binding drift.*
