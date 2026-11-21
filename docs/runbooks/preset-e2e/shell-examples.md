# Beispiele mit Bash und PowerShell 7 / Bash and PowerShell 7 examples

## Deutsch

Diese Beispiele ergänzen das [E2E-Runbook](README.md). Wähle pro Schritt **eine** Shell. Bash-Beispiele gelten für macOS und Linux einschließlich WSL2. PowerShell-Beispiele verwenden PowerShell 7 (`pwsh`), nicht Windows PowerShell 5.1. PowerShell auf macOS ist kein Windows-Test. Starte im bereits genehmigten, isolierten Test-HOME. Passe Beispielpfade, Programme und Ports an den Auftrag an; ein leerer oder fehlender Beleg ist kein Pass.

- [Vorbereitung und Bootstrap](#setup-example): Revision und Hash prüfen; die nativen Bootstrap-Anleitungen zeigen Aufbau und Vorschau.
- [Runner und Phasenstatus](#state-example): Eine vorhandene Zustandsdatei lesend prüfen. Das prüft das Datenformat, nicht die fachliche Abnahme oder eine Startfreigabe.
- [CLI und TUI](#cli-example) (A/B): Erfolgs- und Fehlerfall ausführen und Exitcodes direkt ablesen. Die TUI separat ohne Umleitung in einem interaktiven Terminal starten. Tastensequenz und Wiederherstellung des Terminalmodus im Lernprüfblatt festhalten.
- [HTTP und Browser](#http-example) (C/D): Eine bereits gestartete, freigegebene lokale Anwendung anfragen. Erwartet: HTTP 200 und Ergebnis 8; bei Division durch null HTTP 400 und Fehlertext. Danach die lokale Startseite im Browser öffnen und Fehlerkorrektur und Tastaturbedienung selbst prüfen.
- [PDF und Abschlussbeleg](#pdf-example) (A–D): Typst ist ein Beispiel, keine Pflicht. Nur mit lokal freigegebener Quelle und installiertem Werkzeug bauen. Hash der endgültigen Datei erfassen; automatische Strukturprüfung, Sicht- und Tastaturprüfung getrennt berichten. Im Laufbericht Shell, tatsächlichen Befehl und Ergebnis notieren.

## English

These examples supplement the [E2E runbook](README.md#end-to-end-test-of-all-spec-kit-presets). Choose **one** shell per step. Bash examples are for macOS and Linux including WSL2. PowerShell examples use PowerShell 7 (`pwsh`), not Windows PowerShell 5.1. PowerShell on macOS is not a Windows test. Start in the approved, isolated test HOME. Adapt sample paths, binaries and ports to the request; empty or missing evidence is not a pass.

- [Setup and bootstrap](#setup-example): Check revision and digest; the native bootstrap guides cover setup and preview.
- [Runner and phase state](#state-example): Read-only check an existing state file. This checks its format, not substantive acceptance or permission to start.
- [CLI and TUI](#cli-example) (A/B): Run one successful and one failing case and read each exit code immediately. Start the TUI separately in an interactive terminal without redirection. Record keystrokes and restoration of terminal mode in the learner review sheet.
- [HTTP and browser](#http-example) (C/D): Query an approved local app that is already running. Expect HTTP 200 and result 8; for division by zero expect HTTP 400 and error text. Then open the local home page in a browser and personally check keyboard use and error recovery.
- [PDF and closeout evidence](#pdf-example) (A–D): Typst is an example, not a requirement. Build only from an approved local source with installed tools. Record the final digest and report automated structure, visual and keyboard checks separately. Record the shell, actual command and result in the run report.

<a id="setup-example"></a>

## Vorbereitung und Bootstrap / Setup and bootstrap

[macOS/Linux mit Bash](../security-baseline-integration-test.md#macos-und-ubuntuwsl2) ·
[Windows mit PowerShell 7](../security-baseline-integration-test.md#windows)

Im Level-0-Quellklon ausführen. / Run in the Level 0 source checkout.

```bash
git rev-parse HEAD || exit
matrix=scripts/config/spec-kit-project-statistics-governance-presets.json
if command -v sha256sum >/dev/null; then
  sha256sum "$matrix"
else
  shasum -a 256 "$matrix"
fi
```

```powershell
git rev-parse HEAD
if ($LASTEXITCODE -ne 0) { throw 'Git revision unavailable.' }
$matrix = 'scripts/config/spec-kit-project-statistics-governance-presets.json'
(Get-FileHash -LiteralPath $matrix -Algorithm SHA256 -ErrorAction Stop).Hash.ToLowerInvariant()
```

<a id="state-example"></a>

## Runner und Phasenstatus / Runner and phase state

Im Test-Repository mit installiertem Preset; den Beispielpfad ersetzen. / In the test repository with the installed preset; replace the example path.

```bash
state='specs/001-calculator/autonomous-run-state.json'
checks='.specify/presets/autonomous-run-governance/scripts'
bash "$checks/validate-autonomous-run-state.sh" --state "$state"
```

```powershell
$state = 'specs/001-calculator/autonomous-run-state.json'
$checks = '.specify/presets/autonomous-run-governance/scripts'
pwsh -NoProfile -File "$checks/validate-autonomous-run-state.ps1" -State $state
if ($LASTEXITCODE -ne 0) { throw 'State validation did not pass.' }
```

<a id="cli-example"></a>

## CLI und TUI / CLI and TUI

Pfade an die gebauten Programme anpassen; unter Windows in PowerShell ggf. `.exe` angeben. Bei C# den dokumentierten Runtime-Start des Projekts verwenden, wenn kein eigenständig startbares Programm vorliegt. Die Kurzprobe ersetzt keinen Vergleich der Rohbytes beider Ausgabeströme. / Adapt paths to the built programs; include `.exe` in PowerShell on Windows as needed. For C#, use the project's documented runtime launcher when there is no directly launchable binary. This smoke check is not an exact comparison of both raw streams.

```bash
calc='./build/calc'
tui='./build/calc-tui'
if "$calc" 6 add 2; then printf 'exit=0\n'; else printf 'exit=%s\n' "$?"; fi
if "$calc" 1 divide 0; then printf 'exit=0\n'; else printf 'exit=%s\n' "$?"; fi
"$tui"
```

```powershell
& {
    $PSNativeCommandUseErrorActionPreference = $false
    $calc = './build/calc'
    $tui = './build/calc-tui'
    foreach ($app in $calc, $tui) {
        if (-not (Test-Path -LiteralPath $app -PathType Leaf)) { throw "Missing app: $app" }
    }
    & $calc 6 add 2
    "exit=$LASTEXITCODE"
    & $calc 1 divide 0
    "exit=$LASTEXITCODE"
    & $tui
}
```

<a id="http-example"></a>

## HTTP und Browser / HTTP and browser

`5100` ist ein Beispiel innerhalb des freigegebenen Loopback-Bereichs. Keine externe Adresse verwenden. Bash benötigt hier `curl`. Die Fehlermeldung und der Status werden angezeigt, nicht als bestanden gewertet. / `5100` is an example within the approved loopback range. Do not use an external address. Bash uses `curl`. The response and status are displayed; no pass is assigned automatically.

```bash
for json in '{"left":6,"operation":"add","right":2}' '{"left":1,"operation":"divide","right":0}'; do
  curl --noproxy '*' --max-time 5 --silent --show-error --write-out '\nHTTP %{http_code}\n' \
    --header 'Content-Type: application/json' --data-binary "$json" \
    'http://127.0.0.1:5100/calculate' || break
done
```

```powershell
foreach ($case in @(@{left=6; operation='add'; right=2}, @{left=1; operation='divide'; right=0})) {
    $request = @{
        Uri = 'http://127.0.0.1:5100/calculate'
        Method = 'Post'
        ContentType = 'application/json'
        Body = ($case | ConvertTo-Json -Compress)
        NoProxy = $true
        MaximumRedirection = 0
        TimeoutSec = 5
        SkipHttpErrorCheck = $true
        ErrorAction = 'Stop'
    }
    $response = Invoke-WebRequest @request
    $response.Content
    "HTTP $($response.StatusCode)"
}
```

<a id="pdf-example"></a>

## PDF und Abschlussbeleg / PDF and closeout evidence

`./output` muss bereits im isolierten Lauf existieren; die Beispiele ändern weder die Handbuchquelle noch veröffentlichen sie etwas. / `./output` must already exist within the isolated run; the examples neither change the source nor publish anything.

```bash
typst compile --pdf-standard ua-1 --ignore-system-fonts ./docs/handbook.typ ./output/handbook.pdf || exit
if command -v sha256sum >/dev/null; then
  sha256sum ./output/handbook.pdf
else
  shasum -a 256 ./output/handbook.pdf
fi
```

```powershell
typst compile --pdf-standard ua-1 --ignore-system-fonts ./docs/handbook.typ ./output/handbook.pdf
if ($LASTEXITCODE -ne 0) { throw 'PDF build failed.' }
(Get-FileHash -LiteralPath './output/handbook.pdf' -Algorithm SHA256 -ErrorAction Stop).Hash.ToLowerInvariant()
```
