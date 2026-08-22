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

## Feature 029: Source- und Evidence-Provenienz

Profil- und Pfadregistry werden getrennt kanonisch mit SHA-256 gebunden.
Gate-Evidence bindet HEAD und Gate-Set-Hash, Acceptance-Primaries binden ihre
internen normalisierten Input-Hashes. Der installierte Hook wurde byteweise und
per SHA-256 gegen die getrackte Quelle geprüft. Nur atomare `Passed`-Evidence
mit restriktiven Rechten wird publiziert.

Keine neue Abhängigkeit, kein neues Binärpaket und kein Remote-Release wurden
erzeugt. SBOM/VEX/SLSA/OpenSSF bleiben für die bestehende Quelllieferkette
anwendbare Reviewflächen; eine höhere Provenienzstufe wird nicht behauptet.
AI-SBOM ist `N/A`, weil KI kein ausgelieferter Bestandteil ist.

Restrisiko: lokale Werkzeug- oder Account-Kompromittierung. Follow-up:
Dependency-/Secret-Scan und Exact-Candidate-Gate vor Lieferung. Re-Evaluation
bei Paket-, Provider-, Signatur-, Release- oder KI-Runtime-Änderung.

## Feature 030: Stage-B-Provenienz / Stage B Provenance

Stage B verteilt keine neue Drittbibliothek. Provenienz gilt dennoch für jede
auslieferbare Quellfläche: gemeinsamer Python-Kern, Bash-/PowerShell-Adapter,
JSON-Schemas, Workflow-/Ruleset-Templates, der SHA-gepinnte native
Windows-Proof, Dokumentation und spätere redigierte Evidence. Der unveränderliche
Plan bindet Baseline, Zielpfade, Modi und Blobhashes; Exact-Candidate-Evidence
bindet Tree und Diff; PreMerge/PostMerge bindet Kandidaten-Head, Prüfungen,
Review, Mergecommit und Default-Head.

- **SBOM**: `Applicable` als deterministisches Quell-/Skript-/Template-/
  Workflow-Inventar mit Version, Pfad und SHA-256. Die Python-Standardbibliothek
  wird als Laufzeitplattform, nicht als vendorte Paketmenge, dokumentiert.
- **VEX**: `NotAffected` ist nur für das Fehlen einer neu eingeführten
  Paketkomponente zulässig. Ein CVE in Python, PowerShell, Git, `gh` oder einer
  gepinnten Action verlangt werkzeugbezogene Neubewertung statt stiller
  Übernahme.
- **SLSA/Provenance**: `Applicable` als prüfbare Herkunftskette von gebundener
  Quelle über exakten Kandidaten, konkreten Runner/Befehl/Exitcode bis zum
  Merge- und Default-Head. Es wird keine SLSA-Stufe oder Attestation behauptet,
  die nicht tatsächlich erzeugt wurde.
- **OpenSSF**: `Applicable` als Source-Repository-Review für gepinnte Actions,
  Branchschutz, Reviews, Secret Scan, Dependencyhygiene und minimale
  Permissions; kein Organisations- oder Scorecard-Zertifikat wird behauptet.
- **AI-SBOM**: `N/A`; KI unterstützt die Entwicklung, ist aber kein
  ausgeliefertes Modell, Dataset, Agentendienst oder Inferenzbestandteil.

Der Proof-Workflow verwendet `contents: read`, einen festen Branch-/Pfadfilter,
Jobmarker, `windows-2022`, Timeout und `actions/checkout` per vollständigem
Commit-SHA. Das beweist nur den gebundenen PowerShell-Preflight und keine volle
Regression. Owner: Supply Chain Owner. Reviewer: Provenance Reviewer.
Restrisiko: Provider- und Runner-Images sind externe, zeitabhängige
Lieferketten. Re-Evaluation bei Action-, Runner-, Toolchain-, Paket-, Release-,
Signatur-, Provider-, Template- oder Evidence-Schemaänderung.
