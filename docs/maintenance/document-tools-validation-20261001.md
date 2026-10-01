# Dokumentwerkzeuge: Validierung / Document tools: validation

Stand / Date: 2026-10-01. Owner: Workspace Maintainer.

## Vertrag / Contract

Pandoc und Typst CLI sind auf macOS, Linux und Windows Pflichtwerkzeuge.
Tinymist Typst (`myriad-dreamin.tinymist`) ist die Pflicht-Erweiterung fuer
VS Code; das separate `tinymist`-Systempaket ist optional. Die vorhandene
Toolchain-Stufe des Ein-Kommando-Laufs konsumiert dieselben Registries.

*Pandoc and Typst CLI are required on macOS, Linux, and Windows. Tinymist
Typst is the required VS Code extension; standalone `tinymist` remains
optional. The existing one-command toolchain stage consumes these registries.*

Die Paketzuordnung lautet Homebrew `pandoc`/`typst`/`tinymist`, WinGet
`JohnMacFarlane.Pandoc`/`Typst.Typst`/`Myriad-Dreamin.Tinymist` und apt
`pandoc`. Linux ohne Homebrew installiert fehlendes Typst mit
`cargo install --locked typst-cli`; separates Tinymist nur bei Optional-Auswahl
mit `cargo install --locked tinymist-cli`. Die derzeitigen Upstream-Releases
Typst 0.15.1 und Tinymist 0.15.8 verlangen Rust 1.92. Vorhandene
Cargo-Installationen werden nicht automatisch neu gebaut. Alte Distro-Rust-
Toolchains werden nicht stillschweigend ersetzt; Buildfehler bleiben Befunde.

*Package IDs and the locked Cargo fallbacks above are authoritative for this
change. Current upstream releases require Rust 1.92. Existing Cargo installs
are not rebuilt automatically; distro toolchains are not silently replaced.*

## Nachweise / Evidence

- Bash-Syntaxcheck und PowerShell-Parser: bestanden. / Passed.
- Registry-/Wartungsvertraege und Linux-Fixtures: 45 Tests, davon 43 bestanden
  und zwei plattformbedingt uebersprungen; kein Fehler. / 45 tests, 43 passed,
  two platform-dependent skips, no failures.
- PSScriptAnalyzer 1.25.0: 117 repo-eigene Dateien ohne Error oder Warning;
  vier generierte Upstream-Dateien ausgenommen. / No errors or warnings.
- Echter macOS-Dry-Run: `PARTIAL`, Exitcode 1. Typst-Formula und
  Tinymist-Erweiterung werden zur Installation vorgesehen; die Typst-CLI ist
  noch nicht im PATH. Zusaetzlich fehlt die bestehende Swift-Erweiterung.
  Vier Pflichtbefunde enthalten Typst als Paket und CLI separat. Es wurde
  keine Systeminstallation ausgefuehrt. / Actual preview plans the missing
  tools and correctly retains required drift; the existing Swift extension
  also remains missing. No system installation was performed.
- Documentation-Impact-Validator und Offline-Linkpruefung: bestanden,
  keine Linkfehler. `git diff --check`: bestanden. / Passed without link or
  whitespace errors.
- Pandoc 3.11 -> Typst 0.15.1 (`9dfd3a08`) -> PDF: bestanden, 13 177 Byte und
  `%PDF-`-Header. Markdown-Beispiel mit Ueberschrift, Fettdruck, Umlauten und
  Liste; keine externe Typst-Paketreferenz. / Real conversion and compilation
  passed on a small document without external package references.
- Typst-Testarchiv `typst-aarch64-apple-darwin.tar.xz`: SHA-256
  `48f62ed034aa3a7978309579ac6ca00045e2ef0da73114e8af27cfd8e74dc05a`,
  gegen den Digest des offiziellen GitHub-Releases geprueft. Das Binary wurde
  ausschliesslich im temporaeren Testverzeichnis verwendet. / Verified against
  the official release digest and used only in a temporary test directory.

Die isolierten Tests pruefen Vergleich, Vorschau, Nachinstallation,
Wiederholbarkeit, vorhandene CLI, Installationsfehler und Optional-Auswahl.
Die portable PowerShell-Pruefung verwendet die echten Vergleichsfunktionen
mit simulierten Beobachtungen und prueft Pflicht-CLI-, Pflicht-Extension- und
Optional-Status. Sie fuehrt kein WinGet aus.

*Isolated fixtures exercise comparison, preview, installation, repeated runs,
existing CLIs, installation failure, and optional selection. Portable
PowerShell tests load the real comparison functions with simulated observations
and do not invoke WinGet.*

Ausgefuehrte Suite / Executed suite:

```bash
python3 -m unittest scripts.tests.test_maintenance_contracts scripts.tests.test_linux_maintenance_hardening -q
```

Das Statistik-Ledger wurde fortgeschrieben. Der Profil-2-Renderer schreibt
nur bei sauberem Arbeitsbaum. Zur Lieferung gehoeren deshalb ein erster
Implementierungscommit, `render-project-statistics.sh` und ein Statistikcommit.
Vor dem Push muessen dessen `--check-only` und Homogeneity bestanden sein.
Der generierte Statistikblock wird ausschliesslich vom Renderer gepflegt.

*The ledger log is updated. The Profile 2 renderer writes only with a clean
working tree. Delivery therefore includes an implementation commit, the
renderer, and a statistics commit. Renderer check-only and homogeneity must
pass before pushing; the generated block is maintained only by the renderer.*

## Distribution und Proof-Grenzen / Distribution and proof limits

Die vier Registries, beide Pfleger, Tests, Agent-Guidance und Templates liegen
bereits in der manifestgebundenen Home Runtime. Das kanonische Wartungspaket
enthaelt die Registries, Pfleger, Linux-Fixture-Tests, Templates und Manpages
bereits; seine Zielmenge bleibt bestehen. Die Wartungsuebersichten, dieser
Bericht und die Documentation-Impact-Evidence sind `sourceOnly`.

Die Lieferung ist als `MergeAndSync` mit Admin-Bypass ausdruecklich autorisiert:
Branch, PR, technische Checks, Merge des geprueften Heads und lokaler
Main-Sync. Anschliessend wird Home-Sync geprueft und erforderliche Home-Runtime-
Drift synchronisiert. Der Flotten-Rollout erfolgt spaeter. Die Installation
der Werkzeuge auf diesem Rechner bleibt eine eigene Aufgabe.
Native Windows-/Linux-Installationen wurden in diesem macOS-Lauf nicht
nachgewiesen. Auch Extension-Interaktion und PDF-Barrierefreiheit sind durch
CLI- und Fixture-Nachweise allein nicht abgenommen.

*The existing manifests already cover the runtime registries, maintainers,
tests, guidance, templates, and propagated manpages. The central contract suite
remains outside the fleet package. Delivery is explicitly authorized as
MergeAndSync with admin bypass, including a PR, technical checks, a merge of
the verified head, local main synchronization, and Home sync verification and
repair. Fleet rollout is deferred; installing the tools on this machine remains
a separate task. Native Windows/Linux installation, editor interaction,
and PDF accessibility are not established by the local smoke/fixture tests.*

## Quellen / Sources

- [Pandoc-Installation / Pandoc installation](https://pandoc.org/installing.html)
- [Typst-Installation / Typst installation](https://github.com/typst/typst#installation)
- [Typst 0.15.1](https://github.com/typst/typst/releases/tag/v0.15.1)
- [Tinymist-Quellen / Tinymist sources](https://github.com/Myriad-Dreamin/tinymist/tree/v0.15.8)
- [Tinymist in VS Code](https://myriad-dreamin.github.io/tinymist/frontend/vscode.html)
- [WinGet-Paketquelle / WinGet package source](https://github.com/microsoft/winget-pkgs/tree/master/manifests)

Documentation Impact: `UpdateRequired`,
[Evidence](document-tools-documentation-impact-evidence.json).
