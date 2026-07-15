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
| 2026-07-05 | FI/DV-Integration und Spec-Kit-SDD-Auftakt | 55 | 129 705 | 387 | Secure CaseTracker um FI/DV Digital Networking Track mit Master-Intake, zehn Aufgaben-Intakes, Unterrichtsleitfaden und DE/EN-Praesentationen erweitert; IT-Berufe-Mapping fuer FI/AE, FI/SI, FI/DPA, FI/DV, IT-System-Elektroniker/-in, IT-System-Management und Digitalisierungsmanagement ergaenzt; neutrale Spec-Kit-SDD-Auftaktinformation aufgenommen; bestehende CaseTracker-/InventoryHub-Reihen, README, Register, Vorlagen und Agenten-Guidance mit begleitender Spec-Kit-Abgrenzung nachgezogen |
| 2026-07-05 | VS-Code-Container-Tools-Extension | 55 | — | — | VS-Code-Extension-Registry um Microsoft Container Tools fuer Docker-/Podman-Workflows erweitert; README und Manpages fuer Brew-/apt- sowie WinGet-Wartung auf MSL-Extensions plus Container Tools nachgezogen |
| 2026-07-05 | Wartungsroutine-Agentenabfrage und GSDB-Drift | 55 | — | — | Wiederkehrende Workspace-Wartung in README, Agenten-Dateien und Templates mit Startabfrage verankert; `register-level2-repository.*` um `--scan-root` / `-ScanRoot` fuer GSDB-Registry-Drift erweitert; Toolchain-Vergleich nach Required/Optional getrennt und VS-Code-App-Bundle als erfuellter Required-Cask behandelt; fehlende Required-Tools per Homebrew nachgezogen |
| 2026-07-07 | Secure-CaseTracker-Uniformierung 12-Sektionen | 57 | — | — | Secure-CaseTracker-Lastenhefte auf das uniforme 12-Sektionen-Muster der Secure-ServiceHarvester-Familie angeglichen (Paritaets-Gate 63/0): Basis 13 von 17/16 inhaltserhaltend verdichtet (getrennte Sicherheits-/Datenschutzanforderungen zusammengefuehrt; Sprachspezifische Hinweise, Tests und Nachweise, N/A-Regeln, Offene Punkte eingewebt; Reflexionsfragen in die `Fachrichtungsbezug`-Tabelle; `Copy-Paste Spec-Kit Prompt` zu `Optimaler Specify-Prompt`), 40 Track-Lastenhefte additiv um `Fachrichtungsbezug` und `Sprachneutrale Anforderungen` erweitert, v2 `09` Extra-Heading auf `###` herabgestuft; 63 Lernbegleiter unveraendert (9 Sektionen); `Lernreihen-Blueprint` auf uniform als Haus-Default (tiered als unbelegte Variante) und `Lernreihen-Register` nachgezogen; Re-Propagation auf Level-1 und sechs Level-2-Repos (Idempotenz 0) sowie Lern-ZIP neu gebaut (PR #40) |
| 2026-07-07 | Secure-OrderDesk-Familie (Northwind) Level-0 komplett | 57 | — | — | Dritte Lernreihen-Familie **Secure OrderDesk** (relationale Handels-/Bestellplattform auf Northwind-Datenbasis inkl. Pflicht-Datensatz `ALFKI`) als vollstaendige Level-0-Reihe erstellt: Konzept + Pilot (PR #42), Basis-Reihe Jahr 1 mit 13 Aufgaben-Lastenheften + 13 Lernbegleitern + Master + Praesentation (PR #43), v2 Jahr 2 mit 10 Units + Master + Leitfaden + Praesentation (PR #44), 4 Professional Tracks Jahr 3 mit 40 Units + 5 Mastern + 4 Leitfaeden + 8 Praesentationen (PR #45). Uniformes 12-Sektionen-Muster (Paritaet 63/0 ueber alle Aufgaben-Lastenhefte), gemeinsame Systemlandschaft (Secure Trader; EuFPA baut die drei Systeme OrderDesk/ServiceHarvester/CaseTracker), markenneutral mit Northwind nur als Quellhinweis |
| 2026-07-08 | Secure-OrderDesk Datensaetze, Verzahnung und Level-1/2-Rollout | 58 | — | — | Deterministischer Datensatz-Generator plus generierte, konsistente, fiktive Datensaetze fuer alle drei Systeme bis 2026-07 (OrderDesk: 4725 Bestellungen 1996–2026, 597 Kund*innen inkl. `ALFKI`, 338 Monate lueckenlos je 8–16 Bestellungen; ServiceHarvester: 4 Server + 40 PCs; CaseTracker: 7 Cases), referenzielle Integritaet 0 Verletzungen (PR #46); Systemlandschaft-Notiz in CaseTracker + ServiceHarvester gespiegelt und beide Familien re-propagiert (PR #47); Level-1/2-Rollout von Secure OrderDesk als 7 reale private GitHub-Repos (`secure-orderdesk-baseline` + sechs MSL-Sprach-Repos), Registry-Registrierung, Propagation (Idempotenz 0) und Lern-ZIP gebaut und veroeffentlicht |
| 2026-07-08 | Secure-Trader-Datensatz-Generator: Monatskadenz und mitwachsendes Enddatum | 58 | — | — | CaseTracker von 7 statischen Cases auf **monatliche Kadenz** korrigiert (4 Kunden- + 2–4 Mitarbeitenden-Anfragen/Monat mit `CreatedDate`, periodengueltige echte Referenzen, `ALFKI` regelmaessig) — im 2026-07-Snapshot ~2.360 Cases. Generator auf argparse umgestellt: `--end` (Default `now()`, waechst bis zum Projektdatum) und fester `--seed` (reproduzierbar ueber alle sechs Sprach-Repos); alle drei Systeme wachsen monatlich bis zum Endmonat (ServiceHarvester-Server in historischer Kadenz, ~2026=4, danach weiter). OrderDesk-/ServiceHarvester-CSVs im 2026-07-Snapshot byte-identisch (LF-Zeilenenden), referenzielle Integritaet 0 Verletzungen; Docs (Systemlandschaft, Datensatzquelle, datasets/README) nachgezogen, Re-Propagation auf die 7 Repos und Lern-ZIP neu gebaut |
| 2026-07-08 | Container-First-Gate fuer KI-Agenten in den Lernreihen | 58 | — | — | Verbindliches **Container-First-Gate** in allen drei Basis-Familien (OrderDesk/ServiceHarvester/CaseTracker) verankert: Jeder KI-Agenten-Aufruf erfolgt im Container/der Sandbox (`absdd-image-sandbox`), nie auf dem Arbeitsplatz-Rechner, als Gate ab Unit 00 (vor dem ersten Agentenstart). Neues geteiltes Dokument `Secure-Trader-Sandbox-Preflight.md` (bilinguale Preflight-Checkliste + host-agnostisches podman/docker-Runbook, ISO-27001-Bezug A.5.23/A.8.25/A.8.28/A.8.31). Unit 00 (Scaffold) je Familie um R-06, Kernbegriffe, Preflight-Schritt und Selbstcheck erweitert; Unit 09 von „vorbereitend, keine Pflicht" auf verbindliche Vertiefung umgestellt; Lernreihe-Dateien, Unterrichtsleitfaeden, DE/EN-Praesentationen und Rahmenlehrplan-Mapping (Unit 00 nun LF 4 beruehrt) nachgezogen. Formulierungs-Sweep in fuenf v2-/Professional-Track-Sandbox-Lastenheften. Leichte Governance-Verankerung: verbindliche Blueprint-Grundregel + wortgleicher Shared-Guidance-Absatz in `CLAUDE.md`, `AGENTS.md`, `GEMINI.md` und `.github/copilot-instructions.md` (Parity), Verweis auf bestehende `Leitlinie_Sichere-Entwicklungs-Sandbox.md` und `CL_12`; Re-Propagation auf die Level-1/2-Repos und Lern-ZIPs neu gebaut |
| 2026-07-08 | Container-First-Gate: EN-Doc-Pfade (Copilot #52 → PR #53) | 58 | — | — | Copilot-Reviewfolge zu PR #52: Im englischen Container-First-Absatz der vier Agenten-Dateien `Leitlinie_Sichere-Entwicklungs-Sandbox.md` und `CL_12_Agentische-KI-Sandbox.md` von Kurznamen auf die vollen `docs/secure-development/…`-Pfade umgestellt (vom Repo-Root aufloesbar, konsistent zum DE-Absatz), wortgleich in `CLAUDE.md`, `AGENTS.md`, `GEMINI.md` und `.github/copilot-instructions.md` (Parity, md5-identisch); vier Review-Threads beantwortet und resolved (PR #53) |
| 2026-07-09 | Datasets DS-GVO-Klarstellung und Herkunfts-/KI-Provenienz | 58 | — | — | In `docs/learning-units/datasets/README.md` und im Docstring von `generate-secure-trader-dataset.py` eine ehrliche Transparenznotiz ergaenzt: expliziter **DS-GVO**-Bezug (vollstaendig synthetisch/fiktiv, kein Personenbezug → ausserhalb DS-GVO, Erwaegungsgrund 26; Northwind-Namen als fiktive Beispieleintraege), plus saubere **Herkunfts-Trennung** — Datenwerte prozedural/deterministisch aus dem geseedeten Skript (kein LLM-Output), Generator-Skript und Doku KI-assistiert (Claude Code) erstellt, daher kein pauschales „KI-generierte Daten"-Etikett. Keine Aenderung an der CSV-Ausgabe (Determinismus/Bitgleichheit des 2026-07-Snapshots per Regen + `git diff` verifiziert); Re-Propagation auf die Level-1/2-Repos |
| 2026-07-09 | MSL-/SBOM-/Spec-Kit-Toolchain Required-Baseline | 58 | — | — | Agentische Toolchain-Registries auf die Lernreihen-Basis erweitert: sechs MSL-CLI-Pfade als Required-Pruefungen, `syft` fuer SBOM-Evidenz und GitHub Spec Kit (`specify`) als Required-SDD-Tool aufgenommen; Brew-/WinGet-Registries, Wartungsskripte, Testausgaben, README, Manpages, Agenten-Guidance und Templates synchronisiert |
| 2026-07-09 | Vier Agenten-CLI-Required-Baseline | 58 | — | — | `codex`, `claude`, `gemini` und `gh copilot` als Required-Agenten-CLI-Oberflaechen in der CLI-Pruefregistry verankert; neue npm-Agenten-Registry fuer `codex` und Linux-/Windows-`gemini`, Node/npm-Grundlage, Brew-/WinGet-Wartungsskripte, Plattformtests, README, Manpages, Agenten-Guidance und Templates synchronisiert |
| 2026-07-09 | Kaufmaennische Berufsrollen-Linse (KITSM/KDM) | 58 | — | — | Die beiden kaufmaennischen IT-Berufe **KITSM** und **KDM** ohne neue Repos in die drei Lernreihen integriert (Blueprint-konform, `Lernreihen-Blueprint.md:61`): neues zentrales `Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md` (Code-Naehe-Modell — Barriere-Umkehr, SQL als deklarative Bruecken-Programmiersprache, Baender KITSM ~5–10 %/KDM ~15–25 %, Pflicht-SQL-Schreib-Touch, evidenzbasierte Abnahme mit eingebauter Abweichung, Rollen-Split); `Secure-Trader-`-Praefix fuer Auto-Propagation. `Rahmenlehrplan-Lernfeld-Mapping.md` um die **amtlichen KMK-Lernfelder** KITSM (LF 1–13) und KDM (LF 1–12) erweitert (Quelle KMK-RLP 13.12.2019). Drei `IT-Berufe-Secure-*-Mapping.md` um kaufmaennischen SDD-Rollenabschnitt vertieft. 15 **Unit-Overlays** „Kaufmaennische Rollen-Umschaltung" in die Handlungs-Units (01/06/10/11 + Data-&-Process-Track) der drei Familien. Template, Register und Blueprint angeglichen; `Secure InventoryHub` bewusst ausgeschlossen (keine der drei Reihen) |
| 2026-07-10 | Neutraler KI-Erstellungshinweis | 58 | — | — | Root-README um einen gut sichtbaren, bilingualen Transparenzhinweis ergaenzt: die agentische Unterstuetzungs-Umgebung und wesentliche Dokumentations-, Lern- und Skriptinhalte sind menschlich kuratiert, geprueft und fortgeschrieben; Teile wurden mit Hilfe agentischer KI erstellt oder generiert. Der Hinweis bleibt ohne Klarnamen und macht menschliche Verantwortung, Pruefung und Freigabe massgeblich |
| 2026-07-10 | Selbstfuehrender Lernenden-Einstieg und Vier-Agenten-Sandbox | 59 | 229 607 | 422 | Kanonischer Startpfad ab dem 1. Lehrjahr mit persoenlichem `home-baseline`-Fork, persistentem `home-baseline-tmp`, Podman-Sandbox und erstem kontrollierten Agentenlauf; Podman, sechs MSL, JDK, Syft, Spec Kit sowie Codex/Claude/Gemini/Copilot konsistent Required; Lernpaket-Self-Tests, Lychee-Link-/Anker-CI und fehlertolerante 21-Repo-Propagation mit Remote-, Clean-/Main-/Fast-forward- und Neuere-Zieldatei-Gates ergaenzt |
| 2026-07-10 | Provider-neutrales Git-Hosting fuer Lernende | 59 | 230 725 | 423 | Lernenden-Einstieg von einer allgemeinen GitHub-Kontopflicht geloest: institutionelle GitLab-, Forgejo-, Codeberg- und generische Git-Profile mit getrennten `origin`-/`upstream`-Rollen dokumentiert; Ausbildendenleitfaden fuer Import, Schutzregeln, Konten und Aktualisierung ergaenzt; Bootstrap-/Teardown-Skripte um private Forgejo-/Codeberg-Repositories mit sicherer Credential-API-Nutzung erweitert; Sandbox-Dokumentation und Lernpaket-Propagation nachgezogen |
| 2026-07-10 | Secure-Development-Basis 3.0.0 | 59 | — | — | Richtlinie und 15 mitgeltende Dokumente fuer Lernende ab Lehrjahr 1 vertieft; Lernpfad, Standardsregister, 157 stabile CL-IDs und zweiachsiges Evidenzmodell eingefuehrt; Sammelband manifestgesteuert aus 12 kanonischen Checklisten erzeugt; Bash-/PowerShell-Generatoren, CI-Gate und geschuetzte registry-basierte Level-2-Propagation ergaenzt; sechs Governance-Presets unveraendert als Reviewrahmen genutzt |
| 2026-07-11 | Workspace-, Toolchain- und Lernreihen-Wartung | 60 | 235 377 | 429 | Alle verwalteten Level-0-/Level-1-/Level-2-Repos aktualisiert, Secure OrderDesk und Secure ServiceHarvester mit je sechs MSL-Sprachrepos lokal aufgenommen und registriert, Homebrew samt 21 Upgrades gewartet, Gemini CLI durch Google Antigravity ersetzt, VS-Code-/MSL-/SBOM-/Spec-Kit-Toolchain vollstaendig verifiziert sowie zentrale Secure-Development-Baseline und GSDB-Preflights in den zwoelf neuen Level-2-Repos auf `Open=0` gebracht |
| 2026-07-11 | Antigravity-CLI-Vollmigration | 60 | — | 432 | Antigravity CLI `agy` ab 1.1.1 als alleinige aktive Google-Agenten-CLI verankert; plattformgerechte Brew-/WinGet-/verifizierte Linux-Installation, gehärtete JSON-Settings, ASCII-Statusline, eigener Flottenaudit, Spec-Kit-`agy`-Manifest, sichere `.agents/skills`-Allowlist und Entfernung aktiver Gemini-Kommandos umgesetzt; historische Specs und Lastenhefte bewusst bewahrt |
| 2026-07-11 | GSDB-Registry-Promotion und Drift-Haertung | 60 | — | 435 | Alle 25 registrierten Level-2-Repos in den GSDB-Pruefumfang aufgenommen; 18 Lern-Sprachrepos als MSL, `cc65` als Nicht-MSL und `absdd-image-sandbox` als gemischte Tooling-Umgebung klassifiziert; Registry-Upserts in Bash/PowerShell gegen Metadaten-Herabstufung gehaertet, Sprachsuffix-Erkennung und expliziter MSL-Override ergaenzt, zwoelf fehlende Umgebungsregisterzeilen nachgezogen und der read-only Container-Preflight fuer die 20 promovierten Repos mit `Open=0` abgeschlossen |
| 2026-07-11 | GSDB-Preflight fuer archivierte Intakes | 60 | — | — | False Positive bei abgeschlossenen Spec-Kit-Intakes beseitigt: `check-gsdb-self-assessment.*` akzeptiert neben aktiven Root-Dateien nun numerisch branch-suffigierte Archivnachweise, nennt den tatsaechlichen Evidenzpfad und erzeugt bei archiviertem GSDB-Intake kein neues aktives Duplikat; Bash- und PowerShell-Pruefung gegen TuiVisions abgeschlossenes Feature 016 liefern `Open=0` |
| 2026-07-12 | Autonomous-Run-Governance Feld-Input 018 | 61 | — | — | Ersten TuiVision-Feldlauf als 629-zeiligen reproduzierbaren Snapshot aus Skill-Quelle, OpenAI-UI-Metadaten, Runbook, Evidence-Template und Retrospektivmodell uebernommen; Workitem AR-018 dokumentiert PR-/Merge-Evidence, projektspezifische Ausschluesse, reproduzierbare Tests und die Entscheidungen `Promote` fuer exakte Delivery-Evidence-Pfade sowie Berechtigungsgrenzen und `ObserveAgain` fuer gebuendelte Red-Proofs. Zusammen mit dieser Ledger-Zeile `+630/-0`; reine Dokumentation/Skill-/Template-Eingabe, keine Skript- oder Runtime-Aenderung. Manualreferenz: `7,9` Tage beziehungsweise `61,4` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `6,3` Tage beziehungsweise `49,1` Stunden bei 100 Zeilen/Tag. Sichtbares Arbeitsfenster ist der Handoff am 2026-07-12. |
| 2026-07-12 | Autonomous-Run-Governance Feld-Input 019 | 61 | — | — | Zweiten TuiVision-Feldlauf als 1.053-zeiligen Snapshot aus aktuellem Skill, OpenAI-UI-Metadaten, Runbook, Retrospektive, Evidence-/Task-Template und Agent-Policy uebernommen. AR-019 promoviert vollstaendige projektlokale Red-Matrizen nach zweiter Beobachtung, den Compile-Surface-Check, Linked-Source-Artefaktidentitaet und den bestaetigten exakten Delivery-Evidence-Pfad; Reviewer-/Bypass-Sicherheit bleibt explizit autoritaetsgebunden. Zusammen mit dieser Ledger-Zeile `+1054/-0`; keine Skript- oder Runtime-Aenderung. Manualreferenz: `13,2` Tage beziehungsweise `102,8` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `10,5` Tage beziehungsweise `82,2` Stunden bei 100 Zeilen/Tag. Der langlebige Paketbranch bleibt bis nach Feldlauf 023 ungemergt. |
| 2026-07-12 | Autonomous-Run-Governance Feld-Input 020 | 61 | — | — | Dritten TuiVision-Feldlauf als 1.089-zeiligen Snapshot aus Skill, OpenAI-UI-Metadaten, Runbook, Retrospektive, Tasks-/Evidence-Template und Agent-Policy uebernommen. AR-020 promoviert den kausalen Closeout-Pfad fuer selbstinvalidierende Reviewed-Head-Fakten, bestaetigt Compile-Surface-Gate und projektlokale Red-Matrix und haelt physische Host-Evidence als getrennten `ObserveAgain`-Kandidaten fest. Zusammen mit dieser Ledger-Zeile `+1090/-0`; keine Skript- oder Runtime-Aenderung. Manualreferenz: `13,6` Tage beziehungsweise `106,2` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `10,9` Tage beziehungsweise `84,9` Stunden bei 100 Zeilen/Tag. Der langlebige Paketbranch bleibt bis nach Feldlauf 023 ungemergt. |
| 2026-07-12 | Autonomous-Run-Governance Feld-Input 021 | 61 | — | — | Vierten TuiVision-Feldlauf als `+1444/-0`-Snapshot uebernommen. AR-021 bestaetigt den vorab benannten kausalen Closeout und trennt unverfuegbare Reviews, physische Host-Evidence und explizite Remote-Autoritaet. Kein Retrospektiv-PR entstand, weil keine belastbare lokale Korrektur vorlag. Manualreferenz: `18,1` Tage beziehungsweise `140,8` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `14,4` Tage beziehungsweise `112,6` Stunden bei 100 Zeilen/Tag. |
| 2026-07-12 | Autonomous-Run-Governance Feld-Input 022 | 61 | — | — | Fuenften Feldlauf als `+1442/-0`-Snapshot uebernommen. Der Single-Commit-Closeout ohne Selbstreferenz und die Klassifikation aequivalenter Push-/PR-Workflow-Saetze wurden promoviert; Multiword-argv und formaler Primary-Proof-Marker blieben `ObserveAgain`. Manualreferenz: `18,0` Tage beziehungsweise `140,6` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `14,4` Tage beziehungsweise `112,5` Stunden bei 100 Zeilen/Tag. |
| 2026-07-12 | Autonomous-Run-Governance Feld-Input 023 | 61 | — | — | Sechsten Feldlauf als `+2541/-0`-Snapshot einschliesslich Feature-/Closeout-Evidence und fail-closed Bash-/PowerShell-Wrappern uebernommen. Promoviert wurden genau ein mutierbarer Validierungstoken pro explizitem Aufruf sowie Helper-Abnahme ueber expliziten Repo-Root, Exitcode und sauberen Fehlerkanal. Manualreferenz: `31,8` Tage beziehungsweise `247,7` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `25,4` Tage beziehungsweise `198,2` Stunden bei 100 Zeilen/Tag. |
| 2026-07-12 | `autonomous-run-governance` v0.1.0 Release Candidate | 61 | 243 552 | 443 | Sechs Feldlaeufe zu einem optionalen, stackbaren Preset produktisiert: zwei Commands, Constitution-/Spec-/Plan-/Tasks-/Agent-Addenda, Runbook-, Evidence-, Retrospektiv- und Readiness-Vorlagen, Feldvalidierungsbericht, kanonischer Scaffold, Publikationskopie, MIT-Lizenz und getrennte Siebenerkonfiguration bei unveraenderter Standard-Sechsermatrix. Produktisierung vor Statistikpflege `+1390/-23`, also 1367 Nettozeilen. Dev-/lokaler ZIP-Install, siebenfache Komposition, List/Info/Resolve, Remove/Reinstall/Disable/Enable, genau eine Command-Oberflaeche in Codex/Claude/Copilot-Skills/Gemini sowie remote-freier synthetischer LocalImplementation-Lauf bis Analyze bestanden. Manualreferenz fuer 1390 hinzugefuegte oder aktualisierte Zeilen: `17,4` Tage beziehungsweise `135,5` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `13,9` Tage beziehungsweise `108,4` Stunden bei 100 Zeilen/Tag. Remote-PR, Tag-ZIP, Upstream-Issue und TuiVision-Dogfooding folgen als externe Abschlussgates. |
| 2026-07-12 | `Programmierung #include<everyone>` / `Programming #include<everyone>` prominent propagiert | 61 | — | — | Verbindlichen Leitsatz bilingual sichtbar in Home-Baseline-README, zentralem Lernbereich, Lernenden-Start, Blueprint sowie Lernreihen-/Lernbegleiter-Vorlagen verankert; Vorlagen-README grenzt die bewusste Nicht-Wiederholung in einzelnen Aufgaben-Lastenheften ab. Idempotente README-Propagation dokumentiert und in drei Level-1- sowie 18 Level-2-Repositories umgesetzt; insgesamt 21 Ziel-Repositories mit README, beiden START-HERE-Kopien und Vorlagen synchronisiert. Reine Dokumentations- und Wartungslogik, keine Spec-Kit-, Build- oder Runtime-Ausfuehrung. |
| 2026-07-12 | Autonomous-Run-Governance Feld-Input 024 | 61 | 243 608 | 446 | Siebten TuiVision-Feldlauf als Workitem uebernommen und die bereits in v0.1.0 enthaltene Clean-Error-Channel-Regel unabhaengig validiert. Der PowerShell-Homogeneity-Lauf hatte bei Exitcode 0 insgesamt 108 `PropertyNotFoundException`-Zeilen erzeugt; zwei Helfer normalisieren Zero-/One-/Many-Resultate jetzt array-sicher. PowerShell und Bash liefern mit explizitem Repo-Root jeweils genau ein parsebares JSON-Dokument und einen leeren Fehlerkanal. Der gesamte Branch-Diff einschliesslich Statistikpflege umfasst `+81/-25`, also 56 Nettozeilen; die fachliche Kernaenderung sind `+6/-4` PowerShell und ein 52-zeiliges Workitem. Manualreferenz fuer 81 hinzugefuegte oder aktualisierte Zeilen: `1,0` Tage beziehungsweise `7,9` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `0,8` Tage beziehungsweise `6,3` Stunden bei 100 Zeilen/Tag. Das Preset benoetigt keine Scope-Erweiterung, weil die portable Zielregel bereits enthalten ist. |
| 2026-07-12 | Level-2-Umgebungsregister bereinigt und dauerhaft synchronisierbar | 61 | — | — | Alle 31 verwalteten Level-0-/Level-1-/Level-2-Repositories fast-forward aktualisiert; operative GSDB-Registry auf 24 klassifizierte Level-2-Repositories ohne `unknown` gebracht; kanonisches Umgebungsregister auf die 24 real vorhandenen Pfade reduziert. `propagate-security-guidance.*` synchronisiert das Register nun mit einem isolierten Registry-only-Modus in beiden Constitution-Dateien, ohne projektspezifische Governance oder fremde Arbeitsstaende anzutasten. |
| 2026-07-13 | Agentisches Toolchain-Wartungspaket propagiert | 62 | — | — | Kanonische Neun-Dateien-Menge fuer beide Wartungsskripte, fuenf Registries und zwei Manpages als Manifest festgelegt; native, idempotente Bash-/PowerShell-Propagation mit Dry-Run, Drift-Check, Registry-/Dynamik-Erkennung und Schutz lokal veraenderter Zieldateien umgesetzt. Isolierte Schreib-, Idempotenz- und Schutztests bestanden; 256 Dateidifferenzen ohne Schutzkonflikt in sechs Level-1- und 24 Level-2-Repositories synchronisiert, mit 30 gezielten Commits gepusht und abschliessend durch beide Implementierungen als `30/30 current` sowie zusammen mit Level-0 als `31/31` clean und remote-paritaetisch bestaetigt. |
| 2026-07-13 | Plattformuebergreifender Wartungsorchestrator | 62 | — | — | Je einen zentralen Bash- und PowerShell-7-Orchestrator fuer die komplette Level-0-/Level-1-/Level-2- und Maschinenwartung ergaenzt. Standardlaeufe aktualisieren nur per Fast-forward, synchronisieren die lokale Home-Baseline, pflegen Registry und Required-Toolchain und pruefen die kanonische Wartungspaket-Verteilung; Check-only, Vorschau, Scripts-only, optionale Pakete und ausdrueckliche Drift-Reparatur sind getrennte Modi. Lock, lokale Logs sowie Dirty-, detached-HEAD-, fehlender-Upstream-, Ahead-/Diverged- und No-Commit/No-Push-Gates dokumentiert; Registry-Wartungsscans bewahren nun zusaetzlich kuratierte Repository-Rollen. Isolierte lokale Bare-Remote-Tests fuer Fast-forward, Check-only ohne Pull, Dirty-/Ahead-Schutz, Reparatur mit Exit `3`, kanonische Home-Pfade und Bash-/PowerShell-Paritaet bestanden. |
| 2026-07-14 | `autonomous-run-governance` v0.1.3/v0.1.4 Gate-Evidence-Haertung | 63 | 247 929 | 462 | Zwei unabhaengige TuiVision-Feldfunde in v0.1.3 als maschinenlesbare Gate-Requirements, exakte HEAD-Evidence sowie read-only Bash-/PowerShell-Validatoren produktisiert. Home-PRs #62/#63, oeffentliche Preset-PRs #3/#4, Release und exakter Tag-ZIP-Smoke fuer v0.1.4 sowie die TuiVision-Adoption in PR #76 sind abgeschlossen; der Upstream-Nachweis steht in `github/spec-kit#3499`. Beim TuiVision-Dogfooding verlor der installierte Bash-Validator erwartbar das Git-Ausfuehrungsbit; v0.1.4 standardisiert deshalb ohne Schema- oder Autoritaetsaenderung `bash <validator.sh>` und `pwsh -NoProfile -File <validator.ps1>`. Der begrenzte v0.1.4-Patch umfasst vor Statistikpflege `+142/-58`, also 84 Nettozeilen; konservative Manualreferenz `1,8` Tage beziehungsweise `13,8` Stunden, Thorsten-Solo `1,4` Tage beziehungsweise `11,1` Stunden. Sieben-Preset-Komposition, installierter Modus `0644`, beide Interpreterpfade, eindeutige Agent-Oberflaechen und unveraenderte Berechtigungsgrenzen sind nachgewiesen; Feature 028 ist freigegeben, aber nicht gestartet. |
| 2026-07-14 | PSScriptAnalyzer Required-Baseline | 63 | — | — | PSScriptAnalyzer `1.25.0` als versionsgebundenes Required-PowerShell-Modul fuer macOS, Linux und Windows eingefuehrt; gemeinsame Modul-Registry, CurrentUser-Pflege, repositoryweiter Analyzer-Runner und dreiplattformiges CI-Gate ergaenzt. 718 Bestandswarnungen wurden fachlich bewertet: repositorybedingte Stilregeln sind eng dokumentiert ausgeschlossen, waehrend Korrektheits- und Sicherheitsregeln blockierend bleiben; alle verbleibenden echten Befunde wurden behoben und 59 getrackte PowerShell-Artefakte lokal mit null Befunden verifiziert. Wartungsskripte, Plattformtests, README, Manpages, Agenten-Guidance, Templates und 30-Repo-Propagationsmanifest wurden synchron fortgeschrieben. |
| 2026-07-14 | `autonomous-run-governance` v0.2.0 Lifecycle-Haertung | 63 | — | 469 | Einen realen unerwarteten Unterbrechungs- und Benutzerstopp-Fall aus TuiVision Feature 028 als geschuetztes Lifecycle-Modell produktisiert: lesender Status, kooperativer Graceful Stop, explizit autorisierte Wiederaufnahme, sechs validierte Zustaende und `NeedsRevalidation` fuer unklare Operationen. Home-Baseline-PR #65, oeffentlicher Preset-PR #5, Tag/Release v0.2.0 und TuiVision-Adoptions-PR #78 sind gemergt; exakter Tag-ZIP-SHA-256 und Sieben-Preset-Komposition sind nachgewiesen. Der Implementierungscommit umfasst `+1769/-57`, also 1712 Nettozeilen in kanonischem und publizierbarem Preset, vier portablen Lifecycle-/Gate-Validatoren, fuenf Commands, Runbooks, Templates, Agent-Guidance und Feld-Workitem. Konservative Manualreferenz: `22,1` Tage beziehungsweise `172,5` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `17,7` Tage beziehungsweise `138,0` Stunden bei 100 Zeilen/Tag. Feature 028 bleibt vor der Implementierung pausiert; echter Resume-Feldnachweis und Community-Catalog-Folgeissue bleiben bis zur ausdruecklichen Freigabe zurueckgestellt. |
| 2026-07-15 | `autonomous-run-governance` v0.2.1 Resume-Delta-Haertung | 63 | — | 470 | Den echten Feature-028-Resume-Feldnachweis als eng begrenzte Pflichtregel-Migration produktisiert: nach Preset- oder Governance-Drift werden aktuelle Korrektheits-, Sicherheits-, Berechtigungs- und Evidenzpflichten mit akzeptierten Plan-, Task- und Checklist-Artefakten abgeglichen; nur anwendbare fehlende Regeln werden in-place ergaenzt und erneut analysiert, reine Effizienzpraeferenzen bleiben retrospektiv. Der Kandidat umfasst `+268/-74`, also 194 Nettozeilen in kanonischem und publizierbarem Preset, Agent-/Constitution-Paritaet, AR-028-03 und Paketledger. Spec Kit 0.12.11, Sieben-Preset-Komposition, 18 Contributions, Lifecycle-Operationen, beide Validatorpaare sowie das Mandatory-/Efficiency-Fixture sind lokal gruen. Copilot Legacy-Agent/Prompt ist nachgewiesen; die fehlende Custom-Preset-Command-Generierung im neuen Copilot-Skills-Modus bleibt als externer CLI-Kompatibilitaetspunkt offen. Konservative Manualreferenz: `3,4` Tage beziehungsweise `26,8` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `2,7` Tage beziehungsweise `21,4` Stunden bei 100 Zeilen/Tag. Home-Baseline-PR #67, oeffentlicher Preset-PR #6, Release v0.2.1 mit geprueftem Tag-ZIP und TuiVision-Adoptions-PR #81 sind abgeschlossen; Feature 029 bleibt ungestartet. |
| 2026-07-15 | Manifestgesteuerter Home-Sync und Sandbox-Grenze | 64 | — | — | Lokale Betriebskopie `~/` von rekursivem Overlay auf Git-getracktes Manifest, SHA-256-/Dateimodus-Provenienz, Preflight-Konfliktschutz, kontrollierte Altdatei-Bereinigung und pfadbegrenzte Home-Commits umgestellt; selektive Spec-Kit-Agentenflaechen aufgenommen, Check-only in den Wartungsorchestrator integriert und den dauerhaften persoenlichen Level-0-Fork dokumentiert. ABS-DD nutzt die eingebettete oder gemountete Referenz direkt; schreibende Home-Sync-Laeufe nach `/home/adedev` sind gesperrt. Isolierte Bash-/PowerShell-Tests fuer Erstlauf, Idempotenz, Konflikt, Force, Stale Cleanup, lokale Ausschluesse und fremde staged Aenderungen bestanden. |

---

## Gesamtstand des Repositories / Repository Snapshot

Stand / As of: **2026-07-12**

| Kategorie / Category | Dateien / Files | Zeilen / Lines | Anteil / Share |
|---|---:|---:|---:|
| Skripte / Scripts (`.sh`, `.ps1`, `.py`) | 112 | 27 421 | 11.3 % |
| Strukturierte Konfiguration und Templates / Structured config and templates | 66 | 4 417 | 1.8 % |
| Dokumentation / Documentation (`.md`, `LICENSE`, `.txt`) | 1 134 | 185 089 | 76.0 % |
| Daten und Medien / Data and media (`.csv`, `.sql`, `.pdf`, `.pptx`) | 12 | 26 625 | 10.9 % |
| Sonstiges / Other | 0 | 0 | 0.0 % |
| **Gesamt / Total** | **1 324** | **243 552** | **100 %** |

### Aufgliederung Dokumentation / Documentation Breakdown

| Untertyp / Subtype | Zeilen / Lines | Anteil an Doku / Share of Docs |
|---|---:|---:|
| Spec-Kit-Artefakte (`specs/`) | 28 323 | 15.3 % |
| Secure Development (`docs/secure-development/`) | 32 935 | 17.8 % |
| Lernmaterialien und Lernreihen-Intakes (`docs/learning-units/`) | 84 553 | 45.7 % |
| Governance (AGENTS / CLAUDE / GEMINI / constitution / Copilot) | 4 288 | 2.3 % |
| README / CHANGELOG / STATS / Projektstatistik | 4 051 | 2.2 % |
| Sonstige Markdown-Artefakte / Other Markdown artifacts | 30 939 | 16.7 % |

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
| 7 | autonomous — Feld-Inputs 018-024 + Preset v0.1.0 | 9 639 | 7 | 1 | 2026-07-12 |

**Hinweis zu spaeteren Maintenance-Runden:** Die Snapshot- und Gesamtwerte oben
enthalten auch die nachfolgenden Maintenance-Arbeiten bis `2026-07-11`. Dazu
gehoeren insbesondere die Verfassungs- und Agenten-Guidance-Runden, Release-
Please-Aktualisierungen, die Preset-Governance-Arbeit und die sichere-
Entwicklung-Basis mit mitgeltenden Dokumenten.

*Note on later maintenance rounds: the snapshot and overall values above also
include follow-up maintenance work through `2026-07-11`, especially constitution
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

Das optionale siebte Preset liegt mit maschinenlesbaren Acceptance-Gates,
exakter HEAD-Evidence und einem validierten Laufzustand vor. v0.2.1 ergänzt
den echten Resume-Feldnachweis um den begrenzten Abgleich neuer zwingender
Regeln mit akzeptierten Plan-, Task- und Checklist-Artefakten, ohne aus dem
gespeicherten Zustand neue Remote-Berechtigung abzuleiten. Der exakte Tag-ZIP
ist in TuiVision adoptiert. Der Community-Catalog bleibt bis zum vereinbarten
gebündelten Pre-Wave-5-Update auf dem zuletzt eingereichten Stand.

*This closing block is based on the current repository snapshot plus the
documented main phases and maintenance rounds from the sections above.*

*Version v0.2.1 adds the bounded reconciliation of new mandatory rules with
accepted Plan, Tasks, and checklist artifacts to the real resume field proof,
without deriving current remote authority from stored history. The exact tag
ZIP is adopted in TuiVision. The Community Catalog remains at its last submitted
version until the agreed bundled pre-Wave-5 update.*

| Kennzahl / Metric | Verdichteter Gesamtblick / Condensed Overview |
|---|---:|
| Artefaktbasis gesamt / Total artifact base | `247 929` Zeilen |
| Operativer Code und Konfiguration / Operational code and configuration | `32 511` Zeilen (`13.1 %`) |
| Dokumentationsanteil / Documentation share | `185 954` Zeilen (`75.0 %`) |
| Beobachtbarer Projektzeitraum / Observable project window | `2026-03-31` bis `2026-07-14` |
| Sichtbare Git-Aktivtage / Observable active days | `63` |
| Git-Commits gesamt / Total commits | `462` |
| Git-Commits pro Aktivtag / Commits per active day | `7.3` (`462 / 63`) |
| Zeilen pro Aktivtag / Lines per active day | `3 935.4` (`247 929 / 63`) |
| Zeilen pro Commit / Lines per commit | `536.6` (`247 929 / 462`) |
| Konservative Einzelentwickler-Untergrenze | `3 099.1` Arbeitstage / `24 173.1` Stunden |
| Thorsten-Solo-Untergrenze (Scripting-Infra, 100 Z./Tag) | `2 479.3` Arbeitstage / `19 338.5` Stunden |
| Kleines 3er-Team mit Koordinationsaufschlag | `1 239.7` Arbeitstage |
| Repo-weiter Speedup gg. 80-Zeilen-Referenz | `49.2x` |
| Repo-weiter Speedup gg. Thorsten-Referenz (100 Z./Tag) | `39.4x` |

Kurzfazit:
`home-baseline` bleibt dokumentations- und Governance-getrieben: `75.0 %` der
sichtbaren Basis liegen in Markdown-Artefakten. Operative Skripte und
strukturierte Konfiguration machen zusammen `13.5 %` aus. Der groesste
dokumentierte Volumensprung bleibt Phase `1` (Spec-Kit-Batch fuer Homogeneity
Guardian). Die aktuelle Maintenance-Runde aktualisiert die verwalteten
Workspace-Repositories, nimmt zwei weitere Secure-Trader-Lernreihen mit zwoelf
MSL-Sprachrepos in den lokalen Betrieb auf und schliesst deren
Secure-Development-/GSDB-Vorbereitung ab. Google Antigravity ersetzt dabei die
abgeloeste Gemini CLI in der macOS-/Windows-Toolchain; Linux dokumentiert die
fehlende offizielle Paketierung als `N/A`. Die Beschleunigungsfaktoren
beschreiben keine Stoppuhrzeit, sondern sichtbare Lieferdichte gegen
konservative manuelle Referenzmodelle.

*Short summary: `home-baseline` remains documentation- and governance-driven:
`75.0 %` of the visible base sits in Markdown artifacts. Operational scripts
and structured configuration together account for `13.5 %`. The largest
documented volume jump remains Phase `1` (Spec-Kit batch for Homogeneity
Guardian). The current maintenance round updates the managed workspace
repositories, brings two additional Secure Trader series with twelve MSL
language repositories into local operations, and completes their secure-
development and GSDB preparation. Google Antigravity replaces the retired
Gemini CLI in the macOS and Windows toolchains; Linux records the missing
official package as `N/A`. Acceleration factors describe visible delivery
density, not stopwatch measurements.*

### ASCII-Diagramme / ASCII Charts

```text
Artefaktmix nach aktuell dokumentiertem Snapshot (Zeilen)
Skripte         | ###                            | 27 423 | 11.3 %
Konfiguration   | #                              |  4 417 |  1.8 %
Dokumentation   | ######################         |185 143 | 76.0 %
Daten/Medien    | ###                            | 26 625 | 10.9 %
Sonstiges       |                                |      0 |  0.0 %
```

Dieses Diagramm zeigt, wie der aktuelle Snapshot zwischen Skripten,
strukturierter Konfiguration, Dokumentation, Daten/Medien und sonstigen
Artefakten verteilt ist. Dokumentation bildet weiterhin den Schwerpunkt; die
getrennte Ausweisung der Daten- und Medienartefakte verhindert, dass
generierte Lernreihen-Datensaetze dem operativen Code zugerechnet werden.

*This chart shows the split between scripts, structured configuration,
documentation, data/media, and other artifacts in the current snapshot.
Documentation remains the main share; listing data and media separately avoids
counting generated learning-series datasets as operational code.*

```text
Phasenvolumen nach dokumentierter Netto-Basis (Insertions)
0 Init    | #                        |    954
1 001+    | ######################## | 26 519
2 pub     | #####                    |  6 168
3 CI+003  | #                        |  1 523
4 005+    | ##########               | 10 769
5 proj    | #                        |    686
6 presets | ########                 |  8 733
7 autonom | #########                |  9 639
```

Dieses Diagramm zeigt den Netto-Insertions-Beitrag der dokumentierten Phasen.
Phase `7` umfasst die sechs Feld-Inputs und den v0.1.0-Release-Candidate fuer
das autonome Governance-Preset.

*This chart shows the net insertion contribution per documented phase. Phase `6`
is the largest visible package after Phase `4`. Phase `7` contains all six
field inputs and the v0.1.0 release candidate for the autonomous governance
preset.*

```text
Konservative Handarbeits-Referenz je dokumentierter Phase (Arbeitstage, 80 Z./Tag)
0 Init    | #                        |   11.9 d
1 001+    | ######################## |  331.5 d
2 pub     | ######                   |   77.1 d
3 CI+003  | ##                       |   19.0 d
4 005+    | ##########               |  134.6 d
5 proj    | #                        |    8.6 d
6 presets | ########                 |  109.2 d
7 autonom | ###########              |  120.5 d
```

Jeder Balken zeigt, wie viele Arbeitstage ein erfahrener Einzelentwickler
bei `80` manuell erstellten Zeilen pro Tag fuer das jeweilige Phasenpaket
benoetigt haette. Die Preset-Phase entspricht konservativ gut `109`
Arbeitstagen sichtbarem Governance-Output.

*Each bar shows how many workdays an experienced solo developer would have needed
at `80` manually created lines per day for the respective phase package. The
preset phase conservatively represents about `109` workdays of visible
governance output; the complete autonomous package represents about `120`
days.*

```text
Dokumentierte Beschleunigungsfaktoren (Phasen-Speedup vs. 80-Zeilen-Referenz)
Repo ges. | ################################################ | 49.9x
0 Init    | ############                     | 11.9x
1 001+    | >> Spec-Kit-Batch: 331.5x (ausserhalb Skala)
2 pub     | ################################# | 38.6x
3 CI+003  | ######                           |  6.3x
4 005+    | ################################################ | 67.3x
5 proj    | ########                         |  8.6x
6 presets | ################################################ | 54.6x
7 autonom | >> complete field package: 120.5x (outside scale)
```

Hier werden keine Stoppuhrzeiten gemessen. Verglichen wird die dokumentierte
Lieferdichte pro Aktivtag gegen die 80-Zeilen-Referenz. Phase `6` ist hoch,
weil mehrere Preset-Folge-Releases, externe Preset-Repos und Smoke-Test-Runden
in zwei sichtbaren Preset-Aktivtagen abgeschlossen wurden. Phase `7` buendelt
sechs Feldlaeufe und die Produktisierung an einem sichtbaren Handoff-Tag.

*This chart does not measure stopwatch time. It compares documented delivery
density per active day against the 80-line reference. Phase `6` is high because
multiple preset follow-up releases, external preset repositories, and several
smoke-test rounds were completed in two visible preset active days. Phase `7`
bundles six field runs and productization into one visible handoff day.*

```text
Vergleich dokumentierter Gesamtaufwand / sichtbares KI-Lieferfenster
Erfahren (80 Z./Tag)   | ######################## | 3 045.1 d / 23 751.7 h
Thorsten (100 Z./Tag)  | ###################      | 2 436.1 d / 19 001.4 h
KI sichtbar            | #                        |    61.0 d
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
X/Y-Diagramm: Phasenvolumen (X = Phase 0..7, Y = Insertions)
30000 |                                |
25000 |     *                          |
20000 |                                |
15000 |                                |
10000 |                 *       *   *  |
 5000 |         *                      |
    0 | *           *       *          |
      +--------------------------------+
        0   1   2   3   4   5   6   7
```

Als zweite Ansicht zeigt diese X/Y-Kurve denselben Verlauf ueber die
Phasenachse. Die X-Positionen nutzen feste Slots, damit spaetere zweistellige
oder fehlende Phasenwerte keine Punkte verschieben. Phase `1` ragt deutlich
heraus; Phase `6` bildet den Governance-Preset-Nachlauf und Phase `7` das
vollstaendige autonome Paket.

*As a second view, this X/Y curve shows the same progression across the phase
axis. The X positions use fixed slots so later two-digit or missing phase values
do not shift points. Phase `1` stands out clearly; Phase `6` contains the
governance preset follow-up and Phase `7` the complete autonomous package.*
