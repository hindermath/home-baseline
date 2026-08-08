<!-- intake-authoring:begin -->
# Lastenheft: Preset Modell-Routing-Governance

**Status:** Ready for Intake Review

**Delivery Mode:** MergeAndSync
**Reihenfolge:** 2 von 3; benötigt den abgeschlossenen Gap-Audit

## Ziel und Zielgruppe

Das optionale Preset `model-routing-governance` v0.1.0 macht lokale
Modellfähigkeiten für Spec-Kit-Rollen nutzbar, ohne Modellnamen in fachliche
Artefakte oder Flotten-Repositories zu schreiben. Die Anleitung muss für
Lernende ohne Spec-Kit-Vorkenntnisse verständlich sein.

*The optional preset maps local harness capabilities to stable Spec Kit roles
without committing model IDs. Its guidance remains understandable without
prior Spec Kit experience.*

## Öffentliche Schnittstelle

- Priorität `61`, Spec Kit `>=0.8.3`, MIT-Lizenz;
- `$speckit-model-routing-status` ist strikt read-only;
- `$speckit-model-routing-refresh` schreibt genau ein lokales Profil nach
  aktueller ausdrücklicher Autorität;
- Schema `2.0` bindet Harness, Version, Discovery-Modus, Kataloghash und vier
  modellgestützte Rollen; `script-only` startet kein Modell.

## Anforderungen

- **MRGP-001:** Codex verwendet eine dokumentierte `model/list`-Schnittstelle;
  Antigravity verwendet das belastbare lokale Modellinventar.
- **MRGP-002:** Claude und Copilot validieren nur ausdrücklich konfigurierte
  Kandidaten; OpenCode bleibt `ConfiguredOnly`, solange keine sichere
  Enumeration nachgewiesen ist.
- **MRGP-003:** Automatische Auswahl ist nur bei einer bekannten eindeutigen
  Zuordnung und unterstützter Reasoning-Stufe erlaubt.
- **MRGP-004:** Status ist read-only; Refresh schreibt atomar, geheimnisfrei und
  ausschließlich in einen ignorierten maschinenlokalen Pfad.
- **MRGP-005:** Bash-/PowerShell-Aufrufe liefern dieselben Statusklassen und
  Exitcodes. Positive und negative Fixtures prüfen Drift und Mehrdeutigkeit.
- **MRGP-006:** Alle elf bestehenden Presets veröffentlichen ihr vorhandenes
  `model-routing.json` in einem rückwärtskompatiblen Patch-Release.
- **MRGP-007:** Autonomous Run akzeptiert das lokale Schema 2.0 und wechselt ein
  Modell nur an validierten Phasengrenzen in einem neuen Prozess.
- **MRGP-008:** README, Manpage, Runbook und Agent-Guidance erklären Rollen,
  Datenschutz, Autorität, Stop-Grenzen und Beispiele bilingual.

## Nicht-Ziele

Kein Core-Verhalten von Spec Kit, keine automatische Provideranmeldung, kein
Modell-Download oder Deployment, keine Kostenentscheidung, keine implizite
Remote-/Merge-/Admin-Autorität und keine Zusage für unbekannte Harnesses.

## Abnahme

- Status, Refresh, Codex und Antigravity bestehen positive Tests;
- unbekannte, mehrdeutige und nicht verfügbare Modelle blockieren;
- zwölf Presets lassen sich gemeinsam installieren und auflösen;
- jedes Kommando erscheint je unterstützter Agentenfläche genau einmal;
- Standalone-Repository, Tag `v0.1.0`, ZIP-Smoke und Prüfsumme sind vorhanden;
- elf Patch-Releases bleiben zu älteren Evidence-Schemas kompatibel.

## Kopierbare Prompts

<!-- intake-authoring:prompts -->

```text
$speckit-intake-review Lastenheft_Preset-Modell-Routing-Governance.md
```

<!-- spec-kit-command-id: speckit.specify -->
```text
$speckit-specify Use `Lastenheft_Preset-Modell-Routing-Governance.md` as the binding intake. Specify the optional provider-neutral preset at priority 61 without granting provider or delivery authority.
```

<!-- spec-kit-command-id: speckit.autonomous -->
```text
$speckit-autonomous Execute `Lastenheft_Preset-Modell-Routing-Governance.md` in delivery mode MergeAndSync. Publish and validate v0.1.0 plus the eleven compatible catalog patch releases, but do not start fleet adoption automatically.
```
<!-- intake-authoring:end -->
