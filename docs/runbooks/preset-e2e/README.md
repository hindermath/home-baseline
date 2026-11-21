# Praxistest aller Spec-Kit-Presets / End-to-end test of all Spec Kit presets

## Zweck und Freigabe

Dieses Runbook ergänzt den [Integrationstest der Sicherheitsbasis](../security-baseline-integration-test.md). Es beschreibt vier wiederholbare **lokale** Tests des vollständigen 14-Preset-Profils. Das Lesen und Vorbereiten dieser Dokumentation startet keinen Test. Ein Maintainer beauftragt jeden Szenariolauf, eine spätere Veröffentlichung des Berichts und eine mögliche Bereinigung jeweils gesondert.

**Lastenheft** bedeutet hier ein prüfbarer Arbeitsauftrag. **Serie** bedeutet vier Lastenhefte mit bindender Reihenfolge. **Preset** bedeutet eine versionierte Spec-Kit-Erweiterung. Ein **Hash** ist der digitale Fingerabdruck einer konkreten Dateifassung. Für die Lernprüfung gilt die [Lernenden- und A11Y-Basis](../../learning-units/LERNENDEN-UND-A11Y-BASIS.md). Die Dateien in [intakes/](intakes/) sind nur Vorlagen: Sie sind keine aktiven Intakes, keine Serienmitglieder und keine Startberechtigung.

| Szenario | Produkt | Sprachen | Level-2-Repositories |
|---|---|---|---|
| A | CLI-Rechner mit TUI | Eine ausdrücklich gewählte MSL | 1 |
| B | CLI-Rechner mit TUI | C#, Go, Java, Python, Rust, Swift | 6 |
| C | Web-Rechner | Eine ausdrücklich gewählte MSL | 1 |
| D | Web-Rechner | C#, Go, Java, Python, Rust, Swift | 6 |

MSL heißt speichersichere Sprache. B und D koordinieren höchstens drei gleichzeitige Sprachpfade. Innerhalb eines Sprachpfads folgen vier Features strikt aufeinander.

## Gemeinsamer Produktvertrag

- Addition, Subtraktion, Multiplikation und Division benutzen dieselbe fachliche Rechenlogik in CLI/TUI beziehungsweise HTTP/Weboberfläche. Mindestens die Beispiele `6 + 2 = 8`, `6 - 2 = 4`, `6 * 2 = 12`, `6 / 2 = 3` und `1 / 2 = 0.5` werden geprüft. Die Operatortokens lauten `add`, `subtract`, `multiply` und `divide`.
- Ungültige Eingaben und Division durch null liefern eine verständliche Fehlermeldung und keinen scheinbar gültigen Zahlenwert. Kein dynamisches Auswerten eingegebener Ausdrücke.
- Der vergleichbare CLI-Aufruf lautet `calc <left> <operation> <right>`. Erfolg schreibt nur die Zahl und endet mit Exit-Code 0; Fehler schreiben Text nach stderr und enden ungleich 0. Das TUI ist mit Tastatur bedienbar; die CLI bleibt als Textalternative nutzbar.
- Der vergleichbare Web-Vertrag nutzt `POST /calculate` mit JSON-Feldern `left`, `operation` und `right`. Erfolg liefert HTTP 200 und `{"result": <number>}`; ungültige Eingaben und Division durch null liefern HTTP 400 und `{"error": "<text>"}`. `GET /` zeigt die per Tastatur bedienbare Oberfläche. Eingaben werden validiert und Ausgaben sicher dargestellt.
- Das Handbuch entsteht aus einer versionierten textorientierten Quelle. Vollständiges Deutsch steht vor gleichwertigem Englisch, ungefähr auf CEFR-B2-Niveau. Anwendbare WCAG-2.2-AA-Kriterien werden für CLI, TUI, Web und PDF getrennt geprüft. Beim PDF gehören Struktur, Dokumentsprache, Überschriften, Lesereihenfolge, Links und Textalternativen zum Prüfpfad; ein automatischer Check allein belegt keine Konformität.

## Vorlagen und bindende Reihenfolge

| Position | CLI-Serie A/B | Web-Serie C/D |
|---|---|---|
| 1 | [CLI-Rechner](intakes/cli-01-rechner.md) | [HTTP-Rechner](intakes/web-01-rechner.md) |
| 2 | [Unit- und Integrationstests](intakes/cli-02-tests.md) | [Unit- und HTTP-Integrationstests](intakes/web-02-tests.md) |
| 3 | [TUI](intakes/cli-03-tui.md) | [Weboberfläche](intakes/web-03-oberflaeche.md) |
| 4 | [Dokumentation und PDF-Handbuch](intakes/cli-04-handbuch.md) | [Dokumentation und PDF-Handbuch](intakes/web-04-handbuch.md) |

Die Kanten `1 → 2 → 3 → 4` sind bindend. Ein Nachfolger beginnt erst, wenn der Vorgänger mit seinen tatsächlichen Tests und Nachweisen abgeschlossen ist. Beim späteren Auftrag werden die Vorlagen je Sprach-Repository mit dessen Sprache und Versionen zu echten Lastenheften ausgearbeitet, semantisch geprüft und erst dann mit den vorhandenen Intake-Authoring-, Review- und Sequencing-Verfahren zu einer aktiven Serie verbunden. Kein Dokument in diesem Paket führt das automatisch aus.

## Auftrag und isolierter Aufbau

Die [leere Auftragsvorlage](maintainer-order-template.md) nennt Szenario, Ausführungsort `Host` oder `Sandbox`, Plattform, Sprache für A/C, Test-HOME, vorhandenes Modell-/Runner-Profil, Laufzeit- und Abbruchgrenze sowie den verantwortlichen Maintainer. Fehlt ein Pflichtwert, bleibt der Lauf blockiert. Der DeliveryMode der Test-Repositories ist fest `LocalImplementation`; es gibt keine Pushes, PRs oder Merges für sie.

1. Die aktuelle Level-0-Revision, [14-Preset-Matrix](../../../scripts/config/spec-kit-project-statistics-governance-presets.json), Toolversionen und lokalen Repository-Regeln schreibfrei prüfen. Hilfe, Syntaxprüfung und Vorschau der Bootstrap- und Installationsskripte vor jedem schreibenden Lauf ansehen. Eine heute dokumentierte Version ersetzt den Live-Abgleich nicht.
2. Pro Lauf eine eindeutige ID und ein neues, restriktiv berechtigtes Test-HOME wählen. Den echten Home-README- und Registry-Stand vorher per Hash festhalten. `--no-remote` allein isoliert die lokale Registry **nicht**; daher auch Git-Konfiguration, HOME und Registry im Test-HOME halten. Das [bestehende Bootstrap-Beispiel](../security-baseline-integration-test.md#lernübung-lokaler-bootstrap-ohne-registrierung-im-echten-workspace) zeigt die macOS-/Linux- und Windows-Varianten.
3. **Genau ein** lokales Level-1-Git-Repository für diesen Lauf bootstrappen. Darin pro Sprache ein Level-2-Git-Repository anlegen; weder ein existierendes Projekt noch ein anderes Szenario wiederverwenden. Im Level 1 die für Serien und Kampagnen benötigten Presets prüfen; in jedem Level 2 das vollständige Profil `project-statistics-fourteen-governance-presets` mit Versionen und Hashes nachweisen.
4. Aus den vier passenden Vorlagen je Level 2 die tatsächlichen Lastenhefte und die Serie erstellen. Jeder Featurelauf benutzt das geprüfte Autonomous-Run-Preset. B und D benutzen zusätzlich das Parallel-Autonomous-Run-Preset für höchstens drei Sprach-Worker gleichzeitig; die vier Features jedes Workers bleiben seriell. Fehlende oder falsche Modellbindung blockiert den Start.
5. Tests, Preset-Wirkungen und menschliche Prüfung im [Abdeckungsblatt](preset-coverage-template.md), [Bericht](run-report-template.md) und [Lernprüfblatt](learner-review-template.md) dokumentieren. Alte Zähler oder Ergebnisse nicht übernehmen.

**Vor dem Start (A–D):** Trage die für diesen Lauf relevanten [Feldlehren](#feldlehren-aus-szenario-a) in die Auftragsvorlage ein. Prüfe den tatsächlich aufgelösten Programm- und Prüfpfad, Version, Architektur und die beim Start geladene Laufzeit. Halte Caches und temporäre Dateien im Test-HOME; unterbinde für den Test unnötige Erstlaufaktionen wie Telemetrie oder Zertifikatserzeugung, soweit das Werkzeug dies unterstützt. Ein Startfehler ist kein Produkttest. Korrigiere nur die Prozessumgebung, nicht das Host-Profil. Prüfe Zielgruppe, Abnahme und Reihenfolge der vollständigen Intakes fachlich, bevor ihre genaue Fassung per Hash zur Freigabe vorgelegt wird.

### Ausführungsort

[Bash- und PowerShell-7-Beispiele](shell-examples.md) zeigen Vorbereitung, lesende Prüfungen, CLI/TUI, HTTP und PDF-Abnahme. Für Bootstrap und Wartung gilt weiterhin die native Skriptvariante der Plattform.

| Modus | Vorabprüfung | Was das Ergebnis belegt |
|---|---|---|
| Host | Native MSL-Toolchain, Spec Kit, Agent, Dateirechte und isoliertes Test-HOME auf der tatsächlichen Plattform | Nur diese Host-Plattform und ihre Revisionen |
| Sandbox | Freigegebenes Image, native Architektur, benötigte Toolchains (für B/D alle sechs), isoliertes Test-HOME, Mounts, nicht-root Benutzer und erlaubte Ports | Host/Container-Kombination und die Linux-Umgebung im Container |

Der erste geplante Host-Lauf ist macOS; Windows und WSL2/Ubuntu sind optionale spätere Wiederholungen. Im Sandbox-Modus gelten die [Sandbox-Betriebsregeln](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/betrieb/README.md); Host-Anmeldedaten bleiben außerhalb des Containers. TUI-Prüfungen brauchen eine echte interaktive Terminalsitzung. Die Web-Anwendung bindet im Host-Modus an `127.0.0.1`; im Container darf sie intern `0.0.0.0` verwenden, während nur der vorhandene Host-Loopback-App-Bereich `5100–5198` veröffentlicht ist. Fehlende Toolchains, Ports oder Hilfsmittel werden als `blockiert` berichtet; ein Image-Neubau oder ein zusätzlicher Container ist kein stiller Ersatz. Ein Vergleich von Host und Sandbox verlangt zwei getrennte Läufe mit eigenen IDs und möglichst gleichen Quellenständen.

### Codex-Anmeldung auf macOS: Safari ausdrücklich öffnen

Führe den Block in Terminal.app auf dem Host aus. Setze `test_home` auf das bereits für den Lauf angelegte, isolierte Test-HOME. Für `--device-auth` muss die Gerätecode-Anmeldung für dein ChatGPT-Konto oder deinen Workspace erlaubt sein ([Codex-Anmeldung](https://developers.openai.com/codex/auth)). Auf Mac B funktionierte der vorherige Ablauf mit Edge als Standardbrowser nicht. Dieser Block öffnet Safari ausdrücklich, ohne den Standardbrowser umzustellen.

```bash
(
  set -e
  test_home='/absoluter/pfad/zum/isolierten/test-home'
  test -d "$test_home/.codex" && test -d "$test_home/tmp" || exit 1
  cd "$test_home"

  codex_test() {
    env -i HOME="$test_home" CODEX_HOME="$test_home/.codex" \
      XDG_CONFIG_HOME="$test_home/.config" TMPDIR="$test_home/tmp" \
      USER="$USER" LOGNAME="${LOGNAME:-$USER}" \
      PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin \
      codex -c 'cli_auth_credentials_store="file"' "$@"
  }

  /usr/bin/open -a Safari 'https://auth.openai.com/codex/device'
  codex_test login --device-auth
  codex_test login status
)
```

Gib den Einmalcode nur auf der von Codex angegebenen OpenAI-Seite in Safari ein. Erwartet wird `Logged in using ChatGPT`. Falls Safari nicht startet oder die Gerätecode-Anmeldung gesperrt ist, halte an. Kopiere keine Host-Zugangsdaten. Die Anmeldedatei im Test-HOME ist vertraulich und gehört weder in Git noch in den Bericht. Der Anmeldestatus ersetzt nicht die Modellprüfung des Runners.

<a id="safari-powershell"></a>

**Alternative: PowerShell 7.3+ in Terminal.app auf demselben macOS-Host.** Setze `$testHome` wie oben. Die Umgebung gilt nur für die Codex-Kindprozesse. Dieselben Grenzen für Anmeldung und Nachweis gelten.

```powershell
& {
    if (-not $IsMacOS) { throw 'This Safari example is macOS-only.' }
    $PSNativeCommandArgumentPassing = 'Standard'
    $testHome = '/absoluter/pfad/zum/isolierten/test-home'
    foreach ($dir in '.codex', 'tmp') {
        if (-not (Test-Path -LiteralPath (Join-Path $testHome $dir) -PathType Container)) {
            throw "Missing test HOME directory: $dir"
        }
    }
    $isolatedEnv = @(
        "HOME=$testHome"
        "CODEX_HOME=$testHome/.codex"
        "XDG_CONFIG_HOME=$testHome/.config"
        "TMPDIR=$testHome/tmp"
        "USER=$env:USER"
        "LOGNAME=$($env:LOGNAME ?? $env:USER)"
        'PATH=/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin'
    )

    Push-Location -LiteralPath $testHome -ErrorAction Stop
    try {
        & /usr/bin/open -a Safari 'https://auth.openai.com/codex/device'
        if ($LASTEXITCODE -ne 0) { throw 'Safari did not open.' }
        & /usr/bin/env -i @isolatedEnv codex -c 'cli_auth_credentials_store="file"' login --device-auth
        if ($LASTEXITCODE -ne 0) { throw 'Device sign-in failed.' }
        & /usr/bin/env -i @isolatedEnv codex -c 'cli_auth_credentials_store="file"' login status
        if ($LASTEXITCODE -ne 0) { throw 'Codex is not signed in.' }
    } finally {
        Pop-Location
    }
}
```

## Alle 14 Presets funktional belegen

Für **jedes** Preset stehen Version, Hash, konkreter Aufruf, erwartete Wirkung, Artefakt, Ergebnis und Beleg in der Abdeckungsmatrix. Bloße Installation zählt nicht als Test. Die folgende Tabelle legt die Mindestwirkung fest:

| Preset | Mindestnachweis im Szenarienpaket |
|---|---|
| Security Governance | Eingabe-, Datei- und Ausführungsgrenzen im Feature geprüft |
| Secure Development Assurance Governance | Prüfergebnis mit nachvollziehbarer Evidence und offenen Punkten |
| Architecture Governance | Architekturentscheidung und Vertrauensgrenzen |
| iSAQB Architecture Governance | überprüfbares Qualitäts- oder Architekturszenario |
| A11Y Governance | CLI/TUI- oder Web-/PDF-Prüfpfad samt textorientiertem Ergebnis |
| Cross Platform Governance | Plattformannahmen und passende Build-/Testbefehle |
| Agent Parity Governance | konsistente installierte Agentenflächen |
| Model Routing Governance | erfolgreiche, exakt gebundene Runner-Vorprüfung |
| Intake Authoring Governance | nachweisbar erstellte Lastenhefte |
| Intake Review Governance | semantische Prüfung der Lastenhefte |
| Intake Sequencing Governance | validierte bindende Reihenfolge und Eligibility |
| Autonomous Run Governance | Featurezustand und abgeschlossener Einzellauf |
| Parallel Autonomous Run Governance | begrenzte Kampagne B oder D mit getrennten Workern |
| Project Statistics Governance | reproduzierbarer Statistikstand aus tatsächlichen Commits |

Über A und B zusammen braucht jedes Preset mindestens einen positiven Funktionsnachweis; C und D prüfen die anwendbaren Wirkungen erneut an Web-Grenzen. Das Parallel-Preset wird in B und D geprüft und ist in A/C begründet `nicht anwendbar`. Schutz-Gates erhalten ungefährliche Negativ-Fälle in getrennten Fixtures, niemals durch Beschädigung eines aktiven Laufs. Ein offener oder blockierter Preset-Nachweis verhindert die Aussage „alle 14 bestanden“.

### Wiederverwendbarer Nachweis fuer Community-Einreichungen

Community-Einreichungen werden ausschliesslich aus Level 0 vorbereitet und
bleiben ein gesondert zu genehmigender Schritt. Consumer-Repositories liefern
versions- und commitgebundene Evidence; sie kopieren diesen Vertrag nicht.
Jede Einreichung trennt drei Aussagen:

1. **Practical use:** benennt Level-2-Repositories, in denen das Preset
   eingesetzt wird. Ein Link auf `main` belegt nur aktuelle Nutzung. Soll eine
   konkrete Version belegt werden, wird auf den zugehoerigen PR, Merge-Commit
   oder einen unveraenderlichen Tag verwiesen.
2. **Bounded E2E field evidence:** verlinkt den passenden Abschnitt eines
   Szenarioberichts an einer festen Commit-ID oder einem unveraenderlichen Tag.
   Genannt werden Preset-Version, Plattform, Sprache/Runtime, Szenario und die
   Beziehung zur eingereichten Version: `ExactVersion`, `Historical` oder
   `LaterVersion`.
3. **Evidence boundary:** nennt unmittelbar, was nicht geprueft wurde. Der
   Status ist `Positive`, `Partial` oder `NotCovered`. Nur `Positive` darf als
   begrenzter Funktionsnachweis bezeichnet werden; auch er ist keine
   Gesamtfreigabe.

Die [Abschnittslinks aus Szenario A](evidence/scenario-a-mac-b-csharp.md#preset-submission-links)
ordnen Presets den beobachteten Nachweisen und Grenzen zu. Jeder weitere
veroeffentlichte Szenariobericht erhaelt denselben Abschnitt. Der externe Link
in einer GitHub-Einreichung verwendet nicht `main`, sondern den abschliessend
geprueften Evidence-Commit. Fehlt ein passender positiver Nachweis, bleibt die
Einreichung ehrlich bei `Partial` oder `NotCovered`; Installation, gruene CI,
Review-Anzahlen und praktische Nutzung werden nicht zu einem Funktions-Pass
zusammengezogen.

Kopierbarer englischer Block fuer eine GitHub-Einreichung:

> **Practical use:** This preset is installed and used in [version-bound
> repositories or delivery records]. This demonstrates operational adoption,
> not acceptance of every release capability.
>
> **Bounded E2E field evidence (`Positive|Partial|NotCovered`,
> `ExactVersion|Historical|LaterVersion`):** [Scenario and preset-specific
> section at an immutable commit or tag]. The run observed [bounded behavior]
> on [platform/runtime] in [mode].
>
> **Evidence boundary:** This evidence does not establish [unverified negative
> gates, platforms, assistive technology, security scope, delivery mode, or
> other relevant limits].

*Community submissions are prepared only from Level 0 under separate
authority. Consumer repositories provide version- and commit-bound evidence
without copying this contract. Each submission separates practical use,
bounded E2E field evidence, and the immediate claim boundary. Evidence links
use an exact commit or immutable tag and state version relation, platform,
runtime, scenario, and `Positive`, `Partial`, or `NotCovered` status. Only
`Positive` is a bounded functional result, never overall acceptance. A missing
positive result remains explicit; installation, green CI, review counts, and
use in a repository are not combined into a functional pass.*

### Phasenübergang und Abnahme

1. **Anwendung und Tests (A–D):** Zeige zuerst einen ausführbaren Test, der aus dem erwarteten fachlichen Grund fehlschlägt, dann denselben Test erfolgreich. Leite eindeutige Pflichtfall-IDs aus dem aktuellen Vertrag ab. Prüfe an separaten Testdaten, dass fehlende, doppelte oder übersprungene Pflichtfälle erkannt werden. Bei CLI: Argumente direkt übergeben, beide Ausgabeströme und Exitcode getrennt vergleichen. Bei HTTP: Statuscode und Antwortinhalt getrennt prüfen. Baue in einem frischen isolierten Verzeichnis. Zähle Runner-Selbsttests, Produktfälle und unabhängige Abnahme getrennt.
2. **Phasenübergang (A–D):** Eine lesende Analyse gibt ihr Ergebnis aus; der Runner speichert die Antwort außerhalb der Schreibrechte der Analyse. Warte auf das endgültige strukturierte Ergebnis des Versuchs. Prüfe Phase, Versuch, Ergebnis und Hash der zugehörigen Nutzdatei, bevor eine unabhängige Abnahmeentscheidung gebunden wird. Bei Abweichung nicht weitergehen: Fehlnachweis behalten, nur die betroffene Prüfung mit erneut bestätigten Eingaben wiederholen. Falls eine Regression alte Eingaben braucht, nutze nur eine belegte, freigegebene isolierte Archivkopie mit abgeglichenen Produktquellen. Verändere für diese Gegenprobe weder aktive Manifeste noch den echten Git-Index.
3. **Oberfläche:** Bei A/B die tatsächlich gebaute TUI mit echter Terminaleingabe prüfen; Tastatur, Fokus, Fehlerkorrektur, Exit und Wiederherstellung des Terminalmodus beobachten. Keine Abweichungen aus dem Modusvergleich ausblenden. Ein Pseudoterminal (PTY) erlaubt automatisierte Terminaleingaben, belegt aber weder die Terminal-GUI noch Assistenztechnik. Bei C/D dieselben Bedienziele im Browser und den HTTP-Vertrag separat prüfen; keine TUI-Evidenz übernehmen.
4. **Handbuch (A–D):** Probiere einen Sprachwechsel per Tastatur an einer kleinen getaggten PDF aus. Prüfe danach Struktur, Sprache, Lesereihenfolge, Tabellenbezüge und Links automatisch und öffne alle Seiten der endgültigen PDF zur Sichtprüfung. Teste die Navigation im Viewer praktisch. Beziehe beide Nachweise auf denselben PDF-Hash. Tabellenzellen müssen auf die richtigen Überschriften derselben Tabelle verweisen; Codezellen können einen anderen Sprach-Tag haben. Beschrifte Links eindeutig und mache sie auch ohne Farbe erkennbar. Halte persönliche Prüfung, Screenreader und Braille getrennt fest.

## Aus dem Lauf lernen

- **Nach jedem technisch abgeschlossenen Feature:** Eine Zeile pro relevanter Beobachtung in den bestehenden Rückblick schreiben. Benenne Problem, nachvollziehbaren Beleg, übertragbare Regel, Geltungsbereich, Entscheidung und nächste Gegenprobe. „Keine neue Beobachtung“ genügt, wenn nichts hinzugekommen ist. Mache bei einer Wiederaufnahme den kleinsten betroffenen Prüfbereich kenntlich. Ein Rückblick ersetzt keinen Pflichtnachweis.
- **Beim Szenarioabschluss:** Der Maintainer führt alle Sprachpfade im [Laufbericht](run-report-template.md#deutsch-verbesserungen-für-den-nächsten-lauf) zusammen, entfernt Doppelungen und entscheidet, was für welchen Folgelauf übernommen wird. Ein einmalig reproduzierbarer Korrektheits-, Sicherheits-, Berechtigungs- oder Nachweisfehler kann für `Promote` genügen. Effizienzvorschläge bleiben `ObserveAgain`, bis zwei unabhängige Feldbeobachtungen vorliegen; mehrere Features desselben Laufs zählen nicht als unabhängig. Für offene Punkte Verantwortliche und Auslöser für die nächste Prüfung nennen. Blockierte Pflichtnachweise bleiben blockiert, auch wenn andere Sprachpfade fertig sind.
- **Vor dem nächsten Start:** Die [Auftragsvorlage](maintainer-order-template.md) bindet die übernommenen Regeln an Szenario und Sprache. Rückmeldungen aus dem [Lernprüfblatt](learner-review-template.md) werden als eigene Beobachtungen ergänzt, nicht als automatische Ergebnisse. Ausstehende persönliche Prüfungen ausdrücklich so markieren. Das Verfahren startet keinen weiteren Lauf und erlaubt keine Änderung zentraler Regeln, Veröffentlichung oder Bereinigung ohne den jeweiligen Auftrag.

### Feldlehren aus Szenario A

Die [Belegliste](#field-evidence-refs) bindet die vier nur lokal abgeschlossenen Features an ihre Rückblicke. Die Kurzbelege unten bleiben ohne Test-HOME verständlich. `Promote` gilt hier **nur im E2E-Runbook**; neue Plattformen und Sprachen brauchen eigene Nachweise.

| Quelle | Kurzbeleg, Reichweite und Entscheidung | Nächste Gegenprobe |
|---|---|---|
| A-F1 | Falsches SDK und falsche Startlaufzeit lieferten keine Produktbeobachtung; eine früh gebundene Entscheidung passte nicht zu den Endbytes. `Promote`, Start und Phasenübergang A–D; kein fester .NET-Pfad. | Falsche Laufzeit bzw. geänderte Nutzdatei in separater Testkopie: kein Produkt-Pass bzw. keine alte Abnahme übernehmen. |
| A-F2 | Ein Prüfpfad war auf dem Mac ungültig. Die unabhängige Abnahme verglich eine feste Fallliste mit den tatsächlichen Ergebnissen. `Promote`, Prüfpfad, Fallinventar und gezielte Wiederaufnahme A–D; weder `/bin/test` noch die Fallzahl vorgeben. | Einen Pflichtfall weglassen, doppeln oder überspringen; der Prüflauf muss dies jeweils erkennen. |
| A-F3 | Die ältere Regression brauchte frühere Manifestbytes. Die isolierte Archivprobe und der exakte native Modusvergleich lieferten getrennte Nachweise. `Promote`, Archivierung A–D, Terminalprüfung A/B; Darwin-Eigenheiten nicht übertragen. | Geschützte Eingaben vor/nach der Archivprobe vergleichen; bei A/B den Terminalmodus auch nach einem Fehler-Exit vergleichen. |
| A-F4 | Der lesende Prüfer hielt die eigene Schreibsperre zunächst für einen Blocker. Der Runner speicherte die Antwort beim erneuten Versuch ohne Rechteänderung. Beim PDF wurden Tastatursprünge und Struktur am selben Endstand geprüft. `Promote`, Phasenübergang und PDF A–D; konkrete Werkzeuge und Versionen bleiben Beispiele. | Einen Nur-Lese-Versuch ohne Worker-Schreibzugriff und einen kleinen PDF-Sprachwechsel prüfen; danach Enddatei separat abnehmen. |
| A-F1/F2 | Prüfungen zu bündeln könnte Zeit sparen. `ObserveAgain`, nur ein unabhängiger Lauf belegt; keine Messung aktiver Arbeitszeit. | E2E-Maintainer vergleicht beim nächsten unabhängigen Lauf belegte Warte- und Wiederholzeiten, ohne Pflichtprüfungen zu streichen. |

## Lernprüfung, Bericht und spätere Bereinigung

Auszubildende und Entwickler ohne Spezialkenntnisse prüfen **vor** einer Bereinigung, ob sie Lastenheft, Feature, Quellcode, Test und Handbuch miteinander verbinden und Beispiele selbst ausführen können. Sie dokumentieren eigene Beobachtungen statt CI-Ergebnisse nur zu übernehmen. Private Daten, echte Zugangsdaten und ungeprüfte Testeingaben sind ausgeschlossen.

Der zweisprachige Bericht wird als **eine selbstständig lesbare Markdown-Datei** außerhalb des Test-HOME gesichert. Er enthält Run-ID, Auftrag, Plattform, Level-0- und Preset-Stände, Level-1/2-Struktur, Feature-Commits oder Basis plus geprüften lokalen Stand, Befehle, aktuelle und historische Testzahlen getrennt, wichtige Belegauszüge, Artefakt-Hashes, menschliche Prüfung, Fehler und Aussagegrenzen. Git-Statistik ist keine gemessene Arbeitszeit. Der Bericht darf sich nicht ausschließlich auf später gelöschte Pfade stützen. Eine bereinigte öffentliche Fassung erfordert eine gesonderte menschliche Sichtung und Veröffentlichung.

Nur ein **neuer, gezielter Maintainer-Auftrag** darf nach abgeschlossener Lernprüfung das eindeutig identifizierte Test-Level-1-Repository, seine Level-2-Repositories, das Test-HOME und Rohbelege entfernen. Vorher werden Bericht und Hash der echten Home-Dateien geprüft; echte Repositories, Registries, Sandbox-Volumes und Nutzerdaten bleiben erhalten. Danach bleibt allein der Testbericht. Er nennt ausdrücklich, dass der damalige Quellstand nach Löschung nicht erneut geprüft werden kann; ein neuer Lauf ist aus den versionierten Vorlagen möglich.

---

# End-to-end test of all Spec Kit presets

## Purpose and authority

This runbook extends the [security baseline integration test](../security-baseline-integration-test.md). It describes four repeatable **local** tests of the full 14-preset profile. Reading or preparing these documents starts no test. A maintainer separately requests each scenario run, later report publication and optional cleanup.

An **intake** is a reviewable work request. A **series** is four intakes with binding order. A **preset** is a versioned Spec Kit extension. A **hash** is a digital fingerprint of one exact file version. The [learner and accessibility baseline](../../learning-units/LERNENDEN-UND-A11Y-BASIS.md) applies to human review. Files in [intakes/](intakes/) are templates only: no active intake, series membership or start authority.

| Scenario | Product | Languages | Level 2 repositories |
|---|---|---|---|
| A | CLI calculator with TUI | One explicitly chosen MSL | 1 |
| B | CLI calculator with TUI | C#, Go, Java, Python, Rust, Swift | 6 |
| C | Web calculator | One explicitly chosen MSL | 1 |
| D | Web calculator | C#, Go, Java, Python, Rust, Swift | 6 |

MSL means memory-safe language. B and D coordinate at most three language paths at once. Each language path completes four features in order.

## Shared product contract

- Addition, subtraction, multiplication and division share the same domain logic in CLI/TUI or HTTP/web UI. Test at least `6 + 2 = 8`, `6 - 2 = 4`, `6 * 2 = 12`, `6 / 2 = 3` and `1 / 2 = 0.5`. Operation tokens are `add`, `subtract`, `multiply` and `divide`.
- Invalid input and division by zero return a clear error, never a plausible numeric result. Do not evaluate supplied expressions dynamically.
- The comparable CLI invocation is `calc <left> <operation> <right>`. Success prints only the number and exits 0; errors print text to stderr and exit non-zero. The TUI works from the keyboard; the CLI remains a text alternative.
- The comparable web contract uses `POST /calculate` with JSON fields `left`, `operation` and `right`. Success returns HTTP 200 and `{"result": <number>}`; invalid input and division by zero return HTTP 400 and `{"error": "<text>"}`. `GET /` serves the keyboard-usable page. Validate input and render output safely.
- Produce the handbook from versioned text-first source. Complete German comes before equivalent English at about CEFR B2. Review applicable WCAG 2.2 AA criteria for CLI, TUI, web and PDF separately. PDF review includes structure, language, headings, reading order, links and text alternatives; an automated check alone does not establish conformance.

## Templates and binding order

| Position | CLI series A/B | Web series C/D |
|---|---|---|
| 1 | [CLI calculator](intakes/cli-01-rechner.md) | [HTTP calculator](intakes/web-01-rechner.md) |
| 2 | [Unit and integration tests](intakes/cli-02-tests.md) | [Unit and HTTP integration tests](intakes/web-02-tests.md) |
| 3 | [TUI](intakes/cli-03-tui.md) | [Web UI](intakes/web-03-oberflaeche.md) |
| 4 | [Documentation and PDF handbook](intakes/cli-04-handbuch.md) | [Documentation and PDF handbook](intakes/web-04-handbuch.md) |

Edges `1 → 2 → 3 → 4` are binding. A successor starts only after its predecessor has completed with real tests and evidence. On a later request, turn the four matching templates into actual language-specific intakes in each Level 2 repository, review them semantically, and use the existing Intake Authoring, Review and Sequencing workflows to create the active series. Nothing in this package does that automatically.

## Request and isolated setup

The [blank request template](maintainer-order-template.md) records scenario, `Host` or `Sandbox`, platform, language for A/C, test HOME, existing model/runner profile, time and stop limits, and responsible maintainer. A missing required value blocks the run. Test repositories use fixed `LocalImplementation`: no pushes, PRs or merges.

1. Read-only check the current Level 0 commit, [14-preset matrix](../../../scripts/config/spec-kit-project-statistics-governance-presets.json), tool versions and local guidance. Inspect script help, syntax and preview before writing. A version listed today is not a substitute for a live check.
2. Select a unique run ID and new, restricted test HOME. Hash the real home README and registry before the run. `--no-remote` alone does **not** isolate the local registry; keep HOME, Git configuration and registry inside the test HOME. The [existing bootstrap exercise](../security-baseline-integration-test.md#lernübung-lokaler-bootstrap-ohne-registrierung-im-echten-workspace) shows macOS/Linux and Windows variants.
3. Bootstrap **exactly one** local Level 1 Git repository for this run. Create one Level 2 Git repository per language inside it; reuse neither an existing project nor another scenario. Check the presets needed for series and campaigns at Level 1; verify the full `project-statistics-fourteen-governance-presets` profile and hashes in every Level 2.
4. Create the four actual intakes and series in each Level 2. Each feature uses the checked Autonomous Run preset. B and D also use Parallel Autonomous Run for at most three language workers at a time; each worker's four features remain serial. Missing or incorrect model binding blocks start.
5. Record tests, preset behavior and human review in the [coverage sheet](preset-coverage-template.md), [report](run-report-template.md) and [learner review sheet](learner-review-template.md). Never reuse old counts.

**Before starting (A–D):** Record the relevant [field lessons](#field-lessons-from-scenario-a) in the request template. Verify the resolved tool and check executable, version, architecture and the runtime actually loaded. Keep caches and temporary files in the test HOME. Where supported, disable unrelated first-run actions such as telemetry or certificate creation. A launch failure is not a product test. Correct only the process environment, not the host profile. Review the audience, acceptance criteria and order of the complete intakes before requesting approval of their exact hashed version.

### Execution location

[Bash and PowerShell 7 examples](shell-examples.md#english) cover setup, read-only checks, CLI/TUI, HTTP and PDF verification. Continue to use the platform's native script variant for bootstrap and maintenance.

| Mode | Preflight | What the result supports |
|---|---|---|
| Host | Native MSL toolchain, Spec Kit, agent, file permissions and isolated test HOME on the actual platform | Only that host platform and its revisions |
| Sandbox | Approved image, native architecture, needed toolchains (all six for B/D), isolated test HOME, mounts, non-root user and allowed ports | The host/container combination and Linux environment in the container |

The first planned host run is macOS; Windows and WSL2/Ubuntu are optional later repeats. Follow the [sandbox operations guide](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/betrieb/README.md) in Sandbox mode and keep host credentials outside the container. TUI review needs a real interactive terminal. On the host, bind the web app to `127.0.0.1`. Inside the container it may bind to `0.0.0.0` while only the existing host loopback app range `5100–5198` is published. Report missing toolchains, ports or assistive tools as `blocked`; an image rebuild or extra container is not an implicit substitute. Host/sandbox comparison requires two separate runs with separate IDs and as similar source revisions as possible.

### Signing in to Codex on macOS: open Safari explicitly

Run either the [Bash block](#codex-anmeldung-auf-macos-safari-ausdrücklich-öffnen) or the [PowerShell 7.3+ alternative](#safari-powershell) in Terminal.app on the macOS host. Set `test_home` or `$testHome` to this run's existing isolated test home. Device-code sign-in must be allowed for your ChatGPT account or workspace ([Codex authentication](https://developers.openai.com/codex/auth)). The previous flow did not work on Mac B with Edge as the default browser. Both blocks explicitly open Safari without changing the default browser.

Enter the one-time code only on the OpenAI page that Codex identifies, in Safari. Expect `Logged in using ChatGPT`. Stop if Safari does not open or device-code sign-in is blocked. Do not copy host credentials. The sign-in file in the test home is confidential; keep it out of Git and the report. Sign-in status does not replace the runner's model-access check.

## Functional evidence for all 14 presets

Record version, hash, invocation, expected behavior, artifact, result and evidence for **each** preset. Installation alone does not count. Each preset needs the following minimum evidence:

| Preset | Minimum evidence in the scenario package |
|---|---|
| Security Governance | Feature input, file and execution boundaries reviewed |
| Secure Development Assurance Governance | Review decision with traceable evidence and open items |
| Architecture Governance | Architecture decision and trust boundaries |
| iSAQB Architecture Governance | Testable quality or architecture scenario |
| A11Y Governance | CLI/TUI or web/PDF review path with text result |
| Cross Platform Governance | Platform assumptions and matching build/test commands |
| Agent Parity Governance | Consistent installed agent surfaces |
| Model Routing Governance | Successful, exactly bound runner preflight |
| Intake Authoring Governance | Four traceably created intakes |
| Intake Review Governance | Semantic intake review |
| Intake Sequencing Governance | Validated binding order and eligibility |
| Autonomous Run Governance | Feature state and completed single run |
| Parallel Autonomous Run Governance | B or D campaign with bounded, separate workers |
| Project Statistics Governance | Reproducible statistics from actual commits |

Across A and B, every preset needs at least one positive functional result; C and D repeat applicable checks at web trust boundaries. Parallel Autonomous Run is exercised in B and D and is justified `not applicable` in A/C. Test protective negative gates with harmless separate fixtures, never by damaging an active run. Open or blocked preset evidence prevents a claim that all 14 passed.

### Phase handoff and acceptance

1. **Application and tests (A–D):** Start with a runnable test that fails for the expected product reason, then show the same test passing. Derive unique required case IDs from the current contract. Use separate test data to prove that missing, duplicate or skipped required cases are detected. Pass CLI arguments directly and compare both streams and exit status separately. For HTTP, check status and response body separately. Build in a fresh isolated directory. Count runner self-tests, product cases and independent acceptance separately.
2. **Phase handoff (A–D):** A read-only analysis returns its result; the runner saves the response outside the analysis's write permissions. Wait for the final structured attempt result. Verify phase, attempt, result and the associated artifact hash before binding the independent acceptance decision. Stop on a mismatch: retain failed evidence and repeat only the affected check after confirming its inputs. If regression needs earlier inputs, use a verified, authorized isolated archive copy and compare product sources. Do not change live manifests or the real Git index for that check.
3. **User interface:** In A/B, check the actual TUI build with real terminal input. Observe keyboard use, focus, error recovery, exit and restored terminal mode. Do not mask mode differences. A pseudoterminal (PTY) allows automated terminal input but is not evidence of terminal GUI or assistive technology use. In C/D, verify equivalent tasks in the browser and verify the HTTP contract separately; do not borrow TUI evidence.
4. **Handbook (A–D):** Test one keyboard language switch on a small tagged PDF first. On the final PDF, check structure, language, reading order, table associations and links automatically, open all pages for visual review and operate links in a viewer. Bind both records to the same PDF hash. Data cells must reference the correct headers in the same table; code cells may have a different language tag. Use clear link labels and cues other than color. Record personal review, screen reader and Braille separately.

## Learn from each run

- **After each technically completed feature:** Add one row per relevant observation to the existing retrospective. Record problem, traceable evidence, reusable rule, scope, decision and next check. If nothing new was observed, one sentence is enough. On resume, identify the smallest affected check scope. A retrospective is not a substitute for required evidence.
- **At scenario closeout:** The maintainer combines every language track in the [run report](run-report-template.md#english-improvements-for-the-next-run), removes duplicates and decides what to carry into which next run. One reproducible correctness, security, permission or evidence defect can justify `Promote`. Efficiency suggestions remain `ObserveAgain` until there are two independent field observations; different features of one run are not independent. Name the owner and recheck trigger for open items. Blocked required evidence stays blocked even when other language tracks are complete.
- **Before the next start:** The [request template](maintainer-order-template.md) binds adopted rules to the scenario and language. Add observations from the [learner review sheet](learner-review-template.md) as human feedback, not automated results. Explicitly mark a personal review that has not yet happened as pending. This process starts no further run and grants no authority to change central rules, publish or clean up.

### Field lessons from Scenario A

The [evidence references](#field-evidence-refs) bind the four locally completed features to their retrospectives. These summaries stand on their own without the test HOME. `Promote` applies **only to this E2E runbook**; new platforms and languages require their own evidence.

| Source | Evidence summary, scope and decision | Next check |
|---|---|---|
| A-F1 | Wrong SDK and startup runtime yielded no product observation; an early decision did not match the final bytes. `Promote`: startup and phase handoff A–D; no fixed .NET path. | In a separate test copy, use a wrong runtime or changed artifact: do not declare a product pass or reuse the old approval. |
| A-F2 | A check executable path was invalid on the Mac. Independent acceptance compared a fixed inventory with actual outcomes. `Promote`: executable path, inventory and scoped resume A–D; do not prescribe `/bin/test` or the case count. | Omit, duplicate or skip a required case; the check must detect each case. |
| A-F3 | Older regression evidence needed earlier manifest bytes. The isolated archive run and exact native mode comparison produced separate proof. `Promote`: archive use A–D and terminal checks A/B; do not generalize Darwin behavior. | Compare protected inputs before/after the archive check. For A/B compare the restored terminal mode after an error exit as well. |
| A-F4 | The read-only reviewer first mistook its write restriction for a blocker. On retry, the runner saved the result without granting more rights. PDF structure and real keyboard navigation were checked on the same final file. `Promote`: phase handoff and PDF A–D; specific tools and versions are examples. | Test read-only result handling and an early keyboard language switch, then validate the final file separately. |
| A-F1/F2 | Batching checks might save time. `ObserveAgain`: only one independent run and no measurement of active work time. | The E2E maintainer compares observed wait and rerun times in the next independent run without dropping required checks. |

<a id="field-evidence-refs"></a>

**Belegreferenzen / Evidence references** — A, C# auf/on Mac B, 21.11.2026, `LocalImplementation`. Pfade sind relativ zum damaligen Test-Repo; SHA-256 bindet die Original-Rückblicke, die Kurzbelege oben bleiben eigenständig. / Paths are relative to the original test repository; SHA-256 identifies the original retrospectives and the summaries above stand on their own.

DE: Dokumentationsregeln aus einem Feldlauf: A-F1 bis A-F4 sind direkt belegte Funktions- oder Nachweisbefunde; die Übertragung ist noch kein Plattformtest. Alle vier Features sind technisch abgeschlossen. Die persönliche Gesamtprüfung steht aus; „alle 14 Presets bestanden“ folgt aus diesem Lauf nicht. / EN: Documentation rules from one field run: A-F1 through A-F4 are directly evidenced behavior or verification findings, not proof on other platforms. All four features are technically complete. The overall personal review is pending, and this run does not establish that all 14 presets passed.

| ID | Originalpfad / Original path | SHA-256 |
|---|---|---|
| A-F1 | `specs/001-cli-rechner/retrospective.md` | `d121a052269cf624a340838bbb5ca5407c413f475d0d5ef072b62a84f4327533` |
| A-F2 | `specs/002-cli-tests/retrospective.md` | `b8df2235609d71bfa0795d509d4d75e2ccd60e2dca09160472f2fb851f78b05c` |
| A-F3 | `specs/003-cli-tui/retrospective.md` | `ddf8f6cb746d8aee91d28099f0e8cd00a70560f5aa3fbd1bdbccea8c11982a6b` |
| A-F4 | `specs/004-cli-handbuch/retrospective.md` | `576ac4fea4ec810a687b3b5ccd25f9117a9419d724e6ec0d4b88c7c78fc9b88e` |

## Learner review, report and later cleanup

Before cleanup, apprentices and developers without specialist knowledge trace intake, feature, source, tests and handbook, run the examples themselves and record their own observations. Do not treat CI alone as their review. Use no private data, real credentials or unreviewed test inputs.

Keep the bilingual report as **one self-contained Markdown file** outside the test HOME. Include run ID, request, platform, Level 0 and preset versions, Level 1/2 layout, feature commits or base plus verified local state, commands, separate current and historical test counts, key evidence excerpts, artifact hashes, human review, failures and evidence limits. Git statistics are not measured work time. Do not rely only on paths that cleanup will delete. A sanitized public version needs separate human review and publication.

Only a **new targeted maintainer request** may remove the identified test Level 1 repository, its Level 2 repositories, test HOME and raw evidence after learner review. First secure the report and verify real home-file hashes; preserve real repositories, registries, sandbox volumes and user data. Only the report remains. It states that deleted source cannot be rechecked; a new run can be built from the versioned templates.
