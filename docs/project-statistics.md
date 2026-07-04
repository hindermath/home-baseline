# Projektstatistik / Project Statistics — home-baseline

> **Lebendiges Dokument / Living document** — wird nach jedem abgeschlossenen Feature,
> nach jeder abgeschlossenen Spec-Kit-Implementierungsphase und auf explizite Anfrage
> aktualisiert.
>
> *Updated after every completed feature, Spec-Kit implementation phase, or on explicit
> request.*

---

## Fortschreibungsprotokoll / Update Log

Ältester Eintrag oben, neuester Eintrag unten.
*Oldest entry at top, newest entry at bottom.*

| Datum / Date | Phase / Branch | Aktivtage ges. | Zeilen ges. | Commits ges. | Hauptarbeitspakete / Main Work Packages |
|---|---|---:|---:|---:|---|
| 2026-04-12 | Baseline (alle Phasen 0–5) | 11 | 41 969 | 216 | Init-Infrastruktur, Homogeneity Guardian (001+002), Public Template + Sync (pub), CI + Git-Config-Scope (003), Workspace Teardown + GitLab-Support (005+006), Bootstrap-Project + Release Please |
| 2026-04-18 | Maintenance-Rollup inkl. Agent-Audit | 17 | 45 712 | 256 | Nachlaufende Maintenance-Runden, Microsoft-Foundry-Skill-Sync im Arbeitsbaum, neues lokales Agent-Audit mit Baseline/Report fuer Codex, Claude, Copilot und Continue, README-, Guidance- und Manpage-Dokumentation |
| 2026-04-22 | Maintenance-Guidance serielle Migration | 21 | 42 875 | 266 | Remote-Fast-Forward auf Constitution v1.6.0, agentische Umgebung aktualisiert, Homogeneity-Statistiken fortgeschrieben, Fallstrick zu parallelen `migrate-workspace.*`-Laeufen in Shared Guidance und README dokumentiert |
| 2026-04-26 | Spec-Kit Preset Governance & Veroeffentlichung | 25 | 67 251 | 291 | Sechs Spec-Kit-Governance-Presets fachlich geschnitten, standalone GitHub-Repos veroeffentlicht, lokale und GitHub-ZIP-Smoke-Tests ausgefuehrt, Issue `github/spec-kit#2362` aktualisiert, Preset-Pflegeworkflow in Verfassung und Agenten-Dateien dokumentiert; Release-Matrix nachgetragen |
| 2026-04-29 | Agentische Praxisprobe OpenCode-Analyse | 26 | 67 359 | 292 | `WebStormProjects` und `opencode-analysis` praktisch eingerichtet, OpenCode-Fork-Workflow vorbereitet, `bootstrap-project.*` auf agentenweise Spec-Kit-Initialisierung fuer Gemini, OpenCode, Claude, Copilot und Codex korrigiert |
| 2026-04-29 | Git-Identity-Sync-Haertung | 26 | 67 456 | 294 | `.gitconfig` aus blindem `sync-home`-Kopiervorgang entfernt, lokale Git-Identitaet dauerhaft geschuetzt, alte Platzhalter-Warnkoepfe automatisch migriert und README-Dokumentation aktualisiert |
| 2026-04-29 | opencode-analysis CI-Fix | 26 | 67 507 | 302 | Fehlgeschlagenen Homogeneity-Workflow in `opencode-analysis` analysiert und behoben; `--exit-on-fail` durch gueltigen `--fail-fast .`-Aufruf ersetzt, Level-2-README-/Agenten-Templates ergaenzt und Scanner fuer git-ignorierte Unterrepos gehaertet |
| 2026-04-29 | Level-1-Workspace-Bootstrap-Haertung | 26 | 67 914 | 303 | Ursache fuer den minimal eingerichteten `WebStormProjects`-Workspace ermittelt, bestehenden Level-1-Workspace auf vollstaendige agentische Baseline gebracht und `bootstrap-workspace.*` samt Workspace-README-Template fuer kuenftige Erst-Einrichtungen erweitert |
| 2026-04-30 | Spec-Kit 0.8.3 Update-Automation | 28 | 71 461 | 306 | Spec-Kit-0.8.3-Integrationen ueber Level 0/1/2 aktualisiert, OpenCode-Command-Tracking aufgenommen, Governance-Template-Erhalt in Verfassung und Agenten-Dateien dokumentiert, `update-spec-kit.sh/.ps1` samt Manpage und `sync-home`-Docs-Sync ergaenzt |
| 2026-04-30 | Public-Template-Quelle fuer Spec-Kit-Updates | 28 | 71 527 | 309 | `update-spec-kit.*` von impliziter TuiVision-Prioritaet auf selbsttragendes `home-baseline`-Default umgestellt; private Template-Quellen nur noch als expliziter Override dokumentiert; Verfassung, Agenten-Dateien, README und Manpage nachgezogen |
| 2026-04-30 | Release-Please Node-24-Runtime | 28 | 71 547 | 311 | `release-please`-Workflows und Bootstrap-Generatoren auf einen konkreten `googleapis/release-please-action`-SHA mit `node24`-Runtime gepinnt, um GitHubs Node.js-20-Deprecation-Warnung fuer JavaScript-Actions zu vermeiden |
| 2026-05-21 | AI-SBOM Governance & security-governance v0.3.0 | 31 | 72 257 | 316 | G7/BSI-AI-SBOM als bedingt anwendbare Supply-Chain-Evidenz in Constitution, Spec-Kit-Templates, Agenten-Guidance, README und `security-governance`-Preset aufgenommen; Entwicklungswerkzeug-Nutzung als `N/A`, KI-Runtime-/Produktkomponenten mit sieben AI-SBOM-Clustern dokumentiert |
| 2026-05-26 | security-governance v0.4.0 Sprachprofile | 32 | 72 796 | 317 | Sprachspezifische Secure-Coding-Profile fuer Rust, Go, Swift, Java/Kotlin, Python und TypeScript/JavaScript in Constitution, Spec-Kit-Templates, Agenten-Guidance, README und Preset-Scaffolds propagiert; MSL-Status als nicht ausreichender Sicherheitsnachweis dokumentiert |
| 2026-05-31 | Agent-neutrales Spec-Kit-Modell-Routing | 35 | 73 313 | 323 | Spec-Kit-Modell-Routing als agentenneutrale Guidance in den Agenten-Dateien verarbeitet, `agent-parity-governance` auf v0.2.0 fortgeschrieben, Preset-Matrix, Constitution, README und Templates synchronisiert und Standalone-Preset per GitHub-Tag veroeffentlicht |
| 2026-06-05 | a11y-governance v0.3.0 didaktische Inline-Kommentare | 36 | 73 583 | 328 | Didaktische Inline-Code-Kommentar-Governance in `a11y-governance` als Minor-Update ergaenzt, neues Review-Template `didactic-code-comment-check-template` aufgenommen, Constitution, README, Agenten-Dateien, Templates und Preset-Scaffolds synchronisiert |
| 2026-06-11 | architecture-governance v0.3.0 BSI C3A Cloud-Autonomie | 37 | 73 853 | 329 | BSI C3A als bedingt anwendbare Cloud-Autonomie-Evidenz in `architecture-governance` ergaenzt, neues Template `cloud-autonomy-applicability-template` aufgenommen, Constitution, README, Agenten-Dateien, Templates und Preset-Scaffolds synchronisiert |
| 2026-06-11 | C5/NIS2 Preset-Erweiterung | 37 | 74 835 | 330 | BSI C5 als Cloud-Compliance-Assurance in `architecture-governance v0.4.0` und regulatorische Anwendbarkeitsmatrix fuer NIS2, CRA, EU AI Act und DORA in `security-governance v0.5.0` ergaenzt; neue Templates `cloud-compliance-assurance-template` und `regulatory-applicability-template` aufgenommen; Constitution, README, Agenten-Dateien, Templates und Preset-Scaffolds synchronisiert |
| 2026-06-20 | Secure-Development-Basis und mitgeltende Dokumente | 44 | 112 992 | 339 | Generische sichere-Entwicklung-Basis mit Richtlinie, Checklisten, Sammelband, mitgeltenden Dokumenten, CISA-Memory-Safe-Roadmaps-PDF samt EN/DE-Markdown, neuer Verzahnungsdatei fuer Richtlinie/CLs/Presets und Lastenheft fuer einen spaeteren Spec-Kit-Verzahnungslauf fortgeschrieben; Swift als MSL didaktisch sichtbarer gemacht |
| 2026-06-20 | Lastenheft-Abarbeitungsreihenfolge | 44 | 113 066 | 339 | Root-nahe `Lastenheft_Abarbeitungsreihenfolge.md` ergaenzt, aktive spaetere Spec-Kit-Intakes von historischen Feature-Branch-Lastenheften getrennt und README-Verweis auf die Reihenfolge aufgenommen |
| 2026-06-20 | Spec-Kit-Intake-Haertung und Container-Intake | 44 | 113 460 | 339 | Aktive Level-0-Lastenhefte fuer spaetere Spec-Kit-Laeufe als Intake-Dateien geschaerft, kopierbare `/speckit-specify`-Prompts ergaenzt, neues Lastenheft fuer Secure-Development-Container-Hardening aufgenommen und Agenten-/Secure-Development-Guidance zur Intake-Struktur nachgezogen |
| 2026-06-20 | Skriptsprachen-Guidance fuer Agenten | 44 | 113 489 | 339 | README und Agenten-Dateien um OS-Pruefung, PowerShell-7-/Cmdlet-Prioritaet, optionalen C#-Pfad ueber `.NET`/`mono` und Fallback auf vorhandene OS-nahe Repo-Skripte ergaenzt |
| 2026-06-27 | Secure-CaseTracker-Lernreihe | 45 | 115 330 | 347 | Ausführliche DE-first/EN-second Lernreihe für die fiktive Übungsfirma EuFPA erstellt: Master-Intake, elf einzeln startbare Spec-Kit-Aufgaben-Intakes, Unterrichtsleitfaden, Fachrichtungsbezug AE/SI/DPA, Richtlinie-Sichere-Entwicklung-Bezug, sechs MSL-Zielsprachen C#/Go/Java/Python/Rust/Swift und README-/Reihenfolge-Verankerung |
| 2026-06-27 | Secure-CaseTracker-Level-Modell | 45 | 115 429 | 348 | Lernreihe um generisches Level-0-/Level-1-/Level-2-Arbeitsmodell, private Repo-Zielstruktur, Statusmatrix-Vorlage und manuelle Spec-Kit-Laufgrenzen erweitert; C# als Referenzpfad und Go/Java/Python/Rust/Swift als Vergleichspfade dokumentiert |
| 2026-06-27 | Secure-CaseTracker-Repo-Struktur | 45 | 115 442 | 349 | Dokumentation nach realem Bootstrap-Modell geschaerft: lokale CamelCase-Level-2-Ordner und lowercase GitHub-Repository-Slugs unterschieden und in Lernreihe, Master-Intake und README verankert |
| 2026-06-27 | Secure-CaseTracker-Praesentation | 45 | 118 728 | 350 | Pandoc-kompatible DE/EN-Markdown-Praesentationen fuer die Secure-CaseTracker-Lernreihe ergaenzt, zentrale Lernmaterialien dokumentiert und als lokale Einfuehrung fuer Level-1-/Level-2-Repos vorbereitet |
| 2026-06-27 | Secure-CaseTracker-Intake-Ablage | 45 | 118 733 | 351 | Zentrale Secure-CaseTracker-Lastenhefte aus dem Repository-Wurzelverzeichnis nach `docs/learning-units/` verschoben, Abarbeitungsreihenfolge, README, Praesentations-Prompts und Copy-Paste-Intakes auf den neuen kanonischen Lernreihenpfad aktualisiert |
| 2026-06-27 | Generische Lernreihen-Wiederverwendung | 45 | — | — | `docs/learning-units/` als Level-0-Quelle fuer weitere Lernreihen ab dem 1., 2. und 3. Lehrjahr geschaerft; Blueprint, Register, Vorlagen, generische Git-Start-Anleitung und wiederverwendbare Lernpaket-Skripte ergaenzt |
| 2026-06-28 | Lernreihen-Checklisten-Verankerung | 46 | — | — | Lernreihen-Blueprint, README und Vorlage geschaerft: Level-2-Sprachrepos fuehren Richtlinie, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente und Preset-Verzahnung lokal als Arbeits- und Nachweisgrundlage |
| 2026-06-28 | Lernreihen-Governance-Preset-Installation | 46 | — | — | Zentrale Preset-Matrix und Installer fuer alle sechs GitHub-Spec-Kit-Governance-Presets ergaenzt, `bootstrap-project.*` fuer MSL-Level-2-Repos integriert und Secure-CaseTracker-Lernreihe auf nachweisbar installierte Presets ausgerichtet |
| 2026-06-28 | Secure-Development-Hardening-Specify-Prompt | 46 | — | — | Zentrale Secure-Development-Hardening-Lastenheft-Vorlage um kopierbaren `/speckit-specify`-Prompt fuer spaetere separate Haertungslaeufe ergaenzt |
| 2026-06-28 | Lernreihen-ab-2-Lehrjahr | 46 | — | — | Secure CaseTracker v2 und Secure InventoryHub als vollstaendige Level-0-Lernreihen ab dem 2. Lehrjahr vorbereitet: je Reihenbeschreibung, Unterrichtsleitfaden, Master-Lastenheft, zehn einzeln startbare Aufgaben-Intakes, DE/EN-Praesentation, Register-/README-Verankerung und klare Grenze ohne Level-1-/Level-2-Repo-Erzeugung |
| 2026-06-28 | Lernreihen-ab-3-Lehrjahr | 46 | — | — | Secure CaseTracker Professional Tracks als 3.-Lehrjahr-Spezialisierung vorbereitet: Dachreihe, Master-Lastenheft, Application/Operations/Data-Process-Tracks fuer AE/SI/DPA, je Unterrichtsleitfaden, Master-Lastenheft, zehn Aufgaben-Intakes, DE/EN-Praesentationen und README-/Register-Verankerung ohne Level-1-/Level-2-Repo-Erzeugung |
| 2026-06-29 | Secure-CaseTracker-Scaffold-und-Baseline-Modell | 47 | — | — | Secure-CaseTracker-Lernreihe um technischen Startlauf `00`, Jahr-2-Baseline-/Track-Ableitung `12`, Tag `learning/year-2-complete`, `YEAR2_BASELINE.md` und `TRACK_BASELINE.md` erweitert; README, Blueprint, Unterrichtsleitfaden, Jahr-2-/Jahr-3-Doku und Abarbeitungslogik nachgezogen |
| 2026-06-29 | RL-SE-Checklist-Selbstpruefung | 47 | — | — | Generischen Level-0-Intake und Skriptpaar fuer RL-SE-/Checklist-Selbstpruefung vorbereitet: unabhaengig von MSL, mit Evidenzmatrix, Owner, Follow-up, Re-Evaluation-Trigger, Restrisiko, README-/Agenten-Verankerung und Vorbereitung fuer Level-1-/Level-2-Propagation |
| 2026-06-30 | GSDB-Registry-und-Preflight | 48 | — | — | Operative GSDB-Registry fuer relevante Level-1-/Level-2-Repos, Register-Helper und GSDB-Self-Assessment-Preflight ergaenzt; normale Preflight-Laeufe erzeugen `docs/security/gsdb-self-assessment.md`, `Lastenheft_GSDB-Spec-Kit-Intensivpruefung.md` und aktualisieren die Lastenheft-Abarbeitungsreihenfolge, starten aber keinen Spec-Kit-Lauf |
| 2026-07-03 | Skript-/Konfig-Kommentar- und GSDB-Intakes | 49 | — | — | Zwei vorbereitende Lastenhefte fuer didaktische Skript-/Konfig-Kommentare, JSONC-Migrationspruefung und fokussierte GSDB-Pruefung der Skript-, JSON/JSONC-, YAML- und Workflow-Flaechen ergaenzt; Abarbeitungsreihenfolge nach Script-Dokumentation und PowerShell-Cmdlet-Konventionen eingeordnet |
| 2026-07-04 | Level-2-Registry, Spec-Kit und GSDB-Wartung | 53 | 126 858 | 383 | Level-0/1/2-Repos gepullt, SecureCaseTracker- und absdd-Level-2-Struktur lokal geklont/registriert, sechs MSL-CLI-Toolchains verifiziert, Spec-Kit-Integrationen samt Whitespace-Normalisierung aktualisiert, zentrale Level-2-Registry auf 16 operative Repos erweitert und GSDB-Preflight auf `Open=0` gebracht |
| 2026-07-04 | Agentische Toolchain-Registry und Paketwartung | 53 | 127 816 | 384 | Homebrew aktualisiert, `gitleaks` installiert und verifiziert, versionierte Brew-/WinGet-Registries fuer agentische Entwicklung ergaenzt, macOS/Linux-/Windows-Wartungsskripte samt Testausgaben, Manpages, README-Runbook und Agenten-Guidance dokumentiert |
| 2026-07-04 | VS-Code-/Helix-Mindesteditoren fuer sechs MSL-Pfade | 54 | 128 316 | 385 | VS Code als grafische Quasi-IDE, Helix als A11Y-/CLI-Editor, offizielle minimale VS-Code-Extensions fuer C#, Go, Java, Python, Rust und Swift sowie robuste Extension-Wartung in Brew-/WinGet-Skripten, Registries, Testausgaben, Manpages, README und Agenten-Guidance ergaenzt |

---

## Gesamtstand des Repositories / Repository Snapshot

Stand / As of: **2026-06-27**

| Kategorie / Category | Dateien / Files | Zeilen / Lines | Anteil / Share |
|---|---:|---:|---:|
| Skripte / Scripts (`.sh` + `.ps1`) | 85 | 18 682 | 15.7 % |
| Templates (`.tmpl` + Konfigurationsdateien) | 24 | 3 311 | 2.8 % |
| Hooks + CI (pre-push + YAML/JSON) | 33 | 2 050 | 1.7 % |
| Dokumentation / Documentation (`.md`) | 509 | 89 391 | 75.3 % |
| Sonstiges / Other | 28 | 5 299 | 4.5 % |
| **Gesamt / Total** | **679** | **118 733** | **100 %** |

### Aufgliederung Dokumentation / Documentation Breakdown

| Untertyp / Subtype | Zeilen / Lines | Anteil an Doku / Share of Docs |
|---|---:|---:|
| Spec-Kit-Artefakte (`specs/`) | 20 195 | 22.6 % |
| Secure Development (`docs/secure-development/`) | 29 152 | 32.6 % |
| Lastenhefte im Repository-Wurzelverzeichnis (`Lastenheft*.md`) | 4 461 | 5.0 % |
| Lernmaterialien und Lernreihen-Intakes (`docs/learning-units/`) | 2 470 | 2.8 % |
| Governance (AGENTS / CLAUDE / GEMINI / constitution) | 3 982 | 4.5 % |
| README / CHANGELOG / STATS | 3 498 | 3.9 % |
| Sonstiges (Templates, andere `.md`) | 25 633 | 28.7 % |

---

## Phasen und Haupt-Branches / Phases and Main Branches

Die Spalte „Insertions" gibt den dokumentierten Netto-Beitrag der Phase an
(Zeilen eingefuegt, ohne nachtraegliche Loeschungen in spaeteren Phasen abzuziehen).

*The "Insertions" column shows the documented net contribution per phase
(lines inserted, without subtracting later deletions in subsequent phases).*

| Phase | Bezeichnung / Label | Insertions | Commits | Aktivtage / Active Days | Zeitraum / Period |
|---|---|---:|---:|---:|---|
| 0 | main — Init-Backbone | 954 | 24 | 1 | 2026-03-31 |
| 1 | 001+002 — Homogeneity Guardian + Revision | 26 519 | 38 | 1 | 2026-04-01 |
| 2 | pub+sync — Public Template + Sync-Home | 6 168 | 51 | 2 | 2026-04-02 bis 04-03 |
| 3 | CI+003 — CI-Pipeline + Git-Config-Scope | 1 523 | 92 | 3 | 2026-04-04 bis 04-06 |
| 4 | 005+006 — Workspace Teardown + GitLab | 10 769 | 21 | 2 | 2026-04-08 bis 04-11 |
| 5 | proj — Bootstrap-Project + Release Please | 686 | 21 | 1 | 2026-04-12 |
| 6 | presets — Spec-Kit Governance Presets | 8 733 | 10 | 2 | 2026-04-25 bis 2026-06-11 |

**Hinweis zu spaeteren Maintenance-Runden:** Die Snapshot- und Gesamtwerte oben
enthalten auch die nachfolgenden Maintenance-Arbeiten bis `2026-06-20`. Dazu
gehoeren insbesondere die Verfassungs- und Agenten-Guidance-Runden, Release-
Please-Aktualisierungen, die Preset-Governance-Arbeit und die sichere-
Entwicklung-Basis mit mitgeltenden Dokumenten.

*Note on later maintenance rounds: the snapshot and overall values above also
include follow-up maintenance work through `2026-06-20`, especially constitution
and agent-guidance rounds, Release Please updates, preset-governance work, the
secure-development baseline with related documents, and the Level-1 workspace
bootstrap hardening.*

**Hinweis zu Phase 1:** Der hohe Insertions-Wert (26 519 Zeilen an einem Aktivtag)
entsteht durch die Spec-Kit-Batch-Generierung: Spec-Kit erstellt `spec.md`,
`plan.md`, `tasks.md`, `checklist.md` und zugehoerige Artefakte in einem einzigen
orchestrierten Lauf. Das ist kein manueller Tippaufwand, sondern der dokumentierte
Output agentischer KI-Unterstuetzung — genau das, was das Speedup-Modell abbildet.

*Note on Phase 1: The high insertion count (26 519 lines in one active day) results
from Spec-Kit batch generation: Spec-Kit produces spec.md, plan.md, tasks.md,
checklist.md and related artifacts in a single day. This is not manual typing
effort but documented output of agentic AI support — precisely what the speedup
model captures.*

**Hinweis zu Phase 6:** Die Preset-Phase hat aus der Verfassung sechs
wiederverwendbare Spec-Kit-Presets abgeleitet, als repo-foermige Scaffolds
dokumentiert, in eigenstaendige GitHub-Repos veroeffentlicht und per GitHub-ZIP-
Installation smoke-getestet. Der Zeilenzuwachs liegt fast vollstaendig in
Markdown/YAML-Governance-Artefakten.

*Note on Phase 6: The preset phase derived six reusable Spec Kit presets from the
constitution, documented them as repo-shaped scaffolds, published standalone
GitHub repositories, and smoke-tested GitHub ZIP installation. The line growth is
almost entirely Markdown/YAML governance artifacts.*

---

## Release-Staende und Aenderungen / Release States and Changes

Quelle fuer diese Matrix ist `CHANGELOG.md`; lokale Git-Tags sind ab `v0.3.1`
vorhanden. Die Releases `v0.1.0` bis `v0.3.0` sind historisch im Changelog
dokumentiert, im aktuellen lokalen Tag-Satz aber nicht als Tags vorhanden.
GitHub-Releases sind per Remote-Abgleich am `2026-04-26` fuer `v0.4.0` bis
`v0.11.0` vorhanden; `v0.11.1` und `v0.11.2` sind im Changelog dokumentierte
Release-Please-Nachlaeufe. `v0.3.1` ist lokal getaggt und im Changelog
dokumentiert.

*This matrix is based on `CHANGELOG.md`; local Git tags exist from `v0.3.1`
onward. Releases `v0.1.0` through `v0.3.0` are historically documented in the
changelog but are not present as tags in the current local tag set. Remote
GitHub Releases were checked on `2026-04-26` and exist for `v0.4.0` through
`v0.11.0`; `v0.11.1` and `v0.11.2` are changelog-documented Release Please
follow-ups. `v0.3.1` is locally tagged and documented in the changelog.*

| Release | Datum / Date | Erfasst in Statistik / Captured in Statistics | Hauptaenderungen / Main Changes |
|---|---|---|---|
| v0.1.0 | 2026-03-31 | Phase 0 | Initiale Bootstrap-Infrastruktur, Agenten-Dateien, Spec-Kit-Integration, Whitelist-`.gitignore`, `STATS.md`, bilinguale README |
| v0.2.0 | 2026-04-03 | Phase 1 | Workspace Homogeneity Guardian, Stats-/Migrations-/Constitution-Sync-Skripte, MIT-Lizenz, Homogeneity-CI, Template-Repo-Umstellung |
| v0.3.0 | 2026-04-03 | Phase 2 | `sync-home.*`, CHANGELOG, README-Ausbau, Spec-Kit-Dokumentation, WCAG-Abschnitt, Agenten-Guidance und CI-Fixes |
| v0.3.1 | 2026-04-03 | Phase 2 | README-Tabellenkorrektur, `specify init --here --ai {agent}`, Agenten-Known-Pitfalls |
| v0.4.0 | 2026-04-03 | Phase 2 | Release Please eingerichtet, CI-Fehler behoben, Release-Please-Dokumentation |
| v0.4.1 | 2026-04-05 | Phase 2/3 | Compliance-Ziel korrigiert, OpenCode/Linux/Codex/sync-home-Fixes, Arbeitsverzeichnis- und OS-Detection-Guidance |
| v0.4.2 | 2026-04-05 | Phase 3 | Claude-Code-Installationsdokumentation fuer macOS/Linux/Windows korrigiert |
| v0.5.0 | 2026-04-06 | Phase 3 | Plattformtest-Skripte, Pull-/Push-Stabilisierung, macOS/Windows-Testdokumentation, `master`/`main` zusammengefuehrt |
| v0.5.1 | 2026-04-06 | Phase 3 | README-Nachfuehrung fuer Git-Schritte, Auth, neue Projekte, Auszubildenden-Workflow und Spec-Kit-Init-Links |
| v0.5.2 | 2026-04-06 | Phase 3 | CHANGELOG-Korrekturen und `sync-home`-Dateiliste erweitert |
| v0.5.3 | 2026-04-08 | Phase 4 | Spec-Kit-kompatible Lastenhefte fuer CI/CD, GitLab, Git-Config-Scope und Workspace-Teardown |
| v0.6.0 | 2026-04-11 | Phase 4 | Git-Config-Scope, Workspace-Teardown, GitLab-Support und zugehoerige Spezifikationen |
| v0.6.1 | 2026-04-11 | Phase 4 | Lastenheft-Rename-Pflicht in Templates und Agenten-Dateien, Lastenhefte umbenannt |
| v0.6.2 | 2026-04-11 | Phase 4 | `specify`-CLI statt `npx speckit`, `--`-Sentinel, Help-/grep-Guards, Teardown- und GitLab-Doku |
| v0.7.0 | 2026-04-12 | Phase 5 | Workspace-/Projekt-README-Erstellung, Bootstrap-Project Release Please, Statistik-Ledger, Agenten-Statistikregeln, Constitution v1.4.0 |
| v0.7.1 | 2026-04-12 | Phase 5 | Template-README bereinigt und `STATS.md` aktualisiert |
| v0.8.0 | 2026-04-13 | Maintenance-Rollup | GitLab-Release-Automation, GitLab-Release-Fixes, Release-Guidance fuer Agenten |
| v0.8.1 | 2026-04-15 | Maintenance-Rollup | Level-2-Repos weiter ignoriert, README zu Bootstrap, Migration, Versionierung und Security erweitert |
| v0.8.2 | 2026-04-16 | Maintenance-Rollup | Codex-Status-Fall, Speckit-Beispiele, Accessibility- und Agenten-Guidance erweitert |
| v0.9.0 | 2026-04-18 | Maintenance-Rollup | Lokaler Agent-Audit-Workflow, Microsoft-Foundry-Skills, Migrationsebenen |
| v0.9.1 | 2026-04-23 | Maintenance-Guidance | Constitution v1.5.1 bis v1.7.0, Spec-Kit-Assets, serielle Migrationen, Homogeneity-Stats |
| v0.9.2 | 2026-04-24 | Maintenance-Guidance | Lastenheft fuer agentische Umgebungspruefung, Constitution und Security-Templates aktualisiert |
| v0.10.0 | 2026-04-24 | Maintenance-Guidance | Git-Identity-Setup, Propagate-Security-Guidance, Security-Evidence-Templates, sichere Entwicklung in Constitution |
| v0.10.1 | 2026-04-24 | Maintenance-Guidance | Spec-Kit-Issue-Response-Playbook |
| v0.11.0 | 2026-04-26 | Phase 6 | Sechs Spec-Kit-Governance-Presets, iSAQB-Architektur-Preset, Standalone-Repos, Smoke-Tests, Preset-Pflegeworkflow |
| v0.11.1 | 2026-04-28 | Maintenance-Guidance | Git-Identity-Sync-Fix und GitHub-Housekeeping-Fallstricke |
| v0.11.2 | 2026-04-30 | Maintenance-Guidance | Level-1-Agentic-Baseline, Spec-Kit-Initialisierung fuer alle Agenten, Node-24-Release-Please-Fixes |

Damit sind alle in `CHANGELOG.md` dokumentierten Release-Staende in der
Statistik entweder einer Hauptphase oder einer Maintenance-Runde zugeordnet.

*All release states documented in `CHANGELOG.md` are now assigned to either a
main phase or a maintenance round in this statistics ledger.*

---

## Gesamtstatistik / Overall Statistics

Basis dieses Schlussblocks sind der aktuelle Repository-Snapshot sowie die
dokumentierten Hauptphasen und Maintenance-Runden aus den Abschnitten oben.

*This closing block is based on the current repository snapshot plus the
documented main phases and maintenance rounds from the sections above.*

| Kennzahl / Metric | Verdichteter Gesamtblick / Condensed Overview |
|---|---:|
| Artefaktbasis gesamt / Total artifact base | `118 728` Zeilen |
| Operativer Code / Operational code (Skripte + Hooks + CI) | `20 732` Zeilen (`17.5 %`) |
| Dokumentationsanteil / Documentation share | `89 386` Zeilen (`75.3 %`) |
| Beobachtbarer Projektzeitraum / Observable project window | `2026-03-31` bis `2026-06-27` |
| Sichtbare Git-Aktivtage / Observable active days | `45` |
| Git-Commits gesamt / Total commits | `350` |
| Git-Commits pro Aktivtag / Commits per active day | `7.8` (`350 / 45`) |
| Zeilen pro Aktivtag / Lines per active day | `2 638.4` (`118 728 / 45`) |
| Zeilen pro Commit / Lines per commit | `339.2` (`118 728 / 350`) |
| Konservative Einzelentwickler-Untergrenze | `1 484.1` Arbeitstage / `11 576.0` Stunden |
| Thorsten-Solo-Untergrenze (Scripting-Infra, 100 Z./Tag) | `1 187.3` Arbeitstage / `9 260.8` Stunden |
| Kleines 3er-Team mit Koordinationsaufschlag | `593.6` Arbeitstage |
| Repo-weiter Speedup gg. 80-Zeilen-Referenz | `33.0x` |
| Repo-weiter Speedup gg. Thorsten-Referenz (100 Z./Tag) | `26.4x` |

Kurzfazit:
`home-baseline` bleibt dokumentations- und Governance-getrieben: `75.3 %` der
sichtbaren Basis liegen in Markdown-Artefakten. Der operative Code (Skripte,
Hooks, CI) macht `17.5 %` aus. Der größte dokumentierte Volumensprung bleibt
Phase `1` (Spec-Kit-Batch für Homogeneity Guardian). Die aktuelle
Maintenance-Runde ergänzt die sichere-Entwicklung-Basis um eine ausführliche
EuFPA-Lernreihe für Secure CaseTracker, elf einzeln startbare Spec-Kit-
Aufgaben-Intakes, einen Unterrichtsleitfaden, ein klares Level-1-/Level-2-
Arbeitsmodell für private MSL-Sprachpfade und Pandoc-kompatible
Einführungspräsentationen. Für private Ausbildungsprojekte bleibt
Nichtanwendbarkeit als begründetes `N/A` dokumentierbar. Die
Beschleunigungsfaktoren beschreiben keine Stoppuhrzeit, sondern sichtbare
Lieferdichte gegen konservative manuelle Referenzmodelle.

*Short summary: after the Secure CaseTracker learning-series round,
`home-baseline` remains documentation- and governance-driven: `75.3 %` of the visible base sits
in Markdown artifacts. Operational code (scripts, hooks, CI) accounts for
`17.5 %`. The largest documented volume jump remains Phase `1` (Spec-Kit batch
for Homogeneity Guardian). The current maintenance round adds the detailed
EuFPA Secure CaseTracker learning series, eleven individually runnable Spec Kit
task intakes, a teaching guide, and Pandoc-compatible introductory
presentations. Private training projects can still document
non-applicability as justified `N/A`. The
acceleration factors describe
visible delivery density, not stopwatch measurements.*

### ASCII-Diagramme / ASCII Charts

```text
Artefaktmix nach aktuell dokumentiertem Snapshot (Zeilen)
Operativer Code | #######                        | 20 732 | 17.5 %
Dokumentation   | ############################## | 89 391 | 75.3 %
Sonstiges       | ###                            |  8 610 |  7.3 %
```

Dieses Diagramm zeigt, wie der aktuelle Snapshot zwischen operativem Code
(Skripte, Hooks, CI), Dokumentation und sonstigen Artefakten verteilt ist.
Die Preset-Arbeit und die sichere-Entwicklung-Basis haben den
Dokumentations- und Governance-Anteil sichtbar erhoeht; die aktuelle
Lastenheft-Reihenfolge trennt aktive Intakes von historischen Feature-Branch-
Lastenheften.

*This chart shows the split between operational code (scripts, hooks, CI),
documentation, and other artifacts in the current snapshot. The preset work and
the secure-development baseline visibly increased the documentation and
governance share; the current Lastenheft order separates active intakes from
historical feature-branch Lastenhefte.*

```text
Phasenvolumen nach dokumentierter Netto-Basis (Insertions)
0 Init    | #                        |    954
1 001+    | ######################## | 26 519
2 pub     | #####                    |  6 168
3 CI+003  | #                        |  1 523
4 005+    | ##########               | 10 769
5 proj    | #                        |    686
6 presets | ########                 |  8 733
```

Dieses Diagramm zeigt den Netto-Insertions-Beitrag der dokumentierten Phasen.
Phase `6` ist nach Phase `4` das groesste sichtbare Paket und besteht vor allem
aus Preset-Templates, README-Dateien, Governance-Regeln und Smoke-Test-Doku.

*This chart shows the net insertion contribution per documented phase. Phase `6`
is the largest visible package after Phase `4` and mainly consists of preset
templates, README files, governance rules, and smoke-test documentation.*

```text
Konservative Handarbeits-Referenz je dokumentierter Phase (Arbeitstage, 80 Z./Tag)
0 Init    | #                        |   11.9 d
1 001+    | ######################## |  331.5 d
2 pub     | ######                   |   77.1 d
3 CI+003  | ##                       |   19.0 d
4 005+    | ##########               |  134.6 d
5 proj    | #                        |    8.6 d
6 presets | ########                 |  109.2 d
```

Jeder Balken zeigt, wie viele Arbeitstage ein erfahrener Einzelentwickler
bei `80` manuell erstellten Zeilen pro Tag fuer das jeweilige Phasenpaket
benoetigt haette. Die Preset-Phase entspricht konservativ gut `109`
Arbeitstagen sichtbarem Governance-Output.

*Each bar shows how many workdays an experienced solo developer would have needed
at `80` manually created lines per day for the respective phase package. The
preset phase conservatively represents about `109` workdays of visible
governance output.*

```text
Dokumentierte Beschleunigungsfaktoren (Phasen-Speedup vs. 80-Zeilen-Referenz)
Repo ges. | ################################# | 33.0x
0 Init    | ############                     | 11.9x
1 001+    | >> Spec-Kit-Batch: 331.5x (ausserhalb Skala)
2 pub     | ################################# | 38.6x
3 CI+003  | ######                           |  6.3x
4 005+    | ################################################ | 67.3x
5 proj    | ########                         |  8.6x
6 presets | ################################################ | 54.6x
```

Hier werden keine Stoppuhrzeiten gemessen. Verglichen wird die dokumentierte
Lieferdichte pro Aktivtag gegen die 80-Zeilen-Referenz. Phase `6` ist hoch,
weil mehrere Preset-Folge-Releases, externe Preset-Repos und Smoke-Test-Runden
in zwei sichtbaren Preset-Aktivtagen abgeschlossen wurden.

*This chart does not measure stopwatch time. It compares documented delivery
density per active day against the 80-line reference. Phase `6` is high because
multiple preset follow-up releases, external preset repositories, and several
smoke-test rounds were completed in two visible preset active days.*

```text
Vergleich dokumentierter Gesamtaufwand / sichtbares KI-Lieferfenster
Erfahren (80 Z./Tag)   | ######################## | 1 484.2 d / 11 576.5 h
Thorsten (100 Z./Tag)  | ###################      | 1 187.3 d /  9 261.2 h
KI sichtbar            | #                        |    45.0 d
```

Dieser Vergleich macht die grobe Groessenordnung sichtbar: Zwischen klassischer
Handarbeit und dem im Repository sichtbaren Lieferfenster liegt eine deutliche
Verdichtung. Genau diese Verdichtung beschreibt das Ledger als
blended repository speedup.

*This comparison makes the scale visible: there is clear compression between
classical manual effort and the delivery window visible in the repository.
That documented compression is what the ledger labels as blended repository
speedup.*

```text
X/Y-Diagramm: Phasenvolumen (X = Phase 0..6, Y = Insertions)
30000 |                            |
25000 |     *                      |
20000 |                            |
15000 |                            |
10000 |                 *       *  |
 5000 |         *                  |
    0 | *           *       *      |
      +----------------------------+
        0   1   2   3   4   5   6
```

Als zweite Ansicht zeigt diese X/Y-Kurve denselben Verlauf ueber die
Phasenachse. Die X-Positionen nutzen feste Slots, damit spaetere zweistellige
oder fehlende Phasenwerte keine Punkte verschieben. Phase `1` ragt deutlich
heraus; Phase `6` bildet den neuen Governance- und Preset-Nachlauf nach den
Sicherheits- und Architekturarbeiten.

*As a second view, this X/Y curve shows the same progression across the phase
axis. The X positions use fixed slots so later two-digit or missing phase values
do not shift points. Phase `1` stands out clearly; Phase `6` forms the new
governance and preset follow-up after the security and architecture work.*
