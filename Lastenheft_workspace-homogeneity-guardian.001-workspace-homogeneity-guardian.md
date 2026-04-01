# Feature Specification: workspace-homogeneity-guardian
# Lastenheft: Workspace-Homogenitätswächter

**Feature Branch**: `feat/workspace-homogeneity-guardian` *(wird nach Spec-kit-Lauf aktualisiert / updated after Spec-kit run)*
**Erstellt / Created**: 2026-04-01
**Status**: Draft
**Konstitutions-Version / Constitution Version**: 1.1.0
**Autor / Author**: Thorsten Hindermann (`hindermath`)

---

## Dateibenennungs-Konvention / File Naming Convention

> Diese Konvention gilt **auf allen drei Hierarchieebenen** (Ebene 0 = Home,
> Ebene 1 = Workspace, Ebene 2 = Projekt), überall wo mit Spec-kit und
> Lastenheften gearbeitet wird. Sie orientiert sich am etablierten Muster
> in TuiVision.
>
> *This convention applies **at all three hierarchy levels** (Level 0 = Home,
> Level 1 = Workspace, Level 2 = Project), wherever Spec-kit and Lastenhefts
> are used. It follows the established pattern from TuiVision.*

| Ebene / Level | Beispielpfad / Example path |
|---|---|
| 0 — Home (`~/`) | `~/Lastenheft_workspace-homogeneity-guardian.001-workspace-homogeneity-guardian.md` |
| 1 — Workspace | `~/RiderProjects/Lastenheft_rider-baseline.002-rider-baseline.md` |
| 2 — Projekt | `~/RiderProjects/TinyCalc/Lastenheft_calculator-engine.003-calculator-engine.md` |

### Regel / Rule

Der Dateiname eines Lastenhefts folgt diesem Schema:

```
Lastenheft_{KurzName}.{branch-name}.md
```

**Lebenszyklus / Lifecycle**:

1. **Vor dem Spec-kit-Durchlauf / Before Spec-kit run**:
   Datei heißt `Lastenheft_{KurzName}.md` — kein Branch-Suffix.

2. **Nach erfolgreichem Spec-kit-Durchlauf / After successful Spec-kit run**:
   Sobald Spec-kit einen Feature-Branch erstellt oder zuweist (z. B.
   `001-workspace-homogeneity-guardian`), wird der Branch-Name als Suffix
   angehängt:
   ```
   Lastenheft_workspace-homogeneity-guardian.md
       → Lastenheft_workspace-homogeneity-guardian.001-workspace-homogeneity-guardian.md
   ```

3. **Internes Metadaten-Feld / Internal metadata field**:
   Das `**Feature Branch**`-Feld im Dokumentkopf wird gleichzeitig auf den
   tatsächlichen Branch-Namen aktualisiert.

**Beispiele aus TuiVision / Examples from TuiVision**:

| Vorher / Before | Nachher (mit Branch) / After (with branch) |
|---|---|
| `Lastenheft_ControlsRevision.md` | `Lastenheft_ControlsRevision.008-controls-revision.md` |
| `Lastenheft_01_ControlsWidgets.md` | `Lastenheft_01_ControlsWidgets.009-controls-widgets-and-collections.md` |

**Umsetzung / Implementation** (FR-G01):
Das Bootstrap-Skript bzw. ein separates `rename-lastenheft.sh`-Skript MUSS
nach dem Spec-kit-Durchlauf den Dateinamen automatisch anpassen und einen
`git mv`-Commit erzeugen:
```bash
git mv "Lastenheft_${SHORT}.md" "Lastenheft_${SHORT}.${BRANCH}.md"
git commit -m "docs: Lastenheft nach Spec-kit-Lauf umbenannt → ${BRANCH}"
```

---

## Anforderungskatalog (Originalanforderung) / Requirements Catalog (Original Request)

> Dieses Kapitel dokumentiert die ursprüngliche Anforderung vollständig und
> unverändert. Damit bleibt die Entstehungsgeschichte nachvollziehbar.
>
> *This chapter documents the original requirement in full and unchanged, ensuring
> full traceability of the specification's origins.*

### Originaltext (DE)

> Erstelle ein Spec-kit Spezifikations-kompatibles Lastenheft in Markdown, das
> beginnend vom Homeverzeichnis über die Projekt-Wurzelverzeichnisse bis in die
> dort vorhandenen Projekte schaut, ob die KI-Agenten auf allen Ebenen und
> Verfassungen in den SDD (Speckit-Driven Development) gesteuerten Projekten
> alles homogen ist. Als Dateien eigenen sich sicherlich die README,
> KI-Agenten-Dateien und Verfassungs-Dateien.
>
> Wichtig ist mir:
> - die pre-hooks zur Erkennung von Secrets in den Verzeichnissen und Projekten
> - Bilingualität: DE first dann EN Level CEFR B2
> - ist alles accessibility-fähig, also das Thema A11Y (Docs + Code)
> - auf allen Ebenen die Statistikeinführung und Fortschreibung mit ASCII-Diagrammen
>
> Die KI-Agenten sind: Claude, Codex, Gemini, Copilot.
>
> Wenn neue Projekte eingerichtet werden, dass es ein oder mehrere Skripte gibt,
> die alle grundlegenden infrastrukturellen Dinge anlegen und vorbereiten, dass
> die KI-Agenten schon mal mit `init` aufgerufen werden und auch `specify`,
> und auch schon mal Spec-kit installiert für die Agenten.

### Klärungsergebnisse / Clarification Outcomes

| Frage / Question | Antwort / Answer |
|---|---|
| Was bedeutet „SDD"? | **Speckit-Driven Development** — Projekte mit spec/plan/tasks |
| A11Y-Scope? | **Beides**: Dokumentations-A11Y + Code-A11Y kombiniert |
| Homogenitätsprüfung? | **Beides**: Dateipräsenz + inhaltliche Konsistenz |
| Statistikformat? | Präsenz-/Compliance-Zählung auf Root+Workspace; bestehende Projekt-Statistiken nach oben aggregieren |
| KI-Agenten-Aufruf? | Agent-CLIs (`claude`, `codex`, `gemini`, `gh copilot`) + danach `speckit init` + `speckit specify` |

---

## Systemüberblick / System Overview

Das System erstreckt sich über **drei Hierarchieebenen**:

*The system spans **three hierarchy levels**:*

```
~ (home-baseline)                     ← Ebene 0 / Level 0
├── RiderProjects/                    ← Ebene 1 / Level 1 (Workspace)
│   ├── TinyCalc/                     ← Ebene 2 / Level 2 (Projekt / Project)
│   ├── TuiVision/
│   └── ...
├── C64Projects/
│   └── cc65/
├── DataGripProjects/
└── VST_SDK/
```

**Beteiligte KI-Agenten / Involved AI Agents**:

| Agent | Datei / File | Globale Config / Global Config |
|---|---|---|
| Claude | `CLAUDE.md` | `~/.claude/CLAUDE.md` |
| Codex | `AGENTS.md` | `~/.codex/AGENTS.md` |
| Gemini | `GEMINI.md` | `~/.gemini/GEMINI.md` |
| Copilot | `.github/copilot-instructions.md` | `~/.github/copilot-instructions.md` |

---

## Anwendungsszenarien & Tests / User Scenarios & Testing

### Szenario 1 — Vollständiger Homogenitätsscan / Full Homogeneity Scan (Priorität: P1)

Ein Entwickler ruft das Prüfskript auf und erhält sofort eine Übersicht,
welche Dateien auf welcher Ebene fehlen oder inhaltlich inkonsistent sind.

*A developer runs the check script and immediately receives an overview of which
files are missing or content-inconsistent at which level.*

**Warum diese Priorität / Why this priority**: Ohne verlässliche Prüfung ist kein
gezielter Fix möglich. Dies ist das Fundament aller weiteren Features.
*Without reliable checks, no targeted fixes are possible. This is the foundation
for all other features.*

**Unabhängiger Test / Independent Test**: Skript läuft durch und gibt
Compliance-Report mit ASCII-Diagramm aus. Kein Schreibzugriff erforderlich.
*Script runs and outputs compliance report with ASCII diagram. No write access needed.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** eine funktionierende Home-Baseline-Umgebung,
   **wenn** `bash scripts/check-homogeneity.sh` ausgeführt wird,
   **dann** erscheint ein tabellarischer Report aller Ebenen 0–2 mit Status `✓/✗`.

   *Given a working home-baseline environment, when `bash scripts/check-homogeneity.sh`
   is run, then a tabular report of all levels 0–2 appears with status `✓/✗`.*

2. **Gegeben** eine Datei `CLAUDE.md` fehlt in einem Workspace,
   **wenn** das Skript läuft,
   **dann** erscheint `✗ CLAUDE.md` für diesen Workspace und der Exit-Code ist `1`.

   *Given a `CLAUDE.md` file is missing from a workspace, when the script runs,
   then `✗ CLAUDE.md` appears for that workspace and the exit code is `1`.*

3. **Gegeben** alle Dateien vorhanden, aber ohne Bilingual-Abschnitt,
   **wenn** das Skript mit `--check-content` läuft,
   **dann** wird `WARN: bilingual section missing` pro Datei gemeldet.

   *Given all files are present but missing bilingual sections, when the script runs
   with `--check-content`, then `WARN: bilingual section missing` is reported per file.*

---

### Szenario 2 — Bootstrap eines neuen Projekts / New Project Bootstrap (Priorität: P2)

Ein Entwickler richtet ein neues Projekt ein und erhält mit einem einzigen
Skriptaufruf die vollständige KI-Agenten-Infrastruktur, vorinstalliertes Speckit
und einen ersten Spec-Entwurf.

*A developer sets up a new project and receives, with a single script call,
the full AI agent infrastructure, pre-installed Speckit, and a first spec draft.*

**Warum diese Priorität / Why this priority**: Neue Projekte ohne Bootstrap
entstehen inkonsistent. Automatisierung sichert Homogenität von Anfang an.
*New projects created without bootstrap are inconsistent. Automation ensures
homogeneity from the start.*

**Unabhängiger Test / Independent Test**: Ein leeres Testverzeichnis wird als
neues Projekt bootstrapped; danach sind alle Pflichtdateien vorhanden und der
Homogenitätsscan meldet `100 %` für dieses Projekt.
*An empty test directory is bootstrapped as a new project; afterwards all required
files are present and the homogeneity scan reports `100%` for that project.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** ein leeres Verzeichnis `~/RiderProjects/MeinProjekt/`,
   **wenn** `bash scripts/bootstrap-project.sh MeinProjekt` ausgeführt wird,
   **dann** werden `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`,
   `.github/copilot-instructions.md`, `pre-push`-Hook und `spec.md`-Scaffold
   erstellt.

2. **Gegeben** das Bootstrap-Skript läuft erfolgreich,
   **wenn** Speckit noch nicht installiert ist,
   **dann** installiert das Skript Speckit automatisch (`speckit init` für jeden
   Agenten).

3. **Gegeben** das Bootstrap-Skript läuft erfolgreich,
   **wenn** die Agenten-CLIs verfügbar sind,
   **dann** wird `claude /init`, `codex init`, `gemini init` und
   `gh copilot suggest` aufgerufen, gefolgt von `speckit specify`.

4. **Gegeben** ein Skriptfehler bei einem Agenten-CLI-Aufruf (CLI nicht installiert),
   **dann** gibt das Skript eine Warnung aus (`WARN: claude CLI not found — skipped`)
   und bricht **nicht** ab.

   *If a CLI is not installed, the script outputs a warning and does not abort.*

---

### Szenario 3 — Statistik und ASCII-Visualisierung / Statistics & ASCII Visualisation (Priorität: P3)

Nach jedem Prüflauf wird eine aktuelle Statistik erzeugt und in eine
`STATS.md`-Datei auf der jeweiligen Ebene geschrieben oder angehängt.

*After each check run, a current statistic is generated and written or appended
to a `STATS.md` file at the respective level.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** ein ausgeführter Homogenitätsscan,
   **dann** enthält `~/STATS.md` einen Eintrag mit Datum/Zeit, Gesamtzahl
   Workspaces und Compliance-Prozentsatz.

2. **Gegeben** C#-Projekte mit bestehenden Code-Statistiken,
   **dann** aggregiert das Skript diese nach oben (Workspace → Root).

3. **Gegeben** ASCII-Diagramme,
   **dann** enthalten sie Balkendiagramme für Compliance und eine
   Datei×Ebene-Präsenzmatrix.

---

### Szenario 4 — A11Y-Prüfung / Accessibility Check (Priorität: P3)

Jede generierte oder gescannte Dokumentationsdatei wird auf
Barrierefreiheits-Merkmale geprüft.

*Every generated or scanned documentation file is checked for accessibility features.*

**Akzeptanzszenarien / Acceptance Scenarios**:

1. **Gegeben** eine `README.md` ohne Bild-Alt-Texte,
   **dann** meldet das Skript `WARN: image without alt text`.

2. **Gegeben** eine Markdown-Datei mit übersprungener Überschriftenebene (H1 → H3),
   **dann** erscheint `WARN: heading level skipped (H1→H3)`.

3. **Gegeben** eine `spec.md` ohne A11Y-Checklisten-Abschnitt,
   **dann** fügt das Bootstrap-Skript beim Erstellen automatisch einen
   Standard-A11Y-Abschnitt ein.

---

### Randfälle / Edge Cases

- Was passiert, wenn ein Workspace keine `.git/`-Verzeichnis hat?
  → Skript gibt `WARN: not a git repo` aus und überspringt Hook-Prüfung.
  *Script outputs `WARN: not a git repo` and skips hook check.*

- Was passiert, wenn eine KI-Agenten-Datei vorhanden, aber leer ist?
  → Wird als `WARN: file empty` gewertet, nicht als `✓`.
  *Treated as `WARN: file empty`, not as `✓`.*

- Was passiert, wenn ein Projekt zwar SDD-Dateien hat, aber `spec.md` fehlt?
  → `✗ spec.md missing` — gilt als SDD-inkompliant.
  *`✗ spec.md missing` — treated as SDD-non-compliant.*

- Was passiert, wenn keine Netzwerkverbindung für `gh repo create` vorhanden ist?
  → Bootstrap läuft lokal vollständig durch; GitHub-Push wird mit `WARN` zurückgestellt.
  *Bootstrap runs locally in full; GitHub push is deferred with a `WARN`.*

---

## Anforderungen / Requirements

### Funktionale Anforderungen / Functional Requirements

#### A — Homogenitätsprüfung / Homogeneity Check

- **FR-A01**: Das System MUSS Ebene 0 (`~/`), alle Ebene-1-Workspaces und alle
  Ebene-2-Projekte rekursiv scannen.
  *The system MUST scan Level 0 (`~/`), all Level-1 workspaces, and all Level-2
  projects recursively.*

- **FR-A02**: Das Skript MUSS die Präsenz folgender Dateien pro Ebene prüfen:

  | Datei / File | Ebene 0 | Ebene 1 | Ebene 2 |
  |---|:---:|:---:|:---:|
  | `README.md` | ✓ | ✓ | ✓ |
  | `CLAUDE.md` | ✓ | ✓ | ✓ |
  | `GEMINI.md` | ✓ | ✓ | ✓ |
  | `AGENTS.md` | ✓ | ✓ | ✓ |
  | `.github/copilot-instructions.md` | ✓ | ✓ | ✓ |
  | `.git/hooks/pre-push` | ✓ | ✓ | ✓ |
  | `spec.md` (nur SDD-Projekte) | — | — | ✓ |
  | `STATS.md` | ✓ | ✓ | ✓ |

- **FR-A03**: Das Skript MUSS inhaltliche Konsistenz prüfen:
  - Bilinguale Abschnitte vorhanden (DE + EN)?
  - Sicherheitsregel-Kernaussagen identisch (whitelist-Modell, Secret-Muster)?
  - A11Y-Checklisten-Abschnitt vorhanden?

  *The script MUST check content consistency: bilingual sections present,
  security core rules identical, A11Y checklist section present.*

- **FR-A04**: Ausgabe als tabellarischer Report mit `✓` / `✗` / `WARN`.
  Exit-Code `0` = alles OK, `1` = mindestens ein `✗`, `2` = kritischer Fehler.

- **FR-A05**: Das Skript MUSS als Bash (`.sh`) UND PowerShell Core 7+ (`.ps1`)
  vorliegen. (Constitution Prinzip II)

#### B — Pre-Hook Secret Detection / Pre-Hook-Geheimnis-Erkennung

- **FR-B01**: Jedes `.git/`-Verzeichnis auf Ebene 0, 1 und 2 MUSS einen
  `pre-push`-Hook enthalten, der auf dem aktuellen Stand von
  `scripts/hooks/pre-push` basiert.

- **FR-B02**: Der Hook MUSS folgende Muster erkennen und den Push mit Exit-Code 2
  blockieren:
  - Token-Muster: `ghp_*`, `sk-*`, `AKIA[A-Z0-9]{16}`, `AIza[0-9A-Za-z_-]{35}`
  - PEM-Header: `-----BEGIN (RSA |EC |OPENSSH )?PRIVATE KEY-----`
  - Geheimnis-Dateinamen: `.env*`, `*secret*`, `*.key`, `*.pem`, `*credentials*`

- **FR-B03**: Das Prüfskript MUSS verifizieren, dass der installierte Hook
  bitidentisch mit `scripts/hooks/pre-push` ist (SHA-256-Vergleich).
  *The check script MUST verify that the installed hook is bit-for-bit identical
  to `scripts/hooks/pre-push` (SHA-256 comparison).*

- **FR-B04**: Das Bootstrap-Skript MUSS den Hook automatisch installieren.

#### C — Bilingualität / Bilingualism

- **FR-C01**: Alle durch das Bootstrap-Skript generierten Dateien MÜSSEN
  bilinguale Abschnitte enthalten: Deutsch zuerst, Englisch auf CEFR-B2-Niveau.

- **FR-C02**: Der Inhalts-Check (`--check-content`) MUSS erkennen, ob beide
  Sprachebenen in README, CLAUDE.md, GEMINI.md, AGENTS.md und
  `.github/copilot-instructions.md` vorhanden sind (Heuristik: mind. ein
  `*(EN)*`- oder `*/ EN:*`-Marker oder ein zweisprachiger Abschnitt).

- **FR-C03**: Templates für alle generierten Dateien MÜSSEN bilingual sein und
  unter `.specify/templates/` gespeichert werden.

#### D — Barrierefreiheit / Accessibility (A11Y)

- **FR-D01**: **Docs-A11Y**: Das Skript MUSS prüfen:
  - Keine Bilder ohne `alt`-Text (`![alt](...)` leer verboten)
  - Überschriftenhierarchie ohne Sprünge (H1→H2→H3, kein H1→H3)
  - Keine leeren Linkbeschreibungen (`[](url)` oder `[klick hier](url)`)
  - Codefragmente in Backticks, keine reinen ASCII-Ersatz-Markierungen

- **FR-D02**: **Code-A11Y** (nur für SDD-Projekte mit UI-Anteil):
  - Prüfhinweis in `spec.md`: ARIA-Rollen, Farb-Kontrast-Anforderungen,
    Tastaturnavigation-Pflichten
  - Automatischer A11Y-Abschnitt in jeder neu erstellten `spec.md`

- **FR-D03**: Jede Bootstrap-generierte `README.md` MUSS einen
  `## Barrierefreiheit / Accessibility` Abschnitt mit Mindest-Checkliste
  enthalten.

#### E — Statistik / Statistics

- **FR-E01**: Nach jedem Scan MUSS eine `STATS.md` auf Ebene 0 erstellt oder
  aktualisiert werden. Pflichtinhalte:
  - Zeitstempel des letzten Scans
  - Gesamtzahl Workspaces und Projekte
  - Compliance-Gesamtscore (0–100 %)
  - ASCII-Balkendiagramm Compliance pro Workspace
  - Datei×Ebene-Präsenzmatrix (ASCII-Tabelle)

- **FR-E02**: Auf Workspace-Ebene (Ebene 1) MUSS eine eigene `STATS.md` mit
  projektbezogenen Kennzahlen geführt werden.

- **FR-E03**: Vorhandene Projektstatistiken aus C#-Projekten (z. B. Zeilen,
  Tests, Abdeckung) MÜSSEN in die übergeordnete Workspace-`STATS.md` aggregiert
  werden, sofern sie in maschinenlesbarem Format vorliegen (Markdown-Tabelle
  oder CSV).

- **FR-E04**: Statistiken MÜSSEN fortgeschrieben werden (Append-Modus mit
  Zeitstempel-Trennzeile); historische Einträge dürfen nicht überschrieben werden.

- **FR-E05**: Beispiel-ASCII-Ausgabe (normativ):

  ```
  ╔══════════════════════════════════════════════════════╗
  ║  workspace-homogeneity-guardian — Compliance Report  ║
  ║  Stand: 2026-04-01  13:33 UTC                        ║
  ╠══════════════════════════════════════════════════════╣
  ║  Workspace              Score  Balken                ║
  ║  ─────────────────────  ─────  ──────────────────    ║
  ║  RiderProjects          87 %   ████████░░            ║
  ║  C64Projects            75 %   ███████░░░            ║
  ║  DataGripProjects       100 %  ██████████            ║
  ║  VST_SDK                50 %   █████░░░░░            ║
  ╠══════════════════════════════════════════════════════╣
  ║  Gesamt / Total         78 %   ████████░░            ║
  ╚══════════════════════════════════════════════════════╝

  Dateipräsenz-Matrix / File Presence Matrix:
  ┌────────────────────┬────────┬────────┬────────┬────────────────────────────┐
  │ Ebene / Level      │ README │ CLAUDE │ GEMINI │ copilot-instructions       │
  ├────────────────────┼────────┼────────┼────────┼────────────────────────────┤
  │ ~ (root)           │  ✓     │  ✓     │  ✓     │  ✓                         │
  │ RiderProjects/     │  ✓     │  ✓     │  ✓     │  ✓                         │
  │   TinyCalc/        │  ✓     │  ✓     │  ✗     │  ✓                         │
  │   TuiVision/       │  ✓     │  ✓     │  ✓     │  ✓                         │
  │ C64Projects/       │  ✓     │  ✓     │  ✓     │  ✓                         │
  │   cc65/            │  ✓     │  ✓     │  ✓     │  ✓                         │
  └────────────────────┴────────┴────────┴────────┴────────────────────────────┘
  ```

#### F — Bootstrap neuer Projekte / New Project Bootstrap

- **FR-F01**: Das Skript `scripts/bootstrap-project.sh` (Bash) und
  `scripts/bootstrap-project.ps1` (PowerShell 7+) MÜSSEN folgende Schritte
  in dieser Reihenfolge ausführen:

  ```
  1.  Verzeichnis anlegen (falls nicht vorhanden)
  2.  git init
  3.  .gitignore (Whitelist-Modell) aus Template kopieren
  4.  CLAUDE.md aus Template erstellen (bilingual)
  5.  GEMINI.md aus Template erstellen (bilingual)
  6.  AGENTS.md aus Template erstellen (bilingual)
  7.  .github/copilot-instructions.md aus Template erstellen (bilingual)
  8.  README.md aus Template erstellen (bilingual, A11Y-Abschnitt)
  9.  scripts/ kopieren
  10. bash scripts/install-hooks.sh  (Hook installieren)
  11. Speckit prüfen/installieren
  12. claude /init                   (falls CLI vorhanden)
  13. codex init                     (falls CLI vorhanden)
  14. gemini init                    (falls CLI vorhanden)
  15. gh copilot suggest "init"      (falls gh + Copilot-Extension vorhanden)
  16. speckit init                   (für alle Agenten)
  17. speckit specify                (initiales Spec-Scaffold)
  18. STATS.md initalisieren
  19. git add -A && git commit -m "chore: initial project bootstrap"
  20. gh repo create (privat) + push (falls gh vorhanden)
  21. ~/README.md Workspace-Tabelle aktualisieren
  ```

- **FR-F02**: Fehlende CLIs (claude, codex, gemini, gh) dürfen den Bootstrap
  nicht abbrechen. Jeder CLI-Schritt MUSS mit `|| warn "CLI not found — skipped"`
  gesichert sein.

- **FR-F03**: Das Skript MUSS `--dry-run` / `-WhatIf` unterstützen.

- **FR-F04**: Speckit MUSS für alle vier Agenten (Claude, Codex, Gemini, Copilot)
  initialisiert werden. Falls Speckit nicht installiert ist, MUSS das Skript die
  Installation anstoßen (plattformspezifisch).

- **FR-F05**: Die Speckit-Skills (`speckit-specify`, `speckit-plan`,
  `speckit-tasks`, `speckit-implement`) MÜSSEN als Teil des Bootstrap in die
  richtigen Zielpfade kopiert werden:
  - `.specify/` (Konfiguration, Templates, Constitution-Referenz)
  - `.claude/commands/` (Claude-Kommandos)
  - `.gemini/commands/` (Gemini-Kommandos)
  - `.github/agents/` (GitHub Copilot Agents)
  - `.github/prompts/` (Copilot Prompts)

#### G — README-Dokumentation auf allen Ebenen / README Documentation at All Levels

> Zielgruppe: Entwickler, Azubis (Fachinformatiker in Ausbildung) und alle
> weiteren Nutzer dieser Infrastruktur. Die README.md jeder Ebene dient als
> primäre Orientierungshilfe — auch als generischer Bauplan zum Weitergeben.
>
> *Target audience: developers, apprentices (IT trainees) and all other users
> of this infrastructure. The README.md at each level serves as the primary
> orientation guide — and as a generic blueprint to pass on.*

- **FR-G01**: Jede `README.md` auf Ebene 0, 1 und 2 MUSS folgende
  Pflichtabschnitte enthalten:

  | Abschnitt / Section | Ebene 0 | Ebene 1 | Ebene 2 |
  |---|:---:|:---:|:---:|
  | Projektübersicht / Project Overview | ✓ | ✓ | ✓ |
  | Voraussetzungen / Prerequisites | ✓ | ✓ | ✓ |
  | Schnellstart / Quick Start | ✓ | ✓ | ✓ |
  | KI-Agenten-Übersicht / AI Agent Overview | ✓ | ✓ | ✓ |
  | Spec-kit-Workflow | ✓ | ✓ | ✓ |
  | Homogenitätsprüfung / Homogeneity Check | ✓ | ✓ | — |
  | Pre-Hook & Secret-Scan | ✓ | ✓ | ✓ |
  | Lastenheft-Benennungsregel / Lastenheft naming rule | ✓ | ✓ | ✓ |
  | Statistik / Statistics | ✓ | ✓ | ✓ |
  | Barrierefreiheit / Accessibility (A11Y) | ✓ | ✓ | ✓ |
  | Für Azubis / For Apprentices | ✓ | ✓ | ✓ |

- **FR-G02**: Der Abschnitt **„Für Azubis / For Apprentices"** MUSS enthalten:
  - Schritt-für-Schritt-Anleitung, um ein neues Projekt einzurichten
    (Bootstrap-Skript aufrufen, KI-Agenten starten, ersten Spec erstellen)
  - Erklärung der wichtigsten Dateien und ihrer Bedeutung
  - Hinweis auf Spec-kit-Workflow (specify → plan → tasks → implement)
  - Hinweis: Keine kostenpflichtigen GUI-Komponenten; nur NuGet-Pakete oder
    selbst erstellte Bibliotheken verwenden
  - Links zu weiterführenden Ressourcen (.NET-Dokumentation, Spec-kit-Doku)

- **FR-G03**: Der Abschnitt **„Spec-kit-Workflow"** MUSS den vollständigen
  Lebenszyklus beschreiben:
  ```
  specify → plan → tasks → implement
      ↓
  Lastenheft-Umbenennung: {Name}.md → {Name}.{branch}.md
  ```

- **FR-G04**: Die README.md MUSS bilingual sein (DE zuerst, EN CEFR B2).
  Azubi-Abschnitte dürfen vereinfachtes Deutsch/Englisch verwenden.
  *README.md MUST be bilingual (DE first, EN CEFR B2). Apprentice sections
  may use simplified German/English.*

- **FR-G05**: Das Bootstrap-Skript MUSS eine `README.md` aus einem bilingualen
  Template erzeugen, das alle Pflichtabschnitte als Platzhalter enthält.

#### H — Plattformunterstützung / Platform Support

- **FR-H01**: Alle Skripte MÜSSEN auf folgenden Plattformen lauffähig sein:

  **macOS**:
  - macOS 14 (Sonoma) und 15 (Sequoia), Arm64 (M1–M4) und x64
  - Shell: `bash` ≥ 5 (via Homebrew), `zsh` als Fallback
  - PowerShell Core ≥ 7 (via Homebrew)

  **Linux** — unterstützte Distributionen (.NET 10 SDK, Stand 2026-03-30,
  **ausschließlich kostenlos + LTS / free + LTS only**):

  | Distribution | LTS-Versionen | Architekturen | Support bis ca. |
  |---|---|---|---|
  | Ubuntu LTS | 22.04 LTS, 24.04 LTS | x64, Arm64, Arm32 | Apr 2027 / Apr 2029 |
  | Debian Stable | 12 „Bookworm" | x64, Arm64, Arm32 | Jun 2028 |

  **Explizit ausgeschlossen / Explicitly excluded**:

  | Distribution | Grund / Reason |
  |---|---|
  | Ubuntu 25.10 (und andere Nicht-LTS) | Kurzer Support-Zyklus (~9 Monate) |
  | Debian 13 „Trixie" | Noch Testing-Phase, kein stabiles LTS |
  | Alpine, Fedora, CentOS Stream, openSUSE Leap | Zu viele Abhängigkeiten / zu kurze oder fehlende LTS-Zyklen |
  | RHEL, SUSE Linux Enterprise | Kostenpflichtige Abonnements |

  > **Hinweis für Azubis / Note for apprentices**: Ubuntu 22.04 LTS oder
  > 24.04 LTS sind die empfohlenen Linux-Distributionen — kostenlos,
  > bestens dokumentiert, LTS-gesichert und auf nahezu jeder Hardware lauffähig.
  > macOS und Windows werden in der Regel vom Ausbildungsbetrieb gestellt.
  >
  > *Ubuntu 22.04 LTS or 24.04 LTS are the recommended Linux distributions —
  > free, well documented, LTS-secured, and running on almost any hardware.
  > macOS and Windows are typically provided by the employer.*

  **Windows**:
  - Windows 10 (21H2 Enterprise/IoT) und Windows 11 (alle aktuellen Builds)
  - Windows Server 2019, 2022, 2025
  - Shell: PowerShell Core ≥ 7 (primär / primary)
  - **WSL2** (Windows Subsystem for Linux 2) mit denselben kostenlosen
    LTS-Distributionen wie oben (Ubuntu 22.04/24.04 LTS, Debian 12 Stable);
    Bash-Skripte laufen dann unverändert
    in der WSL-Umgebung.

  > **Hinweis WSL / WSL note**: WSL2 ist unter Windows 10 (Build 19041+)
  > und Windows 11 kostenlos verfügbar (`wsl --install`). Empfehlung für
  > Azubis: **Ubuntu 22.04 LTS** aus dem Microsoft Store — kostenlos,
  > einfach zu installieren, vollständig .NET-10-fähig.
  >
  > *WSL2 is free on Windows 10 (Build 19041+) and Windows 11
  > (`wsl --install`). Recommended for apprentices: **Ubuntu 22.04 LTS**
  > from the Microsoft Store — free, easy to install, fully .NET 10 capable.*

- **FR-H02**: Skripte, die plattformspezifische Pfade verwenden, MÜSSEN
  Pfadtrenner abstrahieren:
  - Bash: `/` (fest)
  - PowerShell: `Join-Path` statt hartcodiertem `\` oder `/`

- **FR-H03**: Das Prüfskript MUSS den .NET-SDK-Status melden (`dotnet --version`),
  falls `.csproj`-Dateien im Scan-Bereich gefunden werden, und bei fehlenden oder
  veralteten SDK-Versionen (< 10.0) eine `WARN` ausgeben.

#### I — C#-Projekt-Konventionen / C# Project Conventions

> Diese Anforderungen gelten für alle C#-Projekte im Workspace-System und
> spiegeln die bewusste Entscheidung wider, auf kostenpflichtige GUI-Frameworks
> zu verzichten — insbesondere im Ausbildungskontext.
>
> *These requirements apply to all C# projects in the workspace system and
> reflect the deliberate decision to avoid paid GUI frameworks — especially
> in an apprenticeship context.*

- **FR-I01**: C#-Projekte MÜSSEN als **CLI- oder TUI-Anwendungen** konzipiert
  sein. GUI-Frameworks, die kostenpflichtige Komponentenlizenzen erfordern
  (z. B. DevExpress, Telerik, Syncfusion, ComponentSource-Produkte), sind
  **verboten**.
  *C# projects MUST be CLI or TUI applications. GUI frameworks requiring paid
  component licences are prohibited.*

- **FR-I02**: Erlaubte Abhängigkeiten für C#-Projekte:
  - **NuGet-Pakete** mit MIT-, Apache-2.0- oder äquivalenter Open-Source-Lizenz
  - **Eigene Bibliotheken** aus dem gleichen Workspace (Projektreferenzen)
  - Empfohlene TUI-Bibliotheken: `Spectre.Console`, `Terminal.Gui`,
    `Gui.cs` (alle MIT-lizenziert, kostenlos)

- **FR-I03**: Jedes C#-Projekt MUSS eine `Directory.Build.props`-Datei
  enthalten mit:
  - Ziel-Framework: `net10.0` oder höher
  - `<Nullable>enable</Nullable>`
  - `<ImplicitUsings>enable</ImplicitUsings>`
  - `<TreatWarningsAsErrors>true</TreatWarningsAsErrors>`

- **FR-I04**: Das Prüfskript MUSS für C#-Projekte prüfen:
  - `Directory.Build.props` vorhanden?
  - Keine verbotenen NuGet-Pakete (Blocklist, konfigurierbar)?
  - `.csproj` zielt auf `net10.0` oder neuer?

- **FR-I05**: In der README.md jedes C#-Projekts MUSS ein Abschnitt
  **„Abhängigkeiten / Dependencies"** die verwendeten NuGet-Pakete mit
  Version und Lizenz auflisten — auch als Orientierung für Azubis.



- **NFR-001 Geschwindigkeit / Speed**: Der Homogenitäts-Scan MUSS für eine
  typische Umgebung (≤ 10 Workspaces, ≤ 50 Projekte) in unter 30 Sekunden
  abschließen.
  *The homogeneity scan MUST complete in under 30 seconds for a typical environment.*

- **NFR-002 Sicherheit / Security**: Das Prüfskript DARF KEINE Dateiinhalte an
  externe Dienste senden. Alle Prüfungen sind lokal (kein Netzwerkzugriff).

- **NFR-003 Idempotenz / Idempotency**: Mehrfaches Ausführen von Bootstrap oder
  Scan MUSS zu demselben Zustand führen ohne Datenverlust.

- **NFR-004 Plattformparität / Platform Parity**: Alle Skripte MÜSSEN auf
  macOS (14+, Arm64/x64), Linux (.NET-10-fähige Distributionen, s. FR-H01)
  und Windows 10/11 + Windows Server 2019–2025 lauffähig sein. Bash- und
  PowerShell-Core-7+-Varianten MÜSSEN funktional äquivalent sein
  (Constitution Prinzip II). Skripte, die nur auf einer Plattform laufen,
  gelten als unvollständig.
  *All scripts MUST run on macOS (14+), Linux (see FR-H01) and Windows 10/11.
  Bash and PowerShell Core 7+ variants MUST be functionally equivalent.
  Scripts running on only one platform are considered incomplete.*

- **NFR-005 Rückwärtskompatibilität / Backward Compatibility**: Bestehende
  Workspaces und Projekte DÜRFEN durch das Prüfskript nicht verändert werden
  (read-only). Das Bootstrap-Skript greift nur bei explizitem Aufruf.

- **NFR-006 A11Y-Standard / Accessibility Standard**: Alle generierten Markdown-
  Dateien MÜSSEN WCAG 2.1 Level AA-Entsprechungen im Textformat erfüllen
  (semantische Struktur, Lesbarkeit, kein Informationsverlust durch Farbe allein).

---

## Schlüsselobjekte / Key Entities

- **Ebene / Level**: Eine Hierarchiestufe im Workspace-Baum (0 = Home, 1 = Workspace,
  2 = Projekt).
- **Agenten-Datei / Agent File**: Eine der vier KI-Konfigurations-Dateien
  (`CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `copilot-instructions.md`).
- **SDD-Projekt / SDD Project**: Ein Speckit-Driven Development Project mit
  `spec.md`, `plan.md` und `tasks.md`.
- **Hook**: `pre-push`-Git-Hook zur Secret-Erkennung; blockiert Push bei `HIGH`.
- **Compliance-Score**: Prozentualer Anteil vorhandener und inhaltlich korrekter
  Pflichtdateien.
- **STATS.md**: Fortgeschriebene Statistikdatei pro Ebene mit ASCII-Diagrammen
  und Zeitstempel.

---

## Erfolgskriterien / Success Criteria

### Messbare Ergebnisse / Measurable Outcomes

- **SC-001**: Nach Ausführen von `bootstrap-project.sh` für ein neues Projekt
  liefert `check-homogeneity.sh --level 2` für dieses Projekt `100 %` Compliance.
  *After running `bootstrap-project.sh`, `check-homogeneity.sh --level 2` reports
  `100%` compliance for the new project.*

- **SC-002**: `check-homogeneity.sh` führt für die aktuelle Home-Umgebung
  (6 Workspaces, ca. 12 Projekte) in unter 15 Sekunden durch.

- **SC-003**: Der Pre-Hook blockiert einen Test-Push mit einer `ghp_`-Token-Zeile
  mit Exit-Code 2.
  *The pre-hook blocks a test push containing a `ghp_` token line with exit code 2.*

- **SC-004**: `STATS.md` auf Root-Ebene enthält nach drei aufeinanderfolgenden
  Scan-Läufen drei Zeitstempel-Einträge (Trend-Fortschreibung).

- **SC-005**: Alle Bootstrap-generierten Dateien enthalten einen deutschen und
  einen englischen Abschnitt, erkennbar durch Sprach-Marker.

- **SC-006**: Alle Bootstrap-generierten `README.md`-Dateien bestehen den
  A11Y-Docs-Check (keine WARN-Ausgabe für fehlendes Alt-Text, Heading-Sprünge
  oder leere Links).

---

## Annahmen / Assumptions

- `bash`, `git`, `rg` (ripgrep), `sha256sum` / `shasum -a 256` sind in der
  Zielumgebung vorhanden.
  *`bash`, `git`, `rg` (ripgrep), `sha256sum`/`shasum -a 256` are available in
  the target environment.*

- `gh` (GitHub CLI) ist optional; dessen Fehlen blockiert keinen lokalen Bootstrap.

- Die KI-Agenten-CLIs (`claude`, `codex`, `gemini`) sind optional; Fehlen löst
  nur Warnungen aus, kein Abbruch.
  *AI agent CLIs are optional; their absence only triggers warnings, not aborts.*

- Speckit ist über npm oder direkten Download installierbar.

- Alle SDD-Projekte enthalten eine `spec.md` im Root-Verzeichnis.

- Code-A11Y-Prüfungen sind Hinweise (`WARN`), keine harten Blocker, solange kein
  UI-Framework im Projekt erkannt wird.
  *Code A11Y checks are hints (`WARN`), not hard blockers, unless a UI framework
  is detected in the project.*

- Bestehende Projekte werden durch das Skript **nicht** modifiziert; sie können
  aber durch separaten `apply`-Aufruf auf den aktuellen Stand gebracht werden.

---

## Abhängigkeiten / Dependencies

| Abhängigkeit | Erforderlich? | Hinweis |
|---|:---:|---|
| `bash` ≥ 5 | Ja / Yes | macOS: via Homebrew (`brew install bash`) |
| PowerShell Core ≥ 7 | Ja / Yes | für `.ps1`-Varianten; Linux/macOS: `brew install powershell` |
| `git` | Ja / Yes | Hook-Installation |
| `rg` (ripgrep) | Ja / Yes | Secret-Scan |
| `sha256sum` / `shasum` | Ja / Yes | Hook-Integritätsprüfung |
| .NET 10 SDK | Bedingt / Conditional | Nur für C#-Projekte; Ubuntu 22.04/24.04 LTS, Debian 12, Windows 10+, macOS 14+ |
| `gh` (GitHub CLI) | Nein / No | nur für Remote-Push und Repo-Erstellung |
| `claude` CLI | Nein / No | Bootstrap-Schritt 12 |
| `codex` CLI | Nein / No | Bootstrap-Schritt 13 |
| `gemini` CLI | Nein / No | Bootstrap-Schritt 14 |
| Speckit (npm) | Bedingt / Conditional | wird bei Fehlen installiert |

---

## Konstitutions-Konformität / Constitution Compliance

Diese Spezifikation ist konform mit Constitution v1.1.0:

| Prinzip | Status |
|---|---|
| I. Security-First | ✓ FR-B01–FR-B04 decken Secret-Scanning vollständig ab |
| II. Cross-Platform Parity | ✓ FR-A05, FR-F01 fordern `.sh`+`.ps1` |
| III. Bootstrap Automation | ✓ FR-F01–FR-F05 erweitern den bestehenden Bootstrap |
| IV. Workspace Isolation | ✓ NFR-005 schützt bestehende Repos |
| V. Manual-First Verification | ✓ `--dry-run`/`-WhatIf` in FR-F03 |

---

## Barrierefreiheit / Accessibility (A11Y)

*Dieser Abschnitt ist ein Pflichtbestandteil aller spec.md-Dateien in
Speckit-Driven Development Projekten.*

*This section is a mandatory part of all spec.md files in Speckit-Driven
Development projects.*

### Docs-A11Y-Checkliste / Docs A11Y Checklist

- [ ] Alle Bilder haben `alt`-Texte / All images have `alt` texts
- [ ] Überschriftenhierarchie ohne Sprünge / Heading hierarchy without gaps
- [ ] Keine leeren Linkbeschreibungen / No empty link descriptions
- [ ] Codefragmente in Backticks / Code fragments in backticks
- [ ] Tabellen haben Kopfzeilen / Tables have header rows
- [ ] Keine Information ausschließlich durch Farbe / No information by colour alone
- [ ] Abkürzungen beim ersten Vorkommen erklärt / Abbreviations explained on first use

### Code-A11Y-Hinweise / Code A11Y Hints (für UI-Projekte / for UI projects)

- [ ] Interaktive Elemente haben ARIA-Rollen / Interactive elements have ARIA roles
- [ ] Farbkontrast ≥ 4,5:1 (WCAG 2.1 AA) für Normtext / Contrast ≥ 4.5:1 for normal text
- [ ] Alle Funktionen per Tastatur erreichbar / All functions keyboard-accessible
- [ ] Fokus-Management bei modalen Dialogen / Focus management for modal dialogs

---

*Dieses Dokument ist Speckit-kompatibel und kann direkt als Eingabe für
`speckit plan` und `speckit tasks` verwendet werden.*

*This document is Speckit-compatible and can be used directly as input for
`speckit plan` and `speckit tasks`.*
