# Plan-Review-Prüfliste / Plan Review Checklist
# Workspace Homogeneity Guardian — Revision & Gap Fix

**Zweck / Purpose**: Peer-Review-Gate für `plan.md` — prüft Plan-Vollständigkeit,
Verfassungskonformität und Konsistenz mit `spec.md` sowie `contracts/`.  
*Peer-review gate for `plan.md` — validates plan completeness, constitution compliance,
and consistency with `spec.md` and `contracts/`.*

**Erstellt / Created**: 2026-04-02  
**Feature**: `specs/002-homogeneity-guardian-revision/spec.md`  
**Plan**: `specs/002-homogeneity-guardian-revision/plan.md`  
**Anleitung / Instructions**: Hake ab mit `[x]`, sobald ein Punkt erfüllt ist.
Notiere Befunde direkt inline unter dem Prüfpunkt.  
*Mark with `[x]` when satisfied. Note findings inline below each item.*

---

## 1. Dokumenten-Header / Document Header

- [x] CHK001 Branch-Name im Header stimmt mit dem aktiven Git-Branch überein.
  *Hinweis: `git branch --show-current` ausführen und mit dem `**Branch**`-Feld in `plan.md` Zeile 3 vergleichen.*

- [x] CHK002 Datumsfeld ist ausgefüllt (kein Platzhalter `[DATE]`).
  *Hinweis: `plan.md` Zeile 4 — Feld `**Datum / Date**` auf echtes Datum prüfen.*

- [x] CHK003 Spec-Link zeigt auf existierende `spec.md` im korrekten Verzeichnis.
  *Hinweis: `ls specs/002-homogeneity-guardian-revision/spec.md` — muss existieren und nicht leer sein.*

- [x] CHK004 Abhängigkeit von `001-workspace-homogeneity-guardian` ist explizit deklariert.
  *Hinweis: `plan.md` Zeile 6 — Feld `**Abhängig von**` vorhanden und korrekt befüllt.*

---

## 2. Zusammenfassung / Summary

- [x] CHK005 Zusammenfassung nennt konkret die Anzahl der Lieferobjekte (Skript-Paare, Templates, CI-Workflow).
  *Hinweis: `plan.md` §Zusammenfassung — prüfe, ob „7 neue Skript-Paare", „4 Template-Dateien" und „1 CI/CD-Workflow" explizit genannt sind; dann `§Projektstruktur/Quellcode` zählen und abgleichen.*
  > ✏️ Korrektur: „7 Skript-Paare" → „6 Skript-Paare" (6 Skript-Paare gezählt); plan.md korrigiert.

- [x] CHK006 Zusammenfassung referenziert `NFR-REV-01` als Quelle für die Umsetzungsreihenfolge.
  *Hinweis: `plan.md` §Zusammenfassung — Stichwort „NFR-REV-01" suchen; dann in `spec.md` §Non-Functional Requirements prüfen, ob diese Referenz korrekt ist.*

---

## 3. Technischer Kontext / Technical Context

- [x] CHK007 Kein Feld enthält den Platzhaltertext `NEEDS CLARIFICATION`.
  *Hinweis: `grep -i "NEEDS CLARIFICATION" specs/002-homogeneity-guardian-revision/plan.md` — muss leer zurückkehren.*

- [x] CHK008 Sprachversionen (Bash 5+, PowerShell Core 7+) stimmen mit `spec.md NFR-REV-04` überein.
  *Hinweis: `plan.md` §Technischer Kontext, Feld `Language/Version` — gegen `spec.md` §NFR-REV-04 abgleichen.*

- [x] CHK009 Alle Kern-Dependencies (`git`, `rg`, `gh`) sind aufgeführt; Optionalität von `gh` ist markiert.
  *Hinweis: `plan.md` §Technischer Kontext, Feld `Primary Dependencies` — `gh` muss als `(optional, Bootstrap)` markiert sein; gegen `spec.md §Assumptions` abgleichen.*

- [x] CHK010 Zielplattformen decken genau die vier in `spec.md NFR-REV-04` genannten Systeme ab.
  *Hinweis: `plan.md` Feld `Target Platform` — erwartete Werte: `macOS 14+`, `Ubuntu 22.04/24.04 LTS`, `Debian 12`, `Windows 10/11 (nativ + WSL2)`.*

- [x] CHK011 Testing-Strategie stimmt mit `spec.md Constitution V` überein: kein automatisches Test-Framework.
  *Hinweis: `plan.md` Feld `Testing` — muss `--dry-run`/`-WhatIf` + `check-homogeneity.sh` als Validierung nennen; darf kein Test-Framework (pytest, jest usw.) enthalten.*

- [x] CHK012 Constraints nennen explizit „append-only", „idempotent" und „kein Test-Framework".
  *Hinweis: `plan.md` Feld `Constraints` — gegen `spec.md NFR-REV-02` (nicht-destruktiv) und `Constitution V` (Manual-First) prüfen.*
  > ✏️ Ergänzt: NFR-REV-07 (keine ANSI-Escape-Sequenzen in `scripts/`) in Constraints aufgenommen.

---

## 4. Verfassungs-Prüfung / Constitution Check

- [x] CHK013 Alle 5 Constitution-Prinzipien sind bewertet (I–V); kein Prinzip fehlt oder ist übersprungen.
  *Hinweis: `plan.md` §Verfassungs-Prüfung — Tabelle muss 5 Zeilen enthalten; gegen `~/.specify/memory/constitution.md` Abschnitt `## Core Principles` abgleichen.*

- [x] CHK014 Jedes PASS-Urteil enthält eine konkrete Begründung mit FR-/NFR-Referenz — keine Leer-Rationale.
  *Hinweis: Tabelle Spalte `Begründung` — jede Zeile muss mindestens eine FR-/NFR-ID oder eine Skript-Datei-Referenz enthalten.*

- [x] CHK015 Prinzip I (Security-First): Begründung verweist auf `FR-REV-A04` (Level-2-Hook) UND `FR-REV-B02` (constitution.md-Kopie).
  *Hinweis: `plan.md` Tabellenzeile „I. Security-First" — beide FR-IDs müssen sichtbar sein; gegen `spec.md §FR-REV-A04` und `contracts/bootstrap-project-cli.md` §Prozessablauf prüfen.*

- [x] CHK016 Prinzip II (Cross-Platform): Begründung gibt die konkrete Skript-Zahl an.
  *Hinweis: `plan.md` Tabellenzeile „II." — Zahl muss in der Begründung stehen; gegen die Skriptliste in §Projektstruktur/Quellcode zählen und verifizieren.*
  > ✏️ Korrektur: „7" → „6" in Prinzip-II-Begründung; plan.md korrigiert.

- [x] CHK017 Ergebnis-Zeile unter der Tabelle bestätigt explizit, dass Complexity Tracking entfällt.
  *Hinweis: `plan.md` §Verfassungs-Prüfung unterhalb der Tabelle — Satz „Complexity Tracking entfällt" oder äquivalent muss vorhanden sein.*

---

## 5. Projektstruktur / Project Structure

- [x] CHK018 Alle 8 `contracts/`-Dateien aus dem Spec-Artefakte-Baum existieren tatsächlich im Dateisystem.
  *Hinweis: `ls specs/002-homogeneity-guardian-revision/contracts/` — muss genau 8 Dateien zeigen: `bootstrap-project-cli.md`, `check-homogeneity-cli.md`, `homogeneity-check-yml.md`, `init-stats-cli.md`, `migrate-workspace-cli.md`, `rename-lastenheft-cli.md`, `stats-md-format.md`, `sync-constitution-cli.md`.*

- [x] CHK019 Phase-0-Artefakt `research.md` und Phase-1-Artefakte (`data-model.md`, `quickstart.md`) sind im Baum gelistet UND im Dateisystem vorhanden.
  *Hinweis: `ls specs/002-homogeneity-guardian-revision/` — `research.md`, `data-model.md` und `quickstart.md` müssen alle vorhanden sein.*

- [x] CHK020 `tasks.md` fehlt im Dateisystem (wird erst von `/speckit.tasks` generiert) — Kommentar im Baum macht das explizit.
  *Hinweis: `ls specs/002-homogeneity-guardian-revision/tasks.md 2>&1` — Datei sollte NICHT existieren; `plan.md` §Spec-Artefakte-Baum muss den Hinweis `# Phase 2 Output (/speckit.tasks — NOT created by /speckit.plan)` enthalten.*

- [x] CHK021 Alle 6 Skript-Paare sind im Quellcode-Baum aufgeführt, jedes mit `.sh`- UND `.ps1`-Variante.
  *Hinweis: `plan.md` §Quellcode — zähle die `.sh`-Einträge (sollten 6 sein). Für jedes `.sh` muss eine korrespondierende `.ps1`-Variante in derselben Zeile aufgeführt sein.*
  > ✏️ Korrektur: Ursprünglich stand „7 Paare" — tatsächlich sind es 6; Checklist-Text und plan.md korrigiert.

- [x] CHK022 Jedes Skript im Quellcode-Baum referenziert mindestens ein `FR-REV-*`-Kürzel als Kommentar.
  *Hinweis: `plan.md` §Quellcode-Baum — jede Skript-Zeile muss einen `# FR-REV-*`-Kommentar tragen; gegen `spec.md §Functional Requirements` prüfen, ob die FR-IDs korrekt sind.*

- [x] CHK023 `Strukturentscheidung`-Absatz erklärt das gewählte Layout und warum kein `src/`-Verzeichnis verwendet wird.
  *Hinweis: `plan.md` §Quellcode, letzter Absatz — muss das Single-repo-CLI-Muster begründen.*

---

## 6. Umsetzungsreihenfolge / Implementation Order

- [x] CHK024 Die Tabelle enthält exakt 10 Phasen und entspricht `spec.md NFR-REV-01` Schritt für Schritt.
  *Hinweis: `plan.md` §Umsetzungsreihenfolge — 10 Zeilen zählen; gegen `spec.md §NFR-REV-01` Reihenfolge `(1) REV-C → (2) REV-B01 → ... → (10) REV-G` abgleichen.*

- [x] CHK025 Alle 18 `SW-xx`-Kennzeichnungen sind in der Tabelle abgedeckt (kein SW bleibt ohne Phase).
  *Hinweis: `plan.md` Spalte `SW-Fix` — alle SW-01 bis SW-18 aufsammeln (mehrere SWs pro Zeile erlaubt); prüfen, ob SW-01 bis SW-18 lückenlos abgedeckt sind. `spec.md §Audit-Ergebnisse` als Referenz verwenden.*
  > ✏️ Korrektur: SW-17 fehlte — jetzt in Phase 2 (REV-B01) ergänzt; plan.md korrigiert.

- [x] CHK026 Phase 2 (REV-B01 = `check-homogeneity.sh`) kommt vor Phase 3 (REV-B04 = `init-stats.sh`), weil `init-stats.sh` intern `check-homogeneity.sh --json` aufruft.
  *Hinweis: `plan.md` Tabelle Zeilen 2 und 3 — Reihenfolge prüfen; dann `contracts/init-stats-cli.md` §Prozessablauf Schritt 1 lesen und Abhängigkeit bestätigen.*

---

## 7. Spezifikations-Konsistenz / Spec Consistency (Cross-Check)

- [x] CHK027 Alle 22 `FR-REV-*`-Anforderungen aus `spec.md` sind in der Projektstruktur oder der Umsetzungsreihenfolge referenziert — kein FR bleibt ohne Skript/Datei-Zuordnung.
  *Hinweis: `grep "FR-REV-" specs/002-homogeneity-guardian-revision/spec.md | grep -oE "FR-REV-[A-Z0-9]+" | sort -u` — erzeuge Liste aller FR-IDs; dann `grep "FR-REV-" specs/002-homogeneity-guardian-revision/plan.md | grep -oE "FR-REV-[A-Z0-9]+" | sort -u` — vergleiche beide Listen.*
  > ✅ Gruppenreferenzen decken alle 22 FRs ab: REV-A (A01–A06), REV-B01, REV-B04 (B02, B03, B05 im Quellcode-Baum), REV-C (C01–C02), REV-D (D01–D02), REV-E (E01–E02), REV-F (F01–F02), REV-G (G01–G03).

- [x] CHK028 Erfolgskriterien `SC-REV-01` bis `SC-REV-07` aus `spec.md` lassen sich den Lieferobjekten im Plan zuordnen (SC-REV-01 → `check-homogeneity.sh`, SC-REV-03 → `init-stats.sh`, usw.).
  *Hinweis: `spec.md §Success Criteria` öffnen — für jeden SC-REV-* das korrespondierende Skript/Datei in `plan.md §Projektstruktur` oder `§Umsetzungsreihenfolge` identifizieren; fehlende Zuordnungen als Befund notieren.*
  > ✅ SC-REV-01 → Phase 2; SC-REV-02 → Phase 4; SC-REV-03 → Phase 3; SC-REV-04 → Phase 1; SC-REV-05 → Phase 6; SC-REV-06 → Phase 10; SC-REV-07 → Phase 4. Vollständige Abdeckung.

- [x] CHK029 Die 7 `NFR-REV-*`-Anforderungen finden sich im Technical Context oder Constitution Check des Plans wieder.
  *Hinweis: `spec.md §Non-Functional Requirements` — NFR-REV-01 (Reihenfolge) in §Umsetzungsreihenfolge; NFR-REV-02 (nicht-destruktiv) in `Constraints`; NFR-REV-04 (Plattform) in `Target Platform`; NFR-REV-06 (Laufzeit) in `Performance Goals`; NFR-REV-07 (TUI-A11Y) in `contracts/check-homogeneity-cli.md §Checks`.*
  > ✏️ Ergänzt: NFR-REV-07 jetzt explizit in plan.md §Constraints aufgenommen.

---

## 8. Contract-Vollständigkeit / Contract Coverage

- [x] CHK030 Für jedes der 6 neuen Bash-/PowerShell-Skripte existiert ein dediziertes Contract-Dokument in `contracts/`.
  *Hinweis: Skripte aus `plan.md §Quellcode-Baum` auflisten (6 Paare); dann `ls contracts/` — jedem Skript-Paar muss genau eine `*-cli.md`-Datei entsprechen. `stats-md-format.md` und `homogeneity-check-yml.md` sind Bonus-Verträge, keine Script-Verträge.*

- [x] CHK031 Jeder Script-Contract enthält die Pflichtabschnitte: Aufruf-Syntax, Argumente, Prozessablauf, Fehlerbehandlung, Exit-Codes.
  *Hinweis: Jede `contracts/*-cli.md` öffnen — auf Abschnitte `## Aufruf`, `## Argumente`, `## Prozessablauf`, `## Fehlerbehandlung`, `## Exit-Codes` prüfen; fehlt einer → Befund notieren.*
  > ✏️ Korrektur: `check-homogeneity-cli.md` hatte `## Ausgabe` statt `## Prozessablauf` — Abschnitt `## Prozessablauf` hinzugefügt.

- [x] CHK032 `contracts/check-homogeneity-cli.md` enthält die vollständige Pflichtdatei-Check-Tabelle (15 Checks aus `spec.md FR-REV-B01`, `FR-REV-E02`, `NFR-REV-07`).
  *Hinweis: `contracts/check-homogeneity-cli.md §Checks` — zähle Tabellenzeilen; erwartete Checks gemäß `spec.md FR-REV-B01` + `FR-REV-E02` (`.editorconfig` für C#) + `NFR-REV-07` (ANSI-Codes in `scripts/`).*
  > ✅ 15 Checks gezählt — vollständig.

- [x] CHK033 `contracts/stats-md-format.md` enthält die ASCII-Bar-Berechnungsformel und ein vollständiges Beispiel.
  *Hinweis: `contracts/stats-md-format.md` öffnen — Bash-Formel für `filled`/`empty` und ein Beispiel mit mindestens 2 Tabellenzeilen müssen vorhanden sein.*

- [x] CHK034 `contracts/homogeneity-check-yml.md` enthält die vollständige Workflow-YAML-Vorlage inkl. Matrix, Ripgrep-Install-Steps und Dual-Output-Hinweis (`stdout` + `$GITHUB_STEP_SUMMARY`).
  *Hinweis: `contracts/homogeneity-check-yml.md` öffnen — YAML-Block auf Matrix `[ubuntu-22.04, macos-14, windows-latest]`, alle 3 Ripgrep-Install-Steps und den Abschnitt `## Ausgabe` mit zwei Kanälen prüfen.*

---

## 9. Artefakt-Vollständigkeit / Artifact Completeness

- [x] CHK035 `research.md` enthält mindestens 10 nummerierte Entscheidungen mit Begründung und Spec-Referenz.
  *Hinweis: `specs/002-homogeneity-guardian-revision/research.md` öffnen — Überschriften `## Entscheidung N` zählen (erwartet: 11); jede muss `**Referenz**`-Zeile enthalten.*
  > ✅ 11 Entscheidungen vorhanden, alle mit `**Referenz**`-Zeile.

- [x] CHK036 `data-model.md` enthält alle 7 Entitäten, die Pflichtdatei-Matrix und die Validierungsregeln.
  *Hinweis: `specs/002-homogeneity-guardian-revision/data-model.md` öffnen — auf Abschnitte `## Kernentitäten`, `### Pflichtdatei-Matrix`, `## Validierungsregeln` prüfen.*
  > ✅ Alle drei Abschnitte vorhanden; 7 Entitäten (WorkspaceLevel, WorkspaceInfo, ComplianceCheck, ComplianceReport, StatsEntry, StatsMd, ConstitutionVersion + TemplateFile).

- [x] CHK037 `quickstart.md` deckt mindestens die 5 Szenarien ab: Migration, Bootstrap, Constitution-Sync, Rename-Lastenheft, CI-Status.
  *Hinweis: `specs/002-homogeneity-guardian-revision/quickstart.md` — auf `## Szenario 1` bis `## Szenario 5` prüfen; vollständige Validation-Sequenz muss ebenfalls vorhanden sein.*
  > ✅ Alle 5 Szenarien + vollständige Validation-Sequenz vorhanden.

- [x] CHK038 `tasks.md` existiert noch NICHT (wird von `/speckit.tasks` erzeugt) — Plan ist bereit für den nächsten Schritt.
  *Hinweis: `[ -f specs/002-homogeneity-guardian-revision/tasks.md ] && echo EXISTS || echo READY` — erwartete Ausgabe: `READY`. Wenn `EXISTS`: klären, ob tasks.md manuell angelegt wurde.*
  > ✅ Ausgabe: `READY` — Plan ist bereit für `/speckit-tasks`.

---

## Gesamtergebnis / Overall Result

| Kategorie | Geprüfte Items | Bestanden | Befunde |
|---|---|---|---|
| 1. Dokumenten-Header | CHK001–CHK004 | 4 / 4 | — |
| 2. Zusammenfassung | CHK005–CHK006 | 2 / 2 | CHK005: „7→6 Skript-Paare" korrigiert |
| 3. Technischer Kontext | CHK007–CHK012 | 6 / 6 | CHK012: NFR-REV-07 in Constraints ergänzt |
| 4. Verfassungs-Prüfung | CHK013–CHK017 | 5 / 5 | CHK016: „7→6" in Prinzip-II-Begründung korrigiert |
| 5. Projektstruktur | CHK018–CHK023 | 6 / 6 | CHK021: Checklist-Text „7→6" angepasst |
| 6. Umsetzungsreihenfolge | CHK024–CHK026 | 3 / 3 | CHK025: SW-17 in Phase 2 ergänzt |
| 7. Spezifikations-Konsistenz | CHK027–CHK029 | 3 / 3 | CHK027: Gruppenreferenzen decken alle 22 FRs; CHK029: NFR-REV-07 ergänzt |
| 8. Contract-Vollständigkeit | CHK030–CHK034 | 5 / 5 | CHK031: `## Prozessablauf` in check-homogeneity-cli.md ergänzt |
| 9. Artefakt-Vollständigkeit | CHK035–CHK038 | 4 / 4 | — |
| **Gesamt / Total** | **38** | **38 / 38** | **4 Korrekturen durchgeführt** |

**Entscheidung / Decision**: `[x] APPROVED` `[ ] APPROVED WITH NOTES` `[ ] CHANGES REQUESTED`

**Reviewer**: GitHub Copilot (automatisierte Review-Durchführung)  
**Datum / Date**: 2026-04-02
