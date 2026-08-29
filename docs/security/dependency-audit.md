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

## Feature 029: CI-Budget-Governance

Es wurde keine neue Laufzeit- oder Paketabhängigkeit hinzugefügt. Bash,
PowerShell 7, Python-Standardbibliothek, Git und die bereits authentifizierte
`gh`-CLI bleiben vorhandene Werkzeuge. Die neuen Registries, Schemas, Templates,
Tests und der Hook sind im repositoryweiten Softwareinventar zu führen.

SBOM: `Applicable` auf Quellen-/Skriptinventar; VEX: `NotAffected`, solange
Dependency- und Secret-Scan ohne Befund bleiben. SLSA/Provenance und OpenSSF
Scorecard: `Applicable` als Review der versionierten Quelle und späteren
Lieferkette, ohne in Stufe A eine neue Release-Provenienz zu behaupten.
AI-SBOM: `N/A`, weil KI ausschließlich Entwicklungswerkzeug ist und weder
Modell, Dataset, Inferenzdienst noch AI-Runtime ausgeliefert wird.

Owner: Supply Chain Owner; Reviewer: Security Reviewer. Re-Evaluation bei
Dependency-, Paket-, Release-, Distributions- oder KI-Runtime-Änderung.

## Feature 030: Stage-B-Abhängigkeits- und Lizenznachweis

**Ergebnis / Result**: `Passed for local implementation`; keine neue Runtime-,
Paket- oder Buildabhängigkeit. Der Stage-B-Kern importiert ausschließlich die
Python-Standardbibliothek. Bash 3.2+, PowerShell 7, Git und die authentifizierte
`gh`-CLI bleiben bereits akzeptierte externe Werkzeuge. Die einzige Action im
eng begrenzten Windows-Proof ist `actions/checkout` mit vollständigem
Commit-SHA `9c091bb21b7c1c1d1991bb908d89e4e9dddfe3e0` (v7.0.0), nicht mit beweglichem
Tag.

| Prüffläche | Stage-B-Evidence | Entscheidung |
|---|---|---|
| Dependency registry | Python standard library, system Bash/PowerShell/Git/gh; keine neue Registry oder Paketquelle | Passed |
| CVE | Kein neues Paket und kein neuer auflösbarer Dependencygraph; bestehende repositoryweite Scanner bleiben T124-Gate | Passed locally; re-evaluate on tool/package drift |
| Lizenz | Neue Python-/Shell-Dateien enthalten keine vendorte Bibliothek; Templates und Workflow sind Repositoryquellen | Passed |
| SBOM | Quell-/Skript-/Template-/Workflow-Inventar ist anwendbar; Pfade und Hashes gehören in Exact-Candidate-/Delivery-Evidence | Applicable |
| VEX | `NotAffected` für neue Paket-CVEs, weil keine neue Paketkomponente eingeführt wurde; jeder spätere Befund hebt die Aussage auf | Conditional |
| AI-SBOM | Kein Modell, Dataset, Inferenzdienst oder AI-Runtime wird ausgeliefert; KI ist ausschließlich Entwicklungswerkzeug | N/A |

Die distributablen Flächen umfassen `scripts/lib/agentic_workspace_fleet.py`,
beide Maintenance-Adapter, fünf Stage-B-Schemas, CI-Budget-Templates, Manpage/
Help sowie den eng begrenzten Proof-Workflow. Owner: Supply Chain Owner.
Reviewer: Dependency and License Reviewer. Restrisiko: Systemwerkzeuge und
GitHub Actions können nach dem gebundenen Stand neue Schwachstellen erhalten.
Re-Evaluation bei Import-, Paket-, Action-SHA-, Registry-, Lizenz-, Toolchain-,
Distributions- oder AI-Runtime-Änderung.

## Feature 031

Keine neue Package-, Registry- oder Laufzeitabhängigkeit wurde eingeführt.
Produktkern: vorhandenes PowerShell 7/.NET; Adapter: Bash 3.2; Tests: vorhandenes
Python 3 Standard Library. Damit gibt es keine neue Paketlizenz und keine
bekannte kritische CVE im hinzugefügten Dependency-Umfang. Systemtools und
GitHub Actions bleiben extern zu beobachten. AI-SBOM ist `N/A`, weil kein Modell,
Dataset, Promptdienst oder KI-Runtime ausgeliefert wird. Owner: Supply Chain
Owner; Reviewer: Dependency Reviewer; Trigger: Import-, Paket-, Action-,
Registry-, Lizenz- oder Runtimeänderung.
