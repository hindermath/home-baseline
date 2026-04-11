# Changelog / Änderungsprotokoll

Alle wesentlichen Änderungen werden hier dokumentiert.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · Versionsschema: [Semantic Versioning](https://semver.org/)

*All notable changes are documented here.
Format: [Keep a Changelog](https://keepachangelog.com/en/1.1.0/) · Versioning: [Semantic Versioning](https://semver.org/)*

---

## [0.6.2](https://github.com/hindermath/home-baseline/compare/v0.6.1...v0.6.2) (2026-04-11)


### Bug Fixes / Fehlerbehebungen

* **bootstrap-project.ps1:** replace npx speckit with specify CLI ([1debf14](https://github.com/hindermath/home-baseline/commit/1debf14cce652112f40b66526798fd6ece3f4c45))
* **bootstrap-project:** replace npx speckit with specify CLI ([198f4e8](https://github.com/hindermath/home-baseline/commit/198f4e803cf42f8aaef46357f1f80c4425278ae9))
* **scripts:** add -- end-of-options support to 4 scripts ([bf81fd7](https://github.com/hindermath/home-baseline/commit/bf81fd7944ec40e5e602684c792ae0a84ac16bb5))
* **scripts:** add -h/--help and guard grep against option-like project names ([fa9a799](https://github.com/hindermath/home-baseline/commit/fa9a7992a202ee9d4cf021af0b96af01728ee389))
* **teardown-workspace:** add -- end-of-options support for dash-prefixed workspace names ([49d4fed](https://github.com/hindermath/home-baseline/commit/49d4fed6895eb498211bec66e27d9f23fb7dd6b2))


### Documentation / Dokumentation

* **agents:** complete 003-git-config-scope coverage in agent files ([4b04379](https://github.com/hindermath/home-baseline/commit/4b04379e8fcb75ad993efd34d695f23c151ee2dc))
* **constitution+agents:** document teardown, -- sentinel, 005/006 in all agent files ([31ae070](https://github.com/hindermath/home-baseline/commit/31ae070a4230e77acd142946932c2c40da9ed4ee))
* **README:** document teardown workflow and glab prerequisite ([39358ee](https://github.com/hindermath/home-baseline/commit/39358eef8ca45309a51cc19143c8c18b1b699d52))
* **README:** replace npm install with uv tool install for specify-cli ([d675047](https://github.com/hindermath/home-baseline/commit/d675047341c62d8f1b192d0469801a6f55603f50))

## [0.6.1](https://github.com/hindermath/home-baseline/compare/v0.6.0...v0.6.1) (2026-04-11)


### Documentation / Dokumentation

* **constitution:** Lastenheft-Rename als Pflicht-Schritt in tasks-template und allen KI-Agenten-Dateien verankert ([5cd0dd8](https://github.com/hindermath/home-baseline/commit/5cd0dd8b82036b88aea8a5f12cb80015859d7a2b))


### Maintenance / Wartung

* rename Lastenheft to Lastenheft_Git_Config_Scope.003-git-config-scope.md ([f0dce42](https://github.com/hindermath/home-baseline/commit/f0dce42d631a82f8977da6fef9778b993f9aacec))
* rename Lastenheft to Lastenheft_GitLab_Support.006-gitlab-support.md ([e323093](https://github.com/hindermath/home-baseline/commit/e3230931f21789cad1246ebb994cf3e1aab30237))
* rename Lastenheft to Lastenheft_Workspace_Teardown.005-workspace-teardown.md ([6437fc2](https://github.com/hindermath/home-baseline/commit/6437fc2f891f6c8fed773f14198bb95aa200c032))

## [0.6.0](https://github.com/hindermath/home-baseline/compare/v0.5.3...v0.6.0) (2026-04-11)


### Features / Neue Funktionen

* **003-git-config-scope:** Git-Konfiguration Scope-Isolierung ([#12](https://github.com/hindermath/home-baseline/issues/12)) ([3531ddc](https://github.com/hindermath/home-baseline/commit/3531ddcf6918d86d2d242b3218d854fc9ff3bc8e))
* add workspace teardown flow ([d672db8](https://github.com/hindermath/home-baseline/commit/d672db886231f0d93a8413a4056c2bef7da689f0))
* add workspace teardown flow ([e65dbbb](https://github.com/hindermath/home-baseline/commit/e65dbbb787b4a134f4a4acf54aa9ba3ce8190101))
* GitLab support for bootstrap scripts ([#14](https://github.com/hindermath/home-baseline/issues/14)) ([3912807](https://github.com/hindermath/home-baseline/commit/3912807c1d0f03e76832f3099ffc90b951a4cc7d))


### Documentation / Dokumentation

* **005-workspace-teardown:** Spezifikation erstellt — 16 FRs, 4 User Stories, 6 SCs ([54a730b](https://github.com/hindermath/home-baseline/commit/54a730b2d93e26976072e4709613f3cbb25ab831))
* Lastenheft_Git_Config_Scope — Level-2-Klarstellung ergänzt ([411d5d8](https://github.com/hindermath/home-baseline/commit/411d5d80b69380ce5843e92dd852df79e9817235))

## [0.5.3](https://github.com/hindermath/home-baseline/compare/v0.5.2...v0.5.3) (2026-04-08)


### Documentation / Dokumentation

* EN Bootstrap-Liste als nummerierte Liste formatiert (analog DE) ([88d0b45](https://github.com/hindermath/home-baseline/commit/88d0b45a9e3872a051e6e0b35e58b1f79c74582e))
* Implementierungsreihenfolge prominent in alle drei Lastenheft-Dateien eingefügt ([1ef4e2c](https://github.com/hindermath/home-baseline/commit/1ef4e2c816cc7fd0edb2230cf51d7e7402f883cd))
* Lastenheft CI/CD-Pipeline und Workspace-Migration hinzugefügt (Spec-Kit-kompatibel) ([1361a02](https://github.com/hindermath/home-baseline/commit/1361a02dd121eec06f066176f9dad308369d2c9f))
* Lastenheft GitLab-Support hinzugefügt (Spec-Kit-kompatibel) ([3365f49](https://github.com/hindermath/home-baseline/commit/3365f495cd9e5ff2863941521826d0cebefb9e00))
* Lastenheft Workspace-Teardown hinzugefügt; Implementierungsreihenfolge in allen Lastenheften auf 4 Schritte erweitert ([cf09655](https://github.com/hindermath/home-baseline/commit/cf09655f953f24068877075e7cf5e4523b8ede4e))
* Lastenheft_Git_Config_Scope.md hinzugefügt; Schritt-0 in alle Lastenheft-Dateien eingetragen ([3a62e61](https://github.com/hindermath/home-baseline/commit/3a62e61c446baa30312a86c756bb3caa14e38dc7))

## [0.5.2](https://github.com/hindermath/home-baseline/compare/v0.5.1...v0.5.2) (2026-04-06)


### Bug Fixes / Fehlerbehebungen

* CHANGELOG bereinigt — v0.5.0-Heading wiederhergestellt, redundanten v0.6.0-Eintrag entfernt ([c76b0ee](https://github.com/hindermath/home-baseline/commit/c76b0ee188a95221c8cf1fcccab7d40caaaa67ad))
* CHANGELOG.md zur sync-home-Dateiliste ergänzt (sh + ps1) ([3059942](https://github.com/hindermath/home-baseline/commit/3059942c210c111a410fd501b99559d2417d0988))

## [0.5.1](https://github.com/hindermath/home-baseline/compare/v0.5.0...v0.5.1) (2026-04-06)


### Documentation / Dokumentation

* automatisch erledigte Git-Schritte in Nächste-Schritte und Schritt 3 dokumentiert ([07e9c5c](https://github.com/hindermath/home-baseline/commit/07e9c5cdd1b5f7a43d8d2b173e797a2eea33abc5))
* CHANGELOG v0.6.0 — README-Verbesserungen für End-User und Auszubildende ([626f999](https://github.com/hindermath/home-baseline/commit/626f99981d54bbccb981ab974934deb503255f65))
* GitHub/GitLab-Auth und git remote add origin in Ersteinrichtung ergänzt ([40148a4](https://github.com/hindermath/home-baseline/commit/40148a478e673822c311587ac766261d005947e3))
* Nächste-Schritte-Leitfaden und Schritt 5+6 für Auszubildende ergänzt ([b367acc](https://github.com/hindermath/home-baseline/commit/b367acc150cfa81c6cd7c8e0f09d854030795c8f))
* redundanten Abschnitt 'Neues Projekt anlegen' zu Verweis gestrafft ([eb67966](https://github.com/hindermath/home-baseline/commit/eb67966a9f80ad4d1832e9f196763d4a73e44d3e))
* Schritt Projekt anlegen in Nächste Schritte und Auszubildende ergänzt ([ae5c119](https://github.com/hindermath/home-baseline/commit/ae5c1194d6901664c64b0fb66266842e88619347))
* Spec-Kit-init-Links am Ende jedes KI-Agenten-Blocks ergänzt ([243178d](https://github.com/hindermath/home-baseline/commit/243178dc27848c6fdad7c3444ccce87695d2f8bb))

## [0.5.0](https://github.com/hindermath/home-baseline/compare/v0.4.2...v0.5.0) (2026-04-06)


### Features / Neue Funktionen

* linux-test.sh und windows-test.ps1 hinzugefuegt ([df22668](https://github.com/hindermath/home-baseline/commit/df22668d00e0ac38297a9dda9611457a122e2953))
* mac-test.sh hinzugefuegt ([f5be93c](https://github.com/hindermath/home-baseline/commit/f5be93cb073c789c717d064eea0110c2d9973939))
* mac-test.sh Script zum Sammeln von System-Info und Testergebnissen ([619f9c9](https://github.com/hindermath/home-baseline/commit/619f9c95fde8d09602737dc5055ce92acc48eaf8))


### Bug Fixes / Fehlerbehebungen

* --autostash bei git pull --rebase in Test-Scripts ([c2b7830](https://github.com/hindermath/home-baseline/commit/c2b7830f1dbfe5dc57a84bcc74f89d076fbfd209))
* -NoProfile bei pwsh-Subprozessen in windows-test.ps1 ([d7e1ceb](https://github.com/hindermath/home-baseline/commit/d7e1ceba1b34e09224077bb3f4ae673002f1acb6))
* git pull --rebase vor push in allen Test-Scripts ergaenzt ([851b6cc](https://github.com/hindermath/home-baseline/commit/851b6ccf57d8fcc9a93e54f97f50c06db5ad99ad))
* mac-test.sh fängt commit/push-Output in Datei und pusht korrekt zu main ([a6404bf](https://github.com/hindermath/home-baseline/commit/a6404bf0788f291c811fb8f45ecd19f22a9af128))
* mac-test.sh pullt vor commit/push, kein tee-a nach Commit ([27f92e7](https://github.com/hindermath/home-baseline/commit/27f92e783248448138ffa7dffb9cf1317ac0804a))
* specify zur Tool-Pruefliste in mac-test.sh ergaenzt ([ad8b8a0](https://github.com/hindermath/home-baseline/commit/ad8b8a0bc13e08f764ce2c82668a8b384dab1d0c))


### Documentation / Dokumentation

* Bekannte Fallstricke aus plattformuebergreifendem Test dokumentiert ([9b84def](https://github.com/hindermath/home-baseline/commit/9b84deff2fb32fd4170837176e94036e3ec69208))
* brew update && brew upgrade vor Tool-Installation auf macOS ergaenzt ([3b62fa0](https://github.com/hindermath/home-baseline/commit/3b62fa0a099016dd601e5761e7bc4177b1569a5f))
* mac-test.sh in README und Agenten-Dateien dokumentiert ([1bb0462](https://github.com/hindermath/home-baseline/commit/1bb046223c12f9d83829eca7ab5bdcb3566d8ff2))


### Maintenance / Wartung

* master und main zusammenführen ([e030e41](https://github.com/hindermath/home-baseline/commit/e030e415df6c471a8d605f5acc5150b29c3e1c10))

## [0.4.2](https://github.com/hindermath/home-baseline/compare/v0.4.1...v0.4.2) (2026-04-05)


### Bug Fixes / Fehlerbehebungen

* Claude Code Installationsanleitung auf nativen Installer aktualisiert ([b35977e](https://github.com/hindermath/home-baseline/commit/b35977e55953357001c17bfe66283322767abd9e))


### Documentation / Dokumentation

* Claude Code Homebrew-Installation auch fuer Linux dokumentiert ([2c75a75](https://github.com/hindermath/home-baseline/commit/2c75a75aea773bec6681782a02659e067c87739f))
* WinGet als Windows-Alternative fuer Claude Code im Code-Block ergaenzt ([df348dd](https://github.com/hindermath/home-baseline/commit/df348dda136f9a51114799a530fc55b1fda2bff8))

## [0.4.1](https://github.com/hindermath/home-baseline/compare/v0.4.0...v0.4.1) (2026-04-05)


### Bug Fixes / Fehlerbehebungen

* Compliance-Score-Ziel auf 100% korrigiert (war irrefuehrend 90%) ([f2bb993](https://github.com/hindermath/home-baseline/commit/f2bb9936d2e53076d286b847a57988d4b58adf43))
* OpenCode brew-Tap auf anomalyco/tap/opencode korrigiert ([2c0cc59](https://github.com/hindermath/home-baseline/commit/2c0cc59fa86343ec8a1d0eba3b9aa44dce1f1da1))
* sudo fuer npm install -g unter Linux ergaenzt ([a2092d1](https://github.com/hindermath/home-baseline/commit/a2092d133b7553611c08fd8a12f906158b7653da))
* sync-home erkennt Aufruf aus ~/scripts/ und nutzt home-baseline-tmp als Quelle ([b18646b](https://github.com/hindermath/home-baseline/commit/b18646b304b6d700cb75dee8190d7c0e18bb5f6b))
* sync-home initialisiert ~/ automatisch falls noch kein Git-Repo ([78d2d21](https://github.com/hindermath/home-baseline/commit/78d2d21cb3903b7eabf6dacf4d854a43110be355))
* sync-home.sh erkennt untracked Dateien nach git init ([1b2609e](https://github.com/hindermath/home-baseline/commit/1b2609e518eb2ba3643cbcce555a1a782616b3ee))


### Documentation / Dokumentation

* Arbeitsverzeichnis-Hinweis in alle Agenten-Dateien ergaenzt ([4f1fc46](https://github.com/hindermath/home-baseline/commit/4f1fc46c10e670bf07ab88eaa6648f5f99676759))
* Codex bubblewrap-Hinweis fuer Linux ergaenzt ([7038e8e](https://github.com/hindermath/home-baseline/commit/7038e8eadfa3ac30037f284d1cfe8bbf7b8df8d1))
* Codex CLI ChatGPT-Anmeldung als Option 2 ergaenzt ([88f760a](https://github.com/hindermath/home-baseline/commit/88f760ab803d136c39a3b42a8dd6895924ddf144))
* Daily-Sync-Abschnitt um Auto-Detect-Hinweis und optionalen Compliance-Check ergaenzt ([963807d](https://github.com/hindermath/home-baseline/commit/963807dbb57ed54e3f71ea51591369cec48af12a))
* DE/EN-Labels und Trennung unter 'So nutzt du dieses Template' ergaenzt ([43fcab9](https://github.com/hindermath/home-baseline/commit/43fcab9c569f1b946930b794ce9407d2c2b275ac))
* EN-Schritte unter 'So nutzt du dieses Template' als nummerierte Liste formatiert ([85b3caa](https://github.com/hindermath/home-baseline/commit/85b3caa5db2d3b2383541e5195105cbc479c76f1))
* fehlende EN-Uebersetzungen in README ergaenzt ([bbb35a2](https://github.com/hindermath/home-baseline/commit/bbb35a2c3cf0859d572b9ad931407da8bf73c5db))
* gh CLI Clone-Alternative in Ersteinrichtung und Template-Entwickler-Workflow ergaenzt ([4434c2d](https://github.com/hindermath/home-baseline/commit/4434c2d4b02c86f44bb474b0b9fdc61800c8be9f))
* install-hooks Schritt nach git clone in Template-Entwickler-Workflow ergaenzt ([b20532c](https://github.com/hindermath/home-baseline/commit/b20532c554301fd88279b7e7a6d7b923013ab211))
* KI-Agent-Workflow in "Aenderungen am Template entwickeln" ergaenzt ([e19a96a](https://github.com/hindermath/home-baseline/commit/e19a96a8c236189032d4261e3f4bbe304ffe8aaf))
* KI-Agenten-Installation plattformspezifisch dokumentiert ([d574a77](https://github.com/hindermath/home-baseline/commit/d574a7706ff023e946c6d4e78ff4d4cb255f25be))
* OpenCode brew-Installation auch fuer Linux dokumentiert ([4ddc564](https://github.com/hindermath/home-baseline/commit/4ddc564e49c6183e58fabd49fd117e84057efb39))
* OS-Detection Skript-Auswahl in alle Agenten-Dateien ergaenzt ([b3f0c1e](https://github.com/hindermath/home-baseline/commit/b3f0c1e24044261ef375f58a216c814c247fa1af))
* specify-cli Installation und Spec-Kit-Doku erweitert ([9ed50f4](https://github.com/hindermath/home-baseline/commit/9ed50f4b5a9063dea235e83c3238e780675fb616))
* speckit.checklist und speckit.analyze in Workflow ergaenzt ([3996489](https://github.com/hindermath/home-baseline/commit/3996489923915c460a1a2c2818577d15372d60ce))
* Template-Updates-Workflow dokumentiert (upstream remote + merge) ([fde29f2](https://github.com/hindermath/home-baseline/commit/fde29f2956ef2d562dfe511a4cfb42e8abdd37b4))
* Template-URL auf github.com/hindermath/home-baseline gesetzt ([18aaf03](https://github.com/hindermath/home-baseline/commit/18aaf038819cc815eee9d1f8ef1f6fee74db28fd))
* TOC vollstaendig auf bilinguales Format aktualisiert ([b9aace7](https://github.com/hindermath/home-baseline/commit/b9aace78a37a626d6d6d40b2d23384984f3f04a9))
* upstream-Sync mit 3 Strategien und Beispiel-Kommandos ergaenzt ([8faafeb](https://github.com/hindermath/home-baseline/commit/8faafeb219c227cf19a033af360c3ab79009c1f5))
* uv und specify-cli Installationsanleitung ergaenzt ([5eb179a](https://github.com/hindermath/home-baseline/commit/5eb179a4bbe1f3bb64246395a8fbd3ff57311a99))
* Zielgruppen in Ersteinrichtung und Template-Entwickler-Workflow klar abgegrenzt ([cbea7b7](https://github.com/hindermath/home-baseline/commit/cbea7b763538ee8e692a15bb2784d34385962b08))

## [0.4.0](https://github.com/hindermath/home-baseline/compare/v0.3.1...v0.4.0) (2026-04-03)


### Features / Neue Funktionen

* Release Please eingerichtet (automatisches Versioning) ([e9a8167](https://github.com/hindermath/home-baseline/commit/e9a81671be6f9b069a22f01ce35bc46cff78ba38))


### Bug Fixes / Fehlerbehebungen

* CI-Fehler in check-homogeneity behoben ([df52abf](https://github.com/hindermath/home-baseline/commit/df52abfb3f1de55ae5a52fd63a957c7395df561d))


### Documentation / Dokumentation

* Release Please in README dokumentiert ([994b06b](https://github.com/hindermath/home-baseline/commit/994b06b6d8f2fbad7a1d94b0710ab7453ea34aed))

## [Unreleased]

---

## [0.3.1] — 2026-04-03

### Fixed / Behoben

- `README.md`: 5 Zeilen der SDD-Workflow-Tabelle von 64 auf 63 Zeichen korrigiert (ein überzähliges Leerzeichen vor dem schließenden `│` je Zeile)
- `README.md`: Abschnitt „Verzeichnis für Spec-Kit vorbereiten" von manuellem `cp -r ~/home-baseline-tmp/` auf `specify init --here --ai {agent}` umgestellt; `--ai-skill` als Codex-spezifisch dokumentiert

### Docs / Dokumentation

- Alle 4 Agenten-Dateien mit neuen Known Pitfalls ergänzt: ASCII-Tabellen-Alignment, `specify init`-Syntax

---

## [0.3.0] — 2026-04-03

### Added / Hinzugefügt

- `scripts/sync-home.sh` und `scripts/sync-home.ps1` — synchronisiert `home-baseline-tmp` → `~/`
  Flags: `--no-pull` / `-NoPull`, `--no-commit` / `-NoCommit`, `--dry-run` / `-WhatIf`
- `CHANGELOG.md` — diese Datei; dokumentiert alle Versionen ab v0.1.0
- README: zweistufiges Inhaltsverzeichnis — alle `##` und `###` Überschriften direkt verlinkt
- README: Abschnitt „Was ist dieses Template-Repo?" mit Fork-vs.-Template-Vergleich
- README: vollständige Umschreibung des Auszubildenden-Abschnitts (Schritt 0–4, Fehler-Tabelle, Glossar)
- README: Template-Entwickler-Workflow mit sync-home-Optionen-Tabelle
- README: ausführlicher Spec-kit-Abschnitt — SDD-Konzept, Einrichtung für 5 KI-Agenten, Beispiel, Artefakt-Struktur
- README: Barrierefreiheit-Abschnitt auf WCAG 2.2 Level AA aktualisiert (Kriterien-Tabelle, Plattform-Einschränkung)

### Changed / Geändert

- README: Spec-kit-Abschnitt verschoben — jetzt nach Auszubildende, vor Barrierefreiheit
- README: Alle Code-Blöcke ohne Sprachmarkierung nachträglich mit `text` versehen (WCAG 4.1.1)
- Alle 4 KI-Agenten-Dateien mit Session-Erkenntnissen, Known-Pitfalls-Tabelle und Repository-Status aktualisiert

### Fixed / Behoben

- CI (`homogeneity-check.yml`): korrekte TARGET_DIR-Berechnung — `cd "$(dirname $GITHUB_WORKSPACE)"` vor Scanner-Aufruf
- CI: `windows-latest` → `windows-2022` fixiert (windows-2025 instabil, git.exe-Step timing out)
- CI: PowerShell-Parameter `-WorkspaceName` → `-TargetDir` korrigiert
- `check-homogeneity.sh`: `${#FAILURES[@]+"${#FAILURES[@]}"}` entfernt (bad substitution auf Ubuntu 22.04 bash)

---

## [0.2.0] — 2026-04-03

### Added / Hinzugefügt

- Workspace Homogeneity Guardian (`scripts/check-homogeneity.sh` und `.ps1`)
  — 25 Compliance-Checks, JSON-Ausgabe, STATS.md-Update, CI/CD-Support
- `scripts/init-stats.sh/.ps1` — STATS.md-Baseline-Eintrag erzeugen
- `scripts/migrate-workspace.sh/.ps1` — bestehende Workspaces zur Baseline migrieren
- `scripts/sync-constitution.sh/.ps1` — `constitution.md` in alle Level-1-Workspaces synchronisieren
- `scripts/rename-lastenheft.sh/.ps1` — Lastenheft-Dateien per `git mv` umbenennen
- MIT `LICENSE`
- `.github/workflows/homogeneity-check.yml` — CI auf ubuntu-22.04, macos-14, windows-2022
- README: Homogeneity-Guardian-Kurzreferenz mit allen Kommandos
- README: Inhalt/Contents-Tabelle für alle Scripts

### Changed / Geändert

- Repository als öffentliches GitHub Template-Repo gesetzt (via „Use this template" nutzbar)
- `bootstrap-workspace.sh/.ps1`: GitHub-Username jetzt dynamisch (`gh api user --jq '.login'`) — kein hardcodierter Username mehr
- `check-homogeneity.sh`: vom eigenen ANSI-Scan ausgeschlossen (`--glob '!check-homogeneity.*'`)

---

## [0.1.0] — 2026-03-31

### Added / Hinzugefügt

- Initiale Bootstrap-Infrastruktur:
  - `scripts/bootstrap-workspace.sh/.ps1` — vollständige Workspace-Einrichtung in einem Schritt
  - `scripts/install-hooks.sh/.ps1` — Git-Hooks installieren
  - `scripts/scan-agent-secrets.sh/.ps1` — Secret-Scanner für KI-Agenten-Verzeichnisse
  - `scripts/hooks/pre-push` — blockiert Push bei HIGH-Severity Secret-Befunden
  - `scripts/bootstrap-project.sh/.ps1` — neues Projekt innerhalb eines Workspace anlegen
- Projekt-Verfassung `constitution.md` (v1.0.0)
- KI-Agenten-Kontext-Dateien: `AGENTS.md`, `CLAUDE.md`, `GEMINI.md`, `.github/copilot-instructions.md`
- Spec-Kit-Integration: `.specify/`, `.agents/skills/`, `.claude/commands/`, `.gemini/commands/`
- `.gitignore`-Whitelist-Modell (blockiert standardmäßig alles; nur explizit erlaubte Dateien getrackt)
- `STATS.md` für Workspace-Compliance-Tracking
- Bilinguale `README.md` mit Installations-Anleitung (DE + EN)
- `bootstrap-workspace.sh`: aktualisiert automatisch `~/README.md`-Workspace-Tabelle

---

[Unreleased]: https://github.com/hindermath/home-baseline/compare/v0.3.0...HEAD
[0.3.0]: https://github.com/hindermath/home-baseline/compare/v0.2.0...v0.3.0
[0.2.0]: https://github.com/hindermath/home-baseline/compare/v0.1.0...v0.2.0
[0.1.0]: https://github.com/hindermath/home-baseline/releases/tag/v0.1.0
