# Stabile MSL-Toolchains / Stable MSL toolchains

Die Wartung vergleicht die sechs Host-Toolchains C#/.NET, Go, Java/Javac,
Python, Rust/Cargo und Swift mit den neuesten stabilen Projekt-Releases.
Paketversion, gestartete CLI und Herstellerstand werden getrennt geprueft.
Neue Hauptversionen sind eingeschlossen. Projekt-Pins wie `global.json`,
virtuelle Python-Umgebungen, `rust-toolchain.toml` und `.swift-version` bleiben
eigenstaendige Projektvertraege.

*Maintenance compares the six host toolchains with the latest stable project
releases, including new major versions. Package version, active command and
upstream release are checked separately. Project pins remain independent.*

## Begrenzter Lauf / Bounded run

macOS/Linux:

```bash
bash scripts/maintain-agentic-brew-apps.sh --msl-only --compare-only
bash scripts/maintain-agentic-brew-apps.sh --msl-only --dry-run
bash scripts/maintain-agentic-brew-apps.sh --msl-only --result-file /tmp/msl-result.json
```

Windows:

```powershell
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -MslOnly -CompareOnly
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -MslOnly -WhatIf
# Nur mit aktueller Autoritaet fuer sichtbare Admin-Prompts:
# Only with current authority for visible administrator prompts:
$env:HB_ALLOW_ADMIN_PROMPTS = '1'
pwsh -NoProfile -File scripts/maintain-agentic-winget-apps.ps1 -MslOnly -ResultFile "$env:TEMP/msl-result.json"
Remove-Item Env:HB_ALLOW_ADMIN_PROMPTS
```

Der begrenzte Lauf installiert und aktualisiert nur diese Toolchains samt
Manager- und Paketabhaengigkeiten. Andere Apps, VS-Code-Extensions, Agenten-CLIs
und PowerShell-Module gehoeren nicht zu diesem Lauf. Der normale Paketpfleger
enthaelt weiterhin seine bisherigen Wartungsstufen und ergaenzt die MSL-Pruefung.
`--skip-upgrade` / `-SkipUpgrade` belaesst vorhandene Toolchains; verbleibender
Rueckstand bleibt sichtbar. Vergleich und Vorschau sind getrennte Modi.

*The bounded mode maintains only these toolchains and required managers and
package dependencies. Full maintenance retains its other stages and adds the
MSL checks. Skip-upgrade preserves existing toolchains and reports remaining
drift. Comparison and preview are separate modes.*

PowerShell 7 ist Voraussetzung der gemeinsamen Versionslogik. Fehlt diese
Engine, endet der Lauf mit einem Fehler statt einer Aktualitaetsbestaetigung.
Der MSL-Paketlauf deaktiviert die automatische Homebrew-Bereinigung: eine
gerade verwendete .NET-Runtime darf nicht waehrend des PowerShell-Laufs
entfernt werden. Spaetere Speicherbereinigung bleibt ein eigener Lauf.

*PowerShell 7 is required by the shared version logic. A missing engine fails
instead of reporting currency. The MSL package stage disables automatic
Homebrew cleanup so a .NET runtime currently hosting PowerShell remains
available until the process ends. Later cleanup is a separate operation.*

## Quellen und Auswahl / Sources and selection

| Toolchain | Release-Quelle / Release source | Installation |
|---|---|---|
| .NET SDK | Microsoft release metadata | Homebrew; configured apt feeds; WinGet SDK major ID |
| Go | Go download API, stable releases | Homebrew; apt; WinGet |
| Java/Javac | Adoptium GA metadata, feature and patch version | OpenJDK/Homebrew; apt; Temurin/WinGet |
| Python | Published final releases from Python.org API | Rolling Homebrew `python`; apt; WinGet major/minor ID |
| Rust/Cargo | Rust stable channel manifest | Homebrew; apt; Rustup stable via WinGet manager |
| Swift | Swift.org release API | Swiftly/macOS/Linux; WinGet/Windows |

Die CLI-Registry ist die kanonische Quelle der Versionsregeln. Die Paketregister
ordnen jedem MSL-Pfad eine Quelle zu. Auf Windows werden markierte Paket-ID-
Vorlagen erst nach stabiler Release-Ermittlung konkretisiert. Homebrew-Aliase
werden vor dem Inventarvergleich aufgeloest. Paketrevisionen wie `_1` und
JDK-Buildnummern wie `+35` sind keine neue Sprachversion.

*The CLI registry owns the release policy; package registries own package
mapping. Windows package ID templates are resolved from stable releases.
Homebrew aliases are normalized. Package revisions and JDK build numbers do
not count as language version changes.*

Ein Hersteller-Rueckstand der Paketquelle bleibt ein Pflichtbefund. Es gibt
keinen automatischen Wechsel auf andere Installer. Netzwerkfehler,
Zeitgrenzen und unlesbare Metadaten bestaetigen keine Aktualitaet. Abfragen
verwenden HTTPS, erlaubte Hosts, 15 Sekunden Zeitgrenze und hoechstens einen
Wiederholungsversuch; jede Toolchain bleibt unabhaengig pruefbar.

*A package source behind upstream remains required drift. Maintenance does
not silently switch installers. Network failure or invalid metadata cannot
establish currency. Requests use HTTPS, allowed hosts, a 15-second timeout and
at most one retry. Each toolchain remains independently reportable.*

## Swift und Benutzerumgebung / Swift and user environment

Swiftly verwendet einen eigenen Zustand unter
`~/.home-baseline/toolchains/swiftly`. Gezielte Launcher fuer `swift`, `swiftc`
und `sourcekit-lsp` liegen unter `~/.home-baseline/toolchains/bin`. Swiftlys
Zustandsvariablen werden im Benutzerblock exportiert, damit auch direkte
`swiftly list`-/`swiftly use`-Aufrufe dieselbe Installation verwenden. Swiftlys
zusaetzliche Compiler-Proxies werden nicht global in PATH eingebunden.
Apples Xcode, Command Line Tools und die Host-Compiler-Auswahl bleiben erhalten.
Der gezielte Launcher `python3` startet den geprueften versionierten Python-
Interpreter. Die globale Swiftly-Auswahl verwendet `--global-default`; ein Projekt-Pin
hat weiterhin Vorrang. Shell-Profile erhalten einen markierten Benutzerblock
mit Sicherungskopie; fremde Launcher oder widerspruechliche Bloecke werden
nicht ueberschrieben. Eine neue Shell liest die aktualisierte Umgebung.

*Swiftly state and selected Swift launchers live under the user's Home Baseline
toolchain directory. Other compiler proxies are not globally exposed. Apple
tools and host compiler selection remain intact. Direct Swiftly commands use
the same state through exported user variables. A targeted python3 launcher
starts the verified versioned Python interpreter. Swiftly global-default does
not change project pins. Profile changes use a marked block and backups;
conflicting files are preserved. Open a new shell to load the updated PATH.*

## Ergebnis und Nachweis / Result and proof

Der optionale atomare JSON-Bericht enthaelt `mslToolchains` mit genau sechs
Eintraegen: installierte Version, aktive Version, Paketquellen-Version,
stabile Projektversion, ausfuehrbarer Pfad, Quelle, UTC-Pruefzeit, Status und
naechste Aktion. `Current` bestaetigt den geprueften Release-Snapshot.
`SourceBehind`, `PathMismatch`, `Unknown`, fehlende oder fehlgeschlagene
Toolchains bleiben offene Pflichtbefunde. `Planned` bezeichnet nur Vorschau.
Exitcode `0` bedeutet vollstaendig geprueft, `1` offenen Pflichtbefund und `2`
einen ungueltigen Vertrag. Windows erhaelt Exitcode `75` fuer zurueckgestellte
Admin-Aktionen. Ein Mac-Nachweis ersetzt keine native Windows-/Linux-Abnahme.

*The atomic JSON report contains six MSL entries with versions, executable,
source, UTC check time, status and next action. Current refers to the checked
release snapshot. Source lag, path mismatch, unknown currency and failed or
missing toolchains remain required findings. Planned is preview only. Exit
codes are 0 for complete proof, 1 for required findings, 2 for invalid contract,
and Windows 75 for deferred administrator actions. Mac proof does not establish
native Windows or Linux acceptance.*

Documentation Impact: `UpdateRequired`; Owner: Workspace Maintainer.
Kanonische Quelle / canonical source: CLI- und Paketregister. Zielgruppe /
audience: taegliche Nutzende und Maintainer. Leserpfad / reader path:
Wartung -> MSL-Vorschau -> Ergebnisbericht. DE/EN gemeinsam / together.
Registries und Code sind `homeRuntime`; diese Referenz ist `sourceOnly`.
Home-Sync erforderlich; Flotten-Propagation separat. Re-Evaluation bei neuen
Release-APIs, Plattformen, Paket-IDs oder Swiftly-Aktivierungsregeln.

Nachweis / evidence: [Mac-A-Validierung](msl-toolchains-validation-2026-10-18.md).
