# Autonomous Run Evidence: Feature 016

## Authority and accepted inputs

- Run ID: `142ec996-e896-4dd7-8983-6fede46a339f`
- Delivery mode: `MergeAndSync`
- Branch: `016-linux-maintenance-hardening`
- Starting head: `2d778931e0e24cd14be345a7b7b2684b39cca4a0`
- Binding intake: Linux-/Ubuntu-Härtung v1.2, LUM-001 bis LUM-011 und
  AC-001 bis AC-015.
- Current single review:
  `48ca0b20-22e0-47f0-bee0-a19672c48b42`, `Ready`.
- Current series review:
  `0005ff81-a7a4-4803-ad33-12a25393ae8b`, `Ready`, 28 Ziele.
- Historical baseline: abgeschlossenes Feature 009; Feature 015 ist der
  seriell vorhergehende, nicht technische Vorgänger.
- Admin boundary: Der angeforderte Admin-Bypass gilt ausschließlich für die
  Repository-Reviewregel beim autorisierten Merge. `sudo`, Paketmanager-,
  Capability-, Integritäts-, Test- und Sicherheitsgrenzen werden nicht
  technisch umgangen.

## Preflight

- Linux und Bash wurden gemäß Repository-Anweisung ausgewählt; PowerShell 7
  bleibt für strukturierte Paritäts- und Analysewege verfügbar.
- `origin/main`, lokales `main` und der dauerhafte Level-0-Klon wurden vor
  Branch-Erstellung synchronisiert.
- Der Quellklon `/home/hinde/home-baseline-source` bleibt erhalten; das
  frühere temporäre Migrationsziel ist nicht Teil dieses Features.
- Das exakte Zehn-Preset-Profil ist installiert und frisch geprüft.
- Kein anderer nicht terminaler Autonomous Run oder Wartungsprozess blieb
  aktiv.
- Die kanonische Serie erklärte ausschließlich die Linux-/Ubuntu-Härtung als
  `Eligible`.
- Intake-Authoring-Receipt, Single Review, Series-Manifest und Series Review
  bestanden ihre Hash- und Freshness-Gates.

## Clarify and plan

- Die vollständige Spec-Qualitätscheckliste ist grün.
- Der strukturierte Clarify-Scan fand keine materielle Frage, die Scope,
  Akzeptanz, Sicherheit, Architektur oder Validierung ändern könnte.
- Der Plan bindet Registry-stdin, Required-Abschluss, Swiftly-Supply-Chain,
  Admin-Prompts, begrenzte CLI-Proben und einmalige atomare Finalisierung.
- Die Gate-Anforderungen wurden vor dem ersten Produktionsedit unter
  `autonomous-run-gate-requirements.json` festgelegt.

## Analyze

- 28 von 28 funktionalen und verfassungsbezogenen Anforderungen sowie 15 von
  15 Erfolgskriterien besitzen Task-Coverage; 59 von 59 Tasks sind zugeordnet.
- Keine Critical-/Verfassungsbefunde blieben offen.
- Ein High- und drei Medium-Präzisionsbefunde wurden vor Implementierung
  behoben: Swiftly `1.1.2`/Swift `6.3.3` und Hashes sind festgelegt,
  Ubuntu 20.04 wurde aus der unterstützten aktuellen Toolchainmatrix entfernt,
  der neue Helfer erhält Katalog-/Propagationspflege, und Vorschauwege
  unterscheiden Paket-/Profilmutation von erlaubten Fetch-/Log-/Reportwrites.

## Test-first baseline

- Die unveränderte Baseline blieb grün: 13
  `test_agentic_workspace_maintenance`-, 10 `test_maintenance_contracts`- und
  4 `test_home_sync_files`-Tests.
- `python3 scripts/tests/test_linux_maintenance_hardening.py` wurde vor dem
  ersten Produktionsedit ausgeführt. Alle neun Tests scheiterten
  erwartungsgemäß ausschließlich an den noch fehlenden neuen Verträgen:
  `--cli-registry`/Result-JSON, Linux-Helfer, atomarer Finalize-Unterbefehl und
  Orchestrator-Integration.
- Die rote Baseline deckt stdin-Konsum und Idempotenz, Required-/Optional-
  Exitcodes, begrenzte Probe-/Capability-Klassen, Swift-Plattform und
  Integrität, stale Success, `INT`/`TERM` sowie öffentliche Integration ab.

## Implementation result

- Geordnete Registry-Snapshots und eigene Dateideskriptoren entkoppeln alle
  mutierenden Homebrew-, apt-, VS-Code-, CLI- und npm-Schleifen von stdin.
  Jede ausgewählte Reihenposition erhält genau ein finales JSON-Resultat.
- Required-/Optional-Aggregation liefert `0` nur bei erreichtem
  Required-Sollzustand. `Planned`, `Failed` und `StillMissing` bleiben für
  Required fatal; optionaler Drift bleibt sichtbar und nicht allein fatal.
- CLI-Proben laufen in einer eigenen Prozessgruppe mit 5-Sekunden-Grenze,
  begrenzter bereinigter Evidence und den Klassen `Missing`, `Unusable`,
  `TimedOut` und `CapabilityBlocked`.
- Der offizielle Swift-Vertrag ist auf Swiftly `1.1.2`, Swift `6.3.3`,
  Ubuntu 22.04/24.04 und `x86_64`/`aarch64` geschlossen. Beide Archive sind
  HTTPS- und SHA-256-gebunden; Extraktion akzeptiert genau ein reguläres
  `swiftly`-Binary. `--no-modify-profile`, aktuelle Shell-Aktivierung,
  autorisierte Post-Installation und Same-run-Probe sind umgesetzt.
- Der Orchestrator importiert Toolchain-Einzelresultate, erhält
  `DEFERRED_ADMIN_REQUIRED` und finalisiert Erfolg, späten Fehler, `INT` und
  `TERM` genau einmal durch atomaren Ersatz. `INT=130`, `TERM=143`.

## Test and validation evidence

- `python3 -m unittest discover -s scripts/tests -p 'test_*.py' -v`:
  52 Tests grün; 42 auf Linux ausgeführt, 10 ausschließlich
  Windows-spezifische Prozessfixtures erwartungsgemäß übersprungen.
- Die fokussierte Linux-Suite umfasst nach Erweiterung 13 Tests. Sie belegt
  drei stdin-konsumierende Formeln in Reihenfolge, idempotenten Zweitlauf,
  Required-/Optional-Exitcodes und Parent-Propagation, Swift-Erfolg,
  falschen Hash, fehlende Admin-Autorität, Plattformablehnung,
  Timeout/Capability/Redaction sowie späten Fehler und `TERM` in einem echten
  Bash-Prozessharness mit genau einer Finalisierung.
- `bash -n` ist für beide geänderten öffentlichen Bash-Skripte grün.
  Sämtliche geänderten JSON-Dateien bestehen `python3 -m json.tool`.
- PowerShell-Parität: Die gemeinsame Registry bleibt additiv kompatibel;
  `swiftly` ist ausschließlich der Linux-Zweig, WinGet-Swift bleibt
  unverändert. Parserprüfung und PSScriptAnalyzer `1.25.0` sind für
  `maintain-agentic-workspace.ps1` und `maintain-agentic-winget-apps.ps1`
  grün. Der unveränderte repositoryweite Analyzerlauf lieferte innerhalb von
  mehr als fünf Minuten kein Ergebnis und wurde beendet; daraus wird kein
  Full-repository-Pass abgeleitet.
- Documentation Impact: fünf exakte Entscheidungen validiert; der neue
  Report-Beispielsatz ist valides JSON. Die Skriptreferenz wurde auf 122
  kanonische Skripte regeneriert und anschließend als `CURRENT` verifiziert.
- Das Statistikprofil enthält den neuen Slot 43 und ist nach dem
  reproduzierbaren Schreiblauf `CURRENT`; die deterministische Suite besteht
  146 Assertions. Ein erster Paritätslauf erbte unter WSL ein
  plattformfremdes Windows-`pwsh.exe` und wurde von dessen unveränderter
  Execution Policy abgewiesen. Der vorgeschriebene Linux-Lauf mit
  Linux-only-PATH und nativem `/snap/bin/pwsh` bestand vollständig.
- `check-homogeneity.sh --dry-run --no-patch --json` meldet mit derselben
  Linux-Toolauswahl Score 100, null Fehler und null Warnungen.
  `scan-agent-secrets.sh --fail-on-high .` meldet null High-/Medium-Befunde;
  `gitleaks` ist nicht installiert, deshalb blieb der dokumentierte
  repositoryweite Regex-Fallback aktiv und meldete ausschließlich fünf
  erwartete Low-Hinweise für Agenten-Promptverzeichnisse.
- `git diff --check`, `git diff --cached --check`, Bash-Syntax und alle
  geänderten JSON-Dateien sind fehlerfrei. Der unveränderte Gatevertrag
  G001-G006 ist lokal vollständig abgedeckt; G007 bleibt bis zum exakten
  PR-Head bewusst ausstehend und G008 bleibt begründet `N/A`.

## Mutation-free operational evidence

- Direkter `--compare-only`- und `--dry-run`-Paketlauf veränderten keine
  Pakete oder Profile und meldeten wahrheitsgetreu Exit `1`: neun fehlende
  Required-Homebrew-Formeln, 13 optionale Formeln und null fehlende
  Required-CLI-, npm-CLI- oder VS-Code-Extension-Ziele. Die vormals
  widersprüchliche Erfolgsausgabe ist damit geschlossen.
- Der echte `maintain-agentic-workspace.sh --check-only`-Lauf
  `bbbeca5c-2275-4a77-9e42-d4e496b4ba5a` schrieb nur erlaubte Fetch-/Log-/
  Reportzustände. Sein atomarer Report ist `PARTIAL/1`, `finalized=true` und
  enthält 59 Toolchain-Einzelresultate samt vollständiger Restmenge.
- Der Dry-run
  `f2c98a31-662a-4ea3-9749-9ca36d7fb9a8` blieb ebenfalls paket- und
  profilmutationfrei und finalisierte `PARTIAL/1`.
- Beide Orchestratorläufe zeigten außerhalb dieses Level-0-Features
  vorhandenen Hostzustand: Feature-Branch ohne Upstream, 25 bereits dirty
  Flotten-Worktrees, sieben deklarierte noch fehlende Secure-CaseTracker-
  Ziele und einen dadurch vorübergehend nicht kanonischen Registry-Eintrag.
  Diese fremden/operativen Zielzustände wurden nicht verändert. Wegen der
  nicht grünen Vorschau wurde der echte Admin-/Paketlauf nicht technisch
  erzwungen.

## Security, architecture and accessibility review

- Trust Boundaries für Registry, stdin, Prozesse, PATH, Temp-Dateien,
  Downloads, Admin-Prompts und Reportpfade sind durch Validierung,
  stdin-Isolation, Prozessgruppen, Zeit-/Größenlimits, verifizierte Hashes und
  atomaren Ersatz abgesichert. Least Privilege, Fail-safe Defaults, Defense in
  Depth und getrennte Probe-/Mutation-/Finalisierungspfade sind erfüllt.
- NIST SSDF: PW.4/PW.5/PW.7/PW.8 und RV.1 sind durch Threat Review,
  fail-closed Verträge, Code-/Diff-Review, Test-first-Fixtures und
  Restdrift-Nachweis abgedeckt. Relevante CWE/CAPEC-Klassen sind
  OS-Command-Injection, Path Traversal, unkontrollierter Ressourcenverbrauch,
  unsichere Temp-/Downloadverarbeitung, Informationspreisgabe und
  Privilegienmissbrauch; die Gegenmaßnahmen sind im Code und in den
  Negativtests nachgewiesen.
- OWASP SAMM Secure Build und Security Testing sind durch den reproduzierbaren
  Registry-/Fixture-/Gate-Pfad erfüllt. OpenSSF-Supply-Chain-Prüfung bindet
  die offizielle Swift.org-Herkunft, konkrete Versionen und beide
  SHA-256-Werte; Swiftly prüft die nachgelagerte Toolchain zusätzlich mit dem
  offiziellen Signaturvertrag.
- ASVS, SBOM/VEX/AI-SBOM, SLSA, BSI C3A/C5, Zero Trust, NIS2, CRA, EU AI Act
  und DORA bleiben mangels Web-/Cloud-/Produkt-/Release-/KI-Runtime-Scope
  `N/A`; Re-Evaluation erfolgt bei entsprechender Scope-Erweiterung.
- Status, Restdrift, letzte Stufe und nächste Aktion sind text-first,
  farbunabhängig und DE-first/EN-second. CLI-Hilfe, Manpages und README wurden
  auf CEFR-B2-Nutzbarkeit geprüft; nicht triviale Grenzlogik besitzt
  didaktische Warum-/Sicherheitskommentare.
- `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`,
  `.github/copilot-instructions.md` und
  `.github/agents/copilot-instructions.md` wurden gemeinsam geprüft. Das
  Feature setzt bestehende Regeln um und erzeugt keine neue dauerhafte
  Agentenregel; daher ist die dokumentierte Entscheidung
  `NoUpdateRequired`.

## Corrective validation event

Ein frühes Swift-Positivfixture erbte unbeabsichtigt die drei lokalen
`SWIFTLY_*`-Variablen und ersetzte dadurch den vorhandenen Swiftly-Launcher.
Der Launcher wurde unmittelbar aus dem gepinnten offiziellen
Swiftly-`1.1.2`-Archiv mit exakt geprüftem
`21ad3d6376af0b423435f1f7295364add66c7173ea342654f4ae536c20ae88ba`
wiederhergestellt. Toolchains und Konfiguration blieben erhalten;
`swift --version` bestätigt Swift `6.3.3`. Das Fixture entfernt die drei
Variablen nun ausdrücklich; Positivlauf, Fehlerlauf und idempotenter Zweitlauf
sind danach grün.

## Delivery boundary

Nur Level 0 und die deklarierte Home-Runtime werden geliefert. Der Lauf
committet oder pusht keine Flottenziel-Repositories, umgeht keine
Administrator- oder Sicherheitsgrenze und startet nach dem Closeout kein
Folgefeature.

## Pull request

- Feature-PR: <https://github.com/hindermath/home-baseline/pull/146>
- Beim Öffnen veröffentlichter Head:
  `0562956897ca2eb6bc0b5603fd3c3dd778d58b31`.
- Der nachfolgende Evidence-Commit verändert den PR-Head erwartungsgemäß
  nochmals. Die verbindliche Exact-Head-Zuordnung bleibt deshalb bis zur
  G007-Konvergenz in temporärer providerneutraler Evidence und wird nicht
  selbstreferenziell in diesen Feature-Head geschrieben.
