# Quickstart: Validierung der RL-SE-Checklisten-Selbstprüfung

Dieser Leitfaden wird nach der Implementierung vom Repository-Wurzelverzeichnis `~/home-baseline-source` ausgeführt. Er verändert in den Szenarien 1 bis 4 keine fachlichen Quelldateien. Das Statistik-Rendering in Szenario 5 ist ausdrücklich ein späterer Schreibschritt und darf nur bei sauberem Arbeitsbaum und passender Autorität erfolgen.

## Voraussetzungen

- Aktiver Branch: `025-rl-se-self-assessment`
- Verfügbar: Git, Bash, PowerShell 7, Python 3, `jq`, `rg`, `specify`
- Die Ergebnisdateien aus dem [Artefaktvertrag](./contracts/assessment-artifact-contract.md) sind umgesetzt.
- Für positive Evidence wird der tatsächlich geprüfte Commit oder Arbeitsbaumstatus dokumentiert.

```bash
git branch --show-current
git rev-parse HEAD
git status --short
```

**Erwartung**: Der Branch stimmt. Commit und Arbeitsbaumzustand entsprechen exakt der Bindung in Matrix und Summary; ein nicht sauberer Arbeitsbaum ist ausdrücklich dokumentiert und wird nicht als Commit-Evidence ausgegeben.

## Szenario 1: Intake-, Review- und Series-Bindung

```bash
bash .specify/presets/intake-sequencing-governance/scripts/validate-intake-governance-config.sh \
  --config requirements/intake-governance-config.json --repo . --json
bash .specify/presets/intake-authoring-governance/scripts/validate-intake-authoring-receipt.sh \
  --receipt specs/intake-authoring-receipts/rl-se-checklist-selbstpruefung.json --repo .
bash .specify/presets/intake-review-governance/scripts/validate-intake-review-result.sh \
  --result specs/rl-se-checklist-selbstpruefung-intake-review/intake-review-result.json --repo .
bash .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-manifest.sh \
  --file requirements/intakes/series/home-baseline-delivery/manifest.json --repo . --json
bash .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-receipt.sh \
  --file requirements/intakes/series/home-baseline-delivery/receipt.json --repo . --json
```

PowerShell-7-Gegenprobe:

```bash
pwsh -NoProfile -File .specify/presets/intake-sequencing-governance/scripts/validate-intake-governance-config.ps1 -Config requirements/intake-governance-config.json -Repo . -Json
pwsh -NoProfile -File .specify/presets/intake-authoring-governance/scripts/validate-intake-authoring-receipt.ps1 -Receipt specs/intake-authoring-receipts/rl-se-checklist-selbstpruefung.json -Repo .
pwsh -NoProfile -File .specify/presets/intake-review-governance/scripts/validate-intake-review-result.ps1 -Result specs/rl-se-checklist-selbstpruefung-intake-review/intake-review-result.json -Repo .
pwsh -NoProfile -File .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-manifest.ps1 -File requirements/intakes/series/home-baseline-delivery/manifest.json -Repo . -Json
pwsh -NoProfile -File .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-receipt.ps1 -File requirements/intakes/series/home-baseline-delivery/receipt.json -Repo . -Json
```

**Erwartung**: Alle Validatoren bestehen. Die aktuellen Graphzahlen werden als Evidence festgehalten, aber nicht als dauerhaft angenommen. Eine rechnerisch unblocked Root erteilt keine Delivery Authority.

## Szenario 2: Baseline- und Mapping-Drift ausschließen

```bash
bash scripts/build-secure-development-docs.sh --check
pwsh -NoProfile -File scripts/build-secure-development-docs.ps1 -Check
python3 specs/024-mitgeltende-dokumente-verzahnung/tests/test_mapping.py
python3 specs/024-mitgeltende-dokumente-verzahnung/tools/validate_mapping.py --repo .
specify preset list
```

Die kanonische ID-Menge prüfen:

```bash
validation_dir="$(mktemp -d)"
printf 'Temporäre Prüfdaten / temporary validation data: %s\n' "$validation_dir"
awk '/^#### CL-[0-9][0-9]-[0-9][0-9]:/ { value=$2; sub(/:$/, "", value); print value }' \
  docs/secure-development/checklisten/*.md | sort > "$validation_dir/source-ids.txt"
test "$(wc -l < "$validation_dir/source-ids.txt" | tr -d ' ')" = "157"
test "$(sort -u "$validation_dir/source-ids.txt" | wc -l | tr -d ' ')" = "157"
```

**Erwartung**: Beide Builder bestehen; Mapping-Tests melden 7/7; der Validator meldet 12 Checklisten, 157 Punkte, 15 Dokumente und 8+3 Presets. Die ID-Datei enthält 157 Zeilen und 157 eindeutige Werte. Das ausgegebene temporäre Verzeichnis enthält nur öffentliche Kontroll-IDs und kann nach der Prüfung gezielt entfernt werden.

## Szenario 3: Matrixvertrag und Evidence-Frische

```bash
matrix_path='docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md'
summary_path='docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md'
test -f "$matrix_path"
test -f "$summary_path"
```

Die Primärzeilen der deutschen Matrixhälfte werden nach dem im Artefaktvertrag festgelegten ersten ID-Feld extrahiert. Die Implementierung dokumentiert den exakten Bereich zwischen den deutschen Matrixmarken; dieselbe Abfrage wird für Englisch wiederholt.

```bash
awk -F'|' '$2 ~ /^ CL-[0-9][0-9]-[0-9][0-9] / { value=$2; gsub(/^ +| +$/, "", value); print value }' \
  "$matrix_path" | sort > "$validation_dir/matrix-cl-ids.txt"
test "$(sort -u "$validation_dir/matrix-cl-ids.txt" | wc -l | tr -d ' ')" = "157"
comm -3 "$validation_dir/source-ids.txt" "$validation_dir/matrix-cl-ids.txt"
```

**Erwartung**: Die eindeutige CL-Menge umfasst 157 IDs; `comm -3` gibt nichts aus. Falls beide Sprachhälften durch dieselbe generische Abfrage erfasst werden, muss die Implementierung stattdessen die dokumentierten Sprachbereichsmarker verwenden und je Sprachhälfte 157/157 beweisen.

Zusätzliche Vertragsprüfungen:

```bash
rg -n '^\| HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)* ' "$matrix_path"
rg -n '\b(Applicable|AlreadySatisfied|N/A|Open|FollowUp)\b' "$matrix_path"
rg -n '\b(High|Medium|Low)\b' "$matrix_path"
rg -n '/Users/|[A-Za-z]:\\|(^|/)\.\.(/|$)' "$matrix_path" "$summary_path"
```

**Erwartung**:

- Jede Zusatz-ID steht genau einmal je Sprachhälfte und besitzt einen Registereintrag.
- Es erscheinen nur die vertraglichen Status-, Prioritäts- und Restrisikowerte.
- Jede `AlreadySatisfied`-Entscheidung verweist auf vollständige Zustands-, Zeit- und Ergebnisevidence.
- Jede `N/A`-, `Open`- und `FollowUp`-Entscheidung erfüllt ihre statusabhängigen Pflichtfelder.
- Der letzte `rg`-Aufruf findet keine privaten oder aufwärts gerichteten Pfade; Exitcode 1 bedeutet hier „kein Treffer“ und ist das erwartete Ergebnis.
- Eine absichtlich als nicht erreichbar dokumentierte externe Quelle setzt nur ihren Prüfpunkt auf `Open`; die Summary bleibt vollständig.

## Szenario 4: Sprache, A11Y, Navigation und Repository-Gates

Semantische Review-Checkliste:

1. Vollständiges Deutsch steht vor vollständigem Englisch.
2. Beide Hälften besitzen dieselben IDs, Statuswerte, Zahlen, Owner, Risiken, Trigger und Evidence-Verweise.
3. Fachbegriffe und Abkürzungen werden beim ersten Auftreten erklärt.
4. Überschriften und Tabellen sind linear verständlich; keine Aussage hängt nur von Farbe, Symbol oder Position ab.
5. `docs/security/README.md` führt zur datierten Matrix und Summary und beschreibt das Repository korrekt als Level 0.

Documentation Impact und Repository prüfen:

```bash
bash scripts/validate-documentation-impact.sh \
  --evidence specs/025-rl-se-self-assessment/documentation-impact-evidence.json
pwsh -NoProfile -File scripts/validate-documentation-impact.ps1 \
  -Evidence specs/025-rl-se-self-assessment/documentation-impact-evidence.json
git diff --check
lychee --offline --include-fragments . './**/*.md'
bash scripts/check-homogeneity.sh .
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
bash scripts/scan-agent-secrets.sh --fail-on-high .
specify check
```

**Erwartung**: Documentation Impact ist genau `UpdateRequired`, Distribution `sourceOnly`, `homeSyncRequired=false`. Alle vom tatsächlichen Diff betroffenen Gates bestehen. Ein nicht installiertes optionales Werkzeug wird gemäß Repository-Vertrag dokumentiert und nicht als positives Ergebnis erfunden.

## Szenario 5: Statistik und kausaler Series-Closeout

Statistiktests und lesende Driftprüfung:

```bash
pwsh -NoProfile -File scripts/test-render-project-statistics.ps1
bash scripts/render-project-statistics.sh --repo . --check-only --json
```

**Erwartung**: Die Fixture-Tests bestehen. Vor einer autorisierten Commit-Bindung kann der Git-basierte Block erwartbar `DRIFT` mit Exitcode 1 melden. Das ist transparent in der Summary festzuhalten und kein technischer Fehler.

Nur nach separater Lieferautorität, einem Source-Commit und sauberem Arbeitsbaum:

```bash
bash scripts/render-project-statistics.sh --repo .
bash scripts/render-project-statistics.sh --repo . --check-only --json
pwsh -NoProfile -File scripts/render-project-statistics.ps1 -Repo . -CheckOnly -Json
```

**Erwartung**: Der Renderer ändert nur den kanonisch gesteuerten Statistikbereich; beide Prüfpfade melden danach `CURRENT`. Wenn diese Voraussetzungen unter `LocalImplementation` fehlen, bleibt ein vollständiger Follow-up-Vertrag statt eines erzwungenen Renderings.

Der Series-Closeout ist ein eigener kausaler Nachweis:

- erst nach vollständiger und validierter Matrix/Summary;
- Graphwerte aus dem dann aktuellen Manifest neu berechnen;
- bisherige Manifest-/Receipt-Dateien bytegleich archivieren;
- Nachfolger-Manifest/-Receipt, Operationsjournal, Supersession-Hashes und Order-Dokument gemeinsam validieren;
- Bash- und PowerShell-Series-Validatoren erneut ausführen;
- keinen Nachfolgeintake starten;
- ohne neue Autorität weder committen noch pushen, PR erstellen oder mergen.

---

# Quickstart: Validating the RL-SE Checklist Self-Assessment

Run this guide from the repository root `~/home-baseline-source` after implementation. Scenarios 1 through 4 do not modify professional source files. Statistics rendering in Scenario 5 is explicitly a later write step and is allowed only with a clean worktree and appropriate authority.

## Prerequisites

- Active branch: `025-rl-se-self-assessment`
- Available: Git, Bash, PowerShell 7, Python 3, `jq`, `rg`, `specify`
- The result files from the [artifact contract](./contracts/assessment-artifact-contract.md) are implemented.
- Positive evidence records the actual assessed commit or working-tree state.

```bash
git branch --show-current
git rev-parse HEAD
git status --short
```

**Expected**: The branch matches. Commit and working-tree state exactly match the matrix and summary binding; a dirty worktree is explicitly documented and is not presented as commit evidence.

## Scenario 1: Intake, Review, and Series Binding

```bash
bash .specify/presets/intake-sequencing-governance/scripts/validate-intake-governance-config.sh \
  --config requirements/intake-governance-config.json --repo . --json
bash .specify/presets/intake-authoring-governance/scripts/validate-intake-authoring-receipt.sh \
  --receipt specs/intake-authoring-receipts/rl-se-checklist-selbstpruefung.json --repo .
bash .specify/presets/intake-review-governance/scripts/validate-intake-review-result.sh \
  --result specs/rl-se-checklist-selbstpruefung-intake-review/intake-review-result.json --repo .
bash .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-manifest.sh \
  --file requirements/intakes/series/home-baseline-delivery/manifest.json --repo . --json
bash .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-receipt.sh \
  --file requirements/intakes/series/home-baseline-delivery/receipt.json --repo . --json
```

PowerShell 7 cross-check:

```bash
pwsh -NoProfile -File .specify/presets/intake-sequencing-governance/scripts/validate-intake-governance-config.ps1 -Config requirements/intake-governance-config.json -Repo . -Json
pwsh -NoProfile -File .specify/presets/intake-authoring-governance/scripts/validate-intake-authoring-receipt.ps1 -Receipt specs/intake-authoring-receipts/rl-se-checklist-selbstpruefung.json -Repo .
pwsh -NoProfile -File .specify/presets/intake-review-governance/scripts/validate-intake-review-result.ps1 -Result specs/rl-se-checklist-selbstpruefung-intake-review/intake-review-result.json -Repo .
pwsh -NoProfile -File .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-manifest.ps1 -File requirements/intakes/series/home-baseline-delivery/manifest.json -Repo . -Json
pwsh -NoProfile -File .specify/presets/intake-sequencing-governance/scripts/validate-intake-series-receipt.ps1 -File requirements/intakes/series/home-baseline-delivery/receipt.json -Repo . -Json
```

**Expected**: Every validator passes. Current graph counts are captured as evidence but not treated as permanent. A mathematically unblocked root does not grant delivery authority.

## Scenario 2: Exclude Baseline and Mapping Drift

```bash
bash scripts/build-secure-development-docs.sh --check
pwsh -NoProfile -File scripts/build-secure-development-docs.ps1 -Check
python3 specs/024-mitgeltende-dokumente-verzahnung/tests/test_mapping.py
python3 specs/024-mitgeltende-dokumente-verzahnung/tools/validate_mapping.py --repo .
specify preset list
```

Check the canonical ID set:

```bash
validation_dir="$(mktemp -d)"
printf 'Temporäre Prüfdaten / temporary validation data: %s\n' "$validation_dir"
awk '/^#### CL-[0-9][0-9]-[0-9][0-9]:/ { value=$2; sub(/:$/, "", value); print value }' \
  docs/secure-development/checklisten/*.md | sort > "$validation_dir/source-ids.txt"
test "$(wc -l < "$validation_dir/source-ids.txt" | tr -d ' ')" = "157"
test "$(sort -u "$validation_dir/source-ids.txt" | wc -l | tr -d ' ')" = "157"
```

**Expected**: Both builders pass; mapping tests report 7/7; the validator reports 12 checklists, 157 items, 15 documents, and 8+3 presets. The ID file contains 157 lines and 157 unique values. The printed temporary directory contains public control identifiers only and may be removed deliberately after validation.

## Scenario 3: Matrix Contract and Evidence Freshness

```bash
matrix_path='docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-matrix.md'
summary_path='docs/security/secure-development/2026-08-05-home-baseline-rl-se-self-assessment/assessment-summary.md'
test -f "$matrix_path"
test -f "$summary_path"
```

Primary rows from the German matrix half are extracted through the first ID field defined by the artifact contract. Implementation records the exact range between German matrix markers; the same query is repeated for English.

```bash
awk -F'|' '$2 ~ /^ CL-[0-9][0-9]-[0-9][0-9] / { value=$2; gsub(/^ +| +$/, "", value); print value }' \
  "$matrix_path" | sort > "$validation_dir/matrix-cl-ids.txt"
test "$(sort -u "$validation_dir/matrix-cl-ids.txt" | wc -l | tr -d ' ')" = "157"
comm -3 "$validation_dir/source-ids.txt" "$validation_dir/matrix-cl-ids.txt"
```

**Expected**: The unique checklist set contains 157 identifiers; `comm -3` emits nothing. If the generic query captures both language halves, implementation must instead use the documented language-section markers and prove 157/157 per half.

Additional contract checks:

```bash
rg -n '^\| HB-RLSE-[A-Z0-9]+(?:-[A-Z0-9]+)* ' "$matrix_path"
rg -n '\b(Applicable|AlreadySatisfied|N/A|Open|FollowUp)\b' "$matrix_path"
rg -n '\b(High|Medium|Low)\b' "$matrix_path"
rg -n '/Users/|[A-Za-z]:\\|(^|/)\.\.(/|$)' "$matrix_path" "$summary_path"
```

**Expected**:

- Every additional identifier appears exactly once per language half and has a register entry.
- Only contractual status, priority, and residual-risk values appear.
- Every `AlreadySatisfied` decision references complete state, time, and result evidence.
- Every `N/A`, `Open`, and `FollowUp` decision satisfies its status-dependent fields.
- The final `rg` invocation finds no private or upward-relative path; exit code 1 means “no match” and is expected here.
- An intentionally documented unavailable external source changes only its checkpoint to `Open`; the summary remains complete.

## Scenario 4: Language, Accessibility, Navigation, and Repository Gates

Semantic review checklist:

1. Complete German precedes complete English.
2. Both parts carry the same IDs, statuses, counts, owners, risks, triggers, and evidence references.
3. Terms and abbreviations are explained at first use.
4. Headings and tables are linearly understandable; no claim depends only on color, symbol, or position.
5. `docs/security/README.md` leads to the dated matrix and summary and correctly identifies the repository as Level 0.

Validate Documentation Impact and the repository:

```bash
bash scripts/validate-documentation-impact.sh \
  --evidence specs/025-rl-se-self-assessment/documentation-impact-evidence.json
pwsh -NoProfile -File scripts/validate-documentation-impact.ps1 \
  -Evidence specs/025-rl-se-self-assessment/documentation-impact-evidence.json
git diff --check
lychee --offline --include-fragments . './**/*.md'
bash scripts/check-homogeneity.sh .
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
bash scripts/scan-agent-secrets.sh --fail-on-high .
specify check
```

**Expected**: Documentation Impact is exactly `UpdateRequired`, distribution is `sourceOnly`, and `homeSyncRequired=false`. All gates triggered by the actual diff pass. An unavailable optional tool is documented according to the repository contract and is not represented as a positive result.

## Scenario 5: Statistics and Causal Series Closeout

Statistics tests and read-only drift check:

```bash
pwsh -NoProfile -File scripts/test-render-project-statistics.ps1
bash scripts/render-project-statistics.sh --repo . --check-only --json
```

**Expected**: Fixture tests pass. Before an authorized commit binding, the Git-derived block may report expected `DRIFT` with exit code 1. The summary records this transparently; it is not a technical failure.

Only after separate delivery authority, a source commit, and a clean worktree:

```bash
bash scripts/render-project-statistics.sh --repo .
bash scripts/render-project-statistics.sh --repo . --check-only --json
pwsh -NoProfile -File scripts/render-project-statistics.ps1 -Repo . -CheckOnly -Json
```

**Expected**: The renderer changes only the canonically controlled statistics area; both check paths then report `CURRENT`. If these prerequisites are absent under `LocalImplementation`, a complete follow-up contract remains instead of forced rendering.

Series closeout is a separate causal proof:

- only after a complete and validated matrix/summary;
- recalculate graph values from the then-current manifest;
- archive the previous manifest/receipt byte-for-byte;
- jointly validate the successor manifest/receipt, operations journal, supersession hashes, and order document;
- rerun Bash and PowerShell series validators;
- start no successor intake;
- without new authority, do not commit, push, create a pull request, or merge.
