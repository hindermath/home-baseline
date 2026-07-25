<!-- intake-authoring:begin -->
# Feature Specification: CI/CD-Pipeline-Konfiguration
# Lastenheft: CI/CD-Pipeline-Konfiguration für Bootstrap-Projekte

**Feature Branch**: `feat/cicd-pipeline-konfiguration` *(wird nach Spec-kit-Lauf aktualisiert / updated after Spec-kit run)*
**Erstellt / Created**: 2026-04-08
**Status**: Draft
**Verwandte Lastenheft / Related Lastenheft**: `Lastenheft_GitLab_Support.md`
**Konstitutions-Version / Constitution Version**: 1.1.0
**Autor / Author**: hindermath (`hindermath`)

---

## Aktive Serienrolle / Active Series Role

Dieser Intake ist eine Root auf Position 9 der aktiven Reihe. Er liefert eine
Surface Baseline fuer die didaktische Kommentarhaertung auf Position 12 und
das abschliessende GSDB-Audit auf Position 13. Die historische
Implementierungsreihenfolge unten bleibt fachlicher Kontext innerhalb dieses
Intakes; sie ersetzt nicht die zentrale aktive Reihe.

*This intake is a root at position 9. It provides a surface baseline for
positions 12 and 13. The historical implementation order below remains
internal context and does not replace the central active series.*

> ## ⚠️ Implementierungsreihenfolge / Implementation Order
>
> Diese Lastenheft-Dateien bauen aufeinander auf und **müssen in dieser
> Reihenfolge** implementiert werden:
>
> ```text
> Schritt 0 → Lastenheft_Git_Config_Scope.md               (ZUERST oder parallel — Grundlage)
> Schritt 1 → Lastenheft_GitLab_Support.md                (Voraussetzung / prerequisite)
> Schritt 2 → Lastenheft_CICD_Pipeline_Konfiguration.md   ← DU BIST HIER / YOU ARE HERE
> Schritt 3 → Lastenheft_Workspace_Migration.md            (erfordert Schritt 1 + 2)
> Schritt 4 → Lastenheft_Workspace_Teardown.md              (unabhängig — parallel möglich)
> ```
>
> **Schritt 1 muss abgeschlossen sein**, bevor GitLab-CI-Templates (FR-04, FR-05)
> aus diesem Lastenheft implementiert werden. Die GitHub-Actions-Teile (FR-01–FR-03,
> FR-06–FR-09) können unabhängig von Schritt 1 umgesetzt werden.
>
> *Step 1 must be completed before implementing GitLab CI templates from this
> Lastenheft. The GitHub Actions parts can be implemented independently.*

---

## Dateibenennungs-Konvention / File Naming Convention

```
Lastenheft_{KurzName}.{branch-name}.md
```

Aktueller Stand vor Spec-kit-Durchlauf: `Lastenheft_CICD_Pipeline_Konfiguration.md`
Nach Spec-kit-Durchlauf: `Lastenheft_CICD_Pipeline_Konfiguration.{branch-name}.md`

---

## Anforderungskatalog (Originalanforderung) / Requirements Catalog (Original Request)

> Dieses Kapitel dokumentiert die ursprüngliche Anforderung vollständig und
> unverändert.
>
> *This chapter documents the original requirement in full and unchanged.*

### Originaltext (DE)

> Das Bootstrap-System erstellt zwar bereits eine `homogeneity-check.yml`-Datei
> in neu angelegten Projekten, jedoch fehlt eine durchgängige, konfigurierbare
> CI/CD-Pipeline-Strategie für die gesamte Infrastruktur. Insbesondere:
>
> - Neue Workspaces/Projekte bekommen zwar einen Homogenitäts-Check, aber keine
>   weiteren CI-Stufen (Secret-Scan, Lint, Release)
> - Es gibt keine CI-Unterstützung für GitLab CI/CD (`.gitlab-ci.yml`)
> - Das Release-Please-Workflow ist nur im `home-baseline`-Repo vorhanden
> - Secret-Scanning läuft nur im pre-push-Hook, nicht in CI-Pipelines
> - Es gibt keinen zentralen Ort, der CI-Workflow-Templates verwaltet und
>   beim Bootstrap in neue Projekte kopiert

### Klärungsergebnisse / Clarification Outcomes

| Frage / Question | Antwort / Answer |
|---|---|
| Welche CI-Plattformen? | GitHub Actions (primär) + GitLab CI (sekundär, abhängig von GitLab-Support-Feature) |
| Welche Stufen minimal? | Secret-Scan + Homogenitäts-Check — immer; Lint/Release — optional konfigurierbar |
| Release-Please in Child-Repos? | Ja — Bootstrap-Project soll optional eine `release-please.yml` anlegen |
| Bestehende Skripte erweitern? | `bootstrap-project.sh/.ps1` + `migrate-workspace.sh/.ps1` |
| Template-Dateien? | Neue Workflow-Templates unter `scripts/templates/workflows/` |
| Self-hosted Runner? | Out of Scope für dieses Feature |

---

## Systemüberblick / System Overview

### Ist-Zustand / Current State

```
╔══════════════════════════════════════════════════════════════════════╗
║  CI/CD — Ist-Zustand / Current State                                 ║
╠══════════════════════════════════════════════════════════════════════╣
║  Komponente                           Status   Befund                ║
║  ───────────────────────────────────  ──────   ──────────────────── ║
║  home-baseline: homogeneity-check.yml ✓ OK     läuft auf 3 OS       ║
║  home-baseline: release-please.yml    ✓ OK     auto-Release          ║
║  bootstrap-project: homogeneity.yml   ✓ OK     wird erzeugt          ║
║  bootstrap-project: secret-scan CI    ✗ FEHLT  nur pre-push-Hook     ║
║  bootstrap-project: release-please    ✗ FEHLT  kein Template          ║
║  GitLab CI (.gitlab-ci.yml)           ✗ FEHLT  keine Unterstützung   ║
║  Workflow-Template-Verzeichnis        ✗ FEHLT  kein zentraler Ort    ║
║  migrate-workspace: CI-Update         ~ WARN   nur homogeneity.yml   ║
║  Konfigurierbarkeit der Stufen        ✗ FEHLT  alles hardkodiert      ║
╠══════════════════════════════════════════════════════════════════════╣
║  Legende: ✓ OK · ✗ FEHLT · ~ WARN                                   ║
╚══════════════════════════════════════════════════════════════════════╝
```

### Ziel-Zustand / Target State

Ein zentrales `scripts/templates/workflows/`-Verzeichnis enthält wiederverwendbare
CI-Workflow-Templates für GitHub Actions und GitLab CI. Bootstrap- und
Migrations-Skripte kopieren die passenden Templates in neue Projekte. Über
Flags können Stufen aktiviert/deaktiviert werden.

*A central `scripts/templates/workflows/` directory contains reusable CI workflow
templates for GitHub Actions and GitLab CI. Bootstrap and migration scripts copy
the appropriate templates into new projects. Flags allow enabling/disabling stages.*

---

## Funktionale Anforderungen / Functional Requirements

### FR-01 — Template-Verzeichnis / Template Directory

Ein neues Verzeichnis `scripts/templates/workflows/` wird angelegt mit:

```text
scripts/templates/workflows/
├── github/
│   ├── homogeneity-check.yml       (bereits vorhanden → verschieben)
│   ├── secret-scan.yml             (neu)
│   └── release-please.yml          (neu — aus home-baseline übernommen)
└── gitlab/
    ├── homogeneity-check.gitlab-ci.yml   (neu)
    └── secret-scan.gitlab-ci.yml         (neu)
```

*A new `scripts/templates/workflows/` directory is created with GitHub Actions
and GitLab CI templates.*

---

### FR-02 — GitHub Actions: Secret-Scan-Workflow / Secret Scan Workflow

Neue Datei `scripts/templates/workflows/github/secret-scan.yml`:

- Trigger: `push`, `pull_request`
- Führt `bash scripts/scan-agent-secrets.sh --fail-on-high .` aus
- Matrix: `ubuntu-22.04` (reicht — rg verfügbar)
- Schlägt fehl (exit ≠ 0) wenn HIGH-Findings gefunden werden

*New `secret-scan.yml` template: runs `scan-agent-secrets.sh --fail-on-high` on
every push/PR. Fails on HIGH findings.*

---

### FR-03 — GitHub Actions: Release-Please-Workflow / Release Please Workflow

Neue Datei `scripts/templates/workflows/github/release-please.yml`:

- Analog zur bestehenden `home-baseline`-Variante
- Konfigurierbarer `release-type` (Standard: `simple`)
- Verwendet `googleapis/release-please-action@v4`
- Wird von `bootstrap-project.sh/.ps1` nur bei `--release-please` Flag angelegt

*New `release-please.yml` template, analogous to home-baseline. Only created
when `--release-please` flag is passed to `bootstrap-project`.*

---

### FR-04 — GitLab CI: Homogenitäts-Check / Homogeneity Check

Neue Datei `scripts/templates/workflows/gitlab/homogeneity-check.gitlab-ci.yml`:

```yaml
# Minimale GitLab-CI-Pipeline für Homogenitäts-Check
stages:
  - check

homogeneity-check:
  stage: check
  image: ubuntu:22.04
  before_script:
    - apt-get update -qq && apt-get install -y ripgrep
  script:
    - bash scripts/check-homogeneity.sh $(basename "$CI_PROJECT_DIR")
```

*New GitLab CI template for the homogeneity check.*

---

### FR-05 — GitLab CI: Secret-Scan / Secret Scan

Neue Datei `scripts/templates/workflows/gitlab/secret-scan.gitlab-ci.yml`:

- Analog zu FR-02 für GitLab CI
- Führt `scan-agent-secrets.sh --fail-on-high .` aus

*New GitLab CI template for secret scanning.*

---

### FR-06 — bootstrap-project: CI-Flags / CI Flags

`bootstrap-project.sh/.ps1` erhält neue optionale Flags:

```text
--ci <github|gitlab|none>   (Bash, Standard: github)
--release-please             (Bash, legt release-please.yml an)
-CI <github|gitlab|none>    (PowerShell)
-ReleasePlease               (PowerShell)
```

Verhalten:
- `--ci github` (Standard): legt `homogeneity-check.yml` + `secret-scan.yml` an
- `--ci gitlab`: legt `.gitlab-ci.yml` (kombiniert) an
- `--ci none`: kein CI-Workflow
- `--release-please`: legt zusätzlich `release-please.yml` an (nur bei `--ci github`)

*`bootstrap-project` receives new optional CI flags to control which workflow
templates are installed.*

---

### FR-07 — migrate-workspace: CI-Update

`migrate-workspace.sh/.ps1` prüft und ergänzt:

1. Fehlende `secret-scan.yml` in bestehenden Projekten
2. Veraltete `homogeneity-check.yml` (Version-Kommentar-Vergleich)

Bei `--dry-run` werden geplante Änderungen angezeigt ohne Ausführung.

*`migrate-workspace` checks and adds missing `secret-scan.yml` and updates
outdated `homogeneity-check.yml` files.*

---

### FR-08 — Versionsstempel in Workflow-Templates / Version Stamp

Jedes generierte Workflow-Template enthält einen Kommentar-Header:

```yaml
# Generated by bootstrap-project v{VERSION} on {DATE}
# Template: scripts/templates/workflows/github/homogeneity-check.yml
```

Damit kann `migrate-workspace` veraltete Templates erkennen.

*Each generated workflow template contains a version comment header for
update detection.*

---

### FR-09 — Dokumentation / Documentation

`README.md` erhält einen neuen Unterabschnitt unter „Bootstrap-Vorgang":

- Beschreibung der CI-Flags
- Kurz-Übersicht der erzeugten Workflows
- Hinweis auf GitLab CI (sofern GitLab-Support aktiviert)

*`README.md` receives a new subsection describing CI flags and generated
workflows.*

---

## Nicht-funktionale Anforderungen / Non-Functional Requirements

### NFR-01 — Rückwärtskompatibilität / Backward Compatibility

Bestehende `bootstrap-project`-Aufrufe ohne CI-Flags erzeugen wie bisher
nur `homogeneity-check.yml`. Kein Breaking Change.

*Existing `bootstrap-project` calls without CI flags generate only
`homogeneity-check.yml` as before.*

---

### NFR-02 — Bilingualität / Bilingualism

Alle neuen Benutzerausgaben und Template-Kommentare (wo sinnvoll) sind
bilingual: Deutsch zuerst, Englisch (CEFR B2).

*All new user-facing output and template comments are bilingual: German first,
English (CEFR B2).*

---

### NFR-03 — Konsistenz Bash / PowerShell

Bash- und PowerShell-Varianten sind funktional äquivalent. Workflow-Templates
sind plattformunabhängig (YAML).

*Bash and PowerShell variants are functionally equivalent. Workflow templates
are platform-independent (YAML).*

---

### NFR-04 — Scope-Abhängigkeit GitLab / GitLab Scope Dependency

GitLab-CI-Templates werden nur relevant wenn der GitLab-Support
(`Lastenheft_GitLab_Support.md`) ebenfalls implementiert ist. Die Implementierung
dieses Features SOLLTE nach dem GitLab-Support-Feature erfolgen.

*GitLab CI templates only become relevant after the GitLab support feature
(`Lastenheft_GitLab_Support.md`) is implemented. This feature SHOULD be
implemented after the GitLab support feature.*

---

## Abgrenzung / Out of Scope

| Thema / Topic | Begründung / Reason |
|---|---|
| Self-hosted GitHub/GitLab Runner | Separates Infrastruktur-Feature |
| Docker-basierte CI-Builds | Zu projektspezifisch für eine allgemeine Vorlage |
| Dependabot / renovate | Separates Feature |
| Deployment-Workflows (CD) | Zu projektspezifisch |
| GitHub Environments / Secrets-Management | Separates Feature |

---

## Akzeptanzkriterien / Acceptance Criteria

| ID | Kriterium / Criterion | Testmethode |
|---|---|---|
| AC-01 | `bootstrap-project.sh TestProj` erzeugt `homogeneity-check.yml` + `secret-scan.yml` | `--dry-run` |
| AC-02 | `bootstrap-project.sh TestProj --release-please` erzeugt zusätzlich `release-please.yml` | `--dry-run` |
| AC-03 | `bootstrap-project.sh TestProj --ci none` erzeugt keine Workflow-Dateien | `--dry-run` |
| AC-04 | `bootstrap-project.sh TestProj --ci gitlab` erzeugt `.gitlab-ci.yml` | `--dry-run` |
| AC-05 | Aufruf ohne neue Flags verhält sich rückwärtskompatibel | Regressions-Check |
| AC-06 | `secret-scan.yml` schlägt in CI fehl wenn `ghp_`-Token in Datei vorhanden | Fehlertest |
| AC-07 | `migrate-workspace.sh --dry-run` zeigt fehlende `secret-scan.yml` an | `--dry-run` |
| AC-08 | Versions-Header in erzeugten Workflows vorhanden | Sichtprüfung |
| AC-09 | PowerShell-Variante verhält sich äquivalent | Cross-Plattform-Test |
| AC-10 | README dokumentiert neue CI-Flags | Sichtprüfung |

---

## Technische Abhängigkeiten / Technical Dependencies

| Tool / Datei | Zweck / Purpose |
|---|---|
| `scripts/templates/workflows/` | Neues Template-Verzeichnis (zu erstellen) |
| `bootstrap-project.sh/.ps1` | Erweitern um CI-Flags (FR-06) |
| `migrate-workspace.sh/.ps1` | Erweitern um CI-Update-Logik (FR-07) |
| `scripts/scan-agent-secrets.sh` | Wird in `secret-scan.yml` referenziert |
| `scripts/check-homogeneity.sh/.ps1` | Wird in `homogeneity-check.yml` referenziert |
| `googleapis/release-please-action@v4` | GitHub Action für Release-Please-Template |

---

## Dateien mit Änderungsbedarf / Files Requiring Changes

| Datei / File | Art der Änderung / Type of Change |
|---|---|
| `scripts/bootstrap-project.sh` | `--ci` + `--release-please` Flags; Template-Auswahl |
| `scripts/bootstrap-project.ps1` | `-CI` + `-ReleasePlease` Flags; Template-Auswahl |
| `scripts/migrate-workspace.sh` | CI-Update-Logik für `secret-scan.yml` |
| `scripts/migrate-workspace.ps1` | CI-Update-Logik für `secret-scan.yml` |
| `scripts/templates/workflows/github/homogeneity-check.yml` | Verschieben + Header ergänzen |
| `scripts/templates/workflows/github/secret-scan.yml` | Neu anlegen |
| `scripts/templates/workflows/github/release-please.yml` | Neu anlegen |
| `scripts/templates/workflows/gitlab/homogeneity-check.gitlab-ci.yml` | Neu anlegen |
| `scripts/templates/workflows/gitlab/secret-scan.gitlab-ci.yml` | Neu anlegen |
| `README.md` | CI-Flags dokumentieren |

---

## Spec-Kit-Intake-Reife / Spec Kit Intake Readiness

Dieses Lastenheft ist inhaltlich breit genug fuer einen spaeteren
`/speckit-specify`-Lauf, muss aber beim Start gegen den heutigen Repository-
Stand validiert werden. Einige Teilanforderungen koennen bereits durch spaetere
Home-Baseline-Arbeiten ganz oder teilweise erledigt sein.

*This requirements document is broad enough for a later `/speckit-specify` run,
but must be validated against the current repository state at run start. Some
requirements may already be fully or partly covered by later home-baseline work.*

Der spaetere Lauf muss zuerst klassifizieren:

- `AlreadySatisfied`: im aktuellen Stand bereits umgesetzt und nachweisbar.
- `Applicable`: noch offen und fuer diesen Lauf umzusetzen.
- `N/A`: nicht mehr passend, mit kurzer Begruendung.
- `FollowUp`: sinnvoll, aber zu gross oder zu unabhaengig fuer diesen Lauf.

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_CICD_Pipeline_Konfiguration.md als verbindliche Eingabedatei. Bewahre die Root-Position 9 und die Surface Baselines fuer die Positionen 12 und 13. Erstelle die Feature-Spezifikation fuer einen CI/CD-Pipeline-Konfigurationslauf im home-baseline-Repository.

Ziel: Pruefe und haerte die CI/CD-Template-Strategie fuer neue Level-1- und Level-2-Repositories. Beruecksichtige GitHub Actions primaer und GitLab CI sekundaer, ohne bereits erledigte historische Anforderungen blind erneut umzusetzen.

Pflichtschritte in der Spezifikation:
- Vergleiche alle FR-/NFR-/AC-Punkte dieses Lastenhefts mit dem aktuellen Repository-Stand.
- Klassifiziere jeden Punkt als `AlreadySatisfied`, `Applicable`, `N/A` oder `FollowUp`.
- Plane nur `Applicable`-Punkte fuer diesen Lauf.
- Erhalte Rueckwaertskompatibilitaet fuer bestehende Bootstrap- und Migrationsskripte.
- Beruecksichtige Secret-Scan, Homogeneity Check, Release Please, GitLab-CI-Unterstuetzung, Workflow-Template-Versionierung, `--dry-run`/`-WhatIf` und Dokumentation.
- Halte DE/EN, CEFR B2, WCAG-2.2-AA-freundliche Dokumentation und GitHub/GitLab-CLI-first-Guidance ein.

Nicht-Ziele:
- Keine Self-hosted-Runner-Architektur.
- Keine Deployment-CD fuer konkrete Produkte.
- Keine Dependabot-/Renovate-Einfuehrung, falls sie nicht zwingend fuer diesen CI/CD-Scope gebraucht wird.

Erzeuge eine Spezifikation mit Scope, Nicht-Zielen, aktualisierter Ist-/Soll-Klassifikation, funktionalen Anforderungen, Akzeptanzkriterien, Risiken, Teststrategie und klaren Folgeentscheidungen.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Lastenheft_CICD_Pipeline_Konfiguration.md Fuehre den vollstaendigen Spec-Kit-Lauf mit deliveryAuthority=LocalImplementation aus. Nutze dieses Lastenheft als verbindlichen Intake und bewahre die Root-Position 9, die Surface Baselines fuer die Positionen 12 und 13 sowie alle Anforderungen, Nicht-Ziele, Sicherheits-, A11Y-, Plattform-, Evidence- und Abnahmegrenzen. Implementiere und validiere nur lokal. Erstelle keine Commits, Pushes, Pull Requests oder Merges, veraendere keine Remote-Zustaende und starte nach Abschluss kein Folgefeature.
```

<!-- intake-authoring:end -->
