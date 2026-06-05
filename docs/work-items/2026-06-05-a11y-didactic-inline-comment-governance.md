# Arbeitsnotiz: a11y-governance um didaktische Inline-Kommentar-Regeln erweitern

Status: offen
Quelle: `/Users/thorstenhindermann/RiderProjects/TuiVision`
Quelle-Kontext: `add didactic inline comment hardening guidance`
Datum: 2026-06-05

## Anlass

In TuiVision sowie den Level-2-Repos TinyPl0, TinyCalc und
InventarWorkerService wurde eine gemeinsame Guidance fuer didaktische
Inline-Code-Kommentare ergaenzt. Die Regel ist nicht TuiVision-spezifisch:
Neue oder geaenderte nicht-triviale Logik soll auf Kommentarbedarf geprueft
werden, wenn Lernverstaendnis oder Wartbarkeit betroffen sind.

Die fachliche Preset-Zustaendigkeit liegt bei `a11y-governance`, weil dieses
Preset bereits `Programmierung #include<everyone>`, DE-first/EN-second,
CEFR-B2, text-first und inklusive Lern-/Dokumentationsqualitaet traegt.
`agent-parity-governance` bleibt der Synchronisationsmechanismus fuer
Agenten-Dateien, ist aber nicht der fachliche Ort fuer diese Regel.

## Ziel

`a11y-governance` soll als Minor-Update von `0.2.0` auf `0.3.0` erweitert
werden. Das Update macht didaktische Inline-Code-Kommentare zu einer
expliziten Spec-Kit-Governance-Erwartung, ohne triviale Kommentarflut zu
erzwingen.

## Primaere Bearbeitungsorte

Zuerst im `home-baseline`-Scaffold bearbeiten:

- `specs/spec-kit-presets/a11y-governance/`
- `specs/spec-kit-preset-repos/spec-kit-preset-a11y-governance/`

Danach in das Standalone-Preset-Repo propagieren:

- `~/SpecKitPresetProjects/spec-kit-preset-a11y-governance/`

Konsumenten wie TuiVision werden erst nach der sauberen Preset-Aktualisierung
und Verifikation nachgezogen.

## Inhaltliche Anforderungen

- `a11y-governance` Version auf `0.3.0` erhoehen.
- Preset-Beschreibung und README um didaktische Code-Kommentar-Governance
  erweitern.
- Constitution-Addendum ergaenzen:
  - neue/geaenderte nicht-triviale Logik auf didaktischen Kommentarbedarf
    pruefen, wenn Lernverstaendnis oder Wartbarkeit betroffen sind.
  - Kommentare erklaeren Warum, Trade-off, Randbedingung, historische
    Abweichung oder Proof-Grenze.
  - Kommentare wiederholen nicht den offensichtlichen Code.
  - normale Intensitaet: 1 bis 3 Zeilen vor einem nicht-trivialen Block.
  - didaktische Erklaerbloecke bleiben German-first/English-second und
    CEFR-B2-orientiert.
- Spec-Addendum ergaenzen:
  - festhalten, ob neue/geaenderte nicht-triviale Logik betroffen ist.
  - festhalten, ob didaktische Inline-Kommentare fuer Lern-/Wartungsverstaendnis
    erforderlich sind.
  - `N/A` mit kurzer Begruendung dokumentieren, wenn keine Code-Logik betroffen
    ist.
- Plan-Addendum ergaenzen:
  - Review-Schritt fuer didaktischen Inline-Kommentarbedarf planen.
  - vorhandene Kommentare auf Aktualitaet pruefen, wenn Logik geaendert wird.
- Tasks-Addendum ergaenzen:
  - explizite Tasks fuer didaktische Inline-Kommentar-Pruefung aufnehmen.
  - Review-Kategorien in Task- oder Evidence-Text nutzen, wenn sinnvoll.
- Agent-File-Addendum ergaenzen:
  - Agenten pruefen neue/geaenderte nicht-triviale Logik auf didaktischen
    Kommentarwert.
  - Kommentare erklaeren Warum/Trade-off/Randbedingung/historische Abweichung/
    Proof-Grenze, nicht triviales Was.

## Neues Template

Neues Template anlegen:

- `templates/didactic-code-comment-check-template.md`

Vorgeschlagene Struktur:

- Scope: Feature, Reviewer, Datum, betroffene Pfade.
- Review-Kategorien:
  - `CommentAdequate`
  - `CommentNeeded`
  - `NoCommentNeeded`
  - `UpdateExistingComment`
  - `FollowUpHardening`
- Prueffelder:
  - nicht-triviale Logik identifiziert
  - Lern-/Wartungswert bewertet
  - Kommentar erklaert Warum, Trade-off, Randbedingung, historische Abweichung
    oder Proof-Grenze
  - Kommentar vermeidet offensichtliches Was
  - Intensitaet bleibt moderat
  - German-first/English-second und CEFR-B2 fuer didaktische Erklaerbloecke
- Follow-up: offene Stellen, Owner, Re-Review-Trigger.

Das Template in `preset.yml` registrieren und in README/Evidence-Listen nennen.

## Abgrenzung

Keine fachliche Aenderung an:

- `agent-parity-governance`
- `security-governance`
- `architecture-governance`
- `isaqb-architecture-governance`
- `cross-platform-governance`

Diese Presets duerfen nur dann mitgeprueft werden, wenn zentrale Matrix-,
README- oder Installationshinweise die neue `a11y-governance`-Version nennen.

## Mit zu pruefende home-baseline-Oberflaechen

Preset-Version oder Preset-Scope-Aenderungen muessen gemaess
`.specify/memory/constitution.md` zusammen geprueft werden:

- `constitution.md`
- `.specify/memory/constitution.md`
- `README.md`
- `AGENTS.md`
- `CLAUDE.md`
- `GEMINI.md`
- `.github/copilot-instructions.md`
- `scripts/templates/speckit-workflow-section.md`
- relevante Agent-Templates unter `scripts/templates/`
- `docs/project-statistics.md`

## Validierung

- `rg -n "didactic|didakt|CommentNeeded|Inline" specs/spec-kit-presets/a11y-governance specs/spec-kit-preset-repos/spec-kit-preset-a11y-governance`
- `rg -n "a11y-governance.*0\\.3\\.0|0\\.3\\.0.*a11y-governance" README.md constitution.md .specify/memory/constitution.md AGENTS.md CLAUDE.md GEMINI.md .github/copilot-instructions.md`
- `specify preset list`
- `specify preset info a11y-governance`
- `specify preset resolve a11y-governance:a11y-agent-guidance-addendum-template`
- `specify preset resolve a11y-governance:didactic-code-comment-check-template`
- `git diff --check`

Wenn das Standalone-Preset-Repo aktualisiert wurde:

- Tag/Release fuer `v0.3.0` erstellen.
- GitHub-ZIP-URL smoke-testen.
- Danach Konsumenten gezielt aktualisieren, nicht vorher.

## Entscheidung

Level-0 soll dieses Work-Item als Preset-Pflegeaufgabe ausfuehren. TuiVision
bleibt Konsument und darf die neue Regel erst nach aktualisiertem
`a11y-governance`-Preset uebernehmen.
