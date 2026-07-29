# Abhängigkeits-Audit / Dependency Audit: home-baseline

**Stand / State**: 2026-07-29
**Prüfumfang / Scope**: Feature 018 Wartungs-TUI

## Direkte .NET-Abhängigkeiten / Direct .NET Dependencies

| Paket | Version | Zweck | Quelle und Lizenz | Entscheidung |
|---|---:|---|---|---|
| Spectre.Console | 0.57.2 | Terminal-Prompts und textorientierte Darstellung | NuGet.org, MIT | Akzeptiert |
| Spectre.Console.Testing | 0.57.2 | Deterministische Konsolentests | NuGet.org, MIT | Nur Tests |
| Microsoft.NET.Test.Sdk | 18.8.1 | `dotnet test`-Host | NuGet.org, MIT | Nur Tests |
| MSTest.TestFramework | 4.3.3 | Test-API | NuGet.org, MIT | Nur Tests |
| MSTest.TestAdapter | 4.3.3 | Test-Discovery | NuGet.org, MIT | Nur Tests |

NuGet.org ist in `scripts/lib/maintenance-tui/NuGet.config` als einzige Quelle
festgelegt. Beide Projekte verwenden eingecheckte `packages.lock.json`.
Locked Restore muss auf macOS, Ubuntu und Windows bestehen.

*NuGet.org is the only configured source. Both projects use committed lock
files, and locked restore must pass on macOS, Ubuntu, and Windows.*

## Sicherheitsprüfung / Security Review

- `dotnet list package --include-transitive` inventarisiert direkte und
  transitive Pakete.
- `dotnet list package --vulnerable --include-transitive` muss null bekannte
  Schwachstellen melden.
- Fremde Paketquellen, Floating Versions und generierte Binärdateien in Git
  sind nicht erlaubt.
- Der Runtime-Helfer verwendet keine Netzwerk-API. Restore ist ausschließlich
  eine Build-/Cache-Operation.
- Neue Pakete erteilen keine Git-, Provider-, Secret- oder Adminrechte.

## SBOM und VEX / SBOM and VEX

Die Lockfiles und das transitive Paketinventar bilden die
SBOM-orientierte Komponenten-Evidence für diesen internen Helfer. Es wird kein
eigenständiges öffentliches Binärpaket veröffentlicht. Eine VEX-Aussage
(Vulnerability Exploitability eXchange) ist `NotAffected`, solange der
Vulnerability-Scan null Befunde meldet. Bei einem Befund wird diese Aussage
sofort ungültig und benötigt eine paketbezogene Neubewertung.

*Lock files and the transitive inventory provide SBOM-oriented component
evidence for this internal helper. No public binary package is released. The
VEX disposition is `NotAffected` only while vulnerability scanning reports no
finding; any finding invalidates it and requires package-specific review.*

## Nicht anwendbar / Not Applicable

AI-SBOM ist nicht anwendbar, weil kein KI-Modell Teil der Laufzeit ist. SLSA
und OpenSSF Scorecard werden neu geprüft, sobald ein öffentliches
Binärartefakt oder Paket veröffentlicht wird.

<!-- EN: docs/security/dependency-audit.md
[DE-Zusammenfassung: Paket-, Lockfile-, SBOM- und VEX-Nachweis der Wartungs-TUI.]
-->
