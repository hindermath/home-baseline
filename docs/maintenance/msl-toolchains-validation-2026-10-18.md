# MSL-Wartung: Mac A / MSL maintenance: Mac A

Datum / date: 2026-10-18. Ziel / target: Mac A, Apple Silicon.
Auftrag / authority: gemeinsame Level-0-Implementierung und begrenzter echter
MSL-Lauf auf Mac A; keine Remote-Veroeffentlichung und kein Flotten-Rollout.

## Vertrag und Ausgangslage / Contract and initial state

Die gemeinsame PowerShell-7-Logik liest stabile Release-Metadaten und trennt
installierte, aktive, Paketquellen- und Hersteller-Version. Vorschau plant
.NET SDK 10.0.402, Python 3.15.0 und Swift 6.4.1. Go 1.27.2, OpenJDK 27 und
Rust/Cargo 1.99.1 sind bereits aktuell. Vorher startet `python3` Apples 3.9.6;
Homebrew-Python 3.14.8 ist parallel vorhanden.

*Shared PowerShell logic separates installed, active, package-source and
upstream versions. The initial preview plans three changes. Apple's Python
3.9.6 is initially active while Homebrew Python 3.14.8 is also installed.*

## Technische Pruefungen / Technical checks

Der echte Lauf und die anschliessende Pruefung melden sechs Mal `Current`,
Exitcode `0` und keine offenen Pflichtabweichungen. Ein weiterer Lauf mit
`--skip-upgrade` bestaetigt einen No-op: alle sechs Felder `changed` und
`environmentChanged` sind `false`.

| Toolchain | Aktive stabile Version / Active stable version | Ergebnis / Result |
|---|---|---|
| C# / F# (.NET SDK) | 10.0.402 | Aktualisiert / Updated |
| Go | 1.27.2 | Bereits aktuell / Already current |
| Java (OpenJDK, javac) | 27 | Bereits aktuell / Already current |
| Python | 3.15.0 | Installiert und aktiviert / Installed and activated |
| Rust / Cargo | 1.99.1 | Bereits aktuell / Already current |
| Swift | 6.4.1 | Installiert und aktiviert / Installed and activated |

Eine neue Login-Shell bestaetigt die Versionen sowie `pip` 26.2.1 fuer Python
3.15. Neun native Smoke-Schritte sind erfolgreich: .NET-Kompilierung und
Ausfuehrung ohne Paketfeeds, Go-Ausfuehrung, Java-Kompilierung und Ausfuehrung,
Python mit `ssl` und `venv`, Rust-Kompilierung und Ausfuehrung, Cargo-Aufruf
und Swift-Ausfuehrung. Direkte `swiftly`-Aufrufe erkennen dieselbe globale
6.4.1-Auswahl wie die verwalteten Swift-Launcher.

Die SHA-256-Werte von `/usr/bin/python3`, `/usr/bin/clang` und dem
Command-Line-Tools-Swift sind vor und nach dem Lauf identisch. `clang` wird
weiter unter `/usr/bin/clang` aufgeloest; `xcrun --find swift` verwendet weiter
Apples Command Line Tools. Homebrew-Python 3.14 bleibt parallel installiert.
Homebrew hat beim ersten SDK-Upgrade die alte .NET-Version bereinigt; die
gemeinsame Logik deaktiviert diese automatische Bereinigung jetzt fuer
kuenftige Laeufe, damit ein noch laufender PowerShell-Prozess seine
Runtime-Dateien behaelt.

Die isolierten Tests decken Release-Auswahl, PATH-Drift,
Paketquellen-Rueckstand, Preview-Grenzen und Berichtskonsistenz ab.
17 neue MSL-Tests bestehen; PSScriptAnalyzer 1.25.0 prueft 120 Dateien ohne
Error-/Warning-Befund. Documentation-Impact-Validierung, Secret-Scan und
Skriptinventar-Pruefung sind erfolgreich. Die Constitution-Kopie und die
fuenf gemeinsamen MSL-Guidance-Bloecke werden auf Gleichheit geprueft.
Die bestehenden POSIX-Fixtures verwenden jetzt den Interpreter des
Testprozesses direkt, statt pro JSON-Probe den Host-Python-Launcher zu starten.
Ein isolierter unveraenderter Test bestaetigte vorher die funktionale
Korrektheit nach 41.82 Sekunden; sein 20-Sekunden-Budget wurde durch die
Host-Aufrufkosten ueberschritten. Assertions und Zeitlimit bleiben erhalten.
Die bestehende 56er-Suite besteht unter Python 3.14 (13 plattformbedingte
Skips). Unter Python 3.15 bleibt nach der Fixture-Isolation genau ein
5-Sekunden-Timeout im separaten Finalisierungs-Harness; dessen gezielte
Wiederholung mit direktem Interpreter besteht in 2.149 Sekunden. Auch dort
bleiben Deadline und Assertions erhalten. Die uebrigen 42 ausfuehrbaren
Regressionstests bestehen im Python-3.15-Gesamtlauf.
Die finale 17er-MSL-Suite besteht nach den letzten Codeaenderungen in
28.314 Sekunden; die erneute Modul-Analyse meldet keine Befunde.

Der Benutzerblock stellt seine PATH-Prioritaet auch nach macOS `path_helper`
wieder her, entfernt Duplikate und wird atomar ersetzt. Bash und Zsh pruefen
wiederholtes Einlesen; verschachtelte native Login-Shells bestaetigen Swift
6.4.1 und Python 3.15.0. Bei der Anpassung wurde eine fehlerhafte Regex-
Ersetzung vor der Distribution aus den unmittelbar vorher erstellten
Sicherungen zurueckgenommen. Die korrigierte Ersetzung behandelt Shell-Dollar-
Zeichen woertlich. Ein Vergleich ausserhalb des verwalteten Blocks bestaetigt
den unveraenderten Benutzerinhalt beider Profile. Der finale No-op-Bericht
`mac-a-final-2026-10-18.json` bestaetigt sechs Mal `Current` ohne Aenderungen.
Windows-/Linux-Installationen benoetigen eine eigene native Abnahme;
Fixture-Tests auf Mac A ersetzen diese nicht. Die lokalen JSON-Berichte
liegen unter `~/.home-baseline/reports/msl/` (`mac-a-2026-10-18.json`,
`mac-a-verified-2026-10-18.json`, `mac-a-idempotent-2026-10-18.json` und
`mac-a-smoke-2026-10-18.json`).

*The real run and verification report six Current toolchains, exit zero and
no required drift. Repeating maintenance with skip-upgrade changes neither
packages nor activation files. A fresh login shell and nine native smoke
steps confirm all six languages. Apple's executables retain their original
hashes and command resolution. Python 3.14 remains installed alongside 3.15.
The first SDK upgrade cleaned up the old SDK; future runs disable automatic
Homebrew cleanup to protect a running PowerShell runtime. Windows and Linux
still require their own native acceptance; Mac fixture tests do not provide
that proof. Seventeen new tests and the pinned analyzer pass. Existing POSIX
fixtures now resolve their test interpreter directly to avoid repeated host
launcher startup; functional assertions and timeouts remain unchanged. The
56-case suite passes with Python 3.14, with 13 platform skips. Python 3.15
passes the other 42 executable cases; the remaining finalization harness
passes its targeted repeat after the same interpreter isolation. The final
MSL suite and module analysis pass. Bash/Zsh and nested native login shells
verify PATH precedence and duplicate removal. A faulty profile replacement
was restored from immediate backups before distribution, then corrected to
preserve literal shell variables. User content outside managed blocks is
unchanged; the final native report is a successful no-op.
Machine-local JSON reports retain the installation evidence.*

## Dokumentation und Distribution / Documentation and distribution

[Documentation Impact](msl-toolchains-documentation-impact.json):
`UpdateRequired`. Code, Register, gemeinsame Guidance und Constitution-Kontext
sind `homeRuntime`; Referenz und Nachweis werden im Level-0-Klon gelesen.
Constitution-Prinzip XI und die Projekt-Runtime-Zeilen bleiben unveraendert;
der ergaenzte Absatz beschreibt die Betriebsgrenze der Host-Wartung.

*Code, registries, shared guidance and constitution context are homeRuntime;
read reference and evidence in the source clone. Principle XI and project
runtime rows remain unchanged; the added context explains host maintenance.*
