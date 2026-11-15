# Wiederholbarer Integrationstest der Sicherheitsbasis

## Zweck und Freigabe

Dieses Runbook hält einen wiederholbaren Test der aus Level 0 verteilten Skripte und Spec-Kit-Presets fest. Es ist eine **Anleitung**, kein Auftrag zum Start. Bootstrap, Builds, Sandbox-Tests und Secure-Trader-Läufe beginnen erst nach einem gesonderten Maintainer-Auftrag. Ein erfolgreicher Lauf belegt nur die tatsächlich geprüften Revisionen, Plattformen und Testfälle; er ist keine allgemeine Sicherheitsfreigabe.

Ein gesondertes [Preset-End-to-End-Runbook](preset-e2e/README.md) beschreibt vier spätere Praxisläufe A–D mit allen 14 Presets und wählbarem Host- oder Sandbox-Ort.

Die [leere Berichtsvorlage](security-baseline-integration-test-report-template.md) gehört zu jedem Lauf. Ausgefüllte Berichte bleiben zunächst lokal. Private Repository-Namen, Pfade, Revisionen, Logs und Zugangsdaten gehören nicht in öffentliche PRs.

## Zwei Leserpfade

| Leserpfad | Umfang | Voraussetzung |
|---|---|---|
| Lernübung | Isolierter Level-1-Workspace, zwei lokale Level-2-Projekte und höchstens ein freigegebenes Beispielprojekt | Betreuung und ein schreibbarer temporärer Bereich; kein GitHub-Konto |
| Maintainer-Lauf | Lernübung plus neun öffentliche Level-2-Repositories und drei Secure-Trader-Stränge mit insgesamt 18 Sprach-Repositories | Gesonderter Auftrag, Zugriff auf die jeweiligen Repositories und freigegebene Sandbox |

Die Lernübung ist kein verkleinerter Sicherheitsnachweis für die gesamte Flotte. Lernende verwenden nur eigene oder ausdrücklich freigegebene Beispielprojekte. Sie benötigen keinen Zugriff auf private Repositories.

## Plattformen und gemeinsame Regeln

Der erste geplante Lauf findet auf macOS statt. Windows mit PowerShell 7 und Ubuntu unter WSL2 sind **optionale spätere Wiederholungen**. Auf macOS und Ubuntu werden vorhandene `.sh`-Skripte mit Bash aufgerufen, auf Windows die `.ps1`-Varianten mit PowerShell 7. Secure-Trader-Agentenarbeit läuft auf jeder Plattform nur in einer freigegebenen Sandbox. Die optionale Windows/WSL2-Wiederholung ist keine Bedingung für den macOS-Bericht.

Vor jedem Lauf:

1. Betriebssystem, Architektur, Toolversionen, Level-0-Commit und den Commit jedes Prüfziels notieren. Bei unterschiedlichen Commits die Plattform-Ergebnisse getrennt auswerten.
2. Repository-Guidance, CI-Definitionen und aktuelle Arbeitsverzeichniszustände lesen. Vorhandene Änderungen bleiben erhalten. Builds und Tests möglichst in temporären Arbeitskopien des **exakten** Commits ausführen; keine fremden Branches zurücksetzen.
3. Die aktuelle Level-0-Preset-Matrix und die installierten Versionen und Hashes mit den vorhandenen Check-only-Funktionen vergleichen. Abweichungen im Bericht nennen, nicht während des Tests ungefragt ausrollen.
4. Bei schreibenden Hilfsskripten zuerst Hilfe, Syntaxprüfung und Vorschau ausführen. Keine Live-Daten, produktiven Zugangsdaten oder privaten Agentenlogs als Testdaten verwenden.

Die Statuswerte im Bericht sind `bestanden`, `fehlgeschlagen`, `nicht anwendbar` und `blockiert`. `Nicht anwendbar` braucht eine Begründung, etwa ein noch nicht vorhandenes Produktprojekt. `Blockiert` bezeichnet eine fehlende Voraussetzung oder einen nicht ausführbaren Test. Weder ein erfolgreicher Build noch ein grüner CI-Status ersetzt die fehlenden Einzeltests.

## Lernübung: lokaler Bootstrap ohne Registrierung im echten Workspace

Der normale Level-2-Bootstrap schreibt **auch mit `--no-remote`** in die lokale GSDB-Registry. Deshalb wird ein eigenes, restriktiv berechtigtes Test-HOME mit eigener Git-Konfiguration und eigener Registry verwendet. `--no-remote` allein genügt nicht. Vorher Prüfsummen der echten Home-README und Registry festhalten. Der Testbereich erhält einen eindeutigen Namen und liegt weder im echten Home noch in einem bestehenden Projekt.

### macOS und Ubuntu/WSL2

Ausführungsort: **Host**, Shell: **Bash**. Die folgenden Befehle sind ein Ablaufmuster. Vor einem echten Lauf die aktuelle `--help`-Ausgabe und die konkrete Level-0-Quelle prüfen. `HB_TEST_HOME` bezeichnet ausschließlich das neu angelegte Testverzeichnis; vorhandene Verzeichnisse nie wiederverwenden.

```bash
HB_SOURCE="$(git -C "$HOME/home-baseline-source" rev-parse --show-toplevel)"
HB_TEST_HOME="$(mktemp -d "${TMPDIR:-/tmp}/hb-security-integration.XXXXXX")"
chmod 700 "$HB_TEST_HOME"
mkdir "$HB_TEST_HOME/ValidationProjects"
cp "$HB_SOURCE/constitution.md" "$HB_TEST_HOME/constitution.md"
GIT_CONFIG_GLOBAL="$HB_TEST_HOME/.gitconfig" git config --global user.name 'Bootstrap Test'
GIT_CONFIG_GLOBAL="$HB_TEST_HOME/.gitconfig" git config --global user.email 'bootstrap-test@example.invalid'
export HOME_BASELINE_SOURCE="$HB_SOURCE"
export GIT_CONFIG_GLOBAL="$HB_TEST_HOME/.gitconfig"
HOME="$HB_TEST_HOME" bash "$HB_SOURCE/scripts/bootstrap-workspace.sh" --dry-run --no-remote ValidationProjects
HOME="$HB_TEST_HOME" bash "$HB_SOURCE/scripts/bootstrap-workspace.sh" --no-remote ValidationProjects
HOME="$HB_TEST_HOME" bash "$HB_TEST_HOME/ValidationProjects/scripts/bootstrap-project.sh" BootstrapCSharp "$HB_TEST_HOME/ValidationProjects" --primary-language csharp --preset-profile project-statistics-fourteen-governance-presets --no-remote --preview
HOME="$HB_TEST_HOME" bash "$HB_TEST_HOME/ValidationProjects/scripts/bootstrap-project.sh" BootstrapCSharp "$HB_TEST_HOME/ValidationProjects" --primary-language csharp --preset-profile project-statistics-fourteen-governance-presets --no-remote
HOME="$HB_TEST_HOME" bash "$HB_TEST_HOME/ValidationProjects/scripts/bootstrap-project.sh" BootstrapPython "$HB_TEST_HOME/ValidationProjects" --primary-language python --preset-profile project-statistics-fourteen-governance-presets --no-remote --preview
HOME="$HB_TEST_HOME" bash "$HB_TEST_HOME/ValidationProjects/scripts/bootstrap-project.sh" BootstrapPython "$HB_TEST_HOME/ValidationProjects" --primary-language python --preset-profile project-statistics-fourteen-governance-presets --no-remote
```

Wenn die lokale Level-0-Quelle anders liegt, `HB_SOURCE` vor dem Lauf auf ihren verifizierten Checkout setzen. Bei WSL2 einen Linux-Pfad verwenden; nicht den Windows-Checkout über `/mnt/c` als stillschweigend gleichwertige Quelle behandeln.

### Windows

Ausführungsort: **Windows-Host**, Shell: **PowerShell 7**. Die echte Home-README und Registry vorher und nachher per Hash vergleichen. `HBSource` muss auf einen verifizierten Windows-Checkout zeigen. Den neuen Testordner nicht wiederverwenden. Im Testprozess `HOME`, `USERPROFILE` und `GIT_CONFIG_GLOBAL` isolieren; die ursprüngliche PowerShell-Sitzung bleibt unverändert.

```powershell
$HBSource = (git -C "$HOME/home-baseline-source" rev-parse --show-toplevel).Trim()
$HBTestHome = Join-Path $env:TEMP ("hb-security-integration-" + [guid]::NewGuid().ToString('N'))
New-Item -ItemType Directory -Path $HBTestHome | Out-Null
New-Item -ItemType Directory -Path (Join-Path $HBTestHome 'ValidationProjects') | Out-Null
Copy-Item (Join-Path $HBSource 'constitution.md') (Join-Path $HBTestHome 'constitution.md')
$env:HOME = $HBTestHome
$env:USERPROFILE = $HBTestHome
$env:HOME_BASELINE_SOURCE = $HBSource
$env:GIT_CONFIG_GLOBAL = Join-Path $HBTestHome '.gitconfig'
git config --global user.name 'Bootstrap Test'
git config --global user.email 'bootstrap-test@example.invalid'
pwsh -NoProfile -File (Join-Path $HBSource 'scripts/bootstrap-workspace.ps1') -WorkspaceName ValidationProjects -NoRemote -WhatIf
pwsh -NoProfile -File (Join-Path $HBSource 'scripts/bootstrap-workspace.ps1') -WorkspaceName ValidationProjects -NoRemote
$BootstrapProject = Join-Path $HBTestHome 'ValidationProjects/scripts/bootstrap-project.ps1'
pwsh -NoProfile -File $BootstrapProject -ProjectName BootstrapCSharp -TargetWorkspace (Join-Path $HBTestHome 'ValidationProjects') -PrimaryLanguage csharp -PresetProfile project-statistics-fourteen-governance-presets -NoRemote -Preview
pwsh -NoProfile -File $BootstrapProject -ProjectName BootstrapCSharp -TargetWorkspace (Join-Path $HBTestHome 'ValidationProjects') -PrimaryLanguage csharp -PresetProfile project-statistics-fourteen-governance-presets -NoRemote
pwsh -NoProfile -File $BootstrapProject -ProjectName BootstrapPython -TargetWorkspace (Join-Path $HBTestHome 'ValidationProjects') -PrimaryLanguage python -PresetProfile project-statistics-fourteen-governance-presets -NoRemote -Preview
pwsh -NoProfile -File $BootstrapProject -ProjectName BootstrapPython -TargetWorkspace (Join-Path $HBTestHome 'ValidationProjects') -PrimaryLanguage python -PresetProfile project-statistics-fourteen-governance-presets -NoRemote
```

Die isolierte PowerShell-Sitzung beenden, bevor normale Arbeit fortgesetzt wird. Wenn die Level-0-Quelle anders liegt, nur `$HBSource` vor dem Lauf auf den verifizierten Checkout setzen.

### Abnahme und Bereinigung der Lernübung

- Genau ein neuer lokaler Level-1-Workspace und zwei lokale Level-2-Git-Repositories mit den erwarteten Agentenflächen, Sicherheitsdokumenten, Hooks und 14 Presets. Versionen und Hashes stammen aus der aktuellen Matrix; keine Preset-Zahl schätzen.
- Kein GitHub-/GitLab-Remote und kein Eintrag in der **echten** Registry. Die Test-Registry darf genau die beiden temporären Level-2-Projekte enthalten. Echte Home-README und Registry haben unveränderte Prüfsummen.
- Nur bei erfolgreicher Prüfung: Hilfe und Dry-Run des passenden `teardown-workspace.*` für den eindeutig markierten Test-Workspace prüfen, dann diesen Workspace und anschließend das ausschließlich dafür angelegte Test-HOME entfernen. Nie pauschal temporäre oder Home-Verzeichnisse bereinigen. Bei einem Fehlschlag den isolierten Testbereich zur Diagnose erhalten und seinen Pfad lokal melden.

Ein freigegebenes Beispielprojekt kann danach in einer weiteren temporären Arbeitskopie mit seinen eigenen Build- und Testbefehlen geprüft werden. Das ist optional für Lernende; private Secure-Trader-Repositories sind nicht Teil dieser Übung.

## Maintainer-Lauf: neun öffentliche Level-2-Repositories

Ausführungsort: **macOS-Host** beim ersten Lauf, optional später passender Windows- oder Ubuntu/WSL2-Host. Die im jeweiligen Repository dokumentierten Befehle und CI-Definitionen sind maßgeblich. Zuerst Hilfe und Voraussetzungen prüfen, dann alle dort vorhandenen relevanten Test-Suites am festgehaltenen Commit ausführen.

| Repository | Build und Test-Basis |
|---|---|
| TinyPl0 | `dotnet restore`, Release-Build, vollständige .NET-Tests und vorgesehene Coverage-Prüfung |
| TinyCalc | `MicroCalc.sln` wiederherstellen, Release-Build, vollständige xUnit-Suite und nicht interaktiver TUI-Smoke-Test |
| TuiVision | `TuiVision.sln` wiederherstellen, Release-Build, vollständige MSTest-Suite und konfigurierte Coverage-Gates |
| InventarWorkerService | `InventarWorkerService.sln` wiederherstellen, Build und vollständige Unit-/Integrationstests; benötigte Testdienste getrennt ausweisen |
| Show-CommandTui400 | Vorhandene Lösung und tatsächliche Projektdateien prüfen, dann vorhandene Build-/Testsuiten sowie PowerShell- und Governance-Prüfungen ausführen; fehlende Produktteile nicht als bestanden ausweisen |
| Agent Operations Cockpit | Solange keine freigegebene Produktlösung vorliegt: Intake-, Serien-, Governance- und Dokumentationsprüfungen; Produkt-Build `nicht anwendbar` |
| cc65 | `make`, `make test`, `make check`, `make checkstyle` und der dokumentierte C64-Zieltest mit `SYS=c64` |
| tvision | CMake mit `TV_BUILD_TESTS=ON` konfigurieren, Bibliothek und Beispiele bauen, vollständige konfigurierte Testsuite ausführen |
| absdd-image-sandbox | Bestehendes Image: Compose-Konfiguration, Container-Health, dokumentierte Toolchain-, Sicherheits- und Repository-Smoke-Tests; kein Image-Neubau |

`cc65` und `tvision` sind C/C++-Projekte; die Sandbox ist ein Container-Projekt. Sie dürfen nicht als C#-Tests gezählt werden. Bei fehlendem Emulator, Testdienst oder Paket die betroffene Prüfung `blockiert` melden. Keine zusätzlichen Container oder Images als stillschweigenden Ersatz anlegen.

## Maintainer-Lauf: drei Secure-Trader-Stränge

Ausführungsort für **jede Agentenarbeit**: freigegebene Sandbox. Vorher Mounts, Benutzer ohne Root-Rechte, Image-Stand und Testdaten-Grenzen prüfen. Die sechs Secure-CaseTracker-Sprach-Repositories haben Laufzeit-Manifeste und werden nach ihren lokalen Vorgaben in C#, Go, Java, Python, Rust und Swift gebaut und getestet. Die je sechs Secure-OrderDesk- und Secure-ServiceHarvester-Sprach-Repositories sind derzeit Produktgerüste ohne Build-Manifest: dort vorhandene Governance-, Preset-, Sicherheits- und Dokumentationsprüfungen ausführen; Produkt-Builds mit Begründung `nicht anwendbar` führen.

Falls sich ein Gerüst bis zum späteren Lauf zu einem Produkt entwickelt hat, gelten dessen dann aktuelle Guidance, Manifest und CI-Tests. Ein veralteter Runbook-Eintrag ersetzt keine Live-Prüfung. Projektübergreifende Datenflüsse nur mit synthetischen Testdaten prüfen; echte Kundendaten und Secrets bleiben ausgeschlossen.

## Bericht und Abschluss

Pro Repository die genaue Revision, Plattform, Testbefehle, Testanzahl, Dauer und jeden Fehler oder Skip in der [Vorlage](security-baseline-integration-test-report-template.md) festhalten. Quellenstand und installierte Presets getrennt nennen. Keine Zahl aus alten Berichten übernehmen. Beim Vergleich zwischen macOS, Windows und WSL2/Ubuntu immer Revision und Image-Stand mitlesen.

Temporäre Arbeitskopien nach Prüfung ihrer Identität gezielt entfernen. Echte Repositories, Registries, Home-Dateien, Sandbox-Volumes und Nutzerdaten unverändert lassen. Der Maintainer-Bericht trennt nachgewiesene Ergebnisse von offenen Prüfungen und nennt den nächsten konkreten Schritt; er löst keine Reparatur, Veröffentlichung oder Spec-Kit-Ausführung selbst aus.

---

# Repeatable security baseline integration test

## Purpose and authority

This runbook records a repeatable test of scripts and Spec Kit presets distributed from Level 0. It is an **instruction**, not permission to run it. Bootstrap, builds, sandbox checks and Secure Trader tests require a separate maintainer request. A successful run supports only the tested commits, platforms and cases. It is not a general security approval.

The separate [preset end-to-end runbook](preset-e2e/README.md) describes four later practical runs A–D covering all 14 presets, with Host or Sandbox chosen per run.

Use the [blank report template](security-baseline-integration-test-report-template.md) for each run. Keep completed reports local at first. Do not publish private repository names, paths, commits, logs or credentials.

## Reader paths

| Path | Coverage | Prerequisite |
|---|---|---|
| Guided exercise | An isolated Level 1 workspace, two local Level 2 projects and at most one approved example project | Supervision and a writable temporary location; no GitHub account |
| Maintainer run | The exercise plus nine public Level 2 repositories and all 18 language repositories in three Secure Trader tracks | A separate request, repository access and an approved sandbox |

The exercise does not establish security coverage for the whole fleet. Learners use only their own or explicitly approved example projects; they need no access to private repositories.

## Platforms and common rules

The first planned run is on macOS. Windows with PowerShell 7 and Ubuntu under WSL2 are **optional later repeats**. Use existing Bash `.sh` scripts on macOS and Ubuntu, and PowerShell `.ps1` scripts on Windows. Any agent work on Secure Trader runs only inside an approved sandbox. Optional platform repeats do not gate the macOS report.

Before each run, record OS, architecture, tool versions, the Level 0 commit and each target commit. Read local guidance, CI definitions and working-tree state. Preserve existing work and prefer temporary copies at the **exact** commit. Compare the current Level 0 preset matrix with installed versions and hashes using existing check-only modes; report drift without silently rolling out changes. Inspect help, syntax and preview before any writing helper. Use synthetic data, never production data or private agent logs.

Report `passed`, `failed`, `not applicable` or `blocked`, with a reason for the last two. Missing product code may be not applicable; a missing tool or service is blocked. Neither a build nor green CI replaces an individual test.

## Guided exercise: local bootstrap

The normal Level 2 bootstrap updates the local GSDB registry **even with `--no-remote`**. Use a new restricted test HOME, separate Git configuration and separate registry. Record hashes of the real home README and registry before and after. Never reuse a pre-existing directory. The [macOS/Ubuntu Bash commands](#macos-und-ubuntuwsl2) and [Windows PowerShell commands](#windows) above set `HOME_BASELINE_SOURCE`, preview each operation and create a local Level 1 workspace plus C# and Python Level 2 projects with the explicit 14-preset profile. Check current help before running them. In WSL2, use a Linux checkout rather than silently treating a Windows checkout under `/mnt/c` as equivalent.

Acceptance requires the expected Git repositories, agent surfaces, security files, hooks and matrix-bound presets; no remote or real registry entry; and unchanged real home files. Only after success, preview the matching teardown, remove the identified workspace and then its dedicated test HOME. Keep a failed isolated test for diagnosis and report its location locally. An approved example project may be built in a further temporary copy. Private Secure Trader repositories are outside the exercise.

## Maintainer run: public Level 2

Use the repository's current guidance and CI definitions as the source for exact commands. The first run uses the macOS host; a later Windows or Ubuntu/WSL2 run uses the matching host tools.

| Repository | Build and test baseline |
|---|---|
| TinyPl0 | `dotnet restore`, Release build, full .NET test suite and specified coverage check |
| TinyCalc | Restore `MicroCalc.sln`, Release build, full xUnit suite and non-interactive TUI smoke test |
| TuiVision | Restore `TuiVision.sln`, Release build, full MSTest suite and configured coverage gates |
| InventarWorkerService | Restore `InventarWorkerService.sln`, build and full unit/integration suites; record required test services separately |
| Show-CommandTui400 | Inspect the existing solution and actual projects, then run available builds/tests plus PowerShell and governance checks; do not count absent product parts as passed |
| Agent Operations Cockpit | Until an approved product solution exists: intake, series, governance and documentation checks; product build `not applicable` |
| cc65 | `make`, `make test`, `make check`, `make checkstyle` and the documented C64 target test with `SYS=c64` |
| tvision | Configure CMake with `TV_BUILD_TESTS=ON`, build library and examples, run the full configured test suite |
| absdd-image-sandbox | Existing image: Compose configuration, container health, documented toolchain, security and repository smoke tests; no image rebuild |

Do not count C/C++, container or governance checks as C# product tests. Record missing emulators, services or packages as blocked rather than passed. Do not silently create additional containers or images.

## Maintainer run: Secure Trader

All agent work runs inside the approved sandbox. Verify mounts, non-root user, image version and synthetic test-data limits first. Build and test the six Secure CaseTracker language repositories using their current C#, Go, Java, Python, Rust and Swift manifests. The six Secure OrderDesk and six Secure ServiceHarvester language repositories currently lack product build manifests: run existing governance, preset, security and documentation checks, and mark product builds not applicable with a reason. If a scaffold gains product code later, use its then-current guidance, manifests and CI tests. Do not treat this runbook as a live inventory.

## Report and closeout

For each repository, record its commit, platform, commands, test count, duration, errors and skips in the [template](security-baseline-integration-test-report-template.md). Separate source and installed preset versions. Never reuse historical counts. Compare results across platforms only with their commits and image versions. Remove only identified temporary copies; preserve real repositories, registries, home files, sandbox volumes and user data. The report states the next concrete step without authorizing repairs, publication or Spec Kit work.
