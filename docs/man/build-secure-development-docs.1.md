# build-secure-development-docs(1)

## Name

`build-secure-development-docs` - erzeugt und prueft den Checklistensammelband der sicheren-Entwicklung-Basis

*builds and validates the secure-development checklist compendium*

## Synopsis

```bash
bash scripts/build-secure-development-docs.sh [--check]
```

```powershell
pwsh -NoProfile -File scripts/build-secure-development-docs.ps1 [-Check]
```

## Beschreibung / Description

Das Werkzeug liest `docs/secure-development/baseline-manifest.json`, prueft die zwölf kanonischen Einzelchecklisten und erzeugt daraus den Sammelband. Der Sammelband darf nicht manuell bearbeitet werden.

*The tool reads `docs/secure-development/baseline-manifest.json`, validates the twelve canonical individual checklists, and generates the compendium. The compendium must not be edited manually.*

## Optionen / Options

| Bash | PowerShell | Bedeutung / Meaning |
|---|---|---|
| `--check` | `-Check` | Nur Konsistenz pruefen; keine Datei aendern / Check consistency without changing files |
| `-h`, `--help` | `Get-Help` | Hilfe anzeigen / Show help |

## Exit-Status / Exit Status

- `0`: Manifest, IDs, Versionen und Sammelband sind konsistent.
- `1`: Eine Quelle fehlt, IDs oder Versionen widersprechen sich oder der Sammelband ist veraltet.
- `2`: Unbekannte Kommandozeilenoption.
