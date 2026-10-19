# Begrenzter 14-Preset-Rollout / Bounded fourteen-preset rollout

Documentation Impact: `UpdateRequired`. Owner: @hindermath.
Beginn / Started: 2026-10-18. Abschluss / Closeout: 2026-10-19, Europe/Berlin.

## Auftrag und Grenzen / Authority and boundaries

DE: Freigegeben sind Level 0 mit anschliessendem Home Runtime Sync sowie genau
TinyCalc, Show-CommandTui400 und absdd-image-sandbox. Lieferung repositoryweise
per MergeAndSync mit Admin-Bypass nur nach gruenen technischen Checks des exakten
Heads. Technische GSDB-/Evidence-Nachpruefung ist beauftragt; neue Produkt-,
Risiko-, Pilot-, allgemeine Release- oder Zertifizierungsentscheidungen nicht.
Keine Community-Einreichung, weitere Flotte, Toolinstallation oder Spec-Kit-Laeufe.

EN: Authority covers Level 0 followed by Home Runtime sync and exactly three
named consumers. Deliver one repository at a time using exact-head MergeAndSync
with authorized admin bypass only after successful technical gates. Technical
GSDB/evidence revalidation grants no new human/product/risk/release/certification
decision. No community submission, wider fleet, tool installation or feature run.

## Ausgangsstand und Ziel / Baseline and target

PR [#333](https://github.com/hindermath/home-baseline/pull/333) und
[#334](https://github.com/hindermath/home-baseline/pull/334) sind enthalten;
Ausgangscommit ist `c2bf93f874507aa8027f1ff2bf46a8eb7f55a869`.
Fetch bestaetigte sauberes main mit 0/0. Home Runtime war vor Beginn aktuell.
Alle vier Repositories hatten dieselben 14 bisherigen Preset-Versionen.
TinyCalcs fremde ungetrackte Datei `sheet.mcalc.json` bleibt unangetastet.

PRs #333/#334 are included; initial main and Home Runtime were current. All four
repositories had the same previous fourteen versions. Preserve unrelated files
and use a clean worktree where necessary.

Zielmatrix / Target matrix:
`scripts/config/spec-kit-project-statistics-governance-presets.json`.
[Release-, Tag-Commit- und ZIP-Hashes / Release, commit and ZIP bindings](preset-source-lock.json).
[Veroeffentlichungsnachweis / Publication record](preset-readme-patch-releases-2026-10-18.md).
Alle 14 Tags/Commits und heruntergeladenen ZIP-SHA-256 wurden erneut exakt geprueft.
Prioritaeten, Profilname und globales Acht-Preset-Default bleiben unveraendert.

## Level-0-Integration / Level-0 integration

- Installation ueber die zentrale Matrix nach Vorschau und Quellabgleich.
  / Install through the central matrix after preview and source comparison.
- Bash und PowerShell CheckOnly: exakt 14 aktivierte Versionen und Prioritaeten.
  / Both shell checks validate the exact enabled matrix.
- Das bereits akzeptierte Home-only-Overlay `TerminalAwareRunnerAdoption` bleibt
  in genau fuenf Dateien bytegleich gegen den Ausgangscommit erhalten: Runner,
  Manpage, Fixture, PowerShell-Test und Bash-Wrapper unter
  `.specify/presets/autonomous-run-governance/`. Das ist v0.4.5 plus ein explizites
  lokales Overlay, kein Claim bytegleicher Vanilla-Installation. Das Overlay wird
  nicht in die drei Verbraucher kopiert. Herkunft:
  [akzeptierte Reconciliation](../../specs/032-linked-intake-evidence/checklists/preset-v042-analysis-2026-09-10.md).
- Preserve exactly five previously accepted Home-only terminal-adoption files.
  Bind package identity separately from this unchanged local overlay; do not
  promote the project-specific extension into downstream repositories.
- Spec Kit 0.12.8 erzeugte bei der Installation fuer Claude nur einen einzelnen
  Wrapper mit unaufgeloestem `{CORE_TEMPLATE}`. Die drei Claude-Flaechen wurden
  mit dem vorhandenen `CommandRegistrar.register_commands` aus den bereits
  vollstaendig aufgeloesten `.composed/speckit.{specify,plan,tasks}.md`-Quellen
  regeneriert. Keine CLI-, Preset-, Prioritaets- oder Interfaceaenderung.
- Existing generator APIs regenerate the three Claude skills from the resolved
  command stack. The added parity regression rejects unexpanded cores, missing
  wrappers and missing C3A/C5 contracts across all five maintained surfaces.
- Generierte Markdown-Flaechen erhalten LF, Schlussnewline und keinen neuen
  Trailing-Whitespace. Cache bleibt ausgeschlossen. / Normalize generated
  Markdown only; preserve semantics and exclude cache from version control.
- Der Installed-Lock wird erst gegen den Commit mit der tatsaechlichen neuen
  Installation gebunden, nicht nur neu erzeugt, um Tests gruen zu machen.
  / Bind the installed lock to the actual installation commit, not to a failed
  test's desired output.

## Technische Evidence / Technical evidence

Neuer, getrennter Kontext / New separate context:
`docs/security/secure-development/2026-10-18-home-baseline-preset-patch-rollout/`.
Er bindet die tatsaechliche Baseline 3.3.0 und alle kontrollierten Dokumente.
Vier getrennte Reviews und Status werden in beiden Shells ausgefuehrt; rohe
Kontextdatei-Hashes muessen vorher/nachher identisch bleiben.

Historical v0.1.3 contexts are preserved. Their baseline-3.2 hash drift against
current sources was observed before installation and is not a current pass.
The new context proves document identity/integrity and the installation contract,
not implementation of every checklist control or a new ReleaseAccepted decision.
Pilot authorization, project acceptance and general release remain Open.

## Lieferstatus / Delivery status

### Lokale Level-0-Pruefung / Local Level-0 validation

- Tag-/Commit-/ZIP-Pruefung: 14/14, Exit 0; Bash-/PowerShell-Matrix jeweils
  14/14, Exit 0. / Source and exact installed-matrix verification passed.
- Erhaltenes Home-Overlay: direkte PowerShell- und Bash-Wrapper-Matrix jeweils
  18/18, Exit 0; zusaetzlich Vanilla-v0.4.5-Routingtests aus dem verifizierten
  ZIP unter beiden Einstiegspunkten Exit 0. / Preserved overlay and immutable
  package tests pass independently; no overlay is claimed to be vanilla.
- Installierte Assurance-Fixtures: Exit 0, einschliesslich Context-/Mode-/Risk-
  Negativfaellen, Rohbyte-Snapshots, CRLF-/Error-Probes und Runbook-Blockierung.
  / Installed strict negative fixtures and shell parity passed.
- Status und vier getrennte Gate-Reviews unter beiden Shells: zehn Aufrufe,
  jeweils Exit 0, unveraenderte rohe Evidence-Hashes.
  [Befehle und Nullschreibnachweis / Commands and zero-write proof](preset-readme-patch-rollout-2026-10-18-home-gates.json).
- Agenten-/Profil-/Installed-Lock-Vertrag: neun Tests Exit 0; vollstaendige
  Wrapperkomposition auf allen gepflegten Agentenflaechen eingeschlossen.
  / Nine contract tests include complete multi-wrapper composition.
- Documentation Impact beider Shells, Skriptreferenz, Whitespace und Secret-
  Scan bestanden. Erster gestagter Liefersatz: 148 Pfade, Delivery-Set Pass,
  keine historische Whitespace-Ausnahme. / Documentation and staged delivery
  gates passed without historical whitespace allowances.
- Installed-Lock-Baseline ist der tatsaechliche Installationscommit
  `ab7e392b44faf2c2261abe2c0fabb27e60940f9b`. Statistik-Nachlauf und 21 technische
  PR-Gates bestanden vor Lieferung; der bedingte Collect-Job war uebersprungen
  und wird nicht als Pass gezaehlt. / The snapshot binds actual installation;
  statistics and 21 technical PR checks passed; a conditional skipped collector
  is not counted as successful execution.

| Ziel / Target | Lieferung / Delivery | Nachweis und Grenze / Proof and boundary |
| --- | --- | --- |
| Level 0 | [PR #335](https://github.com/hindermath/home-baseline/pull/335), Merge [bd64c607](https://github.com/hindermath/home-baseline/commit/bd64c6076021200ea8a12f8d5a55b78b0e6decd1) | 21 technische PR-Checks, sechs Merge-Workflows erfolgreich; main 0/0 / Technical checks and six merge workflows passed; main synchronized |
| Home Runtime | Lokaler Runtime-Commit `ce842a620101c9f44f01c7469f665897806c6867` / Local runtime commit | Syntax, Check-only und Vorschau vor Sync; zwoelf Dateien ohne Force/Konflikt verteilt, danach CURRENT und sauber / Twelve files distributed after preview without force/conflicts; current and clean afterward |
| TinyCalc | [PR #111](https://github.com/hindermath/TinyCalc/pull/111), Merge [98414a2d](https://github.com/hindermath/TinyCalc/commit/98414a2dc9ec38439e84b3cec324caab7b237f0d); Statistik-Nachlauf [#112](https://github.com/hindermath/TinyCalc/pull/112), Merge [45c66a2d](https://github.com/hindermath/TinyCalc/commit/45c66a2d5542bd3747e9523e5df661b160e57a61) | Je 18 technische PR-/Push-Checks erfolgreich; nach Reparatur sieben Merge-Workflows erfolgreich, main 0/0; fremde ungetrackte Datei erhalten / Technical checks and all seven final merge workflows passed; synchronized main with preserved unrelated untracked file |
| Show-CommandTui400 | [PR #51](https://github.com/hindermath/Show-CommandTui400/pull/51), Merge [ce7188b4](https://github.com/hindermath/Show-CommandTui400/commit/ce7188b43eec02a7d594a56aa58fc7b5d685faae) | Sieben PR-Checks und vier Merge-Workflows erfolgreich; main sauber 0/0 / Seven PR checks and four merge workflows passed; clean synchronized main |
| absdd-image-sandbox | [PR #95](https://github.com/hindermath/absdd-image-sandbox/pull/95), Merge [51af13d1](https://github.com/hindermath/absdd-image-sandbox/commit/51af13d11e403ea7acdfc15bc928708df6f1f8a2) | Neun PR-Checks und vier Merge-Workflows erfolgreich; main sauber 0/0 / Nine PR checks and four merge workflows passed; clean synchronized main |

### Verbraucher-Nachweise / Consumer proof

DE: Alle drei Verbraucher erhielten ausschliesslich die veroeffentlichten
vierzehn Pakete und benoetigte lokale Integrations-/Versionsbindungen.
Prioritaeten und globale Achtermatrix bleiben erhalten; keine Home-Overlays
werden in Verbraucher uebernommen. Die getrennten Quellen-Locks und Berichte
liegen jeweils unter `docs/maintenance/preset-readme-patch-*2026-10-18*`.

EN: All three consumers receive the fourteen immutable published packages and
required local bindings, not the Home-only overlay. Preserve priorities and
the global eight-preset default. Each repository retains its dated source lock,
technical report and exact-head delivery record in the linked PR.

- TinyCalc: 18 GSDB-Quellenbindungen und 14 exakte Erwartungsversionen erneuert;
  28 neue Negativfaelle blockieren alte Hashes/Versionen. Kontrollzeilen,
  externe Pflichten, Findings, Summen und urspruengliches Review erhalten.
  Vier Gate-Reviews plus Status in beiden Shells: zehn erfolgreiche Aufrufe,
  sechs Kontextdateien rohbytegleich. / Refresh exact GSDB identities with
  stale-binding negatives; preserve historical findings and human decisions.
- TinyCalc: gezielt beauftragte macOS-PTY-Testinfrastruktur korrigiert, nicht
  Produktcode oder vorhandene Produkt-Testorakel. Bereitschaft statt blinder
  Wartezeit, frische Ausgabe, vollstaendige UTF-8-/ANSI-Grenzen und B1-Bindung
  des bestehenden Navigationsablaufs. Hardlimits bleiben 25/30 Sekunden.
  21 gezielte Tests sowie vollstaendig ungefiltert 217 Core + 461 TUI bestanden,
  keine Fehler/Skips; nativer Sammler bindet 364 macOS-Pfade; `SMOKE_OK`.
  / Explicitly authorized adapter repair preserves strict oracles/deadlines;
  focused and full unfiltered product suites, native collector and smoke pass.
  [Diagnose / Diagnosis](https://github.com/hindermath/TinyCalc/blob/98414a2dc9ec38439e84b3cec324caab7b237f0d/docs/maintenance/macos-pty-adapter-2026-10-18.md).
- TinyCalc: Die spaetere Merge-CI von #111 meldete einen echten Statistik-
  Drift am Datumswechsel 18./19. Oktober. Der Fehler wird nicht durch die
  Claude-Ausnahme gedeckt und bleibt im Lauf
  [39235545135](https://github.com/hindermath/TinyCalc/actions/runs/39235545135)
  sichtbar. [PR #112](https://github.com/hindermath/TinyCalc/pull/112) aktualisiert
  ausschliesslich vier generierte Zeilen fuer Stichtag, Heatmap und DE/EN-
  Textalternativen. Gleiche Quelle `973dda57b7a29a3bf172d46e713f5d542398ca70`,
  272030 Textzeilen, 1701 Dateien, 96 Aktivtage und 303 relevante Commits;
  Konfiguration, Renderer und Methodik unveraendert. / Preserve the initial
  post-merge failure; repair only the date-dependent generated presentation,
  never the validator or measurement. Fresh technical checks remain mandatory.
  #112 ist mit 18 technischen Checks und ausdruecklicher Claude-Ausnahme
  geliefert; alle sieben Workflows am exakten Merge `45c66a2d` sind erfolgreich.
  / The repair passes eighteen technical checks and all seven exact-merge
  workflows; the old failed workflow is preserved, not rewritten.
- Show-CommandTui400: eigener technischer Trainingskontext, zehn erfolgreiche
  Gate-/Status-Aufrufe und fuenf rohbytegleiche Kontextdateien; historische
  LH-01-Reviewfrist nicht erneuert. Bestehende Linux-/Windows-Produktautomation
  erfolgreich; Installation startet keinen neuen Feature-Lauf.
  / Distinct technical context and native existing product automation, without
  renewing an expired feature review or authorizing a new implementation.
- Sandbox: gesichteter vollstaendiger Diff mit SHA-256
  `b77b49a1df57880bb12410f173a822e17ef7972053f973c56abd6ef0e8ed73b3`,
  einschliesslich Sitzungsprotokoll, exakt vor Commit erneut abgeglichen.
  Danach nur ausdruecklich erlaubter generierter Statistik-Nachlauf.
  Vorhandenes Image/VM wiederverwendet, keine Image-/Mount-/Provideraenderung.
  Linux-arm64-Matrix/Paritaet/CLI/Assurance-Fixtures und fuenf Pre-Commit-Hooks
  bestanden. PSScriptAnalyzer fehlte im Container: kein Pass; Host (86 Dateien)
  und native Linux-PR-/Merge-Analyse bestanden getrennt. / Exact sighted patch
  plus generated-only statistics; preserve container and human boundaries.
  The missing container analyzer is not misrepresented as a successful check.

### Review- und Abnahmegrenzen / Review and acceptance boundaries

DE: Fuer TinyCalc #111 hat der Owner ausschliesslich das ausgefallene
Claude-Review ausgenommen und diese Ausnahme auch fuer kuenftige TinyCalc-
Lieferungen bestaetigt. Sie betrifft ausgefallene Provider-Reviews, nicht
technische Checks oder tatsaechliche fachliche Review-Befunde. `is_error:true`
bleibt ein fehlgeschlagener Dienstlauf, kein Pass. Es wurden weder Workflows
noch Branch-Schutz oder Validatoren abgeschwaecht. Die Autoritaet fuer andere
Provider oder Repositories wird dadurch nicht erweitert.
[Ausnahme / Exception](https://github.com/hindermath/TinyCalc/pull/111#issuecomment-6264791664).
Copilot meldete bei Level 0, TinyCalc und Show sein Kontingentlimit; eine
abgeschlossene inhaltliche Copilot-Pruefung wird nicht behauptet.

EN: The owner expressly waived only the failed Claude provider review for
TinyCalc #111 and future TinyCalc deliveries. This does not waive technical
checks or actual substantive findings, weaken workflows/validators/protection,
or authorize other repositories/providers. Provider failure remains failure.
Copilot quota messages are not completed substantive reviews. Authorized admin
bypass is the formal merge mechanism, never technical acceptance evidence.

DE: Produkt-, Risiko-, Pilot-, allgemeine Release-, C5-, Konformitaets- und
Zertifizierungsentscheidungen bleiben unveraendert. Keine Community-
Einreichung, neue Version/Tag/ZIP, weitere Flotte oder Toolchaininstallation.
TinyCalcs ungetrackte `sheet.mcalc.json` blieb unveraendert (SHA-256
`5fc57d57bcb7ba88e7667f27c1241264628ba26ecd64e8153addddf13045243d`).
Die Homogeneity-Werkzeugwurzel ist kein pauschaler Level-2-Nachweis: der
fehlangesetzte generische lokale Workspace-Scan gilt nicht als Pass; getrennte
Projekt-/Setup-Vertraege und native CI sind belegt. DocFX/axe/lynx in TinyCalc
belegen nur den begrenzten HTML-Smoke; manuelle Kontrast-/Screenreader-Gates
bleiben offen. Statistik ist reproduzierbare Projekttransparenz, keine
gemessene KI-Produktivitaet. Vor spaeteren Feature-Starts Review-Frische,
Serie, Modell-Routing und aktuelle Autoritaet erneut pruefen.

EN: Preserve all human acceptance and certification boundaries. No community,
release, wider fleet or toolchain action. Preserve the user's untracked sheet.
Mis-scoped generic homogeneity execution is not a passing Level-2 gate; scoped
contracts and native CI are separate proof. HTML automation is not full
accessibility acceptance, and statistics do not measure AI productivity.
Recheck intake review, series, routing and authority before later features.

### Zentrale Dokumentationslieferung / Central documentation delivery

DE: Dieser Abschluss aktualisiert ausschliesslich den vorhandenen Bericht,
Documentation Impact und das Statistik-Ledger samt generiertem Nachlauf.
Distributionsklasse `sourceOnly`: kein erneuter Home Runtime Sync. Exakter
Abschluss-PR-Head, Merge, Merge-CI und finale Synchronisierung werden im
Liefer-PR dokumentiert; keine weitere Commit-Schleife fuer Selbstreferenzen.

EN: This closeout is source-only report/impact/ledger maintenance and generated
statistics, with no further Home Runtime sync. Record its exact head, merge,
post-merge CI and synchronization in its delivery PR rather than creating
self-referential report/statistics commits.

DE: Der erste lokale Gesamtlauf fuer den Abschluss hatte 335 Tests, 14 Skips
und zwei Fehler in CI-Budget-Fixtures. Ihre reale `git diff HEAD`-Pfadauswahl
selektierte wegen der noch uncommittierten Dokumente nur das Dokumentations-
Gate. Beide unveraenderten Faelle bestehen gegen den sauberen Ausgangsstand;
es wurde kein Produktions-/Testcode angepasst. Dieser rote Lauf ist kein Pass.
Gesamtnachpruefung und CI erfolgen am sauberen finalen Commit; deren tatsaechliche
Ergebnisse werden im Abschluss-PR dokumentiert.

EN: The first local 335-test run had fourteen skips and two CI-budget fixture
failures because real dirty-tree path selection selected only the documentation
gate. Both unchanged cases pass against the clean base. No production/test code
was changed and the failed aggregate is not a pass. Repeat the full suite and
CI against the clean final commit and record actual results in its delivery PR.

[Documentation-Impact-Evidence](preset-readme-patch-rollout-2026-10-18-impact.json).

[Abschluss: exakte PR-/Commit-/Workflow-Links und Grenzen / Closeout delivery
and workflow evidence](preset-readme-patch-rollout-2026-10-19-closeout-evidence.json).
[Abschluss-Documentation-Impact / Closeout documentation impact](preset-readme-patch-rollout-2026-10-19-closeout-impact.json).
