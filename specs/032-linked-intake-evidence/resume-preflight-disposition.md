# Wiederanlauf: begrenzte Plan-Korrekturen / Resume: bounded plan corrections

## Umfang und Ergebnis / Scope and outcome

Der Wiederanlauf behält alle 169 Task-IDs und die acht akzeptierten
Intake-/Review-/Series-Artefakte. Geändert werden nur die durch die aktuelle
Prüfung belegten Ausführungsdetails. Keine Implementierungsaufgabe wird durch
dieses Dokument abgeschlossen. Thorsten hat die gesonderte C1-Spiegelkorrektur
ausdrücklich genehmigt; sie ist lokal umgesetzt und wird erneut analysiert.

*The resume preserves all 169 task IDs and eight accepted input artifacts.
Only verified execution details are amended. This document completes no
implementation task. Thorsten explicitly authorised the separate C1 mirror
correction; it is applied locally and awaits fresh analysis.*

## C1: Genehmigte Spiegelkorrektur / Authorised mirror correction

Die vier Versionsverweise in `constitution.md` und
`.specify/memory/constitution.md` nennen jetzt die bereits kanonische
`autonomous-run-governance`-Version `0.4.1`. Beide Kopien erhalten die rein
redaktionelle Patch-Version `1.21.1`; Ratified bleibt unverändert. Last Amended
ist vor der Lieferung mit dem tatsächlichen Merge-Datum abzugleichen.
Prinzipien, Presets und Berechtigungsgrenzen bleiben unverändert. Beide Pfade
gehören ausschließlich für diese genehmigte Korrektur zum Delivery-Set.

`cmp` bestätigt byte-identische Kopien; `git diff --check` besteht. Die Suche
in beiden Constitutions, fünf Agentenflächen und den abhängigen Vorlagen
findet keine alten `0.3.4`-Verweise. Spec-, Plan-, Tasks-Vorlagen und README
benötigen keine inhaltliche Anpassung; Command-Vorlagen sind nicht vorhanden.

*Both mirrors now reference canonical v0.4.1 and carry editorial patch v1.21.1.
Ratification and all rules remain unchanged. Check the amendment date at merge.
The two narrowly authorised paths join the delivery set. Byte equality and
whitespace checks pass; dependent guidance requires no semantic update. No
preset installation, remote write or implementation completion is implied.*

## I1: Plattformnachweis nach dem Commit / Platform proof after commit

Der Native-Proof-Checkpointvertrag in `tasks.md` legt die Reihenfolge fest:
lokale Gates, exakte Kandidatenprüfung, Staging/Secret-Check, Commit und Push,
native Tests am unveränderten Remote-Head, danach PR und Review. Die späteren
Kandidatenaufgaben prüfen nur lesend; sie erzeugen keinen neuen Head. Bei
Änderungen wird die betroffene Beweiskette erneut ausgeführt. Es gibt weder
eine CI-Ausnahme noch eine vorweggenommene Merge-Freigabe.

*The task contract freezes and pushes the candidate before native proof.
Later candidate tasks are read-only. Changed bytes or heads require fresh
affected proof; no CI exception or premature merge decision is introduced.*

## I2: Branch-Identitäten / Branch identities

Frische `git fetch --prune origin`, lokale/entfernte Ref-Inventuren und
vorhandene Featureverzeichnisse am 2026-09-08 belegen:

| Repository | Alter Plan / Old plan | Aktueller Plan / Current plan | Grund / Reason |
|---|---|---|---|
| Home | `032` | `032` | Bestehender Lauf / existing run |
| AOC | `003` | `004` | `003-authoring-contract` existiert / exists |
| TinyPl0 | `006` | `007` | `006-embeddable-vm-nuget` existiert / exists |
| TinyCalc | `004` | `006` | Features `004` und `005` existieren / exist |
| InventarWorkerService | `003` | `003` | Keine Kollision / no collision |
| TuiVision | `047` | `047` | Keine Kollision / no collision |
| absdd-image-sandbox | `004` | `004` | Vorgänger `003` abgeschlossen / predecessor completed |

Alle Remotes gehören zum erwarteten `hindermath`-Repository; der per `gh`
ermittelte Default-Branch ist jeweils `main`. Die sechs Downstream-Repositories
sind sauber und bei `0/0`. Unmittelbar vor jeder späteren Branch-Erstellung
bleibt eine erneute Prüfung Pflicht. Kein Downstream-Branch wurde angelegt.

*All remotes and main defaults match. All six downstream checkouts are clean
at 0/0. Recheck before branch creation; no downstream branch was created.*

Aktueller Overlay vom 2026-09-09: Diese 0/0-Aussage bleibt ein historischer
Prüfpunkt. AOC local `main` ist weiterhin sauber auf `17df5332f4d4b6923b1596e11ebfb56d2629a5cc`,
aber fünf Commits hinter `origin/main`
`49bfa60c4c74cc3225b49c308e80ef777827bdf6`. Vor AOC-Featurewrites sind
Fast-forward, frische Base-/Quellinventur, lokaler 0/0-Nachweis und erneute
Branchnummernprüfung verpflichtend. Die übrige Flotte wurde in diesem Delta
nicht erneut inventarisiert.

*Current 2026-09-09 overlay: the prior 0/0 statement is historical. AOC local
main is clean but five commits behind the named origin/main. Fast-forward,
fresh base/source inventory, local 0/0 proof and branch-number revalidation are
mandatory before AOC feature writes. This delta does not repeat the remaining
fleet inventory.*

## G1: Tatsächliche Preset-Profile / Actual preset profiles

Die Checks vom 2026-09-08 bleiben historische Evidence: Acht-only endete wegen
der dokumentierten Zusatzpresets mit Exit 1, und der damalige Dreizehn-Check
gegen Home v0.1.2 ebenfalls mit Exit 1. Sie werden nicht rückwirkend
umetikettiert. Aktuell ist Home auf Assurance v0.1.3; der folgende exakte
13-Preset-Check wurde am 2026-09-09 mit Exit 0 ausgeführt:

```bash
bash scripts/install-spec-kit-governance-presets.sh --check-only \
  --preset-config scripts/config/spec-kit-secure-development-assurance-governance-presets.json \
  --repo .
```

*The 2026-09-08 eight-only and Home-v0.1.2 failures remain historical evidence
and are not relabelled. Home now has Assurance v0.1.3; the exact thirteen-preset
command above passed with exit 0 on 2026-09-09.*

Die repositoryweise Prüfung verwendet aus Level 0 folgende exakte Befehle:

```bash
bash scripts/install-spec-kit-governance-presets.sh --check-only \
  --preset-config scripts/config/spec-kit-model-routing-governance-presets.json \
  --repo ../RiderProjects/AgentOperationsCockpit
bash scripts/install-spec-kit-governance-presets.sh --check-only \
  --preset-config scripts/config/spec-kit-secure-development-assurance-governance-presets.json \
  --repo ../RiderProjects/TinyPl0 --repo ../RiderProjects/TinyCalc \
  --repo ../RiderProjects/InventarWorkerService --repo ../RiderProjects/TuiVision \
  --repo ../container-images/absdd-image-sandbox
bash scripts/install-spec-kit-governance-presets.sh --check-only \
  --preset-config .specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/resume-2026-09-08/home-accepted-assurance-v012-matrix.json \
  --repo .
specify preset list
```

Die vier Befehle im historischen Block oben bleiben ausschließlich der
2026-09-08-Disposition zugeordnet. Für AOC belegt `git show origin/main` am
Remote-Commit `49bfa60c4c74cc3225b49c308e80ef777827bdf6` Assurance v0.1.3 und den
formalen Kontext `aoc-assurance-v013`; das lokale `main` enthält diese Bytes
noch nicht. Deshalb wird weder der alte 12er-Check wiederholt noch ein lokaler
13er-Pass behauptet. Nach Fast-forward muss T079 den aktuellen 13er-Check lokal
ausführen.

*The four historical commands remain evidence for the 2026-09-08 disposition
only. `git show origin/main` proves AOC v0.1.3 and its formal context at the
named remote commit, but local main does not yet contain those bytes. No local
thirteen-preset pass is claimed; T079 must prove it after fast-forward.*

Assurance-v0.1.3-Regeldelta: Reviews wählen genau ein datiertes Verzeichnis mit
vollständiger, case-sensitiver Kontext-ID; Evidence-`contextId` und `mode`
müssen exakt dem Aufruf entsprechen. Wenn `acceptedRisks` vorhanden ist, ist
es ausschließlich ein JSON-Array; jedes Risiko behält eine skalare,
nichtleere Text-ID sowie Owner, Reviewer, Reviewdatum, Wiedervorlage,
Restrisiko und Re-Evaluation-Trigger. Ein leeres Array ist bei
`ReadyWithAcceptedRisks` unzulässig. Die aktuellen Kontexte verwenden
`home-baseline-assurance-v013`/`training` und remote
`aoc-assurance-v013`/`training`; `acceptedRisks` ist in ihren vier Gate-Dateien
nicht vorhanden, also wird keine Risikoannahme neu erzeugt.

Für Feature 032 bleiben eine erneute Kontrollbewertung und Imagewirkung
begrenzt `N/A / Not Assessed`, weil dieses Feature keine dieser formalen
Kontextdateien und keinen Produkt-/Runtime-/Image-Scope ändert. Owner:
Feature-Orchestrator; Reviewer: separater neuer Analyze-Lauf. Restrisiko:
strukturelles `Ready` könnte fälschlich als fachliche Umsetzung oder Freigabe
gelesen werden. Re-Evaluation: Kontext-/Mode-/Risk-Schema-, Evidence-, Scope-,
Authority-, Produkt-/Runtime-/Image- oder installierte Profiländerung sowie vor
dem jeweiligen Repositoryslot. `technicalValidation=Fulfilled` bleibt
technisch; Pilot, Projektabnahme, allgemeines Release, Zertifizierung und
Rollout bleiben menschliche beziehungsweise gesonderte Entscheidungen.

*v0.1.3 requires one exact dated context directory, exact contextId/mode
binding, and array-typed acceptedRisks with typed IDs and review metadata.
Neither current context contains acceptedRisks. Feature 032 changes no formal
context or product/runtime/image scope, so renewed control assessment and image
impact are bounded N/A / Not Assessed with the named owner, residual risk and
triggers. Existing technical Ready evidence grants no human approval,
certification or rollout.*

## Delivery-Vorbereitung / Delivery preparation

Die historischen Analyze-Payloads
`checklists/resume-analysis-2026-09-08.md` und
`checklists/resume-reanalysis-2026-09-08.md` bleiben mit den gebundenen rohen
SHA-256 `3688723e...` und `0d8861b6...` bytegenau erhalten. Sie enthalten
zusammen sieben beabsichtigte Markdown-Hard-Break-Zeilen mit zwei abschließenden
Leerzeichen. Vor ihrem späteren Staging darf `.gitattributes` nur für genau
diese zwei Pfade `whitespace=-trailing-space` setzen. T071 prüft die Attribute,
beide Hashes und danach den vollständigen staged Diff ohne Pfadausschluss. Ein
Wildcard, globales `core.whitespace`, `--no-verify` oder Editieren der Payloads
ist unzulässig.

Ledger und Konfiguration behalten alle publizierten und lokalen Quellen. Der
Statistikrenderer verweigert Schreibmodus im dirty Checkout; deshalb ist die
Statistik aktuell nicht als current belegt. Unter bestehender `MergeAndSync`-
Autorität erstellt T071 beziehungsweise T161 zuerst einen begrenzten
Quellcheckpoint, führt den Renderer erst im wirklich sauberen Checkout aus,
prüft CheckOnly und PowerShell und liefert den erzeugten Ledger als fokussierten
Follow-up. Kein Stash, Fake-Repository/-Index oder Guard-Override.

*Both historical Analyze payloads remain byte-exact. A later exact-path
whitespace attribute classifies only their intentional Markdown hard breaks;
hashes and the full staged diff remain mandatory. Statistics sources are
preserved, but current output is not claimed. Existing MergeAndSync authority
uses a real clean source checkpoint before rendering and a focused generated
follow-up, without stash, fake repository/index, or guard override.*

## Weitere wiederverwendbare Evidence / Additional reusable evidence

Die ignorierte Evidence liegt unter dem Run-Verzeichnis
`resume-2026-09-08/parent-preflight-facts.json` und `source-baselines/`.
3.050 SHA-256-Bindungen decken die ausgewählten Quellen der sieben Repos ab;
die Erfassung hatte null Writes in Zielrepositories. AOCs aktueller
`python3 -B specs/001-programmquellen-baseline/contracts/validate_meta_lh01.py --repo . global-ready`
bestand mit 14 aktuellen Ready-Receipt-/Review-Bindungen und unveränderter
META-LH-02-Historie. Dies startet kein AOC-Programmfeature.

*Ignored run-local facts and 3,050 source hashes preserve the seven-repository
baseline with zero target writes. AOC global-ready passes for all 14 bindings;
this observation starts no programme feature.*

## Documentation Impact

`UpdateRequired`: feature-local source-only execution correction and evidence
navigation; owner Feature-Orchestrator, readers maintainer/reviewer/next
runner, DE-first/EN-second. No Home sync for these documents. Re-evaluate on
Analyze findings, source/branch/profile changes or changed delivery authority.
