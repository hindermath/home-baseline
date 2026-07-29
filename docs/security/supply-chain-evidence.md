# Lieferketten-Evidence / Supply Chain Evidence: home-baseline

**Stand / State**: 2026-07-29
**Feature**: `018-agentic-workspace-tui`

## Herkunft und Integrität / Provenance and Integrity

| Gegenstand | Nachweis |
|---|---|
| NuGet-Quelle | `scripts/lib/maintenance-tui/NuGet.config`, ausschließlich `https://api.nuget.org/v3/index.json` |
| Auflösung | Zwei eingecheckte `packages.lock.json` |
| Build | .NET 10, Locked Restore, frameworkabhängiges lokales Publish |
| Plattformen | macOS, Ubuntu und Windows auf dem exakten PR-Head |
| Cache | SHA-256 über sortierte relative Pfade, Dateibytes und Vertragsversion |
| Veröffentlichung | Temporärer Build, Prüfung, atomare Verzeichnisverschiebung |
| Git-Grenze | `bin/`, `obj/`, Build-Cache und Ereignisse ignoriert |

Der Cache akzeptiert nur eine vollständige Assembly plus Metadaten mit
identischem Fingerprint und Plattformwert. Eine beschädigte, fremde oder
teilweise Cachezeile wird nicht ausgeführt.

*The cache accepts only a complete assembly and metadata with the exact source
fingerprint and platform. Corrupt, foreign, or partial cache state is never
executed.*

## Prüfbefehle / Verification Commands

```bash
dotnet restore scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/HomeBaseline.MaintenanceTui.csproj --locked-mode
dotnet restore scripts/lib/maintenance-tui/tests/HomeBaseline.MaintenanceTui.Tests/HomeBaseline.MaintenanceTui.Tests.csproj --locked-mode
dotnet list scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/HomeBaseline.MaintenanceTui.csproj package --include-transitive
dotnet list scripts/lib/maintenance-tui/src/HomeBaseline.MaintenanceTui/HomeBaseline.MaintenanceTui.csproj package --vulnerable --include-transitive
```

## Restrisiko / Residual Risk

Ein lokaler Restore hängt von der Erreichbarkeit und Integrität von NuGet.org
ab. Fällt Restore aus, startet keine unvollständige Enhanced-TUI; der
lineare Assistent bleibt verfügbar. Öffentliche Binärverteilung,
Signaturkette, SLSA-Provenienz und Scorecard bleiben außerhalb des Features.

<!-- EN: docs/security/supply-chain-evidence.md
[DE-Zusammenfassung: Herkunft, Cache-Integrität und Fallback der TUI-Abhängigkeiten.]
-->
