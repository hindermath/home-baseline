# CI/CD-Workflow-Vertrag: homogeneity-check.yml
# CI/CD Workflow Contract: homogeneity-check.yml

**FR-REV-G01** | **FR-REV-G02** | **FR-REV-G03**

---

## Dateipfad / File Path

`.github/workflows/homogeneity-check.yml`
(in jedem Level-0, Level-1 und Level-2 Repository)

## Trigger

```yaml
on:
  push:
  pull_request:
```

## Matrix-Strategie / Matrix Strategy

```yaml
strategy:
  matrix:
    os: [ubuntu-22.04, macos-14, windows-latest]
```

## Vollständige Workflow-Vorlage / Complete Workflow Template

```yaml
name: Homogeneity Check

on:
  push:
  pull_request:

jobs:
  check:
    name: Homogeneity Check (${{ matrix.os }})
    runs-on: ${{ matrix.os }}
    timeout-minutes: 10

    strategy:
      matrix:
        os: [ubuntu-22.04, macos-14, windows-latest]

    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Install ripgrep (Ubuntu)
        if: runner.os == 'Linux'
        run: sudo apt-get install -y ripgrep

      - name: Install ripgrep (macOS)
        if: runner.os == 'macOS'
        run: brew install ripgrep

      - name: Install ripgrep (Windows)
        if: runner.os == 'Windows'
        run: choco install ripgrep -y

      - name: Run Homogeneity Check (Bash)
        if: runner.os != 'Windows'
        run: bash scripts/check-homogeneity.sh $(basename "$GITHUB_WORKSPACE")

      - name: Run Homogeneity Check (PowerShell)
        if: runner.os == 'Windows'
        shell: pwsh
        run: pwsh scripts/check-homogeneity.ps1 -WorkspaceName (Split-Path $env:GITHUB_WORKSPACE -Leaf)
```

## Ausgabe / Output

| Kanal / Channel | Inhalt / Content |
|---|---|
| `stdout` | Plain Text (Klartext-Ausgabeformat) |
| `$GITHUB_STEP_SUMMARY` | Markdown-Tabelle (renderbar in GitHub Actions UI) |

## Fehlerverhalten / Failure Behavior

- `✗`-Befunde → Exit-Code `1` → Job schlägt fehl → PR-Merge blockiert
- Kein `check-homogeneity.sh` im Repo → `ERROR: check-homogeneity.sh not found — run bootstrap-project.sh first`

## Idempotenz / Idempotency

`migrate-workspace.sh` und `bootstrap-project.sh` erstellen diese Datei nur, wenn sie **nicht bereits vorhanden** ist:
- Bereits vorhanden → `INFO: homogeneity-check.yml already present — skip`
