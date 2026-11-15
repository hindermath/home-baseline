# Praxistest aller Spec-Kit-Presets / End-to-end test of all Spec Kit presets

## Zweck und Freigabe

Dieses Runbook ergänzt den [Integrationstest der Sicherheitsbasis](../security-baseline-integration-test.md). Es beschreibt vier wiederholbare **lokale** Tests des vollständigen 14-Preset-Profils. Das Lesen und Vorbereiten dieser Dokumentation startet keinen Test. Ein Maintainer beauftragt jeden Szenariolauf, eine spätere Veröffentlichung des Berichts und eine mögliche Bereinigung jeweils gesondert.

**Lastenheft** bedeutet hier ein prüfbarer Arbeitsauftrag. **Serie** bedeutet vier Lastenhefte mit bindender Reihenfolge. **Preset** bedeutet eine versionierte Spec-Kit-Erweiterung. Für die Lernprüfung gilt die [Lernenden- und A11Y-Basis](../../learning-units/LERNENDEN-UND-A11Y-BASIS.md). Die Dateien in [intakes/](intakes/) sind nur Vorlagen: Sie sind keine aktiven Intakes, keine Serienmitglieder und keine Startberechtigung.

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

### Ausführungsort

| Modus | Vorabprüfung | Was das Ergebnis belegt |
|---|---|---|
| Host | Native MSL-Toolchain, Spec Kit, Agent, Dateirechte und isoliertes Test-HOME auf der tatsächlichen Plattform | Nur diese Host-Plattform und ihre Revisionen |
| Sandbox | Freigegebenes Image, native Architektur, benötigte Toolchains (für B/D alle sechs), isoliertes Test-HOME, Mounts, nicht-root Benutzer und erlaubte Ports | Host/Container-Kombination und die Linux-Umgebung im Container |

Der erste geplante Host-Lauf ist macOS; Windows und WSL2/Ubuntu sind optionale spätere Wiederholungen. Im Sandbox-Modus gelten die [Sandbox-Betriebsregeln](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/betrieb/README.md); Host-Anmeldedaten bleiben außerhalb des Containers. TUI-Prüfungen brauchen eine echte interaktive Terminalsitzung. Die Web-Anwendung bindet im Host-Modus an `127.0.0.1`; im Container darf sie intern `0.0.0.0` verwenden, während nur der vorhandene Host-Loopback-App-Bereich `5100–5198` veröffentlicht ist. Fehlende Toolchains, Ports oder Hilfsmittel werden als `blockiert` berichtet; ein Image-Neubau oder ein zusätzlicher Container ist kein stiller Ersatz. Ein Vergleich von Host und Sandbox verlangt zwei getrennte Läufe mit eigenen IDs und möglichst gleichen Quellenständen.

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

## Lernprüfung, Bericht und spätere Bereinigung

Auszubildende und Entwickler ohne Spezialkenntnisse prüfen **vor** einer Bereinigung, ob sie Lastenheft, Feature, Quellcode, Test und Handbuch miteinander verbinden und Beispiele selbst ausführen können. Sie dokumentieren eigene Beobachtungen statt CI-Ergebnisse nur zu übernehmen. Private Daten, echte Zugangsdaten und ungeprüfte Testeingaben sind ausgeschlossen.

Der zweisprachige Bericht wird als **eine selbstständig lesbare Markdown-Datei** außerhalb des Test-HOME gesichert. Er enthält Run-ID, Auftrag, Plattform, Level-0- und Preset-Stände, Level-1/2-Struktur, Feature-Commits, Befehle, Testzahlen, wichtige Belegauszüge, Artefakt-Hashes, menschliche Prüfung, Fehler und Aussagegrenzen. Er darf sich nicht ausschließlich auf später gelöschte Pfade stützen. Eine bereinigte öffentliche Fassung erfordert eine gesonderte menschliche Sichtung und Veröffentlichung.

Nur ein **neuer, gezielter Maintainer-Auftrag** darf nach abgeschlossener Lernprüfung das eindeutig identifizierte Test-Level-1-Repository, seine Level-2-Repositories, das Test-HOME und Rohbelege entfernen. Vorher werden Bericht und Hash der echten Home-Dateien geprüft; echte Repositories, Registries, Sandbox-Volumes und Nutzerdaten bleiben erhalten. Danach bleibt allein der Testbericht. Er nennt ausdrücklich, dass der damalige Quellstand nach Löschung nicht erneut geprüft werden kann; ein neuer Lauf ist aus den versionierten Vorlagen möglich.

---

# End-to-end test of all Spec Kit presets

## Purpose and authority

This runbook extends the [security baseline integration test](../security-baseline-integration-test.md). It describes four repeatable **local** tests of the full 14-preset profile. Reading or preparing these documents starts no test. A maintainer separately requests each scenario run, later report publication and optional cleanup.

An **intake** is a reviewable work request. A **series** is four intakes with binding order. A **preset** is a versioned Spec Kit extension. The [learner and accessibility baseline](../../learning-units/LERNENDEN-UND-A11Y-BASIS.md) applies to human review. Files in [intakes/](intakes/) are templates only: no active intake, series membership or start authority.

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

### Execution location

| Mode | Preflight | What the result supports |
|---|---|---|
| Host | Native MSL toolchain, Spec Kit, agent, file permissions and isolated test HOME on the actual platform | Only that host platform and its revisions |
| Sandbox | Approved image, native architecture, needed toolchains (all six for B/D), isolated test HOME, mounts, non-root user and allowed ports | The host/container combination and Linux environment in the container |

The first planned host run is macOS; Windows and WSL2/Ubuntu are optional later repeats. Follow the [sandbox operations guide](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/betrieb/README.md) in Sandbox mode and keep host credentials outside the container. TUI review needs a real interactive terminal. On the host, bind the web app to `127.0.0.1`. Inside the container it may bind to `0.0.0.0` while only the existing host loopback app range `5100–5198` is published. Report missing toolchains, ports or assistive tools as `blocked`; an image rebuild or extra container is not an implicit substitute. Host/sandbox comparison requires two separate runs with separate IDs and as similar source revisions as possible.

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

## Learner review, report and later cleanup

Before cleanup, apprentices and developers without specialist knowledge trace intake, feature, source, tests and handbook, run the examples themselves and record their own observations. Do not treat CI alone as their review. Use no private data, real credentials or unreviewed test inputs.

Keep the bilingual report as **one self-contained Markdown file** outside the test HOME. Include run ID, request, platform, Level 0 and preset versions, Level 1/2 layout, feature commits, commands, test counts, key evidence excerpts, artifact hashes, human review, failures and evidence limits. Do not rely only on paths that cleanup will delete. A sanitized public version needs separate human review and publication.

Only a **new targeted maintainer request** may remove the identified test Level 1 repository, its Level 2 repositories, test HOME and raw evidence after learner review. First secure the report and verify real home-file hashes; preserve real repositories, registries, sandbox volumes and user data. Only the report remains. It states that deleted source cannot be rechecked; a new run can be built from the versioned templates.
