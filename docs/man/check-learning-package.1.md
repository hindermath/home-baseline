# check-learning-package(1)

## NAME

`check-learning-package.sh`, `check-learning-package.ps1` - prueft ein
git-freies Lernreihen-ZIP und seine SHA-256-Datei.

## SYNOPSIS

```bash
bash scripts/check-learning-package.sh [--checksum FILE] ZIP
bash scripts/check-learning-package.sh --self-test
```

```powershell
pwsh -NoProfile -File scripts/check-learning-package.ps1 -PackagePath ZIP
pwsh -NoProfile -File scripts/check-learning-package.ps1 -SelfTest
```

## DESCRIPTION

Die Skripte pruefen, dass ein Lernpaket genau einen Root-Ordner, die Dateien
`START-HERE-FUER-LERNENDE.md`, `GIT-START-FUER-LERNENDE.md`,
`INSTITUTIONELLES-GIT-HOSTING.md` und `PACKAGING-MANIFEST.txt` sowie eine
passende SHA-256-Pruefsumme enthaelt. Sie
weisen `.git`-Verzeichnisse, Build-Ausgaben, IDE-Zustaende und lokale
Einstellungsdateien zurueck. Wenn `gitleaks` verfuegbar ist, wird der entpackte
Inhalt zusaetzlich auf offensichtliche Secrets geprueft. Die bestehende enge
Allowlist aus `scripts/templates/gitleaks.toml` nimmt nur dokumentierte
Beispielmuster in Markdown-Lehrmaterial unter `docs/secure-development/` aus.

*The scripts validate that a learning package contains exactly one root folder,
the learner and institutional-hosting guides, a packaging manifest, and a matching SHA-256 file.
They reject Git metadata, build output, IDE state, and local settings. When
`gitleaks` is available, the extracted content is additionally scanned for
obvious secrets. The existing narrow allowlist in
`scripts/templates/gitleaks.toml` excludes only documented example patterns in
`docs/secure-development/` teaching Markdown.*

## OPTIONS

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--checksum FILE` | `-ChecksumPath FILE` | Abweichende SHA-256-Datei / alternative checksum file |
| `--self-test` | `-SelfTest` | Minimales Paket erzeugen und Ende-zu-Ende pruefen / create and validate a minimal package end to end |
| `ZIP` | `-PackagePath ZIP` | Zu pruefendes Lernreihen-ZIP / learning-series ZIP to validate |

## EXIT STATUS

| Code | Bedeutung / Meaning |
|---:|---|
| 0 | Alle Paketpruefungen erfolgreich / all package checks passed |
| 1 | Inhalt, Pruefsumme, Werkzeug oder Secret-Scan fehlerhaft / content, checksum, tool, or secret scan failed |
| 2 | Ungueltige Bash-Parameter / invalid Bash arguments |

## SEE ALSO

`package-learning-series(1)`, `propagate-learning-series(1)`
