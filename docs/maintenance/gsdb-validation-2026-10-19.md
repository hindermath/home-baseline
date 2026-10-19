# GSDB-Validierung / GSDB Validation

Owner: Thorsten Hindermann. Platform: macOS (Darwin). Date: 2026-10-19.

DE: Ausführbare Prüfung der Level-0-Konsolidierung; kein Ersatz für offenen
Primärquellenreview oder menschliche Freigabe. Laufende Prüfungen werden erst
nach bestätigtem Exit als bestanden eingetragen.
EN: Executable validation of Level-0 consolidation; no replacement for primary
source review or human approval. Record success only after confirmed exit.

## Lokale Prüfungen / Local Checks

| Prüfung / Check | Ergebnis / Result |
|---|---|
| Bash-/PowerShell-Syntax | PASS |
| Generator-Wiederholung / generator repeat | PASS: byte-identical SHA-256 after second generation |
| Sammelband, Baseline-Header, IDs und Profilnamen | PASS, beide Shells / both shells |
| 14 isolierte Regressionen je Shell / isolated regressions per shell | PASS: 28/28; read-only SHA-256 snapshots unchanged |
| Exakte installierte Vierzehnermatrix / exact installed matrix | PASS, beide Shells / both shells |
| Level-0-Preflight mit explizitem Profil / explicit profile | Beide Shells melden dieselben 3 offenen Punkte: unbekannte Sprache und zwei fehlende aktive/archivierte Intake-Nachweise; keine Dateien erzeugt. / Both shells report the same 3 open preflight items; no files created. |
| Documentation Impact | PASS, 4 Entscheidungen / decisions |
| Lokale Links und Anker / local links and anchors | PASS: 4799 repository-wide links checked, 0 errors; changed GSDB scope also checked separately |
| Lokale CISA-PDF-Integrität / local PDF integrity | PASS: SHA-256 matches retained sidecar; online currency remains Open |
| Assurance-Vertrag / contract | PASS, beide Validatoren melden fachlich Overall: Blocked / both validators preserve Blocked subject-matter outcome |
| PSScriptAnalyzer 1.25.0 | PASS: 121 Dateien, keine Error/Warning-Befunde / files, no errors or warnings |
| Gitleaks | PASS: no secrets in current git diff; existing local agent-permission directory notice is informational |
| Skriptkatalog / script catalog | PASS: CURRENT; new test belongs to quality category |
| Jährlicher Review-Vertrag / annual review contract | PASS: seven presets and negative fixtures; existing annual automation unchanged |
| Semantische Quellenfreigabe / source clearance | Blocked; keine akzeptierte Risikoausnahme / no accepted-risk waiver |

## Wiederholung / Reproduction

```bash
bash scripts/build-secure-development-docs.sh --check
bash scripts/install-spec-kit-governance-presets.sh --check-only --preset-config scripts/config/spec-kit-project-statistics-governance-presets.json
bash scripts/check-gsdb-self-assessment.sh --repo . --preset-profile project-statistics-fourteen-governance-presets --check-only
bash scripts/validate-documentation-impact.sh --evidence docs/maintenance/gsdb-documentation-impact-2026-10-19.json
```

```powershell
pwsh -NoProfile -File scripts/build-secure-development-docs.ps1 -Check
pwsh -NoProfile -File scripts/tests/test-gsdb-consolidation.ps1
pwsh -NoProfile -File scripts/install-spec-kit-governance-presets.ps1 -CheckOnly -PresetConfig scripts/config/spec-kit-project-statistics-governance-presets.json
```

## Semantik und A11Y / Semantics and Accessibility

DE: Alle 157 stabilen IDs sind als Text in der Abdeckungsmatrix enthalten.
DE-/EN-Paare der korrigierten Anforderungen, Statusachsen und Freigabegrenzen
wurden gegengelesen. Tabellen benennen Status textuell; keine Aussage hängt
nur von Farbe oder Symbol ab. Lokale Linkprüfung umfasst Quellen, Report,
Matrix und neue Evidence. Keine physische Screenreader-Abnahme behauptet.

EN: Coverage contains all 157 stable IDs as text. Corrected bilingual
requirements, status axes and authority boundaries were compared. Tables state
status in text without color-only meaning. Local links cover sources, report,
matrix and new evidence. No physical screen-reader acceptance is claimed.

## CI und Lieferung / CI and Delivery

CI wird am PR-Head geprüft. Native Linux-/Windows-Ergebnisse werden erst nach
entsprechenden Läufen behauptet. Merge und Home-Sync bleiben ausstehend.
CI is checked at the PR head. Native Linux/Windows results require actual runs.
Merge and Home sync remain pending.
