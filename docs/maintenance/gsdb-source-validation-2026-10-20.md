# GSDB-Quellenabschluss: Validierung / GSDB Source Closure: Validation

Owner: Thorsten Hindermann. Platform: macOS (Darwin). Date: 2026-10-20.

DE: Semantische Aussagen und Fundstellen stehen im
[Quellenabschluss](gsdb-source-closure-2026-10-20.md), nicht in Testergebnissen.
EN: Semantic findings and locators are recorded in source closure, separately
from executable test results. Human review remains pending.

## Prüfläufe / Checks

Prüfergebnisse werden nach bestätigtem Exit ergänzt. / Results are added only
after confirmed command exit.

## Grenzen / Boundaries

DE: Der anfängliche Generatorvergleich zeigte zusätzliche Leerzeilen am Ende
der geänderten Checklisten. Die kanonischen Quelldateien wurden auf genau ein
abschließendes LF normalisiert; keine Generatorlogik wurde dafür geändert.
Keine physische Screenreader- oder Windows-/Linux-Abnahme aus dem lokalen Lauf.
EN: The initial generator comparison exposed extra trailing blank lines in
edited checklists. Canonical sources were normalized to one terminal LF;
no generator logic changed. Local tests do not establish physical assistive
technology acceptance or native Windows/Linux proof.

## Bestätigte Ergebnisse / Confirmed Results

| Prüfung / Check | Ergebnis / Result |
|---|---|
| Quellennachweise / source records | PASS: 7 Open + 3 Partial → Reviewed; 25 Reviewed + 2 ISO BibliographyVerified; jede neue Capture-Prüfsumme bestätigt / each new capture hash confirmed |
| Historische Evidence / historical evidence | PASS: Quellenprotokoll, 37-Datei-Inventar und Assurance-Kontext vom 19.10.2026 bytegleich zum Ausgangscommit / byte-identical to starting commit |
| IDs und Mapping / IDs and mapping | PASS: alle 157 IDs in gleicher Reihenfolge, keine Entfernung/Ergänzung; aktuelle Matrix mit 157 Zeilen / unchanged ordered IDs, 157 coverage rows |
| Generator / compendium | PASS: Bash zuerst, danach PowerShell; zweiter Generatorlauf SHA-256-identisch / Bash first, PowerShell parity, repeat hash-identical |
| Isolierte Regressionen / isolated regressions | PASS: 28/28, 14 je Shell; Dateinamen/SHA-256 vor und nach jedem Check unverändert / 14 per shell, unchanged before/after file/hash snapshots |
| Exakte Preset-Matrix / exact preset matrix | PASS: 14 installierte Presets stimmen mit zugewiesener Matrix überein; keine Installation / assigned exact matrix, no installation |
| Assurance-Vertrag / assurance contract | PASS Bash und PowerShell: Baseline/Delta/Image Ready; Closure Blocked wegen menschlicher Prüfung / human review pending |
| Documentation Impact | PASS Bash und PowerShell, vier Entscheidungen: fachliche Quelle, generierter Sammelband, Statistik und Fixture-Korrektur / four decisions |
| Lokale Links/Anker / local links/anchors | PASS: 4980 Gesamtverweise, 2978 eindeutig, 0 Fehler / total, unique, zero errors |
| PowerShell-Analyse / analysis | PASS: PSScriptAnalyzer 1.25.0, 121 Dateien, 0 Error/Warning / files, no errors/warnings |
| Skriptreferenz / script reference | PASS: CURRENT; canonical=152, embedded=110 |
| Secret-Scan | PASS: gitleaks für aktuellen Diff, high=0; bestehende lokale Agent-Konfiguration nur informativ / diff has no secrets; existing local config notice informational |
| Whitespace / Git diff | PASS: `git diff --check` |

DE: Der erste Regressionslauf schlug beim Baseline-Negativfall fehl: die feste
3.4.0-Ersetzung war mit 3.4.1 wirkungslos. Die Fixture liest jetzt die Version
aus dem Manifest, wählt eine abweichende Version und bricht bei fehlendem
Ausgangsheader ab. Keine Produktionsprüfung wird abgeschwächt.

EN: The first regression run failed because its hard-coded 3.4.0 mutation
became a no-op with baseline 3.4.1. The fixture now reads the manifest version,
chooses a distinct version and rejects a missing starting header. No product
validation was weakened.

## Wiederholung / Reproduction

```bash
bash scripts/build-secure-development-docs.sh --check
bash scripts/install-spec-kit-governance-presets.sh --check-only --preset-config scripts/config/spec-kit-project-statistics-governance-presets.json
bash scripts/validate-documentation-impact.sh --evidence docs/maintenance/gsdb-source-documentation-impact-2026-10-20.json
bash .specify/presets/secure-development-assurance-governance/scripts/validate-secure-development-assurance.sh status docs/security/secure-development/2026-10-20-gsdb-source-closure
bash scripts/render-script-reference.sh --check-only
bash scripts/scan-agent-secrets.sh --fail-on-high .
```

```powershell
pwsh -NoProfile -File scripts/build-secure-development-docs.ps1 -Check
pwsh -NoProfile -File scripts/tests/test-gsdb-consolidation.ps1
pwsh -NoProfile -File scripts/validate-documentation-impact.ps1 -Evidence docs/maintenance/gsdb-source-documentation-impact-2026-10-20.json
pwsh -NoProfile -File .specify/presets/secure-development-assurance-governance/scripts/validate-secure-development-assurance.ps1 -Action Status -EvidenceDirectory docs/security/secure-development/2026-10-20-gsdb-source-closure
pwsh -NoProfile -File scripts/invoke-psscriptanalyzer.ps1
```

## Semantik, Sprache und Zugänglichkeit / Semantics, Language and Accessibility

DE: Die zehn Quellen wurden anhand der im Quellenprotokoll benannten
Fundstellen gegen die geänderten Anforderungen gelesen. DE/EN-Anforderungen,
Fristen, Rollen, Ausnahmen und Akzeptanz wurden paarweise verglichen.
Statuswerte sind Text; Links beschreiben ihre Ziele. Tabellen enthalten keine
farbabhängigen Entscheidungen. Keine tatsächliche Projektumsetzung,
Rechtsberatung, vollständige ISO-Textprüfung oder physische Hilfsmittelabnahme
wird aus technischen Tests abgeleitet.

EN: Source locators were compared with changed requirements. Bilingual
requirements, clocks, roles, exceptions and acceptance were compared in pairs.
Status is textual, links describe targets, and no decision depends on colour.
Technical checks do not establish project implementation, legal advice,
licensed ISO-text review or physical assistive-technology acceptance.

## CI, Statistik und Ausführung / CI, Statistics and Execution

DE: Der aktuelle PR-Head und seine CI-Ergebnisse sind im PR dokumentiert;
frühere grüne Läufe belegen keinen späteren Head. Der Statistikblock wird aus
dem sauberen Quellencommit mit unveränderter Konfiguration gerendert und
anschließend separat committet. Kein Merge, Home-Sync oder Rollout.

EN: The PR records current-head CI; earlier green runs do not validate a later
head. Statistics are rendered from a clean source commit with unchanged
configuration and committed separately. No merge, Home sync or rollout.
