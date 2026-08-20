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
| 2026-07-16 | `autonomous-run-governance` v0.2.2 Bedien- und Zustandsvertrag | 64 | — | 472 | Den Feature-029-Feldnachweis in ein ausfuehrliches, bilinguales CEFR-B2-Bedienhandbuch fuer Lernende und Maintainer ueberfuehrt: Zweck, Zielgruppen, Liefermodi, Konvergenz, Installation, vollstaendige Prompt-Beispiele, Status, Stop, Resume, Run-State-/Exact-Head-Evidence, Retrospektive, Lernreihenfolge und Fehlersuche. Die Paketvalidierung entdeckte zusaetzlich reproduzierbar, dass die lesbare Skill-Ueberschrift `Deliver` in Feature 029 als ungueltiger Maschinenzustand gespeichert worden war. v0.2.2 haelt die Validatoren streng und schreibt fuer Remote-Closeout eindeutig `Publish`, `Review` oder `MergeAndSync` vor. Der Kandidat umfasst vor diesem Ledger-Eintrag `+1175/-161`, also 1014 Nettozeilen ueber kanonisches und publizierbares Preset, Agent-/Constitution-Paritaet, AR-029-Workitems und Paketledger. Spec Kit 0.12.11, Sieben-Preset-Dev-Installation, 18 Contributions, Resolve, Disable/Enable/Remove/Reinstall, fuenf eindeutige Codex-Skills, beide Exact-Head-Validatoren sowie gueltige und ungueltige Stage-Fixtures sind lokal gruen. Konservative Manualreferenz: `14,7` Tage beziehungsweise `114,6` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `11,8` Tage beziehungsweise `91,7` Stunden bei 100 Zeilen/Tag. Home-Baseline-PR #70, oeffentlicher Preset-PR #7, Release `v0.2.2` mit gepruefter Tag-ZIP und TuiVision-Adoption PR #85 sind abgeschlossen; Feature 030 wurde nicht gestartet. |
| 2026-07-16 | `autonomous-run-governance` v0.2.2 Hard-Abort-/Resume-Feldtest | 64 | — | — | Einen isolierten Spec-Kit-0.12.11-Lauf mit voller Sieben-Preset-Matrix, `LocalImplementation` und ohne Git-Remote nach `HARD_ABORT_READY` ueber die Codex-Oberflaeche abgebrochen. Der Kindprozess schloss Attempt 1 danach erfolgreich ab, waehrend der persistierte Zustand bei `Active` 13/30 und die Tasks bei 15/30 standen. Read-only Status klassifizierte effektiv `Interrupted`, veraenderte keinen Hash, und der allgemeine autonome Command verweigerte die implizite Fortsetzung. Explizites Resume revalidierte lokale Autoritaet, pruefte Completed-Marker und bytegenaues Ergebnis, startete keinen zweiten Attempt und endete mit `Retrospective`, `Completed`, 30/30 sowie zwei gruenen State-Validatoren. Retrospektive `NoPromotion`: v0.2.2 deckt State-, Evidence-, Duplicate-Work- und Berechtigungsgrenzen bereits ab; nur eine lokale EOF-Formatkorrektur war noetig. Kein v0.2.3-, Release-, Adoptions- oder Community-Issue-Update erforderlich; Feature 030 bleibt bis zu einem separaten Auftrag ungestartet. |
| 2026-07-17 | Verbindliche Spec-Kit-Standard-Siebenermatrix | 65 | — | 484 | `autonomous-run-governance` v0.2.2 als siebtes Standard-Preset in zentraler Matrix, Installern, Registry-Profil, Constitution, Agenten-Dateien, Templates, Secure-Development-Basis 3.1.0 und Lernreihen verankert. Das bisherige Profil `standard-six-governance-presets` bleibt als deprecated Kompatibilitaetsalias mit exakt identischer Preset-Matrix erhalten. Installation erteilt weiterhin weder autonome Ausfuehrungs- noch Remote-, Merge-, Bypass- oder Provider-Berechtigungen. Bash-/PowerShell-Syntax, Generatoren, Matrixparitaet, Manifest und isolierte Neuinstallation samt Idempotenz sind geprueft; der Bash-Installer erkennt zusätzlich normale Klone und verknüpfte Git-Worktrees über `git rev-parse --git-dir`. |
| 2026-07-18 | `parallel-autonomous-run-governance` v0.1.0 und nativer Real-Agent-Smoke | 66 | — | — | Experimentelles achtes Preset mit vier Topologien, UUID-Vertraegen, isolierten Worktrees, maximal drei parallelen Workern, DAG-Pruefung, gehashten Handoffs, kooperativem Stop/Resume und expliziter Alternativauswahl umgesetzt. Der vom Repository-Eigentuemer bewusst autorisierte native macOS-Entwicklungs-Smoke fuehrte 13 echte Codex-/Spec-Kit-Autonomous-Worker ohne Remote-Schreibzugriff aus: 13/13 Exitcode 0, Replicated/Independent/Alternative jeweils beobachtete Parallelitaet 3, Pipeline `A -> {B,C} -> D` mit Parallelitaet 2 und vier validierten Handoffs. Kanonisches Preset, Publikationskopie und Feature-Artefakte umfassen vor dieser Ledger-Zeile 4.180 Zeilen; konservative Manualreferenz `52,3` Tage beziehungsweise `407,6` Stunden bei 80 Zeilen/Tag, Thorsten-Solo `41,8` Tage beziehungsweise `326,0` Stunden bei 100 Zeilen/Tag. Das Preset bleibt bis zum nativen Secure-CaseTracker-Feldtest experimentell und opt-in; Container-First bleibt ausserhalb dieses ausdruecklichen Entwicklungs-Overrides verbindlich. |
| 2026-07-19 | `parallel-autonomous-run-governance` v0.2.0 und 24-Worker-Feldtest | 68 | 267 166 | 500 | Native Secure-CaseTracker-Kampagne `91c2c1a0-1526-479a-b8a3-e36a7d15d2b1` ueber C#, Go, Java, Python, Rust und Swift kontrolliert abgeschlossen: 24/24 Worker und exakte PR-Heads gemergt, sechs Closeout-PRs einschliesslich Lastenheft-Archivierung abgeschlossen sowie sprachspezifische Hauptbranch-Gates bestanden. Stop, Status, Resume und zweiter idempotenter Resume-Versuch wurden praktisch nachgewiesen; konfigurierte und beobachtete Parallelitaet blieben bei drei. Die portablen Erkenntnisse flossen in Schema 1.1, pro-Worker-Runnerprofile, agentenneutrale Modellmetadaten, providergebundene Preflights, fortsetzbare Teilmerges, gestapelte PR-Basen, kooperativen Konsolidierungsstopp und manifestgebundene Post-Merge-Aktionen ein. v0.2.0 ist im geschuetzten Preset-Repo veroeffentlicht, per exaktem Tag-ZIP isoliert mit allen acht Presets validiert, lokal in 25 registrierten Level-2-Repositories ausgerollt und als `github/spec-kit#3591` eingereicht. Der v0.2.0-Arbeitsstand umfasst vor dieser Ledger-Zeile `+5994/-671`, also 5323 Nettozeilen; konservative Manualreferenz `74,9` Tage beziehungsweise `584,4` Stunden fuer hinzugefuegte oder aktualisierte Zeilen, Thorsten-Solo `59,9` Tage beziehungsweise `467,5` Stunden. Der native Entwicklungs-Override endet mit diesem Closeout; spaetere Secure-Trader-Kampagnen unterliegen wieder Container-First. |
| 2026-07-19 | Standard-Achtermatrix als 33-Repository-Flottenrollout | 68 | 286 594 | 503 | Die Standard-Achtermatrix auf Level 0, alle sieben registrierten Level-1-Repositories und alle 25 registrierten Level-2-Repositories ausgerollt; bestehende Sechser-/Siebenerprofile als Kompatibilitaetsaliase migriert und aktuelle Dokumentation vollstaendig auf acht Presets geprueft. Portable Feld- und Rollout-Erkenntnisse wurden in alle sieben bestehenden Presets uebernommen und zusammen mit `parallel-autonomous-run-governance` als Patch-Releases veroeffentlicht. 33/33 lokale Preset-, Parser-, Matrix-, Drift- und Idempotenzpruefungen bestanden; alle PR-Heads waren exakt, alle Copilot-Threads beantwortet und geschlossen. GitHub Actions lief in einzelnen Repositories wieder real und erfolgreich, waehrend die verbliebenen Null-Schritt-Ablehnungen weiterhin den identischen Billing-/Spending-Limit-Providergrund meldeten und deshalb gemaess Feldtest-Override als `N/A`, nicht als technischer Erfolg, dokumentiert wurden. Der Flottenbranch umfasst einschliesslich dieser Ledger-Zeile `+20917/-1452`, also 19 465 Nettozeilen. Konservative Manualreferenz: `243,3` Tage beziehungsweise `1 897,8` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `194,7` Tage beziehungsweise `1 518,3` Stunden bei 100 Zeilen/Tag. |
| 2026-07-19 | ASCII-Statistikprofil 2 Toolchain und Level-0-Migration | 67 | 284 814 | 511 | Reproduzierbaren PowerShell-7-Renderer mit Bash-Einstieg, JSON-Schema, Repository-Konfiguration, 52-Wochen-Heatmap, Wochen- und kumulativem Volumen, festen Phasenslots, Monatsfallback, ASCII-Gauges und bilingualer Textalternative eingefuehrt. Bootstrap, Homogeneity-Pruefung, Propagationsmanifest, Constitution, fuenf Agentenflaechen, Vorlagen, README und Manpage wurden synchron aktualisiert; historische Gesamtstatistik blieb als Profil-1-Archiv erhalten und `STATS.md` wurde ohne Aenderung von Scores, Zeitstempeln oder Reihenfolge auf `#` normalisiert. 146 deterministische Assertions pruefen unter anderem leere Aktivitaet, Binaerdaten, Umbenennungen, Statistik-only-Commits, ungueltige Konfigurationen, 49 Phasen, Idempotenz, `>500x`, Dry-Run-Ausgabe im aktuellen Zustand, Bootstrap-Commit-Trailer, explizite PowerShell-7-Diagnose und bytegleiche Bash-/PowerShell-Ausgabe. Der Toolchain-Commit umfasst `+3235/-63`, also 3172 Nettozeilen; konservative Manualreferenz fuer 3235 hinzugefuegte oder aktualisierte Zeilen: `40,4` Tage beziehungsweise `315,4` Stunden, Thorsten-Solo: `32,4` Tage beziehungsweise `252,3` Stunden. Aktivtage und Textbasis folgen erstmals durchgehend Methodik v2 und sind deshalb nicht unmittelbar mit den vorherigen Profil-1-Zeilen vergleichbar. Der Homogeneity-Workflow laedt die vollstaendige Git-Historie, damit der synthetische PR-Merge-Commit dieselbe reproduzierbare Statistik wie der Branch-Head validiert. Die Copilot-Hinweise zu PowerShell-Synopsis und Bootstrap-Anzeigename sind umgesetzt; ein gepufferter, kompilierter Dateiscanner beschleunigt besonders die Windows-Validierung, ohne den Datenvertrag zu aendern. Der Windows-Workflow verwendet entsprechend der OS-Regel die native PowerShell-7-Homogeneity-Pruefung statt Git Bash. Homogeneity unterscheidet Renderer-Drift, Validierungs-/Toolingfehler und unerwartete Exitcodes nun in beiden Skriptvarianten eindeutig. Die abschließende Review-Runde harmonisiert außerdem den Dry-Run-Vertrag, Commit-Trailer und die Diagnose eines fehlenden `pwsh`. |
| 2026-07-20 | Preset-7-/Preset-8-Handbuecher und Dokumentations-Releases | — | — | — | `autonomous-run-governance` v0.3.1 und `parallel-autonomous-run-governance` v0.2.2 als Dokumentations-Patch-Releases veroeffentlicht. Zwei kompakte README-Einstiege, 17 ausfuehrliche Handbuch- und Indexdateien, 14 GitHub-gerenderte Mermaid-Diagramme mit vollstaendigen DE-/EN-Textalternativen und ein Feldnachweis-Index machen Einzel- und Parallelbetrieb nachvollziehbar. Der bestehende Produktionsvertrag `Preset 8 -> Preset 7 >=0.2.2 je Worker` ist nun in Doku, Constitution, Matrix, Guidance, Vorlagen und deterministischen Fixtures verbindlich sichtbar. Exakte Public-PR-Heads, Tags, Archive, SHA-256, Mermaid-Syntax, Hell-/Dunkel-Darstellung, Pandoc-Lesereihenfolge, Lychee, PSScriptAnalyzer, Coordinator-/Consolidation-Tests sowie ein isolierter Acht-Preset-Installations-, Resolve-, Idempotenz- und Remove/Reinstall-Smoke wurden verifiziert; Commands, Skripte, Templates, Schemas und Berechtigungsverhalten blieben unveraendert. |
| 2026-07-20 | Preset-7-/Preset-8-Dokumentations-Patches: Flottenabschluss | — | — | — | Die Dokumentations-Releases auf Level 0, alle sieben Level-1- und alle 25 Level-2-Repositories ausgerollt und ueber die noch offenen 31 PRs kontrolliert abgeschlossen. Vor jedem Admin-Bypass wurden exakter Head, Mergefaehigkeit, Checks und aktuelle Review-Threads erneut geprueft. 25 private Repositories zeigten in den neuesten Current-Head-Laeufen 117 verifizierte Null-Schritt-Jobs ohne Runner und mit 25/25 identischen Billing-/Spending-Limit-Annotationen; diese blieben Provider-`N/A`. Drei oeffentliche Claude-Review-Jobs scheiterten nach Runner-Start ohne Reviewbefund, waehrend alle technischen Checks gruen waren. Der vollstaendige `cc65`-Build bestand unter Linux und Windows; der fremd geaenderte Original-Worktree blieb unangetastet. Nach den Merges bestanden 33/33 exakte Preset-, Propagations-, Statistik-, Clean-Tree- und Remote-Paritaetspruefungen. |
| 2026-07-20 | Lastenheft fuer plattformuebergreifende Ein-Kommando-Wartung | 68 | — | — | Neuen aktiven Spec-Kit-Intake fuer macOS, Linux/Ubuntu und Windows angelegt und den aelteren prueforientierten Intake als historischen Vorgaenger eingeordnet. Der Sollvertrag umfasst Bash-3.2-No-op-Regression, Desired-State-Fleet-Manifest, sicheres Clone-on-missing, fortsetzbare Stufen, optionale Formeln, administratorpflichtige Deferred-Befunde, leise Git-Ausgabe und JSON-Abschlussbericht. Zwei alternative Prompts bereiten einen schrittweisen Specify-Lauf oder einen vollstaendigen autonomen Lauf mit explizit begrenzter `MergeAndSync`-Autoritaet vor; kein Spec-Kit-Lauf wurde gestartet. Das fachliche Dokumentationsdelta vor Statistikpflege umfasst `+722/-2`, also 720 Nettozeilen. Konservative Manualreferenz fuer 722 hinzugefuegte oder aktualisierte Zeilen: `9,0` Tage beziehungsweise `70,4` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `7,2` Tage beziehungsweise `56,3` Stunden bei 100 Zeilen/Tag. |
| 2026-07-20 | Lastenheft fuer die Agentic-Workspace-Wartungs-TUI | 69 | — | — | Entscheidungsvollstaendigen, durch den Wartungsvorgaenger hart gesperrten Spec-Kit-Intake fuer eine plattformuebergreifende Spectre.Console-TUI angelegt. Der Vertrag bewahrt den argumentlosen Headless-Lauf ohne TTY, startet interaktiv mit vorausgewaehltem Dry-run, delegiert jede Wartungsaktion an Bash beziehungsweise PowerShell und definiert JSONL-Ereignisse, content-adressierten Build-Cache, Plaintext-Fallback, Exitcodes, sichere Prozessargumente sowie barrierearme ASCII- und Screenreader-Ausgabe. Abarbeitungsposition 25 folgt zwingend auf den Plattform-Wartungsintake; Specify- und Autonomous-Prompt stoppen bei fehlender Vorgaenger-Evidenz vor jeder Feature- oder Repository-Aenderung. Kein Spec-Kit-Lauf wurde gestartet. Das fachliche Dokumentationsdelta vor Statistikpflege umfasst 679 Nettozeilen. Konservative Manualreferenz: `8,5` Tage beziehungsweise `66,2` Stunden bei 80 Zeilen/Tag; Thorsten-Solo: `6,8` Tage beziehungsweise `53,0` Stunden bei 100 Zeilen/Tag. |
| 2026-07-20 | Aktive Lastenheft-Queue repriorisiert | — | — | — | Die plattformuebergreifende Ein-Kommando-Wartung und ihre abhaengige Spectre.Console-TUI von den bisherigen Positionen 24/25 auf 1/2 vorgezogen. Die verbleibenden aktiven Intakes unter Beibehaltung ihrer relativen Reihenfolge lueckenlos bis Position 11 neu nummeriert. Die zuvor auf Position 5 bis 18 gelisteten 14 Secure-CaseTracker-Lernreihen-Intakes aus der zentralen aktiven Queue entfernt; ihre Dateien und die gesamte Lernreihen-Dokumentation unter `docs/learning-units/` bleiben unveraendert erhalten. Der harte TUI-Vorgaenger-Gate verweist nun auf Eintrag 1. Kein Spec-Kit-Lauf wurde gestartet. |
| 2026-07-21 | Home-Sync v2 und agentisches Betriebslernen | — | — | — | 27 lokale Codex-Sessions dedupliziert ausgewertet und wiederverwendbare Regeln fuer Preset-Entwicklung, Unterbrechung/Resume, Evidence, Promotion und Flottenbetrieb versioniert. Home-Sync von 1.547 ausgewaehlten Quellartefakten auf 235 Host-Runtime-Dateien begrenzt; kanonische Dokumentation, Specs, Preset-Quellen und Evidence bleiben im dauerhaften Level-0-Klon. v1-State-Migration gibt 1.261 Altpfade ohne Loeschung frei, bewahrt lokale Abweichungen und erlaubt Entfernung nur ueber explizite Legacy-Cleanup-Pfade. Vier isolierte Migrations- und Konflikt-Fixtures sowie der veroeffentlichte OpenAI-Codex-Request `openai/codex#34582` fuer repositorybewussten sanitisierten Task-Handoff ergaenzt. Das fachliche Delta vor Statistikpflege umfasst 513 Nettozeilen. |
| 2026-07-21 | Optionales Intake-Review-Flottenprofil | 69 | — | — | Das optionale Preset `intake-review-governance` v0.1.0 als ausdruecklich gewaehltes Neunerprofil fuer Level 0 und die verwaltete Level-1-/Level-2-Flotte vorbereitet, ohne die oeffentliche Standard-Achtermatrix zu veraendern. Registry, Wartungsorchestratoren, Installationspruefung, gemeinsame Agenten-Guidance und Lernreihen-Paketierung unterscheiden nun explizit zwischen portabler Intake-Review-Policy und lokalen Review-Ergebnissen. Bash-/PowerShell-Paritaet, PSScriptAnalyzer, exakte Preset-Aufloesung und Paketvorschauen fuer alle drei Lernreihen-Familien sind gruen. Der Implementierungscommit umfasst `+1917/-38`, also 1879 Nettozeilen vor Statistikpflege. |
| 2026-07-21 | Intake-Review-Flottenabschluss | 69 | — | — | Das ausdruecklich optionale Neunerprofil in Level 0, sieben Level-1- und 25 Level-2-Repositories installiert und ueber 33 gemergte PRs abgeschlossen. Alle 33 Repositories tragen exakt neun Presets; die 21 Lernreihen-Repositories aus drei Familien sind vollstaendig enthalten, ohne einen Lernenden-Spec-Kit-Lauf zu starten. 119 reale Exact-Head-Checks waren gruen; 228 vor dem ersten Schritt abgewiesene Billing-/Spending-Checks blieben Provider-`N/A`. Null nicht-providerbedingte Fehler und null Review-Threads. Der fremd geaenderte `cc65`-Worktree blieb unangetastet; dessen Linux- und Windows-Volltests bestanden im isolierten Worktree. Das Closeout-Delta umfasst vor Statistikrendering 48 Nettozeilen. |
| 2026-07-21 | `intake-authoring-governance` v0.1.0 | 69 | — | — | Optionales Preset zur nachvollziehbaren Umwandlung geordneter direkter Texte, eingefuegter Planungen und explizit benannter UTF-8-Dateien in genau einen Spec-Kit-Intake samt Hash-Receipt veroeffentlicht. Zwei Commands, sieben Templates, Bash-/PowerShell-Validatorparitaet, maximal fuenf materielle Rueckfragen, gesperrte Entwuerfe, ausdrueckliche Update-Autoritaet und sicherer `LocalImplementation`-Default halten Authoring von Review und Ausfuehrung getrennt. Zehn-Preset-Dev- und Tag-ZIP-Smokes, fuenf Agentenoberflaechen sowie ein unabhaengiger Authoring-zu-Intake-Review-Nachweis ohne Remote oder nachgelagerten Run-State sind gruen. Release `v0.1.0` nutzt die gepruefte ZIP-SHA-256 `0aee506690ac2753ad683c751705c18cef60fa8c226a3d6da68733659ad83bb6`. Das Paketdelta umfasst vor Statistikrendering `+6502/-165`, also 6337 Nettozeilen. Die Standard-Achtermatrix und das bestehende Neunerprofil bleiben unveraendert; das neue Zehnerprofil ist opt-in. |
| 2026-07-22 | Ein-Kommando-Wartung gehaertet | — | — | — | Den macOS-Bash-3.2-No-op von `sync-home.sh` durch eine leere-array-sichere Schleife repariert und auf macOS sowie Linux im CI-Vertrag abgesichert. Ein zentraler Preset-Profilkatalog ersetzt duplizierte Orchestrator-Zuordnungen und laesst Registry-Eintraege bei unbekannten Profilen fail-closed scheitern. Die Homebrew-Registry klassifiziert MongoDB Community 8.0, Mono, SQLite und Telnet als optional; PowerShell wird als erforderliche Formel mit pruefbarem Link-Vertrag statt als Cask gefuehrt. Manpages, README, Skriptreferenz und plattformparitaetische PowerShell-Analyse wurden synchronisiert. |
| 2026-07-22 | Wartungshaertung: Flottenabschluss | — | — | — | Das kanonische Wartungspaket ueber 30 Level-1-/Level-2-Repositories mit jeweils eigenem PR ausgerollt. Alle Source- und Statistik-Commits wurden als Merge-Commits erhalten; dadurch blieben 30/30 Statistikprofile `CURRENT`. Sechs Repositories lieferten vollstaendige reale Checks einschliesslich `cc65`-Linux-/Windows-Build und `TuiVision`-Build-, Test-, SBOM-, Tooling- und DocFX-Suites. In 24 privaten Repositories starteten die Jobs wegen derselben Billing-/Spending-Limit-Annotation nicht und blieben Provider-`N/A`. Nach dem Merge sind alle 30 Repositories sauber, remote-paritaetisch, wartungspakethomogen und auf dem exakten Zehn-Preset-Profil. Check-only, Dry-run und der argumentlose Wartungslauf endeten mit Exitcode 0. |
| 2026-07-22 | Windows-Intake fuer Ein-Kommando-Wartungshaertung | — | — | — | Tracebaren, entscheidungsvollstaendigen Windows-Folgeintake mit Receipt aus neun realen Wartungsbefunden erstellt. Der Vertrag umfasst validierte Python-Fallbacks und Bootstrap-Reihenfolge, stabile WhatIf-Ermittlung, sichere phasenbasierte Wiederaufnahme, Erhalt des Zehn-Preset-Profils, Git-normalisierten Drift, begrenzte GitHub-Retries, WinGet-/UAC-Timeouts mit Prozessbereinigung und widerspruchsfreie Paketstatus. Der Intake steht als Position 2 vor der weiterhin hart gesperrten Wartungs-TUI. Kein Intake-Review-, Specify-, Autonomous- oder Remote-Lauf wurde gestartet. Das Authoring-Delta vor Statistikpflege umfasst `+593/-17`, also 576 Nettozeilen. |
| 2026-07-22 | Linux-/Ubuntu-Intake fuer Ein-Kommando-Wartungshaertung | — | — | — | Tracebaren, entscheidungsvollstaendigen Linux-/Ubuntu-Folgeintake mit Receipt aus vier realen Wartungsbefunden erstellt. Der Vertrag umfasst stdin-sichere Homebrew-Iteration, vollstaendige Paketstatus, fail-closed Required-Pruefung und Exitcodepropagation, einen sicheren automatisierten Swift-Installationsweg sowie einen isolierten interaktiven Homebrew-Regressionstest. Der Intake steht als Position 3 vor der nun von drei Wartungsvorgaengern hart gesperrten TUI. Kein Intake-Review-, Specify-, Autonomous- oder Remote-Lauf wurde gestartet. Das Authoring-Delta vor Statistikpflege umfasst `+654/-17`, also 637 Nettozeilen. |
| 2026-07-23 | Intake Creator v0.1.1 und aktive Lastenheft-Normalisierung | — | — | — | `intake-authoring-governance` rückwärtskompatibel um Schema 1.1 und den nachweisbaren Modus `LegacyAdoption` erweitert. Alle 14 aktiven Root-Intakes besitzen nun genau ein gültiges Receipt und genau einen Specify-/Autonomous-Prompt mit `LocalImplementation`: elf Git-Blob-gebundene Legacy-Adoptions, zwei reguläre Supersessions und ein neuer Intake. Linux-/Windows-Reihenfolge, das harte TUI-Gate über die Positionen 1 bis 4 und die aktuelle Zehner-Preset-Flottenkardinalität wurden konsolidiert. Bash-/PowerShell-Validatoren, Preset-Parität, PSScriptAnalyzer, Secret Scan und der unabhängige 14-Ziel-Serien-Review sind grün. Historische Root-Dateien und 222 Lernreihen-Intakes blieben unverändert. Das Delta vor Statistikpflege umfasst `+3413/-367`, also 3046 Nettozeilen. |
| 2026-07-23 | Intake Authoring Governance v0.1.1 veröffentlicht und in Level 0 adoptiert | — | — | — | Das öffentliche Preset wurde über PR #1 als v0.1.1 veröffentlicht. Die versionierte GitHub-ZIP hat SHA-256 `15d42670c4d2f1e29a591511a671edb75d4c0aaea0bca0b72d2dc37b8597a8ba` und bestand Installation, Disable/Enable, Remove/Reinstall, die vollständigen Bash-/PowerShell-Fixtures und eindeutige Codex-Skill-Erzeugung im Zehn-Preset-Stack. Home Baseline verwendet nun diese ZIP bei Priorität 64; Intake Review bleibt kompatibel auf v0.1.0 bei Priorität 65, die Standard-Achtermatrix und das Neunerprofil bleiben unverändert. Das Adoptionsdelta vor Statistikpflege umfasst 55 Nettozeilen. |
| 2026-07-23 | Intake Authoring Governance v0.1.1 Flottenabschluss | — | — | — | Die kompatible v0.1.1-Aktualisierung wurde in 33/33 Level-0-/Level-1-/Level-2-Repositories installiert und über 33 PRs gemergt; enthalten sind 21/21 Lernreihen-Repositories aus drei Familien, ohne einen Lernenden-Spec-Kit-Lauf zu starten. Alle lokalen Paket-, Zehner-Matrix-, Statistik-, Diff- und Secret-Prüfungen bestanden. 225 GitHub-Checks wurden vor dem ersten Schritt durch Provider-Billing oder Spending abgewiesen und nicht als technischer Pass gewertet; alle tatsächlich ausgeführten Remote-Gates waren grün, einschließlich der cc65-Builds unter Linux und Windows. Null umsetzbare Review-Threads. Community-Folgeissue `github/spec-kit#3676` dokumentiert Release, `LegacyAdoption` und die bestätigte Kompatibilität mit Intake Review Governance v0.1.0. Das Closeout-Evidence-Delta umfasst vor Statistikrendering 116 Nettozeilen. |
| 2026-07-23 | Aktive Level-2-Intakes mit Authoring und Review normalisiert | — | — | — | Intake Authoring v0.1.1 und Intake Review v0.1.0 wurden auf 241/241 aktive Lastenhefte in acht C#-Level-2-Repositories und cc65 angewendet. Neun geordnete Serien-Reviews endeten `Ready`, ohne offene Findings, Fragen oder akzeptierte Risiken und ohne einen späteren Spec-Kit-Lauf zu starten. Neun PRs wurden gemergt; alle ausgeführten Remote-Gates waren grün, Provider-Zero-Step-Abweisungen blieben ausdrücklich fehlende Remote-Evidence. Ein reproduzierbarer Folgebefund fordert die Bash-/PowerShell-paritätische Validierung des Series-Request-Graphen im Intake-Review-Preset. Das dauerhaft getrackte Kampagnen-Evidence-Delta vor Statistikpflege umfasst 188 Nettozeilen; nicht promovierte lokale Hilfsskripte bleiben bewusst außerhalb des Produktinventars. |
| 2026-07-23 | Intake Review Governance v0.1.1 Series-Graph-Härtung | — | — | — | Den reproduzierten Request-Graph-Befund mit einem hashgebundenen Schema-1.1-Vertrag geschlossen. Series-Reviews prüfen nun Request-Identität, Ziel- und Rollenmenge, exakte Reihenfolge, explizite Roots, eindeutige gerichtete Kanten, Vorgängerabdeckung und Zyklen in Bash und PowerShell mit stabilen Fehlerklassen; Single und Campaign 1.0 bleiben kompatibel. Eine Drei-Ziel-Serie, alle negativen Graph-Fixtures, LF/CRLF/BOM-Normalisierung, der unveränderte Secure-CaseTracker-Campaign-Test, die Zehn-Preset-Komposition sowie jeweils drei eindeutige Commands für Codex, Claude, Copilot Skills und Antigravity sind grün. Kanonischer Scaffold, Publikationskopie und lokale Preset-Kopie sind bytegleich. Der Paketquellen-Commit umfasst `+1892/-62`, also 1830 Nettozeilen vor Statistikpflege. |
| 2026-07-23 | Intake Review Governance v0.1.1 veröffentlicht und in Level 0 adoptiert | — | — | — | Das öffentliche Preset wurde über PR #2 als v0.1.1 veröffentlicht. Die versionierte GitHub-ZIP hat SHA-256 `c34d5ef0d5787ee69dcca8a8f38abaf98ffa6e391bd96225b3aa9463227ce8c6` und bestand Installation sowie beide Validator-Suiten im Zehn-Preset-Stack. Home Baseline verwendet nun v0.1.1 bei Priorität 65 in beiden optionalen Profilen; Constitution, README, Agentenflächen, Vorlagen und generierte Commands tragen denselben hashgebundenen Series-1.1-Vertrag. Die Standard-Achtermatrix bleibt unverändert. Der Adoptionscommit umfasst `+174/-88`, also 86 Nettozeilen vor Statistikpflege. |
| 2026-07-24 | Intake Authoring Governance v0.2.0 CRUD, URL und Series | — | — | — | Das optionale Preset um getrennte Create-, Read-, Update- und logische Delete-Befehle, Schema-2.0-Receipts, hashgebundene Archive und Tombstones, begrenzte öffentliche HTTPS-Snapshots sowie ausdrücklich freizugebende transaktionale Intake-Reihen erweitert. Schema 1.0/1.1 bleibt lesbar. Bash-/PowerShell-Fixtures, SQLite-URL-Feldnachweis, Zehn-Preset-Komposition, Paket-Homogenität und jeweils fünf eindeutige Commands auf allen gepflegten Agentenoberflächen sind grün. Kein Review-, Specify- oder autonomer Lauf wurde automatisch gestartet. Das Delta vor Statistikrendering umfasst 5768 Nettozeilen. |
| 2026-07-24 | Intake Authoring Governance v0.2.0 Flottenabschluss | — | — | — | Intake Authoring v0.2.0 wurde in 33/33 Level-0-/Level-1-/Level-2-Repositories installiert und über 33 PRs gemergt. Die Flotte verwendet exakt zehn Presets; 21/21 Lernreihen-Repositories aus drei Familien sind enthalten, ohne einen Lernenden-Spec-Kit-Lauf zu starten. Alle Receipt-, Lifecycle-, Matrix-, Command-Paritäts-, Statistik-, Diff- und Secret-Prüfungen bestanden. 119 echte Exact-Head-Checks waren grün. Weitere 119 Workflow-Runs mit 229 Jobs wurden vor dem ersten Schritt durch GitHub Billing oder Spending abgewiesen und blieben fehlende Provider-Evidence. Jede Annotation wurde geprüft; null Review-Threads waren offen. Die Abschluss-Evidence umfasst vor Statistikrendering 125 Nettozeilen. |
| 2026-07-24 | Intake Authoring Governance v0.2.0 im Community-Katalog | — | — | — | Die offizielle Preset-Einreichung `github/spec-kit#3720` wurde mit `preset-submission` und `validation-passed` abgeschlossen. Der von Spec Kit erzeugte Katalog-PR #3721 erhielt die Maintainer-Freigabe durch `mnriem` und wurde nach 14 erfolgreichen Checks sowie einem planmäßig übersprungenen Matrix-Job als `b0850c97e648dfd6b6ef253e91b503a030a17532` gemergt. Es gab keine Korrekturanforderung und keinen offenen Review-Thread; der abschließende Maintainer-Kommentar lautet „Thank you!“. Damit sind Paketentwicklung, Release, Flottenverteilung und Community-Katalogaufnahme vollständig abgeschlossen. |
| 2026-07-24 | Plattformübergreifende Ein-Kommando-Wartung | — | — | — | Feature 009 führt ein versioniertes Desired-State-Manifest mit 42 aktiven Git-Zielen und einer Collection, transaktionales Clone-on-missing, fail-closed Repositoryentscheidungen sowie korrelierte lokale Logs und JSON-Berichte ein. Bash und PowerShell behalten native Oberflächen und verwenden denselben Python-Standardbibliothekskern für Pfad-, Remote-, Git- und Reportsemantik. 18 gezielte Vertrags- und Git-Fixture-Tests, Bash-Syntax, PowerShell-Parser und PSScriptAnalyzer sind grün. Eine reale macOS-Vorschau erfasste alle 43 Ziele ohne Clone oder Pull und wies vorhandene Hostdrift wahrheitsgemäß aus. Das Feature ändert und publiziert keine Ziel-Repositories; der Flottenrollout bleibt separat. Das Implementierungsdelta vor Statistikrendering umfasst 2585 Nettozeilen. |
| 2026-07-25 | Intake Sequencing Governance v0.1.0 | — | — | — | Das optionale Preset ergänzt sechs getrennte Series-Befehle, typisierte harte und beratende Abhängigkeiten, azyklische Graphen, unveränderliche Receipts, logisches Löschen und eine sichere Next-Auswahl ohne automatischen Folgelauf. Release-ZIP, Elf-Preset-Komposition und der 13-Ziele-/6-Roots-/15-Kanten-Feldnachweis sind grün. Die Installation wurde über 33 gemergte Repository-PRs einschließlich 21 Lernreihen-Repositories abgeschlossen. 139 Remote-Checks waren erfolgreich; 228 Jobs wurden nachweislich vor dem ersten Schritt durch Billing oder Spending abgewiesen und 17 abhängige Jobs abgebrochen. Es gab null umsetzbare Review-Threads. Die Community-Einreichung ist `github/spec-kit#3742`. |
| 2026-07-25 | Lernenden- und A11Y-Vertrag für Presets und Lernreihen | — | — | — | Alle elf Presets auf den verbindlichen Zielgruppen- und Verständlichkeitsvertrag geprüft. Sieben portable Patch-Releases transportieren Zielgruppe, Vorwissen, Sprachreihenfolge, CEFR B2, Begriffserklärungen und textorientierte Abhängigkeits-, Status-, Entscheidungs- und Next-Action-Information durch A11Y, Agent Parity, Intake Authoring, Intake Review, Intake Sequencing, Autonomous und Parallel Autonomous; Security, Architecture, iSAQB und Cross-Platform bleiben begründet unverändert. Die 44 aktiven Lernreihenwurzeln, Startseite, Blueprint, Register und Vorlagen erben die zentrale Lernenden- und A11Y-Basis für Fachinformatiker*innen sowie die beiden kaufmännischen IT-Berufe ab dem 1. Lehrjahr. Sieben Preset-PRs und Releases, ZIP-Integrität, Elf-Preset-Komposition, eindeutige Codex-Skills und native Validator-Fixtures sind grün. |
| 2026-07-25 | Lernenden- und A11Y-Flottenabschluss | — | — | — | Das optionale Elf-Preset-Profil wurde über 32 gemergte Level-1/2-PRs verteilt; zusammen mit Home Baseline sind 33 von 33 registrierten Repositories aktuell. Alle lokalen Checkouts sind sauber und exakt mit ihrem Default-Branch synchron. 119 Checks waren grün, vier planmäßig übersprungen, 226 vor dem ersten Arbeitsschritt durch GitHub-Billing oder Spending-Limits abgewiesen und 19 abhängige Matrix-Jobs abgebrochen. Es gab null Kommentare, Reviews oder umsetzbare Threads. Die exakte Elf-Preset-Matrix besteht in allen 32 Ziel-Repositories; `cc65` bestand den nativen Linux- und Windows-Build. |
| 2026-07-25 | Secure-Development-Assurance-Intakes vorbereitet | — | — | — | Vier getrennte, noch nicht gestartete Intakes bereiten Gap-Audit, optionales Assurance-Preset v0.1.0 auf Priorität 15, Home-Baseline-3.3-Synchronisierung und ABSDD-Feldadoption vor. Jeder Intake besitzt ein Schema-2.0-Authoring-Receipt sowie kopierbare Review-, Specify- und Autonomous-Prompts mit `MergeAndSync`. Der aktive Series-Review ist `Ready` und belegt 17 Ziele, sechs Roots, 22 eindeutige azyklische Kanten, null Findings und null offene Entscheidungen. Bestehende Positionen 1 bis 13 bleiben unverändert; kein Preset und kein Spec-Kit-Featurelauf wurde gestartet. |
| 2026-07-25 | Dokumentations-Wirklichkeitsabgleich als verbindlicher Vorlauf | — | — | — | Drei neue, noch nicht gestartete Intakes bilden den Vorlauf D1 bis D3: vollständiger read-only Level-0-Audit, findings-basierte Remediation mit dauerhaftem Documentation-Impact-Vertrag und kontrollierter Level-2-Flottenabgleich. Die normative Zielablage umfasst Constitution und Spec-Kit-Memory; Templates, Checklists, PR-Evidence, fünf Agentenflächen und deterministische Gates übernehmen den operativen Vertrag. Der Schema-1.1-Series-Review ist `Ready` und belegt 20 Ziele, eine Root, 30 eindeutige azyklische Kanten, null Findings und null offene Entscheidungen. D3 sperrt die sechs bisherigen Roots, damit Positionen 1 bis 17 erst mit der gemergten Dokumentationsbaseline fortfahren. |
| 2026-07-26 | Canonical-Fleet-Wartungshärtung | — | — | — | Ein formaler Series-Review belegt, dass kein noch aktives Lastenheft die erneut erkannten Legacy-Ziele oder die lokale Elf-Preset-Profilmigration übernimmt. Der gemeinsame Fleet-Vertragskern liefert deshalb ausschließlich aktive Git-Ziele der Klasse `canonical-fleet`; Bash- und PowerShell-Orchestrator registrieren jedes deklarierte Ziel einzeln, und die Propagation verwendet nur die validierte Registry. Plattformübergreifende Regressionen schließen nicht deklarierte, Preset- und inaktive Repositories aus. Der Dry-run führt Preset- und Toolchain-Vorschauen trotz vorhergesagtem Drift vollständig aus und schreibt anschließend einen wahrheitsgemäßen blockierten JSON-Abschlussstatus. Die lokale Registry wurde bei unverändert 32 eindeutigen Pfaden vollständig auf das Elf-Preset-Profil migriert; die sieben Legacy-Ordner blieben unangetastet. Das Delta vor Statistikpflege umfasst `+586/-198`, also 388 Nettozeilen. |
| 2026-07-26 | Feature 011 Dokumentations-Wirklichkeitsaudit | — | — | — | D1 hat Level 0, acht registrierte Level-1- und 36 Level-2-Ziele am exakten Git-Stand read-only geprüft. Die maschinenlesbare Evidence umfasst 248 Dokumentationsfamilien mit genau einer Entscheidung. 33 repository-native Homogeneity-Läufe bestanden, zwölf Preset-/Koordinationsziele besitzen begründet keinen solchen Wrapper. 15 Level-2-Findings dokumentieren fehlende bilinguale README-/CLAUDE-Abschnitte und werden vollständig an D3 übergeben; ein zunächst sichtbarer Level-0-Drift wurde im sauberen Basis-Worktree als feature-eigener Generierungseffekt widerlegt. Kein Ziel-Repository wurde verändert. Das Implementierungsdelta vor Statistikpflege umfasst 31 164 Nettozeilen, überwiegend vollständige strukturierte Flotten-Evidence. |
| 2026-07-26 | Feature 012 Documentation-Impact-Governance | — | — | — | D2 hat den verbindlichen Documentation-Impact-Vertrag in Constitution, Spec-Kit-, PR-, Workflow- und Agentenflaechen verankert. Deterministische Bash-/PowerShell-Tests pruefen die vier Entscheidungen und unzulaessige Deferred-Zustaende. Alle 15 D1-Findings bleiben D3 zugeordnet; ein zentraler Level-0-Remediation-Bedarf entstand nicht. PR #128 wurde nach 20 gruenen Checks, null Review-Threads und bestandenem Exact-Head-Nachweis gemergt. Das Implementierungsdelta vor Statistikpflege umfasst 1 407 Nettozeilen. |
| 2026-07-28 | Feature 015 Windows-Ein-Kommando-Wartungshärtung | — | — | — | Die Windows-Orchestrierung verwendet jetzt genau einen Modus, begrenzte Python-3-Probes, transiente Git-Retries, WinGet-Zeitgrenzen mit Prozessbaum-Bereinigung, atomare hashgebundene Resume-Evidence und einen Run-ID-korrelierten Abschlussstatus. Registry und Flottenprüfung binden das Elf-Preset-Profil; Git-normalisierte Driftzählung trennt Rohabweichungen von aktionsfähigen Änderungen. Zehn gezielte Windows-Vertragstests einschließlich `rawDifferences=93` und `actionableDrift=3`, bestehende Wartungs- und Home-Sync-Suiten, 146 Statistik-Assertions, Parser und PSScriptAnalyzer 1.25.0 sind lokal grün. Admin-Autorität umgeht weder UAC noch Sicherheits-, Test- oder Review-Gates. Das exakte Implementierungsdelta von PR #142 vor Statistikpflege umfasst 4 209 Nettozeilen. |
| 2026-07-28 | KDM-/KITSM-Lernreihen-Intake-Kette vorbereitet | — | — | — | Acht getrennte, noch nicht gestartete Intakes bereiten Gap-Audit, Lernarchitektur, Jahr-1-Retrofit, gemeinsamen kaufmännischen Jahr-2-Kern, getrennte KITSM-/KDM-Vertiefungen im dritten Lehrjahr, kontrollierten C#-Rollout und read-only Abschlussprüfung vor. C# bleibt Referenzsprache; SQL, sichere Entwicklung, Lernenden-Evidence und agentische Evidence besitzen ausdrückliche Grenzen. Acht Schema-2.0-Receipts und acht Einzelreviews sind gültig und `Ready`. Der erneuerte aktive Schema-1.1-Series-Review belegt 28 Ziele, vier Roots, 35 eindeutige azyklische Abhängigkeiten, null Findings und null offene Entscheidungen. Die künftige Auslieferung ist auf drei Level-1- und drei C#-Level-2-Repositories begrenzt; andere MSL-Pfade bleiben unverändert. Kein Lernenden-, Specify- oder autonomer Lauf wurde gestartet. Das Delta vor Statistikpflege umfasst 3 795 Nettozeilen. |
| 2026-07-28 | ITSE-Lernreihen- und Gesamtkonsistenz-Intakes vorbereitet | — | — | — | Acht getrennte, noch nicht gestartete Intakes bereiten den ITSE-Gap-Audit, das Kompetenzmodell, LF1–LF5, LF6–LF9, die achtteilige LF10–LF12-Professional-Reihe, den kontrollierten C#-Rollout, die ITSE-Closure und eine globale Lernreihen-Konsistenzprüfung vor. Alle vier FI-Fachrichtungen bilden den primären Vergleich; KDM und KITSM ergänzen die Perspektive. C# bleibt auf Simulation, Diagnose, Testautomation und Dokumentation begrenzt; elektrische Praxis erfordert eine freigegebene Lernumgebung und fachkundige Aufsicht. Acht Authoring-Receipts und acht Einzelreviews sind gültig und `Ready`. Der aktive Schema-1.1-Series-Review belegt 36 Ziele, vier unveränderte Roots, 43 eindeutige azyklische Abhängigkeiten, null Findings und weiterhin genau einen `Eligible`-Kandidaten. Kein Lernenden-, Specify- oder autonomer Lauf wurde gestartet. Das Delta vor Statistikpflege umfasst 3 607 Nettozeilen. |
| 2026-07-28 | Feature 016 Linux-Ein-Kommando-Wartungshärtung | — | — | — | Die Linux-Orchestrierung verarbeitet Paket- und CLI-Registries mit stdin-sicheren Snapshots, eindeutigen geordneten Ergebnissen und wahrheitsgemäßem Required-Exitcode. Begrenzte Prozessgruppen-Probes unterscheiden fehlende, unbrauchbare, zeitüberschrittene und durch Fähigkeiten blockierte Werkzeuge. Swiftly 1.1.2 und Swift 6.3.3 werden für die offizielle Ubuntu-/Architekturmatrix verifiziert installiert, ohne Profile zu verändern oder Admin-Autorität zu erschleichen. Der Flottenabschluss ist atomar und genau einmal; 13 gezielte Linux- sowie 52 entdeckte Vertragstests sind grün. Vorschauen meldeten reale Host-/Flottendrift und verhinderten deshalb einen erzwungenen Paketlauf. Das exakte Implementierungsdelta vor Statistikpflege umfasst 4 054 Nettozeilen. |
| 2026-07-28 | Lernreihen-Governance- und KI-Kompetenz-Intake-Kette vorbereitet | — | — | — | Vier neue Intakes und die aktualisierte globale Closure bilden die Positionen 33 bis 37: read-only Gap-Audit, domänenneutrale Drei-Ebenen-Erweiterung des Intake Reviews, optionales Learning-Series-Governance-Preset, IHK-Pilot und abschließende Gesamtkonsistenzprüfung. Acht stabile KI-Kompetenzen, vier Lernphasen und vier Quellenstatus trennen amtliche Anforderungen, gestützte Ziele, Projektergänzungen und begründete Zukunftsannahmen. Fünf Authoring-Receipts, fünf Einzelreviews und der gemeinsame Fünf-Ziel-Review sind in Bash und PowerShell `Ready`. Der aktive Series-Vertrag umfasst 39 Ziele, drei Roots, 46 eindeutige azyklische Abhängigkeiten und weiterhin genau einen `Eligible`-Kandidaten an Position 3. Kein Specify-, autonomer oder Lernendenlauf wurde gestartet. Das Delta vor Statistikpflege umfasst 1 816 Nettozeilen. |
| 2026-07-29 | Preset-Profil- und Worktree-Härtungsintake v1.3 | — | — | — | Der bestehende Intake auf Position 3 bindet jetzt die gemergten Features 015/016, Level 0 plus 43 aktive Manifest-Git-Ziele, das separat inventarisierte Collection-Ziel und den dynamischen Elf-Preset-Feldstand. PWH-016 bis PWH-020 sowie AC-018 bis AC-027 ergänzen exakte Bereinigungsfreigaben, begrenzte Netzwerk-Evidence, Regressionsschutz und die Zielrepository-Grenze. Intake-ID, 39 Series-Ziele, drei Roots, 46 Abhängigkeiten, Reihenfolge und alleiniger `Eligible`-Status blieben erhalten. Authoring-, Review- und Series-Validatoren bestehen in Bash und PowerShell. Feature 017, Specify und Autonomous wurden nicht gestartet. Das Delta vor Statistikpflege umfasst 2 453 Nettozeilen. |
| 2026-07-29 | Feature 017 Preset-Profil-, Branch- und Worktree-Härtung | — | — | — | Die Flottenwartung führt jetzt für Level 0 und jedes aktive Git-Ziel eine begrenzte Remote-Freshness-Prüfung vor nachfolgenden Mutationen aus. Beliebige Default-Branches werden aus symbolischer Remote-Evidence statt aus Namensannahmen bestimmt. Pull bleibt auf saubere, eindeutig zugeordnete Behind-only-Checkouts begrenzt. Eigentumsgebundene Worktree-Leases, dynamische Preset-Profile, nicht mutierende MSL-Konfliktprüfung und plattformparitätische Bash-/PowerShell-Evidence sind durch 60 Tests und 20 Provider-Jobs abgesichert. PR #153 wurde am exakten geprüften Head gemergt; Home Runtime ist synchron. Der kausale Closeout archiviert Position 3 und gibt Position 4 als einzigen `Eligible`-Kandidaten frei, ohne ihn zu starten. |
| 2026-07-29 | Feature 018 Agentic-Workspace-Wartungs-TUI | — | — | — | Die vorhandenen Bash-/PowerShell-Wartungs-Engines erhalten eine optionale Spectre.Console-TUI mit ausdrücklich vorausgewählter Vorschau, typisierten Argumenten und linearem Fallback. Ein privater JSONL-Kanal liefert nur Live-Evidence; finalisierter Bericht und Prozess-Exitcode bleiben kanonisch. Cache, Event-Degradierung, genau-einmaliger Abbruch, A11Y, Supply Chain und Verteilungsgrenzen sind durch 62 .NET-, 14 fokussierte Wrapper- und 79 vollständige Wartungstests sowie die grüne macOS-/Ubuntu-/Windows-Matrix abgesichert. PR #160 wurde am exakten geprüften Head gemergt; Home Runtime ist synchron. Der kausale Closeout archiviert Position 4, veröffentlicht 37 Ziele, drei Roots und 44 Kanten und gibt D4 als einzigen `Eligible`-Kandidaten frei, ohne ihn zu starten. Das Implementierungsdelta vor Statistikpflege umfasst 7 639 Nettozeilen. |
| 2026-07-29 | D4-Dokumentationsaudit-Intake aktualisiert | — | — | — | Der bestehende read-only D4-Intake bindet jetzt die gemergten Implementierungs- und Abschlussnachweise der Features 015 bis 018. DIA-019 bis DIA-023 und AC-DIA-013 bis AC-DIA-017 ergänzen konkrete Prüfpunkte für Remote-Freshness, sichere Pull-Klassen, Worktree-Leases, dynamische Preset-Profile sowie die TUI-, Plain-, Headless-, Live-Evidence-, Abschluss-, Unterbrechungs- und Fallback-Dokumentation. Intake-ID, Position, 37 Series-Ziele, drei Roots und 44 Abhängigkeiten blieben unverändert; Authoring-, Einzelreview- und Series-Nachweise bestehen in Bash und PowerShell. D4 bleibt der einzige `Eligible`-Kandidat, wurde aber nicht gestartet. |
| 2026-07-30 | D4-D7 Source-/Home-Runtime-Vertrag verfeinert | — | — | — | Documentation Impact `UpdateRequired`: Die vier noch nicht gestarteten Dokumentationsintakes unterscheiden nun die versionierte Level-0-Quelle `~/home-baseline-source`, die manifestgesteuerte Home-Baseline Runtime unter `~/` und `machineLocal`-Zustand. D4 auditiert Artefaktklassen, Inhalt, Vorteile, Einweg-Sync und Autorität; D5 verankert Navigation und Distributionsklasse; D6 liefert das betriebliche Entscheidungsmodell; D7 verhindert pauschale Level-0-Pfadkopien und verdeckte Propagation. 29 neue Requirements und 19 neue Akzeptanzkriterien präzisieren die Kette. Reihenfolge, 37 Series-Ziele, drei Roots, 44 Kanten und D4 als einziger `Eligible`-Kandidat bleiben unverändert. Die früheren D4-D7- und Series-Reviews sind hashbedingt archiviert; kein D4-D7-Spec-Kit-Lauf wurde gestartet. Zusätzlich wurden die durch PR #176 veralteten Receipt- und Serienhashes der Positionen 24 und 31 metadata-seitig repariert. Ihre vollständigen neuen Reviews melden jeweils einen verbleibenden Medium-Befund zum noch alten Level-1-Namen `secure-casetracker-baseline`, ohne den nicht freigegebenen Lastenheft-Inhalt zu ändern. |
| 2026-07-30 | CaseTracker-Pfade in Rollout-Intakes kanonisiert | — | — | — | Documentation Impact `UpdateRequired`: Die Level-1-Ziele der Positionen 24 und 31 verwenden nun den kanonischen lokalen Fleet-Pfad `SecureCaseTrackerProjects`; Fleet-ID, Remote-Repositoryname und Remote-URL `secure-casetracker-baseline` bleiben unverändert. Beide Intake-Receipts und die aktive Series wurden mit vollständiger Supersession und byteidentischen Archiven neu gebunden. Die vollständigen Re-Reviews sind `Ready` und schließen beide Medium-Befunde `IR001`. Zielzahl, Reihenfolge, drei Roots, 44 Abhängigkeiten und D4 als einziger deklarierter `Eligible`-Kandidat bleiben unverändert. Es wurde kein Specify-, Autonomous- oder Lernreihenlauf gestartet. |
| 2026-07-31 | Wartungs-TUI- und Wrapper-Regressionshaertungsintake | — | — | — | Documentation Impact `UpdateRequired`: Ein neuer Schema-2.0-Intake spezifiziert die Reparatur des lueckenhaften JSONL-Live-Status, des fehlenden `run-completed`, der falschen `RESULT_MISMATCH`-Abschlussmeldung und der Bash-3.2-unsicheren argumentlosen Home-Runtime-Delegation. Die lineare barrierearme Darstellung, Eventschema 1, CLI- und Sicherheitsvertraege bleiben erhalten. Die aktive Series umfasst nun 38 Ziele, vier Roots und unveraendert 44 Abhaengigkeiten; `R-TUI` steht als einziger deklarierter `Eligible`-Kandidat vor der unabhaengigen `Pending`-Root D4. Intake-Receipt, Series-Supersession, Reihenfolge und Archive sind hashgebunden; kein Intake Review, Specify-, Autonomous- oder Parallel-Autonomous-Lauf wurde gestartet. |
| 2026-07-31 | Phase-2-Readiness-Korrekturen im Level-0-Bootstrap | — | — | — | Documentation Impact `GeneratedUpdate`: RF-15 bis RF-18 wurden auf die autoritative Review-Bedeutung korrigiert. `bootstrap-project.*` liest die Constitution-Version fail-closed, loest das Preset-Profil nach expliziter Option, lokaler Registry und Katalog-Standard auf und verwendet denselben Wert fuer Installation und Registrierung. Eintragsbezogene Profiloptionen aendern den Flottenstandard nicht; Registry-Dry-Runs erzeugen auch keine Elternverzeichnisse. Bilinguale Manpages, README und Lernreihen-Dokumentation bilden das Elf-Preset-Profil und die getrennte Public-Readiness-Freigabe ab. Regressionstests decken Bash und PowerShell ab. Kein Level-2-Repository, Bootstrap, Spec-Kit-Lauf oder Remote wurde erzeugt. Das Implementierungsdelta vor Statistikpflege umfasst 511 Nettozeilen. |
| 2026-07-31 | AOC-Level-0-/Level-1-Handoff abgeschlossen | — | — | — | Documentation Impact `GeneratedUpdate`: Das öffentliche `AgentOperationsCockpit` ist als aktives kanonisches Fleet-Ziel und als .NET-10-/C#-14-Ziel im gespiegelten Level-2-Umgebungsregister verankert. Die Engineering Session dokumentiert den realen Phase-2-Merge, 14 Authoring Receipts, den azyklischen Series-Nachweis sowie 13 nach Level 2 übergebene Decision Intakes. Level 1 ist durch Rider-PR #26 abgeschlossen; die breiteren Level-0-Initiativen bleiben Provenienz. Das fachliche Delta vor Statistikpflege umfasst 5 Nettozeilen. |
| 2026-08-01 | R-TUI-zu-D4-Series-Governance gehärtet | — | — | — | Documentation Impact `UpdateRequired`: R-TUI ist nun der bindende Vorgänger des Dokumentationsaudits D4. Die neue `DocumentationSurfaceBaseline`-Kante verhindert einen parallelen oder vorgezogenen D4-Start; D4 bleibt bis zum nachgewiesenen R-TUI-Abschluss `Blocked`. Der aktive Vertrag umfasst 38 Ziele, drei Roots und 45 eindeutige Abhängigkeiten. Beide Intakes, ihre Authoring-Receipts, das Series-Manifest und der neue R-TUI-Einzelreview sind hashgebunden; alte Stände bleiben bytegleich archiviert. Authoring-, Review-, Konfigurations- und Series-Validatoren bestehen in Bash und PowerShell. Kein Specify-, Autonomous- oder D4-Lauf wurde gestartet. |
| 2026-08-01 | Feature 019 Wartungs-TUI- und Wrapper-Regressionshärtung | — | — | — | Der Bash-Wrapper veröffentlicht persistierte JSONL-Ereignisse lückenlos, bindet den kanonischen Berichtspfad vor dem TUI-Prozessstart und stimmt Abschlussstatus, Bericht und Exitcode wahrheitsgemäß ab. Fehlende oder ungültige frühe Berichte führen zu einem sicheren Fallback; die argumentlose Home-Runtime-Delegation bleibt mit Bash 3.2 kompatibel. 19 Wrapper-, 90 Python- und 68 .NET-Tests sowie die vollständige macOS-/Ubuntu-/Windows-Matrix waren grün. PR #192 wurde am exakten geprüften Head gemergt. Der kausale Closeout archiviert R-TUI, dokumentiert `NoPromotion`, veröffentlicht 37 Ziele, drei Roots und 44 Abhängigkeiten und gibt D4 als einzigen `Eligible`-Kandidaten frei. Das Implementierungsdelta vor Statistikpflege umfasst 1 828 Nettozeilen. |
| 2026-08-01 | Feature 020 Dokumentations-Informationsarchitektur-Audit | — | — | — | Documentation Impact `GeneratedUpdate`: Der read-only Audit bindet 2 624 Dokumentationseinheiten, vier Leserpfade, 23 Wartungsverträge und drei vollständig abgedeckte Source-/Runtime-Klassen an den eingefrorenen Git-Baum. Eine bekannte UTF-16-Testausgabe ist über ihren Rohhash begrenzt ausgeschlossen. Das einzige deduplizierte Finding `DIA001` weist die 3 683-zeilige bilinguale Root-README als topic-orientierten D5-Remediation-Bedarf aus; D6 und D7 bleiben leer. 19 Vertragsfixtures, ein providerseitig entdeckbarer Bridge-Test, Hash-, Link-, Secret- und PSScriptAnalyzer-Nachweise sind lokal grün. Der neue Test-Bridge-Eintrag aktualisiert ausschließlich die deterministisch erzeugte Skriptreferenz. PR #194 mergte den exakten geprüften Head; der kausale Closeout archiviert D4, veröffentlicht die `Ready`-Serie mit 36 Zielen, drei Roots und 43 Abhängigkeiten und gibt D5 als einzigen bevorzugten `Eligible`-Kandidaten frei. Das Implementierungsdelta vor Statistikpflege umfasst 134 145 Nettozeilen, überwiegend vollständige strukturierte Audit-Evidence. |
| 2026-08-01 | Feature 021 Level-0-Dokumentationsarchitektur | — | — | — | Documentation Impact `UpdateRequired`: `DIA001` wurde durch getrennte kompakte deutsche und englische Root-Einstiege, zwei Dokumentationsportale und vier textorientierte Leserpfade behoben. Eine hash- und commitgebundene Matrix ordnet alle 16 früheren Root-Bereiche genau einer Entscheidung und einem validierten Ziel zu; D6/D7 bleiben bei null Findings. Der Source-/Home-Runtime-Vertrag, Progressive Disclosure, Sprachpartner und zusätzliche Documentation-Impact-Felder sind in Constitution, Templates, PR-Fläche und fünf Agentenoberflächen synchron verankert. 12 Vertragsgruppen, 3 508 Lychee-Prüfungen, Lernpaket-, Generator-, Homogeneity-, PSScriptAnalyzer-, Secret- und Elf-Preset-Gates bilden den lokalen Nachweis. Der Implementierungs-Checkpoint umfasst 2 778 hinzugefügte und 3 691 entfernte Zeilen; die negative Nettomenge ist die beabsichtigte Ablösung der 3 683-zeiligen Root-Sammelseite durch progressive Navigation. |
| 2026-08-01 | Feature 022 Agentic-Workspace-Effizienzleitfaden | — | — | — | Documentation Impact `UpdateRequired`: Ein ausführliches deutsches und englisches Betriebsmodell verbindet vier Leserpfade für Erstlauf, Routine, Maintainer/KI-Agenten sowie Audit. 17 hashgebundene Claims belegen Optionen, Status, Exitcodes, Evidence, Sicherheits-, Distributions-, Recovery-, Plattform- und Next-Action-Verträge gegen aktuelle Quellen. Root- und Dokumentationsportale verweisen mit stabilen Ankern auf den Leitfaden; zwei Feature-lokale Python-Prüfer validieren Matrix, Quellen, Sprachpartner und negative Driftfälle. 3 558 Lychee-Ziele, Lernpaket, Secure-Development-Generator, Documentation Impact, PSScriptAnalyzer, Secret-Scan und Spec-Kit-Integrität sind lokal grün. Das Implementierungsdelta vor Statistikpflege umfasst 3 013 Nettozeilen. PR #199 mergte den exakten Head nach 26 grünen Jobs und einem kommentarlosen Copilot-Exact-Head-Review. Der kausale Closeout archiviert D6, veröffentlicht die `Ready`-Serie mit 34 Zielen, drei Roots und 40 Abhängigkeiten und gibt D7 als einzigen bevorzugten `Eligible`-Kandidaten frei. Wartungsruntime, Presets, Registry, Workflows und Flottenzustand bleiben unverändert. |
| 2026-08-02 | GitHub-Actions-Runnerprofil und Windows-ripgrep gehärtet | — | — | — | Documentation Impact `UpdateRequired`: Die beiden generisch verteilten Workflows `Maintenance TUI` und `PowerShell Static Analysis` behalten ihre Linux-/macOS-/Windows-Matrix nur auf den drei öffentlichen Referenz-Repositories `home-baseline`, `agent-operations-cockpit` und `TuiVision`; private Fleet-Kopien prüfen kontinuierlich unter Linux. Produktspezifische Plattformprüfungen bleiben unverändert. Der Windows-Homogeneity-Check bezieht ripgrep 15.2.0 direkt aus dem offiziellen Release, verifiziert SHA-256 und prüft `rg --version`, sodass ein temporärer Chocolatey-Gatewayfehler nicht mehr unbemerkt bis zum Folgeschritt reicht. Der bilinguale Effizienzleitfaden dokumentiert Scope, Kostenwirkung und Ausnahmevertrag. Home Runtime benötigt für diese Source- und Workflow-Änderung keinen Sync. |
| 2026-08-05 | Level-0-Checkout- und Public-Template-Intake vorbereitet | — | — | — | Documentation Impact `UpdateRequired`: Ein neuer Schema-2.0-Intake trennt die spätere Dokumentation des bestehenden Level-0-Checkouts von der Erstellung eines eigenständigen Repositorys aus dem GitHub Public Template. `git clone`, `gh repo clone`, `gh repo create --template ... --clone` und das nicht verwandte `git clone --template` erhalten klare Ergebnis-, Remote-, Historien- und Providergrenzen. Die aktive Series umfasst 33 Ziele, vier Roots und 36 Abhängigkeiten; Position 38 ist über `PreferredSerialOrder` beratend angehängt, bleibt `Pending` und verändert Position 6 als einzigen deklarierten `Eligible`-Kandidaten nicht. Intake-Receipt, bytegleiche Series-Archive, Nachfolge-Receipt und Operationsjournal sind hashgebunden. `getting-started.md` wurde bewusst noch nicht geändert; Intake Review, Specify, Autonomous, Remote-Lieferung und Home-Sync wurden nicht gestartet. Das Delta vor Statistikpflege umfasst 1 036 Nettozeilen. |
| 2026-08-05 | RL-SE-/Checklist-Selbstpruefungsintake repariert und neu geprueft | — | — | — | Documentation Impact `UpdateRequired`: Der mechanisch veraltete Position-5-Pfad bindet jetzt die abgeschlossene Feature-024-Quelle und ihren unveraenderlichen PR-Nachweis. Der ausdruecklich bestaetigte Lernenden-, Vorwissens-, Begriffs-, A11Y-, CEFR-B2- und DE/EN-Vertrag sowie der statusabhaengige Feldvertrag fuer `Applicable`, `AlreadySatisfied`, `N/A`, `Open` und `FollowUp` sind in Anforderungen, Artefakten, Abnahme und Prompts synchronisiert. Die Findings `IR001` bis `IR003` sind geschlossen; der vollstaendige Single-Review ist `Ready` mit null verbleibenden Findings, Risiken oder offenen Fragen. Authoring-Receipt, Review und Series-Hashbindung besitzen bytegleiche Archive und vollstaendige Supersession. Die Series bleibt bei 33 Zielen, vier Roots und 36 Abhaengigkeiten; Position 6 bleibt alleiniger bevorzugter `Eligible`-Kandidat. Specify, Autonomous und Remote-Lieferung wurden nicht gestartet. Das Delta vor Statistikpflege umfasst 1 549 Nettozeilen. |
| 2026-08-07 | Ausgewogenes Spec-Kit-Modell-Routing | — | — | — | Documentation Impact `UpdateRequired`: Alle elf Governance-Presets deklarieren einen providerneutralen Kommando-zu-Rolle-Vertrag. Sequenzielle autonome Laeufe duerfen das konkrete Modell nur an abgeschlossenen Prozessgrenzen wechseln; lokale Runner-Profile, SHA-256-Bindung, Preflight und Fail-Closed-Verhalten verhindern stillen Fallback. Status-, Stop- und rein deterministische Pfade bleiben leichtgewichtig oder skriptbasiert, waehrend semantische Planung, Implementierung und Review staerkere Rollen verwenden. Preset-Quellen, beide Spiegel, Agentenoberflaechen und plattformuebergreifende Validatoren sind synchron. Feature 025 und seine Planungsartefakte bleiben davon getrennt. Das Implementierungsdelta vor Statistikpflege umfasst 4 810 Nettozeilen. |
| 2026-08-09 | Feature 026 Home-Runtime-Container-Sync | — | — | — | Documentation Impact `UpdateRequired`: `sync-home.sh --runtime-only` und `sync-home.ps1 -RuntimeOnly` verteilen ausschließlich die manifestgebundene Home Runtime, erzwingen einen Lauf ohne Pull, Commit, Git-Konfiguration, Git-Identität oder Home-Repository-Initialisierung und lassen normale schreibende ABS-DD-Containerläufe weiterhin gesperrt. Konflikte und aus `HOME` herausführende Ziel-Symlinks stoppen vor dem ersten Schreibzugriff. Zehn fokussierte und 97 vollständige Python-Tests, Bash-/PowerShell-Syntax und -Runtime-Closure, PSScriptAnalyzer, Documentation Impact sowie Secret Scan sind grün; zwölf plattformspezifische Tests blieben erwartungsgemäß übersprungen. Das Implementierungsdelta vor Statistikpflege umfasst 238 Nettozeilen. |
| 2026-08-09 | Providerneutrales Modell-Routing flottenweit abgeschlossen | — | — | — | Documentation Impact `GeneratedUpdate`: Model Routing Governance `0.1.4`, Autonomous Run Governance `0.3.6` und Parallel Autonomous Run Governance `0.2.6` wurden als versionierte GitHub-ZIPs geprüft und in 33 registrierten Ziel-Repositories installiert. Alle Ziele bestanden die exakte Zwölf-Preset-Matrix, die Bash-/PowerShell-Modellerkennung, Diff- und Secret-Prüfungen; null umsetzbare Review-Threads blieben offen. 193 Remote-Jobs wurden nachweislich vor dem ersten Schritt vom Provider abgewiesen und vier externe Reviews blieben ohne verwertbares Ergebnis; sie werden ausdrücklich nicht als bestanden gewertet. Alle 33 PRs wurden gemergt und die lokalen Default-Branches synchronisiert. Der getrennte JSON-Eingabefehler des vollständigen Ein-Kommando-Checks bleibt als Wartungsskript-Follow-up offen. |
| 2026-08-09 | Modell-Routing-Post-Merge- und OpenCode-Paritätsabschluss | — | — | — | Documentation Impact `UpdateRequired`: 151 Default-Branch-Workflows wurden getrennt von den PR-Head-Gates geprüft. 47 waren erfolgreich oder neutral; 104 Providerfehler enthielten null Workflow-Schritte und entsprachen exakt den 104 noch ungelesenen GitHub-CI-Mails. Es gab keinen ausgeführten technischen Fehler. Eine pfadbewusste Intake-Sequencing-Prüfung bestätigte alle 33 Ziel-Repositories als vollständig: 30 verwenden `.opencode/command/`, drei `.opencode/commands/`. Nur im ebenfalls singularen Level-0-Pfad fehlten sechs Series-Kommandos; sie wurden reproduzierbar aus Preset v0.2.3 erzeugt. Der Wartungs-JSON-Parserbefund ist als eigenes Workitem abgegrenzt. |
| 2026-08-09 | Wartungs-Toolchain-JSON-Ergebnishaertung | — | — | — | Documentation Impact `UpdateRequired`: Der reproduzierte Leerausgabe- und Parserfehler im macOS-/Linux-Toolchain-Abschluss ist behoben. Producer schreiben auch auf fruehen Fehlerpfaden atomare Schema-1.0-Evidence; Consumer unterscheiden fehlende, leere, abgeschnittene, syntaktisch fehlerhafte, nicht als UTF-8 lesbare und schemafremde Ergebnisse mit stabilen Klassen und ohne Stacktrace oder private Pfade. 17 Linux-Hardening- und 24 Workspace-Wartungstests sowie ein realer macOS-`--compare-only`-Lauf sind gruen; letzterer endete mit `SUCCESS_WITH_WARNINGS`, Exitcode 0, null Pflichtdrift und drei optionalen Paketen. Das Implementierungsdelta vor Statistikpflege umfasst 452 geaenderte Textzeilen. |
| 2026-08-09 | Modell-Routing-Phasenevidence korrigiert | — | — | — | Documentation Impact `UpdateRequired`: Ein vollstaendiger Ein-Kommando-Realtest belegte, dass das gueltige Toolchain-Ergebnis korrekt als `SUCCESS_WITH_WARNINGS` erzeugt wurde, die nachfolgende Modell-Routing-Phase ihre eigene JSON-Datei jedoch ueber den ausschliesslich fuer Toolchain-Evidence reservierten Parameter validieren liess. Die Phasengrenze ist korrigiert; ein Regressionstest verhindert die erneute Fehlklassifikation. Der providerneutrale Modell-Routing-Vertrag und die lokale Ergebnisdatei bleiben unveraendert. |
| 2026-08-09 | CLion-/tvision-Flottenaufnahme | — | — | — | Documentation Impact `UpdateRequired`: `CLionProjects` und der Fork `CLionProjects/tvision` sind als aktive kanonische Level-1-/Level-2-Ziele im Desired-State-Manifest verankert. Die Constitution `1.20.2` und ihr bytegleicher Spec-Kit-Spiegel dokumentieren C++14/CMake/GoogleTest, die text- und tastaturorientierte A11Y-Basis sowie die begruendete Nicht-MSL-Ausnahme fuer historische Borland-API-/ABI- und DOS-/Windows-/Unix-Kompatibilitaet. Zielgruppen sind taegliche Nutzende sowie Maintainer/KI-Agenten; der Leserpfad fuehrt von der Ein-Kommando-Manpage ueber Manifest und Registry-Zeile zur sicheren Dry-run-/Repair-Aktion. Navigation und separate Sprachpartner bleiben unveraendert; die vorhandenen Agent-Guidance-Dateien wurden gemeinsam geprueft und benoetigen keine Regelanpassung. Kanonische Quelle und Owner bleiben das Level-0-Manifest beziehungsweise der Repository Maintainer; `homeRuntime`-Sync ist vor dem operativen Lauf erforderlich. macOS, GitHub-Remotes und die Branches `main`/`master` bilden den Plattformnachweis; Remote-, Branch-, Runtime- oder Build-Vertragsaenderungen loesen die Wiedervorlage aus. 45 fokussierte Wartungsvertragstests sind gruen. Das Delta vor Statistikpflege umfasst 50 Nettozeilen. |
| 2026-08-10 | Zwölf-Preset-Flottenprofil konsolidiert | — | — | — | Documentation Impact `UpdateRequired`: Die lokale, nicht versionierte Level-2-Registry bindet den Standard und alle 35 eindeutigen Ziel-Repositories jetzt an `model-routing-twelve-governance-presets`; eine hashgebundene Sicherung bewahrt den vorherigen Elf-Preset-Stand. Vier aktuelle Lernreihen- und Secure-Development-Leserpfade trennen weiterhin das öffentliche Acht-Preset-Profil von Thorstens verwalteter Zwölf-Preset-Flotte und erklären Model Routing auf Priorität 61 sowie die Intake-Grenzen 64/65/66 Deutsch zuerst und Englisch danach. Beide Copilot-Guidance-Spiegel sind mit AGENTS, CLAUDE, GEMINI und den Templates auf Model Routing Governance v0.1.4 synchron; konkrete Modellbindungen bleiben lokal und Modus 600. Kanonische Source und Owner bleiben die Profilkataloge und der Repository Maintainer; die geänderte `homeRuntime`-Guidance benötigt nach dem Merge einen Home-Sync. Navigation und Sprachpartner bleiben unverändert. Ein vollständiger macOS-Check-only-Lauf bestätigt 35/35 homogene Registry-Ziele, die exakte Zwölf-Preset-Matrix, `model-routing=Passed` und Exitcode 0. Änderungen am öffentlichen Standardprofil, an Prioritäten, Registry-Schema, Distribution oder Model-Routing-Version lösen die Wiedervorlage aus. Kein Spec-Kit-, Intake-, Lernenden- oder Autonomous-Lauf wurde gestartet. |
| 2026-08-14 | Home-Baseline- und Sandbox-Dokumentation verzahnt | — | — | — | Documentation Impact `UpdateRequired` plus `GeneratedUpdate`: Home Baseline ist als kanonische Quelle fuer Lernendenweg, providerneutrales Git-Hosting, Level-0-Governance und Source-/Runtime-Vertrag abgegrenzt; die Sandbox-Dokumentation besitzt Image-Build, gepinnte Versionen, Mounts, Container-Kommandos und den konkreten Runtime-Wrapper. Zielgruppen, Required-Agenten (`codex`, `claude`, `agy`, `copilot`) und der begrenzte Runtime-only-Pfad sind synchron. Der neue `--shared-guides-only`-/`-SharedGuidesOnly`-Modus plant und staged ausschliesslich die drei gemeinsamen Guides in Root und `docs/learning-units/`; Fixture-Tests und Live-Dry-Runs bestaetigten 21/21 erreichbare Ziele, null Skips, null neuere Konflikte und 84 geplante Dateiaenderungen ohne README-, Intake-, Lernbegleiter-, Vorlagen- oder Datensatz-Drift. Die geaenderte `homeRuntime`-Guidance benoetigt nach Merge und Release einen Home-Sync. |
| 2026-08-15 | Achte Pflicht-Erweiterung fuer VS Code | — | — | — | Documentation Impact `UpdateRequired` plus `GeneratedUpdate`: `ms-vscode.powershell` ist als achte eindeutige Required-Erweiterung fuer das Schreiben und Debuggen von PowerShell-Skripten und Cmdlets in der gemeinsamen Registry verankert. Beide Wartungs-Manpages, die fuenf Shared-Guidance-Dateien und vier Vorlagen sind Deutsch zuerst und Englisch danach synchronisiert. Ein fail-closed Regressionstest bindet die exakte Acht-Erweiterungs-Menge und alle elf Dokumentationsflaechen. 124 Python-Wartungstests, beide Documentation-Impact-Suiten und PSScriptAnalyzer fuer 164 Dateien sind lokal gruen; der reale macOS-Compare-only-Lauf meldet null fehlende Required-Erweiterungen und Exitcode 0. Das fachliche Delta vor Statistikpflege umfasst 122 Nettozeilen. Home Runtime wird nach dem Merge synchronisiert; Level-1-/Level-2-Rollout und Fleet-Pushes bleiben ausserhalb dieses Auftrags. |
| 2026-08-15 | Feature 027 Autonomous Evidence Integrity Hardening | — | — | — | Documentation Impact `UpdateRequired` plus `GeneratedUpdate`: Der unveroeffentlichte Autonomous-Run-Governance-Kandidat 0.4.0 validiert eine ausdrueckliche Liefermenge einschliesslich benannter unversionierter Dateien, verlangt ein strukturiertes semantisches Phasenergebnis und trennt Schema-2.0-`PreMerge`- von kausaler `PostMerge`-Evidence. Historisches Schema 1.0 bleibt ausschliesslich im Auditmodus lesbar. Positive und negative Cross-Shell-Fixtures, bestehendes Modell-Routing, drei State-Validatoren, PSScriptAnalyzer fuer 164 Dateien, Script-Referenz und eine Zwölf-Preset-Komposition sind gruen. Kanonischer Scaffold und Publikationskopie sind bytegleich; Release, Tag, ZIP, Katalog, Consumer und Flotten-Rollout bleiben bis zum unabhaengigen G2B-Feldnachweis gesperrt. |
| 2026-08-19 | CI-Budget- und Copilot-Review-Governance-Intakes | — | — | — | Documentation Impact `UpdateRequired`: Zwei getrennte Schema-2.0-Intakes bereiten die flottenweite Rationalisierung von GitHub-Actions-Minuten und die begrenzte GitHub-Copilot-Review-Governance vor. G3 erhebt zuerst das reale CI-Portfolio, schützt technische, Sicherheits- und A11Y-Gates und definiert ein kostenbewusstes Zielprofil; G4 folgt erst danach und begrenzt automatische Copilot-Reviews auf genau acht benannte öffentliche beziehungsweise zentrale Repositories. Beide Receipts und die gemeinsame Authoring-Operation binden den genehmigten Vorschlag mit SHA-256 `1af660a029b71511d4e7345061d1058902289ce42f041552bc8bf819a71517b8`. Die aktive Serie wächst von 32 auf 34 Ziele und von 36 auf 38 Abhängigkeiten bei unverändert drei Roots: G3 ist der einzige deklarierte `Eligible`-Kandidat, G4 und die bisherige Position 7 sind `Blocked`, Positionen 9 und 10 bleiben `Pending`. Die Vorgängerserie ist bytegleich archiviert. Intake Review, Specify, Autonomous, GitHub-Konfigurationsänderungen, Lieferung und Home-Sync wurden nicht gestartet. |

---

## Gesamtstand des Repositories / Repository Snapshot

Stand / As of: **2026-07-19**

| Kategorie / Category | Dateien / Files | Zeilen / Lines | Anteil / Share |
|---|---:|---:|---:|
| Skripte / Scripts (`.sh`, `.ps1`, `.py`) | 159 | 44 624 | 15.6 % |
| Strukturierte Konfiguration und Templates / Structured config and templates | 105 | 7 164 | 2.5 % |
| Dokumentation / Documentation (`.md`, `LICENSE`, `.txt`, Manpages) | 1 399 | 208 181 | 72.6 % |
| Daten und Medien / Data and media (`.csv`, `.sql`, `.pdf`, `.pptx`) | 12 | 26 625 | 9.3 % |
| Sonstiges / Other | 0 | 0 | 0.0 % |
| **Gesamt / Total** | **1 675** | **286 594** | **100 %** |

### Aufgliederung Dokumentation / Documentation Breakdown

| Untertyp / Subtype | Zeilen / Lines | Anteil an Doku / Share of Docs |
|---|---:|---:|
| Spec-Kit-Artefakte (`specs/`) | 36 167 | 17.4 % |
| Secure Development (`docs/secure-development/`) | 32 965 | 15.8 % |
| Lernmaterialien und Lernreihen-Intakes (`docs/learning-units/`) | 84 696 | 40.7 % |
| Governance (AGENTS / CLAUDE / GEMINI / constitution / Copilot) | 4 482 | 2.2 % |
| README / CHANGELOG / STATS / Projektstatistik | 4 417 | 2.1 % |
| Sonstige Markdown-Artefakte / Other Markdown artifacts | 45 454 | 21.8 % |

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
| 8 | parallel — v0.2.0 + 24-Worker-Feldtest | 5 323 | 14 | 2 | 2026-07-18 bis 2026-07-19 |
| 9 | fleet — v0.2.1 + Standard-Achtermatrix | 19 465 | 3 | 1 | 2026-07-19 |

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

**Hinweis zu Phase 8:** Der 24-Worker-Feldtest belegt die kontrollierte
Konsolidierung ueber sechs MSL-Sprachen, Closeout und Hauptbranch-Validierung.
Die daraus abgeleitete v0.2.0-Haertung trennt portable Orchestrierungsregeln von
macOS-, GitHub-, Billing-, Sprach- und Modellspezifika.

*Note on Phase 8: The 24-worker field test covers controlled consolidation
across six MSL languages, closeout, and main-branch validation. The resulting
v0.2.0 hardening separates portable orchestration rules from macOS, GitHub,
billing, language, and model specifics.*

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

## Statistikprofil-1-Archiv / Statistics Profile 1 Archive
Basis dieses Schlussblocks sind der aktuelle Repository-Snapshot sowie die
dokumentierten Hauptphasen und Maintenance-Runden aus den Abschnitten oben.

Die Standard-Achtermatrix enthaelt `autonomous-run-governance` v0.3.0 und
`parallel-autonomous-run-governance` v0.2.1. Das achte Preset wurde durch 24
Worker in sechs MSL-Sprachen mit Stop/Status/Resume, exakten PR-Head- und
Review-Gates, fortsetzbarer Konsolidierung und Post-Merge-Closeout validiert.
Installation und Ausfuehrungsberechtigung bleiben getrennt; weder gespeicherter
Zustand noch ein Runnerprofil erteilen neue Remote-, Merge- oder
Bypass-Berechtigungen. Das exakte v0.2.1-Tag-ZIP ist veroeffentlicht und als
`github/spec-kit#3591` beim Community-Katalog eingereicht.

*This closing block is based on the current repository snapshot plus the
documented main phases and maintenance rounds from the sections above.*

*The standard eight-preset matrix includes `autonomous-run-governance` v0.3.0
and `parallel-autonomous-run-governance` v0.2.1. The eighth preset was validated
by 24 workers across six MSL languages with stop/status/resume, exact PR-head
and review gates, resumable consolidation, and post-merge closeout.
Installation remains separate from execution authority; neither stored state
nor a runner profile grants new remote, merge, or bypass authority. The exact
v0.2.1 tag ZIP is published and submitted to the Community Catalog as
`github/spec-kit#3591`.*

| Kennzahl / Metric | Verdichteter Gesamtblick / Condensed Overview |
|---|---:|
| Artefaktbasis gesamt / Total artifact base | `286 594` Zeilen |
| Operativer Code und Konfiguration / Operational code and configuration | `51 788` Zeilen (`18.1 %`) |
| Dokumentationsanteil / Documentation share | `208 181` Zeilen (`72.6 %`) |
| Beobachtbarer Projektzeitraum / Observable project window | `2026-03-31` bis `2026-07-19` |
| Sichtbare Git-Aktivtage / Observable active days | `68` |
| Git-Commits gesamt / Total commits | `503` |
| Git-Commits pro Aktivtag / Commits per active day | `7.4` (`503 / 68`) |
| Zeilen pro Aktivtag / Lines per active day | `4 214.6` (`286 594 / 68`) |
| Zeilen pro Commit / Lines per commit | `569.8` (`286 594 / 503`) |
| Konservative Einzelentwickler-Untergrenze | `3 582.4` Arbeitstage / `27 942.9` Stunden |
| Thorsten-Solo-Untergrenze (Scripting-Infra, 100 Z./Tag) | `2 865.9` Arbeitstage / `22 354.3` Stunden |
| Kleines 3er-Team mit Koordinationsaufschlag | `1 433.0` Arbeitstage |
| Repo-weiter Speedup gg. 80-Zeilen-Referenz | `52.7x` |
| Repo-weiter Speedup gg. Thorsten-Referenz (100 Z./Tag) | `42.1x` |

Kurzfazit:
`home-baseline` bleibt dokumentations- und Governance-getrieben: `72.6 %` der
sichtbaren Basis liegen in Dokumentationsartefakten. Operative Skripte und
strukturierte Konfiguration machen zusammen `18.1 %` aus. Der groesste
dokumentierte Volumensprung bleibt Phase `1` (Spec-Kit-Batch fuer Homogeneity
Guardian). Phase `8` dokumentiert den vollstaendigen 24-Worker-Feldtest, die
v0.2.0-Haertung, Veroeffentlichung, Achtermatrix und Katalogeinreichung. Phase
`9` bildet die Patch-Releases und den vollstaendigen 33-Repository-Rollout ab. Die
Beschleunigungsfaktoren beschreiben keine Stoppuhrzeit, sondern sichtbare
Lieferdichte gegen konservative manuelle Referenzmodelle.

*Short summary: `home-baseline` remains documentation- and governance-driven:
`72.6 %` of the visible base consists of documentation artifacts. Operational
scripts and structured configuration together account for `18.1 %`. The
largest documented volume jump remains Phase `1` (Spec-Kit batch for
Homogeneity Guardian). Phase `8` records the complete 24-worker field test,
v0.2.0 hardening, publication, eight-preset matrix, and catalog submission.
Phase `9` records the patch releases and complete 33-repository rollout.
Acceleration factors describe visible delivery density, not stopwatch
measurements.*

### ASCII-Diagramme / ASCII Charts

```text
Artefaktmix nach aktuell dokumentiertem Snapshot (Zeilen)
Skripte         | #####                          | 44 624 | 15.6 %
Konfiguration   | #                              |  7 164 |  2.5 %
Dokumentation   | ######################         |208 181 | 72.6 %
Daten/Medien    | ###                            | 26 625 |  9.3 %
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
8 parallel| #####                    |  5 323
9 fleet   | ##################       | 19 465
```

Dieses Diagramm zeigt den Netto-Insertions-Beitrag der dokumentierten Phasen.
Phase `7` umfasst die autonomen Feld-Inputs; Phase `8` den parallelen
24-Worker-Feldtest und die v0.2.0-Produktisierung.

*This chart shows the net insertion contribution per documented phase. Phase
`7` contains the autonomous field inputs; Phase `8` contains the parallel
24-worker field test and v0.2.0 productization. Phase `9` contains the
repository-fleet rollout and patch releases.*

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
8 parallel| ######                   |   66.5 d
9 fleet   | ######################## |  243.3 d
```

Jeder Balken zeigt, wie viele Arbeitstage ein erfahrener Einzelentwickler
bei `80` manuell erstellten Zeilen pro Tag fuer das jeweilige Phasenpaket
benoetigt haette. Die Preset-Phase entspricht konservativ gut `109`
Arbeitstagen sichtbarem Governance-Output.

*Each bar shows how many workdays an experienced solo developer would have needed
at `80` manually created lines per day for the respective phase package. The
preset phase conservatively represents about `109` workdays of visible
governance output; the parallel v0.2.0 package represents about `66` days.*

```text
Dokumentierte Beschleunigungsfaktoren (Phasen-Speedup vs. 80-Zeilen-Referenz)
Repo ges. | ################################################ | 52.7x
0 Init    | ############                     | 11.9x
1 001+    | >> Spec-Kit-Batch: 331.5x (ausserhalb Skala)
2 pub     | ################################# | 38.6x
3 CI+003  | ######                           |  6.3x
4 005+    | ################################################ | 67.3x
5 proj    | ########                         |  8.6x
6 presets | ################################################ | 54.6x
7 autonom | >> complete field package: 120.5x (outside scale)
8 parallel| #################################                | 33.3x
9 fleet   | >> complete fleet rollout: 243.3x (outside scale)
```

Hier werden keine Stoppuhrzeiten gemessen. Verglichen wird die dokumentierte
Lieferdichte pro Aktivtag gegen die 80-Zeilen-Referenz. Phase `6` ist hoch,
weil mehrere Preset-Folge-Releases, externe Preset-Repos und Smoke-Test-Runden
in zwei sichtbaren Preset-Aktivtagen abgeschlossen wurden. Phase `7` buendelt
autonome Feldlaeufe; Phase `8` bildet Feldkonsolidierung und Produktisierung
ueber zwei sichtbare Aktivtage ab. Phase `9` fasst den repo-uebergreifenden
Rollout an einem sichtbaren Aktivtag zusammen.

*This chart does not measure stopwatch time. It compares documented delivery
density per active day against the 80-line reference. Phase `6` is high because
multiple preset follow-up releases, external preset repositories, and several
smoke-test rounds were completed in two visible preset active days. Phase `7`
bundles autonomous field runs; Phase `8` covers field consolidation and
productization across two visible active days. Phase `9` records the
repository-wide rollout on one visible active day.*

```text
Vergleich dokumentierter Gesamtaufwand / sichtbares KI-Lieferfenster
Erfahren (80 Z./Tag)   | ######################## | 3 582.4 d / 27 942.8 h
Thorsten (100 Z./Tag)  | ###################      | 2 865.9 d / 22 354.3 h
KI sichtbar            | #                        |    68.0 d
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
X/Y-Diagramm: Phasenvolumen (X = Phase 0..9, Y = Insertions)
30000 |                                        |
25000 |     *                                  |
20000 |                                     *  |
15000 |                                        |
10000 |                 *       *   *          |
 5000 |         *                       *      |
    0 | *           *       *                  |
      +----------------------------------------+
        0   1   2   3   4   5   6   7   8   9
```

Als zweite Ansicht zeigt diese X/Y-Kurve denselben Verlauf ueber die
Phasenachse. Die X-Positionen nutzen feste Slots, damit spaetere zweistellige
oder fehlende Phasenwerte keine Punkte verschieben. Phase `1` ragt deutlich
heraus; Phase `6` bildet den Governance-Preset-Nachlauf und Phase `7` das
autonome Paket. Phase `8` zeigt das parallele Feldtestpaket und Phase `9` den
Flottenrollout.

*As a second view, this X/Y curve shows the same progression across the phase
axis. The X positions use fixed slots so later two-digit or missing phase values
do not shift points. Phase `1` stands out clearly; Phase `6` contains the
governance preset follow-up, Phase `7` the autonomous package, Phase `8`
the parallel field-test package, and Phase `9` the fleet rollout.*

### 2026-07-19 - Skriptkatalog und dauerhafte Level-0-Quelle / Script catalog and permanent Level 0 source

- Alle kanonischen und eingebetteten Skriptdateien werden nun reproduzierbar
  inventarisiert; eine bilinguale Zentralreferenz dokumentiert Rolle,
  Voraussetzungen, Nebenwirkungen und sichere Aufrufbeispiele.
- Die dauerhafte Level-0-Quelle wechselt von der historischen
  Temp-Bezeichnung zu `~/home-baseline-source`. Ein gemeinsamer Resolver,
  strikter Preflight, lokaler JSON-Nachweis und befristeter
  Kompatibilitaetslink machen die Migration plattformuebergreifend pruefbar.

*All canonical and embedded script files are now inventoried reproducibly. A
bilingual central reference documents roles, prerequisites, side effects, and
safe invocation examples. The permanent Level 0 source moves to
`~/home-baseline-source` through shared discovery, a strict preflight, local
JSON evidence, and a temporary compatibility link.*

### 2026-07-20 - Plattformuebergreifender Ein-Kommando-Wartungsintake / Cross-platform one-command maintenance intake

- Ein neues, entscheidungsvollstaendiges Lastenheft verbindet
  Bash-3.2-Kompatibilitaet, PowerShell-Paritaet, Desired-State-Flotte,
  Clone-on-missing, fortsetzbare Wartung und kompakte JSON-Nachweise.
- Der fruehere Intake bleibt als historischer Kontext erhalten; die aktive
  Abarbeitungsreihenfolge verweist auf den neuen plattformuebergreifenden
  Vertrag.
- Schrittweiser und autonomer Spec-Kit-Einstieg sind als Alternativen
  dokumentiert. Der autonome Prompt begrenzt `MergeAndSync` auf den
  Wartungsscope und erteilt keine Bypass-, Secret- oder Provider-Admin-Rechte.

*A decision-complete intake now combines Bash 3.2 compatibility, PowerShell
parity, desired-state fleet management, safe cloning, resumable maintenance,
and compact JSON evidence. The historical predecessor remains available, the
active order points to the new contract, and staged versus autonomous Spec Kit
entry points are documented as alternatives with tightly bounded delivery
authority.*

### 2026-07-20 - Agentic-Workspace-Wartungs-TUI-Intake / Agentic workspace maintenance TUI intake

- Ein eigener Spectre.Console-Intake definiert TTY-Erkennung, vorausgewaehlten
  Dry-run, Headless-Kompatibilitaet, Live-Phasenanzeige und sicheren
  Plaintext-Fallback fuer macOS, Linux/Ubuntu und Windows.
- Bash und PowerShell bleiben alleinige Wartungs-Engines. Die TUI verwendet
  typisierte Prozessargumente und einen versionierten JSONL-Ereigniskanal,
  statt Wartungslogik oder Konsolentext-Parsing zu duplizieren.
- Ein hartes Gate sperrt die Abarbeitung, bis der Plattform-Wartungsvorgaenger
  vollstaendig umgesetzt, validiert und gemaess seiner Delivery Authority
  abgeschlossen ist. Beide kopierbaren Spec-Kit-Prompts erzwingen dieses Gate.

*A separate Spectre.Console intake defines terminal detection, dry-run as the
safe initial choice, headless compatibility, live phase status, and a plain
fallback across macOS, Linux/Ubuntu, and Windows. Bash and PowerShell remain the
only maintenance engines. A hard gate blocks all TUI feature work until the
platform-maintenance predecessor is implemented, validated, and closed out
under its delivery authority.*

### 2026-07-20 - Aktive Lastenheft-Queue repriorisiert / Active intake queue reprioritized

- Ein-Kommando-Wartung und Wartungs-TUI stehen jetzt auf Position 1 und 2;
  der harte TUI-Gate verweist auf den direkten Vorgaenger auf Position 1.
- Die uebrigen aktiven Intakes sind unter Wahrung ihrer relativen Reihenfolge
  lueckenlos bis Position 11 neu nummeriert.
- Die 14 Secure-CaseTracker-Eintraege der frueheren Positionen 5 bis 18 sind
  nur aus der zentralen aktiven Queue entfernt. Die Lernreihen-Dateien bleiben
  unter `docs/learning-units/` erhalten.

*One-command maintenance and its dependent TUI now occupy positions 1 and 2.
The remaining active intakes are numbered contiguously through 11. The 14
Secure CaseTracker items were removed only from the central active queue; their
learning-series files remain unchanged.*

### 2026-07-21 - Homogeneity-Runtime fail-closed gehaertet / Homogeneity runtime hardened fail-closed

- Das Wartungsmanifest verteilt nun alle 21 kanonischen `hg-*`-Bibliotheken
  zusammen mit beiden Homogeneity-Wrappern.
- Bash und PowerShell pruefen ihre benoetigten Funktionen vor jedem Scan und
  liefern bei einem unvollstaendigen Paket eindeutig Exitcode 2.
- Ein plattformparitaetisches Regressionstestpaar reproduziert den frueheren
  False-Positive in temporaeren Installationen und prueft danach das
  vollstaendige Paket.

*The maintenance manifest now distributes all 21 canonical `hg-*` libraries
with both Homogeneity wrappers. Bash and PowerShell validate their required
functions before scanning and return exit code 2 for an incomplete package. A
cross-platform regression pair reproduces the former false positive in
temporary installations and then verifies the complete package.*

### 2026-07-21 - Intake-Authoring-Flottenabschluss / Intake authoring fleet closeout

- Das optionale Preset `intake-authoring-governance` v0.1.0 ist in allen 33
  verwalteten Level-0-, Level-1- und Level-2-Repositories installiert. Die
  bestehende Acht-Preset-Standardmatrix und das Neun-Preset-Profil bleiben
  unveraendert.
- Alle 21 Lernreihen-Repositories in drei Familien verwenden das explizite
  Zehn-Preset-Profil. Bash- und PowerShell-Paketvorschauen sind gruen; kein
  Spec-Kit-Lauf fuer Lernende wurde gestartet.
- 33 nicht leere PRs sind gemergt. Providerseitige Billing-Ausfaelle wurden
  einzeln als nicht verfuegbare Evidence klassifiziert und nie als technische
  Erfolge gewertet. Die offizielle Community-Einreichung ist
  `github/spec-kit#3621`.

*The optional `intake-authoring-governance` v0.1.0 preset is installed across
all 33 managed Level 0, Level 1, and Level 2 repositories while the existing
eight- and nine-preset profiles remain unchanged. All 21 learning-series
repositories use the explicit ten-preset profile, both package previews pass,
and no learner Spec Kit run was started. All 33 non-empty PRs are merged;
provider billing failures remain unavailable evidence rather than technical
passes. The official community submission is `github/spec-kit#3621`.*

### 2026-07-22 - Ein-Kommando-Wartung gehaertet / One-command maintenance hardened

- Ein echter zweiter `sync-home.sh --no-pull`-Lauf bleibt nun auch mit
  macOS-Bash 3.2 unter `set -u` ein erfolgreicher No-op. Derselbe Regressionstest
  laeuft im Linux-Job mit Bash 5.
- Ein versionierter Profilkatalog verbindet die Acht-, Neun- und
  Zehn-Preset-Matrizen mit den lokalen Registry-Profilnamen. Bash- und
  PowerShell-Orchestrator sowie beide Registrierungsvarianten lehnen unbekannte
  Profile eindeutig ab.
- Die Maschinen-Registry behandelt MongoDB Community 8.0, Mono, SQLite und
  Telnet als optionale, bewusst installierbare Formeln. PowerShell ist eine
  erforderliche Formel; `ensureLinked` prueft, dass `pwsh` tatsaechlich aus dem
  aktiven Homebrew-Praefix aufgeloest wird.

*A real second `sync-home.sh --no-pull` invocation is now a successful no-op
under macOS Bash 3.2 with `set -u`, while the same regression runs with Bash 5
on Linux. A versioned profile catalog maps the eight-, nine-, and ten-preset
matrices to supported registry names, and both Bash and PowerShell paths reject
unknown profiles. MongoDB Community 8.0, Mono, SQLite, and Telnet are explicitly
optional; required formula PowerShell now has a verifiable `pwsh` link contract.*

### 2026-07-22 - Wartungshaertung: Flottenabschluss / Maintenance hardening fleet closeout

- 30/30 manifestverwaltete Repositories erhielten exakt die drei kanonischen
  Wartungsdateien ueber getrennte PRs. Merge-Commits bewahren die
  reproduzierbaren Source- und Statistik-Commit-IDs.
- Sechs Repositories lieferten reale gruene Checks. 24 private Repositories
  meldeten ausschliesslich die identische Billing-/Spending-Limit-Annotation,
  bevor ein Runner startete; diese Evidence bleibt Provider-`N/A`.
- Level 0 und die 30 registrierten Ziele verwenden exakt das
  Zehn-Preset-Profil. Wartungspaket, Arbeitsbaeume, Upstreams und Statistik sind
  nach dem Merge homogen beziehungsweise `CURRENT`.
- `maintain-agentic-workspace.sh --check-only`, `--dry-run` und der
  argumentlose Wartungslauf endeten jeweils mit Exitcode 0. Homebrew ist nach
  dem Cleanup ohne Doctor-Befund; `pwsh` wird aus der Formel 7.6.4 aufgeloest.

*All 30 manifest-managed repositories received exactly the three canonical
maintenance files through separate PRs, preserving reproducible source and
statistics commit IDs with merge commits. Six repositories produced real green
checks; 24 private repositories only reported the identical billing or spending
limit annotation before runner startup and therefore remain provider `N/A`.
Level 0 and all 30 registered targets now use the exact ten-preset profile, and
check-only, dry-run, and the no-argument maintenance run all returned exit code
0.*

### 2026-07-22 - Windows-Intake fuer Ein-Kommando-Wartungshaertung / Windows one-command maintenance hardening intake

- Ein tracebarer Windows-Folgeintake bildet die neun real beobachteten Befunde
  einzeln auf Anforderungen und messbare Abnahmekriterien ab.
- Die aktive Queue fuehrt ihn direkt nach der plattformuebergreifenden Wartung.
  Die Wartungs-TUI rueckt auf Position 3 und bleibt bis zum nachgewiesenen
  Abschluss beider Vorgaenger hart gesperrt.
- Das Receipt weist eine geordnete Inline-Quelle, drei beantwortete
  Authoring-Entscheidungen, keine offene Frage und die begrenzte Authority
  `LocalImplementation` nach. Der lokale Receipt-Validator ist gruen.
- Kein Intake-Review-, Specify-, Autonomous-, Commit- oder Remote-Lauf wurde
  gestartet. Das Authoring-Delta vor Statistikpflege umfasst `+593/-17`, also
  576 Nettozeilen. Die konservative Manualreferenz fuer 593 hinzugefuegte oder
  aktualisierte Zeilen betraegt 7,4 Tage beziehungsweise 57,8 Stunden;
  Thorsten-Solo 5,9 Tage beziehungsweise 46,3 Stunden.

*A traceable Windows follow-up intake maps all nine observed findings to atomic
requirements and measurable acceptance criteria. It is queued directly after
cross-platform maintenance, while the TUI moves to position 3 and remains hard
blocked by both predecessors. The receipt records one ordered inline source,
three answered authoring decisions, no open question, and LocalImplementation
authority; local validation passes. No Intake Review, Specify, Autonomous,
commit, or remote run was started. The authoring delta before statistics work
is +593/-17, or 576 net lines.*

### 2026-07-22 - Linux-/Ubuntu-Intake fuer Ein-Kommando-Wartungshaertung / Linux and Ubuntu one-command maintenance hardening intake

- Ein tracebarer Linux-/Ubuntu-Folgeintake bildet die vier real beobachteten
  Befunde einzeln auf acht atomare Anforderungen und zwoelf messbare
  Abnahmekriterien ab.
- Die aktive Queue fuehrt ihn unter Wahrung der bestehenden Reihenfolge auf
  Position 3. Die Wartungs-TUI rueckt auf Position 4 und bleibt bis zum
  nachgewiesenen Abschluss aller drei Wartungsvorgaenger hart gesperrt.
- Das Receipt weist eine geordnete Inline-Quelle, drei beantwortete
  Authoring-Entscheidungen, keine offene Frage und die begrenzte Authority
  `LocalImplementation` nach. Der lokale Bash-Receipt-Validator ist gruen.
- Kein Intake-Review-, Specify-, Autonomous-, Commit- oder Remote-Lauf wurde
  gestartet. Das Authoring-Delta vor Statistikpflege umfasst `+654/-17`, also
  637 Nettozeilen. Die konservative Manualreferenz fuer 654 hinzugefuegte oder
  aktualisierte Zeilen betraegt 8,2 Tage beziehungsweise 63,8 Stunden;
  Thorsten-Solo 6,5 Tage beziehungsweise 51,0 Stunden.

*A traceable Linux and Ubuntu follow-up intake maps all four observed findings
to eight atomic requirements and twelve measurable acceptance criteria. It is
queued at position 3 while preserving existing relative order; the TUI moves
to position 4 and remains hard blocked by all three maintenance predecessors.
The receipt records one ordered inline source, three answered authoring
decisions, no open question, and LocalImplementation authority; the local Bash
validator passes. No Intake Review, Specify, Autonomous, commit, or remote run
was started. The authoring delta before statistics work is +654/-17, or 637 net
lines.*

### 2026-07-28 - Dokumentationsarchitektur-Intake-Kette D4-D7 / Documentation architecture intake chain D4-D7

- Vier aufeinander aufbauende Intakes erweitern die abgeschlossene
  D1-D3-Dokumentationsbasis um ein read-only Informationsarchitektur-Audit,
  eine Level-0-Neustrukturierung, einen Agentic-Workspace-Effizienzleitfaden
  und die anschliessende registrierte Level-1/2-Adoption.
- Alle vier Einzelreviews und der vollstaendige Series-Review stehen auf
  `Ready`. Die aktive Series umfasst 21 Ziele, fuenf Roots und 28
  Abhaengigkeiten; der Windows-Wartungsintake bleibt der einzige deklarierte
  naechste serielle Lauf.
- Kein D4-D7-Spec-Kit-Lauf wurde gestartet. Das Intake- und Evidence-Delta vor
  Statistikpflege umfasst `+2712/-40`, also 2672 Nettozeilen.

*Four dependent intakes extend the completed D1-D3 documentation baseline with
a read-only information-architecture audit, Level 0 restructuring, an agentic
workspace efficiency guide, and subsequent registered Level 1/2 adoption. All
four individual reviews and the complete Series review are Ready. The active
Series contains 21 targets, five roots, and 28 dependencies; the Windows
maintenance intake remains the only declared next serial run. No D4-D7 Spec
Kit run was started. The intake and evidence delta before statistics work is
2712 additions and 40 deletions, or 2672 net lines.*

### 2026-07-28 - Windows-Ein-Kommando-Wartung gehaertet / Windows one-command maintenance hardened

- Der Windows-Orchestrator leitet `CheckOnly`, `Preview` und `Update` aus genau
  einem Modus ab und validiert Python 3 sowie PSScriptAnalyzer 1.25.0 vor der
  ersten abhaengigen Mutation.
- Transiente Git-Netzwerkfehler werden begrenzt wiederholt. Jeder WinGet-
  Unterprozess besitzt eine harte Zeitgrenze und Prozessbaum-Bereinigung;
  unbeaufsichtigt nicht abschliessbare Adminarbeit wird sichtbar als
  `DEFERRED_ADMIN_REQUIRED` gemeldet, ohne UAC technisch zu umgehen.
- Hashgebundene atomare Resume-Evidence akzeptiert nur exakt belegte eigene
  Dirty-Zwischenstaende. Die Propagation trennt 93 reproduzierte
  Rohabweichungen von genau drei aktionsfaehigen Inhaltsdrifts.
- Registry und Bericht bewahren das explizite Elf-Preset-Profil, kanonische
  Paket-IDs und eine gemeinsame Run-ID-/Exitcode-Wahrheit. Zehn neue Windows-
  Vertragstests, die bestehenden Wartungs- und Home-Sync-Suiten, 146
  Statistik-Assertions, Parser und PSScriptAnalyzer sind lokal gruen.
- Das exakte Implementierungsdelta von PR #142 vor Statistikpflege umfasst 4 209
  Nettozeilen. Gemeinsame Agenten-Guidance blieb nach dokumentierter Pruefung
  unveraendert; es entstand keine neue dauerhafte Agentenregel.

*The Windows orchestrator now derives CheckOnly, Preview, and Update from one
mode and validates Python 3 plus PSScriptAnalyzer 1.25.0 before dependent
mutation. Transient Git network failures use bounded retries. Every WinGet
subprocess has a hard timeout and process-tree cleanup; administrator work that
cannot finish unattended becomes DEFERRED_ADMIN_REQUIRED without bypassing
UAC. Atomic hash-bound resume evidence accepts only exact self-created dirty
state, while propagation separates 93 reproduced raw differences from three
actionable content changes. The eleven-preset profile, canonical package IDs,
and run-ID/exitcode truth are preserved. Ten Windows contract tests, existing
maintenance and Home Sync suites, 146 statistics assertions, parser checks,
and PSScriptAnalyzer pass locally. The exact PR #142 delta before statistics is
4,209 net lines.*

### 2026-07-28 - Linux-Ein-Kommando-Wartung gehaertet / Linux one-command maintenance hardened

- Die Linux-Paket- und CLI-Registries werden vor der Ausfuehrung vollständig
  eingelesen. Dadurch kann kein stdin-lesender Kindprozess nachfolgende
  Eintraege verschlucken; jeder Eintrag erzeugt genau ein geordnetes Ergebnis.
- Begrenzte Prozessgruppen-Probes unterscheiden `Missing`, `Unusable`,
  `TimedOut` und `CapabilityBlocked`, bereinigen Kindprozesse und halten
  Evidence frei von Umgebungsgeheimnissen. Required-Fehler bleiben mit
  Exitcode 1 blockierend, waehrend reine Optional-Abweichungen nicht
  fehlschlagen.
- Swiftly 1.1.2 und Swift 6.3.3 besitzen festgeschriebene Plattform-, URL- und
  SHA-256-Vertraege fuer Ubuntu 22.04/24.04 auf x86_64 und aarch64. Die
  Installation veraendert kein Shellprofil, wird im laufenden Prozess aktiviert
  und fuehrt privilegierte Nacharbeiten nur mit ausdruecklicher
  `--allow-admin-prompts`-Autoritaet aus.
- Der Flottenorchestrator importiert die Kind-Ergebnisse und schreibt seinen
  Abschluss atomar genau einmal – auch bei spaeten Fehlern, `INT` und `TERM`.
  Dreizehn fokussierte Linux-Tests sowie 52 entdeckte Vertragstests sind gruen.
- Check-only und Dry-run blieben mutationsfrei und meldeten neun fehlende
  Required-Formeln, 25 bereits schmutzige Flotten-Worktrees und sieben fehlende
  SecureCaseTracker-Ziele. Diese technischen Gates wurden nicht umgangen; ein
  echter Paketlauf blieb deshalb bewusst aus. Das exakte Delta vor
  Statistikpflege umfasst 4 054 Nettozeilen.

*Linux package and CLI registries are snapshotted before execution, so a child
process consuming stdin cannot hide later entries and every item produces one
ordered result. Bounded process-group probes distinguish missing, unusable,
timed-out, and capability-blocked tools, clean up descendants, and sanitize
evidence. Required failures remain blocking while optional-only drift is
non-fatal. Pinned Swiftly 1.1.2 and Swift 6.3.3 contracts cover the official
Ubuntu 22.04/24.04 x86_64 and aarch64 matrix without mutating shell profiles;
privileged post-install work requires explicit authority. Fleet completion is
atomic and exactly once, including late errors and signals. Thirteen focused
Linux tests and 52 discovered contract tests pass. Mutation-free previews
reported real package and fleet drift, so no technical gate was bypassed and
no forced package run occurred. The exact pre-statistics delta is 4,054 net
lines.*

### 2026-07-28 - Lernreihen-Governance und KI-Kompetenz / Learning-Series Governance and AI Competence

- Die neue Kette auf den Positionen 33 bis 37 trennt Audit, generische
  Intake-Review-Grundlage, lernreihenspezifische Preset-Produktisierung,
  IHK-Pilot und globale Closure. Kein Schritt startet seinen Nachfolger
  automatisch.
- Der Audit prüft jede Lernreihe **in sich**, **an sich** und **insgesamt**.
  Acht stabile Kompetenz-IDs decken Grundlagen, sichere Nutzung, klare
  Aufträge, unabhängige Verifikation, begrenzte Werkzeuge, agentische
  Stop-/Resume-Abläufe, Verantwortung und Reflexion ab.
- Vier Quellenstatus verhindern, dass lokale KI-Zukunftskompetenz als bereits
  amtlich vorgeschriebener oder prüfungsrelevanter Inhalt erscheint.
- Fünf Authoring-Receipts, fünf Einzelreviews und der gemeinsame Series-Review
  sind in Bash und PowerShell `Ready`. Der globale Graph umfasst 39 Ziele,
  drei Roots und 46 eindeutige, reihenfolgekonforme, azyklische
  Abhängigkeiten. Position 3 bleibt der einzige `Eligible`-Kandidat.
- Das gemessene fachliche Delta vor Statistikpflege umfasst 1 816
  Nettozeilen. Weder ein Preset noch ein Spec-Kit-Feature- oder Lernendenlauf
  wurde gestartet.

*The new items 33 through 37 separate auditing, the generic Intake Review
foundation, learning-series preset productization, an IHK field pilot, and
final closure. Eight stable AI competence IDs and four source statuses make
safe agent use, independent verification, human responsibility, and the
difference between official requirements and project future skills explicit.
Five receipts, five individual reviews, and the combined series review are
Ready in Bash and PowerShell. The global graph contains 39 targets, three
roots, and 46 unique acyclic dependencies; item 3 remains the sole Eligible
candidate. No preset, Spec Kit feature, or learner run was started. The exact
pre-statistics delta is 1,816 net lines.*

### 2026-07-29 - Preset-Profil- und Worktree-Härtungsintake v1.3 / Preset Profile and Worktree Hardening Intake v1.3

- Die bestehende Intake-ID und Position 3 bleiben erhalten. Der Inhalt bindet
  nun die gemergten Windows-/Linux-Features 015/016 als Regressionsbasis.
- Die Remote-Freshness-Barriere umfasst Level 0 und 43 aktive
  Manifest-Git-Ziele einschließlich Preset-Repositories. Das Collection-Ziel
  wird getrennt und ohne Git-Netzwerkzugriff inventarisiert.
- Der aktuelle Elf-Preset-Stand ist Feldnachweis für einen dynamischen
  Profilkatalog und keine feste Programmgrenze.
- Exakte Bereinigungsfreigaben nach Zustandswechseln, begrenzte
  Netzwerk-Evidence, sichere Lease-Grenzen und Exact-Head-Revalidierung sind
  als PWH-016 bis PWH-020 und AC-018 bis AC-027 ergänzt.
- Der erneuerte Schema-1.1-Review ist `Ready`: 39 Ziele, drei Roots, 46
  eindeutige azyklische Abhängigkeiten, null Findings und genau Position 3 als
  `Eligible`.
- Das fachliche Delta vor Statistikpflege umfasst 2 453 Nettozeilen. Feature
  017, Specify und Autonomous wurden nicht gestartet.

*The stable intake identity and position 3 now bind the merged Windows/Linux
Features 015 and 016 as regression evidence. The freshness barrier covers
Level 0 plus 43 active manifest Git targets, while the collection is reported
separately. Eleven presets are evidence for a dynamic catalog rather than a
coded limit. Exact cleanup authority, bounded network evidence, lease safety,
and exact-head revalidation are explicit. The renewed schema-1.1 review is
Ready with 39 targets, three roots, 46 unique acyclic dependencies, no
findings, and position 3 as the sole Eligible candidate. The exact
pre-statistics delta is 2,453 net lines. Feature 017, Specify, and Autonomous
were not started.*

### 2026-07-29 - Feature 017 Preset-Profil-, Branch- und Worktree-Härtung / Preset Profile, Branch, and Worktree Hardening

- Die Remote-Freshness-Barriere inventarisiert Level 0, alle aktiven
  Manifest-Git-Ziele und das getrennte Collection-Ziel vollständig, bevor
  eine Fachmutation erlaubt werden kann.
- Default-Branch, Tracking-Ref und exakter Commit werden aus lokaler oder
  entfernter symbolischer HEAD-Evidence gebunden. Nur ein sauberer,
  kanonischer, eindeutig zugeordneter Behind-only-Checkout darf per
  Fast-forward aktualisiert werden.
- Eigentumsgebundene Worktree-Leases schützen aktive, fremde, manipulierte,
  verlassene und PID-wiederverwendete Zustände. Breite Checkout-Bereinigung
  bleibt ausgeschlossen.
- Preset-Profile werden dynamisch aus dem Katalog aufgelöst. Elf Presets sind
  der aktuelle Feldnachweis und keine feste Programmgrenze.
- 60 lokale Tests, 20 Provider-Jobs auf Ubuntu, macOS und Windows,
  PSScriptAnalyzer, Homogeneity, Secret-Scan und acht providerneutrale Gates
  bestanden. PR #153 wurde am exakten Head
  `7c46069b40cce595091440de18741d59ca48a3d1` gemergt.
- Home Runtime ist synchron. Der reale `--check-only`-Lauf inventarisierte
  alle Ziele, löste alle kurzlebigen Preset-Worktrees auf und blieb wegen
  vorhandener Flotten- und Propagationsdrift korrekt fail-closed.
- Der kausale Series-Closeout enthält 38 aktive Ziele, drei Roots und 45
  Abhängigkeiten. Position 4 ist der einzige `Eligible`-Kandidat; kein
  Folgefeature wurde gestartet.

*The Remote Freshness Barrier inventories Level 0, every active manifest Git
target, and the separate collection before domain mutation can be authorized.
Symbolic remote evidence binds the default branch, tracking ref, and exact
commit; only a clean canonical behind-only checkout may fast-forward. Owned
worktree leases protect active, foreign, tampered, abandoned, and PID-reused
state. Preset profiles resolve dynamically. Sixty local tests, twenty
cross-platform provider jobs, and eight provider-neutral gates passed before
PR #153 merged the exact reviewed head. Home Runtime is synchronized. The real
check-only run remained fail-closed on existing fleet drift, and the causal
Series closeout publishes 38 targets, three roots, and 45 dependencies with
item 4 as the sole Eligible candidate without starting it.*

### 2026-07-29 - Intake-Update Agentic-Workspace-Wartungs-TUI / Agentic Workspace Maintenance TUI Intake Update

- Das Lastenheft fuer Position 4 bildet jetzt die abgeschlossenen
  Wartungshaertungen 015 bis 017 als erneut zu pruefende Gate-Evidence ab.
- Ereignisstrom, atomarer Abschlussbericht und Prozess-Exitcode besitzen
  getrennte Verantwortungsgrenzen. `PARTIAL`, Mutation Barrier, sichere
  Pull-Entscheidungen, Worktree-Leases und dynamische Preset-Profile bleiben
  wahrheitsgetreu sichtbar.
- Spectre.Console und Spectre.Console.Testing sind fuer die spaetere
  Implementierung auf die aktuelle stabile Version `0.57.2` mit Locked
  Restore und Supply-Chain-Nachweis festgelegt.
- Authoring- und Series-Receipts wurden mit bytegleichen Archiven erneuert.
  Der Schema-1.1-Review ist `Ready`: 38 Ziele, drei Roots, 45
  Abhaengigkeiten, null Findings und Position 4 als einziger bevorzugter
  `Eligible`-Kandidat.
- Der Autonomous-Prompt verwendet `MergeAndSync`, ohne der Wartungs-Engine
  Remote-, Provider-, Bereinigungs- oder Administratorautoritaet fuer
  Ziel-Repositories zu erteilen. Feature 018 wurde nicht gestartet.

*The item-4 intake now binds completed Features 015 through 017 as
revalidated gate evidence. Live events, atomic final reports, process exits,
partial results, fleet barriers, safe pull decisions, leases, and dynamic
profiles retain truthful boundaries. The future implementation pins the
stable Spectre packages at 0.57.2. Hash-bound authoring and series
supersessions plus a Ready schema-1.1 review preserve 38 targets, three roots,
45 dependencies, and item 4 as the sole preferred Eligible candidate.
MergeAndSync delivery grants no maintenance-target authority, and Feature 018
was not started.*

### 2026-07-29 - Feature 018 Agentic-Workspace-Wartungs-TUI / Agentic Workspace Maintenance TUI

- Die argumentlose interaktive Ausführung startet die optionale
  Spectre.Console-Oberfläche. Parametrisierte oder umgeleitete Aufrufe bleiben
  auf dem bisherigen Headless-Pfad.
- `DryRun` ist ausdrücklich vorausgewählt. Schreibende Optionen und der
  eigentliche Lauf benötigen getrennte, standardmäßig verneinte
  Bestätigungen.
- Ein benutzerprivater append-only JSONL-Kanal zeigt Phasen und Findings.
  Ungültige Daten erzeugen dauerhaft `EVENT_STREAM_DEGRADED`; Abschlussbericht
  und Prozess-Exitcode bleiben die Wahrheit.
- Der plattformgebundene, inhaltsadressierte Cache veröffentlicht nur
  vollständige Locked-Restore-Builds atomar. Jede Vorbereitungslücke fällt vor
  Engine-Start auf den funktional gleichen Plain-Assistenten zurück.
- 62 .NET-Tests, 14 fokussierte Wrapper-Tests und 79 vollständige
  Wartungsregressionen sind lokal grün. Die exakte macOS-/Ubuntu-/Windows-
  Matrix, Supply Chain, Dokumentation, PowerShell und Homogeneity bestehen.
- PR #160 mergte den exakten geprüften Head. Home Runtime ist synchron, und
  beide providerneutralen Gate-Validatoren akzeptieren alle acht Gates.
- Der kausale Closeout archiviert Position 4 und veröffentlicht 37 aktive
  Ziele, drei Roots und 44 Kanten. D4 ist der einzige `Eligible`-Kandidat und
  wurde nicht gestartet.
- Das Delta vor Statistikpflege umfasst 7 639 Nettozeilen. Die TUI erteilt
  keine Commit-, Push-, PR-, Merge-, Secret-, Cleanup- oder Adminautorität für
  Ziel-Repositories.

*Interactive no-argument execution starts the optional Spectre.Console UI,
while parameterized or redirected calls retain the existing headless path.
DryRun is an explicit default and mutation remains separately confirmed. A
private append-only event channel supports live status only; permanent
degradation is visible and the finalized report plus process exit remain
canonical. The platform-bound content-addressed cache publishes only complete
locked builds and otherwise selects the equivalent plain assistant before
engine start. Sixty-two .NET tests, fourteen focused wrapper tests, and
seventy-nine full maintenance regressions pass locally and in the exact
cross-platform provider matrix. PR #160 merged the reviewed head, Home Runtime
is synchronized, and the causal closeout publishes 37 targets, three roots,
and 44 edges with D4 as the sole Eligible candidate without starting it.*

### 2026-07-29 - D4-Dokumentationsaudit-Intake aktualisiert / D4 documentation audit intake refreshed

- D4 bindet nun ausdrücklich die gemergten Implementierungs- und
  Abschlussnachweise der Features 015 bis 018.
- Die neuen Anforderungen `DIA-019` bis `DIA-023` und Abnahmekriterien
  `AC-DIA-013` bis `AC-DIA-017` prüfen die Dokumentationswirklichkeit der
  Remote-Freshness-, Pull-, Worktree-, Preset- und Wartungsoberflächenverträge.
- Die Wartungsoberflächen-Matrix umfasst Enhanced-, Plain- und Headless-Modus,
  sichere Vorschau und Bestätigung, JSONL-Live-Evidence, kanonischen Bericht
  und Exitcode, `EVENT_STREAM_DEGRADED`, Fallback und genau einmaliges
  `Ctrl+C`.
- Authoring-Receipt, D4-Einzelreview und vollständiger Series-Review wurden
  nachvollziehbar supersediert. Die Series bleibt unverändert bei 37 Zielen,
  drei Roots und 44 Abhängigkeiten.
- Der aktualisierte Intake ist `Ready`. D4 bleibt der einzige
  `Eligible`-Kandidat, wurde in diesem Auftrag jedoch nicht gestartet.

*D4 now explicitly binds the merged implementation and closeout evidence from
Features 015 through 018. Requirements `DIA-019` through `DIA-023` and
acceptance criteria `AC-DIA-013` through `AC-DIA-017` cover the current
documentation contracts for Remote Freshness, safe pull classification,
worktree leases, dynamic preset profiles, and the enhanced, plain, and headless
maintenance surfaces. The authoring receipt, the individual D4 review, and the
complete series review were superseded with traceable evidence. Series
cardinality remains 37 targets, three roots, and 44 dependencies; D4 remains
the sole Eligible candidate and was not started.*

### 2026-08-02 - AEPS Engineering Controls Framework registriert / registered

- Der ruhende Level-0-Arbeitsstrang ist mit Aktivierungsvertrag, aktueller
  Navigation und nachvollziehbarer Documentation-Impact-Evidence registriert.
- Der Aktivierungsaudit endet fail-closed in `BlockedPreconditions`: Sieben
  RAW-Intakes besitzen noch kein aktuelles Ready-Review, alle neun
  Completion Receipts und der Series Receipt fehlen, und die kanonische
  Preset-Engineering-Analyse ist noch nicht abgeschlossen.
- Der Auftrag veroeffentlicht nur diese ruhende Registrierung. Er startet
  weder Engineering-Control-Analyse oder -Authoring noch Preset-,
  Produkt- oder Spec-Kit-Arbeit.
- Das Delta vor Statistikpflege umfasst 307 Nettozeilen. Die
  Distributionsklasse ist `sourceOnly`; ein Home-Sync ist nicht erforderlich.

*The dormant Level-0 workstream is registered with an activation contract,
current navigation, and traceable Documentation Impact evidence. Its audit
fails closed in `BlockedPreconditions`: seven RAW intakes still lack a current
Ready review, all nine Completion Receipts and the Series Receipt are missing,
and the canonical Preset Engineering analysis is incomplete. This delivery
publishes only the dormant registration and starts no control analysis or
authoring, preset or product mutation, or Spec Kit run. The pre-statistics
delta is 307 net lines; the source-only change requires no Home sync.*

### 2026-08-13 - Workspace-Storage-Wartung / Workspace storage maintenance

- Der Ein-Kommando-Lauf besitzt jetzt nach Modell-Routing und vor Abschluss
  die Profile `Safe`, `Deep` und `None`; ein echter Deep-Lauf hat eine eigene
  Bestätigung und `scripts-only` erzwingt `None`.
- Der gemeinsame Python-Vertrag prüft enthaltene, symlinkfreie, ignorierte und
  nicht getrackte Buildausgaben, sieben Tage Aufbewahrung, Pressure Mode unter
  15 Prozent freiem Speicher, native Cache-Provider und ausschließlich
  dangling Container-Images ohne Volumes.
- Kuratierte Non-MSL-Adapter übernehmen die dokumentierten C89-/6502- und
  C++14-Begründungen von `cc65` und `tvision`. Eine schreibfreie Live-Inventur
  erkannte 3 165 238 953 Bytes sichere Kandidaten und schützte die cc65-
  Sample-, Image-, Map-, Label- und Debug-Evidence; keine Datei wurde gelöscht.
- 13 Storage-Tests, 69 TUI-Tests, 27 Fleet-Vertragstests und 19 Wrapper-Tests
  bestanden. PSScriptAnalyzer 1.25.0 meldete für 163 Dateien keine Error- oder
  Warning-Befunde. Documentation Impact ist `UpdateRequired` plus
  `GeneratedUpdate`; die Home Runtime benötigt Synchronisation.
- Das Delta vor Statistikpflege umfasst 3 067 Nettozeilen.

*One-command maintenance now runs the `Safe`, `Deep`, or `None` storage profile
after model-routing and before final verification. Update Deep has a separate
confirmation and scripts-only enforces None. The shared contract proves path,
Git, symlink, retention, pressure, provider, and dangling-image boundaries.
Curated non-MSL adapters preserve the documented cc65 C89/6502 and tvision
C++14 justifications. A read-only live inventory found 3,165,238,953 safe
candidate bytes while preserving cc65 build evidence; no file was deleted.
The pre-statistics delta is 3,067 net lines and the Home Runtime requires sync.*

### 2026-08-15 - Autonomous-Evidence-Integrity-Gate-Intakes / Autonomous evidence integrity gate intakes

- Zwei getrennte, reviewbereite Intakes fuer Preset-Kandidatenhaertung und
  unabhaengigen Feldnachweis angelegt. Der erste Lauf darf nur einen
  unveroeffentlichten v0.4.0-Kandidaten erzeugen; Release, Flotten-Rollout und
  Series-Closeout bleiben dem zweiten Lauf vorbehalten.
- Die aktive Series wurde nachvollziehbar von 32 Zielen, drei Roots und 36
  Kanten auf 34 Ziele, eine Root und 40 Kanten erweitert. Der vorherige Stand
  und sein Review bleiben bytegleich archiviert.
- Beide Einzelreviews sowie der neue Schema-1.1-Series-Review sind `Ready`.
  Bash und PowerShell bestaetigen Intake-Hashes, Request-Bindung, Root-Abdeckung
  und den azyklischen Graphen. Es wurde noch kein Feature-Lauf gestartet.
- Documentation Impact ist `UpdateRequired`; die Abarbeitungsreihenfolge und
  Validierungs-Evidence wurden synchron aktualisiert. Die Aenderung ist
  `sourceOnly`, deshalb ist kein Home-Sync erforderlich.

*Two separate reviewed intakes now govern candidate hardening and independent
field validation. The active series moved traceably from 32 targets, three
roots, and 36 edges to 34 targets, one root, and 40 edges while preserving the
prior state byte-for-byte. Both single reviews and the bound schema-1.1 series
review are Ready in Bash and PowerShell. No feature run has started; the
source-only documentation change requires no Home sync.*

### 2026-08-15 - Autonomous-Evidence-Integrity-Haertung / Autonomous evidence integrity hardening

- Der Kandidat prueft geaenderte getrackte Dateien und ausdruecklich benannte
  unversionierte Lieferdateien read-only. Ignorierte, fehlende, doppelte,
  ausbrechende oder whitespace-fehlerhafte Pfade werden fehlgeschlossen.
- Exitcode null beendet eine geroutete Phase nur zusammen mit einem gueltigen
  strukturierten Ergebnis, vollstaendigen Aufgaben, bestandenen Gates und
  gebundenem Payload-Hash.
- Schema 2.0 trennt `PreMerge` und `PostMerge`. Historisches Schema 1.0 kann
  keinen neuen Merge autorisieren.
- Der Quellkandidat bleibt unveroeffentlicht. G2B muss Feldtest, Release,
  versionierten ZIP-Smoke, Adoption und Flottenabschluss unabhaengig pruefen.

*The candidate validates changed tracked files and explicitly named untracked
delivery files without changing Git state. A zero exit code completes a routed
phase only with a valid structured result, complete tasks, satisfied gates, and
a bound payload hash. Schema 2.0 separates PreMerge from PostMerge, while
historical schema 1.0 cannot authorize a new merge. The source candidate remains
unreleased until independent G2B field validation.*

## Gesamtstatistik / Overall Statistics

<!-- project-statistics-v2:begin -->

Profil 2 verwendet Git-getrackte Textdateien und sichtbare Git-Aktivitaet. Die Werte beschreiben Lieferdichte, keine persoenliche Arbeitszeit.

*Profile 2 uses Git-tracked text files and visible Git activity. The values describe delivery density, not personal working time.*

| Kennzahl / Metric | Wert / Value |
|---|---:|
| Textbasis / Text base | 660848 lines |
| Textdateien / Text files | 3392 |
| Beobachtbarer Zeitraum / Observable period | 2025-08-24..2026-08-20 |
| Aktivtage / Active days | 93 |
| Relevante Commits / Relevant commits | 765 |
| Zeilen je Aktivtag / Lines per active day | 7105.9 |
| Peak-Tag im Fenster / Peak day in window | 2026-08-01 / 161357 |
| Peak-Woche im Fenster / Peak week in window | 2026-07-26 / 284516 |
| Laengste Serie / Longest streak | 38 days |
| Speedup vs. 80 lines/day | 88.8x |
| Speedup vs. 100 lines/day | 71.1x |
| Methodik / Methodology | v2; source `9b96aef09ee5` |

### Artefaktmix / Artifact Mix

```text
Produktiv / Production          [#...................]   0.3% | 2237
Tests                           [#...................]   4.2% | 27584
Dokumentation / Documentation   [##########..........]  49.2% | 325229
Skripte / Scripts               [##..................]   9.6% | 63470
Konfiguration / Configuration   [#######.............]  36.5% | 241512
Daten und Medien / Data and media [....................]   0.0% | 0
Sonstiger Text / Other text     [#...................]   0.1% | 816
```

Die Balken teilen die aktuelle getrackte Textbasis in stabile Kategorien. Prozent und Zeilenwert sind die genaue, textorientierte Aussage.

*The bars split the current tracked text base into stable categories. Percentages and line counts provide the exact text-first result.*

### Tagesaktivitaet / Daily Activity

```text
Wochen / Weeks 01..26 | 2025-08-24..2026-02-21
So/Su  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Mo/Mo  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Di/Tu  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Mi/We  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Do/Th  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Fr/Fr  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
Sa/Sa  0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0
```

```text
Wochen / Weeks 27..52 | 2026-02-22..2026-08-22
So/Su  0 0 0 0 0 0 3 3 0 4 0 0 0 0 2 0 4 0 4 4 4 4 4 4 4 4
Mo/Mo  0 0 0 0 0 0 3 3 4 0 3 0 0 0 0 0 0 0 4 4 4 4 3 0 2 1
Di/Tu  0 0 0 0 0 4 0 3 1 2 0 0 0 3 0 0 0 0 2 4 4 4 4 0 0 0
Mi/We  0 0 0 0 0 4 4 3 2 3 0 0 0 0 1 0 4 0 4 4 4 4 4 4 0 4
Do/Th  0 0 0 0 0 4 0 3 2 4 0 0 3 2 1 4 0 0 2 4 3 4 4 0 4 4
Fr/Fr  0 0 0 0 0 4 4 1 4 0 0 0 1 2 2 1 4 2 3 4 3 4 4 4 3 -
Sa/Sa  0 0 0 0 0 2 4 3 4 0 0 0 0 0 0 0 4 4 4 4 4 4 4 4 4 -
```

DE: 0 = keine Aenderung; 1 = 1..79; 2 = 80..399; 3 = 400..1599; 4 = 1600+ geaenderte Textzeilen; - = noch nicht abgelaufen.

*EN: 0 = no change; 1 = 1..79; 2 = 80..399; 3 = 400..1599; 4 = 1600+ changed text lines; - = not elapsed.*

### Wochenvolumen / Weekly Volume

```text
Wochen / Weeks 01..26 | 2025-08-24..2026-02-21
Keine Aktivitaet / No activity
```

```text
Wochen / Weeks 27..52 | 2026-02-22..2026-08-22
  cap 500000 | . . . . . . . . . . . . . . . . . . . . . . . . . .
      416667 | . . . . . . . . . . . . . . . . . . . . . . . . . .
      333333 | . . . . . . . . . . . . . . . . . . . . . . . . . .
      250000 | . . . . . . . . . . . . . . . . . . . . . . # . . .
      166667 | . . . . . . . . . . . . . . . . . . . . . . # . . .
       83333 | . . . . . . . . . . . . . . . . . . . # . # # . . .
           0 +-----------------------------------------------------
```

Das Wochenvolumen zeigt Additionen plus Loeschungen. Es ist Aenderungsaktivitaet, nicht die aktuelle Groesse des Repositories.

*Weekly volume shows additions plus deletions. It represents change activity, not the current repository size.*

### Kumulative Entwicklung / Cumulative Development

```text
Wochen / Weeks 01..26 | 2025-08-24..2026-02-21
Keine Aktivitaet / No activity
```

```text
Wochen / Weeks 27..52 | 2026-02-22..2026-08-22
 cap 1000000 | . . . . . . . . . . . . . . . . . . . . . . . . . .
      833333 | . . . . . . . . . . . . . . . . . . . . . . . . . .
      666667 | . . . . . . . . . . . . . . . . . . . . . . # # # #
      500000 | . . . . . . . . . . . . . . . . . . . . . . # # # #
      333333 | . . . . . . . . . . . . . . . . . . . . . # # # # #
      166667 | . . . . . . . . . . . . . . . . . . . # # # # # # #
           0 +-----------------------------------------------------
```

Die kumulative Kurve summiert nur das Brutto-Aenderungsvolumen im Fenster. Sie darf nicht als aktuelle Codebasis gelesen werden.

*The cumulative curve sums gross change volume within the window only. It must not be read as the current code base.*

### Phasenvolumen / Phase Volume

```text
Slots 0..15
   cap 50000 | . . . . . . . . . . . . . . . .
       41667 | . . . . . . . . . . . . . . . .
       33333 | . . . . . . . . . . . . . . . .
       25000 | . # . . . . . . . . . . . . . .
       16667 | . # . . . . . . . # . . . . . .
        8333 | . # . . # . # # . # . . . . . .
           0 +---------------------------------
             00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15
```

```text
Slots 16..31
   cap 10000 | . . . . . . . . . . . . . . . .
        8333 | . . . . . . . . . . . . . . . .
        6667 | . . . . . . . . . . . . . . . .
        5000 | # . . . . . . . . . . # . . . .
        3333 | # . . . . . . . . . . # . . . .
        1667 | # . . . # . . . # . . # . . # #
           0 +---------------------------------
             16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31
```

```text
Slots 32..47
   cap 50000 | . . . . . . . . . . . . . . . .
       41667 | . . . . . . . . . . . . . . . .
       33333 | . . . . . . . . . . . . . . . .
       25000 | . # . . . . . . . . . . . . . .
       16667 | . # . . . . . . . . . . . . . .
        8333 | . # . . . . # . . . . . . . . .
           0 +---------------------------------
             32 33 34 35 36 37 38 39 40 41 42 43 44 45 46 47
```

```text
Slots 48..63
  cap 200000 | . . . . . . . . . . . . . . . .
      166667 | . . . . . . . . . . . . . . . .
      133333 | . . . . # . . . . . . . . . . .
      100000 | . . . . # . . . . . . . . . . .
       66667 | . . . . # . . . . . . . . . . .
       33333 | . . . . # . . . . . . . . . . .
           0 +---------------------------------
             48 49 50 51 52 53 54 55 56 57 58 59 60 61 62 63
```

```text
Slots 64..66
   cap 10000 | . . .
        8333 | . . .
        6667 | . . .
        5000 | . . #
        3333 | . . #
        1667 | # . #
           0 +-------
             64 65 66
```

| Slot | Phase | Nettozeilen / Net lines |
|---:|---|---:|
| 0 | Initialisierung / Initialization | 954 |
| 1 | Spec-Kit-Batch / Spec Kit batch | 26519 |
| 2 | Publikation / Publication | 6168 |
| 3 | CI und 003 / CI and 003 | 1523 |
| 4 | Governance-Ausbau / Governance expansion | 10769 |
| 5 | Projektpflege / Project maintenance | 686 |
| 6 | Governance-Presets / Governance presets | 8733 |
| 7 | Autonome Laeufe / Autonomous runs | 9639 |
| 8 | Paralleler Feldtest / Parallel field test | 5323 |
| 9 | Flottenrollout / Fleet rollout | 19465 |
| 10 | Skriptkatalog und Quellmigration / Script catalog and source migration | 2731 |
| 11 | Ein-Kommando-Wartungsintake / One-command maintenance intake | 720 |
| 12 | Wartungs-TUI-Intake / Maintenance TUI intake | 679 |
| 13 | Home-Sync v2 und Betriebslernen / Home Sync v2 and operations learning | 513 |
| 14 | Intake-Review-Flottenprofil / Intake review fleet profile | 1879 |
| 15 | Intake-Review-Flottenabschluss / Intake review fleet closeout | 48 |
| 16 | Intake-Authoring-Preset v0.1.0 / Intake authoring preset v0.1.0 | 6337 |
| 17 | Intake-Authoring-Flottenabschluss / Intake authoring fleet closeout | 357 |
| 18 | Windows-Wartungshaertungsintake / Windows maintenance hardening intake | 576 |
| 19 | Linux-/Ubuntu-Wartungshaertungsintake / Linux and Ubuntu maintenance hardening intake | 637 |
| 20 | Aktive Intake-Creator-Normalisierung / Active Intake Creator normalization | 3046 |
| 21 | Intake-Authoring-v0.1.1-Release-Adoption / Intake Authoring v0.1.1 release adoption | 55 |
| 22 | Intake-Authoring-v0.1.1-Flottenabschluss / Intake Authoring v0.1.1 fleet closeout | 116 |
| 23 | Level-2-Intake-Normalisierung / Level 2 intake normalization | 188 |
| 24 | Intake-Review-v0.1.1-Series-Graph-Härtung / Intake Review v0.1.1 series graph hardening | 1830 |
| 25 | Intake-Review-v0.1.1-Release-Adoption / Intake Review v0.1.1 release adoption | 86 |
| 26 | Intake-Review-v0.1.1-Flotten- und Series-Abschluss / Intake Review v0.1.1 fleet and Series closeout | 279 |
| 27 | Intake-Authoring-v0.2.0-CRUD-URL-Series / Intake Authoring v0.2.0 CRUD URL series | 5768 |
| 28 | Intake-Authoring-v0.2.0-Flottenabschluss / Intake Authoring v0.2.0 fleet closeout | 125 |
| 29 | Intake-Authoring-v0.2.0-Community-Katalogabschluss / Intake Authoring v0.2.0 community catalog closeout | 29 |
| 30 | Plattformübergreifende Ein-Kommando-Wartung / Cross-platform one-command maintenance | 2585 |
| 31 | Intake-Sequencing-Preset v0.1.0 / Intake sequencing preset v0.1.0 | 3231 |
| 32 | Canonical-Fleet-Wartungshärtung / Canonical fleet maintenance hardening | 388 |
| 33 | Dokumentations-Wirklichkeitsaudit / Documentation reality audit | 31164 |
| 34 | Documentation-Impact-Governance / Documentation Impact governance | 1407 |
| 35 | Dokumentations-Wirklichkeitsabgleich Flotte / Documentation reality remediation fleet | 2359 |
| 36 | Requirements-Intake-Konsolidierungsübergabe / Requirements intake consolidation handoff | 397 |
| 37 | Requirements-Intake-Konsolidierung / Requirements intake consolidation | 7338 |
| 38 | Requirements-Intake-Schema-2-Flottenübernahme / Requirements intake schema-2 fleet adoption | 10918 |
| 39 | Intake-Sequencing-v0.2.2-Profilabgleich / Intake Sequencing v0.2.2 profile alignment | 3348 |
| 40 | Dokumentationsarchitektur-Intake-Kette / Documentation architecture intake chain | 2672 |
| 41 | Windows-Ein-Kommando-Wartungshärtung / Windows one-command maintenance hardening | 4209 |
| 42 | KDM-/KITSM-Lernreihen-Intake-Kette / KDM/KITSM learning-series intake chain | 3795 |
| 43 | ITSE-Lernreihen- und Gesamtkonsistenz-Intakes / ITSE learning-series and consistency intakes | 3607 |
| 44 | Linux-Ein-Kommando-Wartungshärtung / Linux one-command maintenance hardening | 4054 |
| 45 | Lernreihen-Governance- und KI-Kompetenz-Intakes / Learning-series governance and AI competence intakes | 1816 |
| 46 | Preset-Profil- und Worktree-Härtungsintake v1.3 / Preset profile and worktree hardening intake v1.3 | 2453 |
| 47 | Preset-Profil-, Branch- und Worktree-Härtung / Preset profile, branch and worktree hardening | 3751 |
| 48 | Agentic-Workspace-Wartungs-TUI / Agentic workspace maintenance TUI | 7639 |
| 49 | Level-0-Phase-2-Readiness-Korrekturen / Level 0 phase 2 readiness corrections | 511 |
| 50 | AOC-Level-0-/Level-1-Handoff-Abschluss / AOC Level 0/Level 1 handoff closeout | 5 |
| 51 | Wartungs-TUI- und Wrapper-Regressionshärtung / Maintenance TUI and wrapper regression hardening | 1828 |
| 52 | Dokumentations-Informationsarchitektur-Audit / Documentation information architecture audit | 134145 |
| 53 | Agentic-Workspace-Effizienzleitfaden / Agentic workspace efficiency guide | 3067 |
| 54 | AEPS-Engineering-Controls-Registrierung / AEPS Engineering Controls registration | 307 |
| 55 | Level-0-Checkout- und Public-Template-Intake / Level 0 checkout and public template intake | 1036 |
| 56 | RL-SE-/Checklist-Selbstpruefungsintake-Reparatur / RL-SE checklist self-assessment intake repair | 1549 |
| 57 | Ausgewogenes Spec-Kit-Modell-Routing / Balanced Spec Kit model routing | 4810 |
| 58 | RL-SE-Selbstpruefung: Planungscheckpoint / RL-SE self-assessment planning checkpoint | 2613 |
| 59 | RL-SE-/Checklist-Selbstpruefung / RL-SE checklist self-assessment | 2932 |
| 60 | RL-SE-Selbstpruefung: kausaler Abschluss / RL-SE self-assessment causal closeout | 1586 |
| 61 | Home-Runtime-Container-Sync / Home Runtime container sync | 238 |
| 62 | Wartungs-Toolchain-JSON-Ergebnishaertung / Maintenance toolchain JSON result hardening | 452 |
| 63 | CLion-/tvision-Flottenaufnahme / CLion and tvision fleet onboarding | 50 |
| 64 | Workspace-Storage-Wartung / Workspace storage maintenance | 3013 |
| 65 | Required-PowerShell-Erweiterung fuer VS Code / Required PowerShell extension for VS Code | 122 |
| 66 | Flottenweite CI-Budget-Governance / Fleet-wide CI budget governance | 5388 |

Die festen Slots halten den Phasenvergleich auch bei fehlenden oder spaeter ergaenzten Werten stabil.

*Stable slots keep the phase comparison consistent when values are missing or added later.*

### Beschleunigungsfaktoren / Acceleration Factors

```text
Scale: 0..100x
80 lines/day       [##################..] 88.8x
100 lines/day      [##############......] 71.1x
```

Die Faktoren vergleichen sichtbare Lieferdichte mit den dokumentierten manuellen Referenzen. Sie messen keine Arbeitszeit.

*The factors compare visible delivery density with documented manual references. They do not measure working time.*

### Durchsatzvergleich / Throughput Comparison

```text
Scale: 0..10000 lines/day
Experienced manual [#...................] 80
Thorsten solo      [#...................] 100
Visible repository [##############......] 7105.9
```

Die gemeinsame Skala vergleicht Referenzen und sichtbare Lieferdichte. Sie schreibt die Git-Aktivitaet keiner Person oder KI pauschal zu.

*The common scale compares references with visible delivery density. It does not attribute Git activity to a person or AI by default.*

### Textalternative / Text Alternative

DE: Das Fenster beginnt am 2025-08-24 und endet am 2026-08-20. Es enthaelt 93 aktive und 269 inaktive vergangene Tage. Peak-Tag: 2026-08-01 / 161357. Peak-Woche: 2026-07-26 / 284516. Laengste Serie: 38 Tage (2026-06-26..2026-08-02).

*EN: The window starts on 2025-08-24 and ends on 2026-08-20. It contains 93 active and 269 inactive elapsed days. Peak day: 2026-08-01 / 161357. Peak week: 2026-07-26 / 284516. Longest streak: 38 days (2026-06-26..2026-08-02).*

| Monat / Month | Geaenderte Textzeilen / Changed text lines |
|---|---:|
| 2025-09 | 0 |
| 2025-10 | 0 |
| 2025-11 | 0 |
| 2025-12 | 0 |
| 2026-01 | 0 |
| 2026-02 | 0 |
| 2026-03 | 5591 |
| 2026-04 | 72825 |
| 2026-05 | 2454 |
| 2026-06 | 49106 |
| 2026-07 | 385430 |
| 2026-08 | 237060 |

<!-- project-statistics-v2:end -->
