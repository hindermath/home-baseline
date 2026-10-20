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

## Aktive Metadaten / Active Metadata

DE: Prüft zusätzlich aktive Baseline-Header, eindeutige CL-01 bis CL-12,
Richtlinien-/Baseline-Version und die vollständigen Profilnamen aus dem
Profilkatalog in der Verzahnungsdatei. Historische Versionsangaben bleiben
unverändert. Fachliche Richtigkeit und Quellenaktualität erfordern Review.

EN: Also validates active baseline headers, unique CL-01 through CL-12,
guideline/baseline version, and all catalog profile names in the alignment
document. Historical versions remain unchanged. Subject-matter correctness
and primary-source currency still require review.

DE: Baseline, Dokumentversion und Dokument-ID muessen im ersten zusammenhaengenden
Metadatenblock stehen und mit dem vollstaendigen Manifestwert uebereinstimmen.
Doppelte gleichnamige Felder, Ersatztreffer im Fliesstext und Versionspraefixe
werden abgelehnt. Historische Tabelleneintraege bleiben erlaubt; CRLF und LF
sind fuer den Metadatenvergleich gleichwertig.

EN: Baseline, document version and document ID must occur in the first contiguous
metadata block and match the complete manifest value. Duplicate fields,
replacement matches in body text and version prefixes are rejected. Historical
table entries remain allowed; CRLF and LF are equivalent for metadata checks.
