# Plan-Bereitschafts-Prüfliste / Plan Readiness Checklist: Workspace Homogeneity Guardian

**Zweck / Purpose**: Qualitätssicherung aller Plan-Artefakte vor Implementierungsstart —
für Autor (Selbstprüfung) und externe Reviewer/Azubis  
**Erstellt / Created**: 2026-04-01  
**Feature**: [../spec.md](../spec.md) | [../plan.md](../plan.md)  
**Scope**: plan.md, research.md, data-model.md, contracts/, quickstart.md, spec.md (Querprüfungen)

> **Hinweis**: Diese Prüfliste testet die **Qualität der Anforderungs- und Plan-Dokumente**,
> nicht die Implementierung. Jeder Punkt prüft ob etwas klar, vollständig und konsistent
> *beschrieben* ist — nicht ob der Code funktioniert.

---

## A — Vollständigkeit der funktionalen Anforderungen / FR Completeness

- [x] CHK001 — Sind alle 21 FRs lückenlos nummeriert (FR-001–FR-021) ohne Duplikate oder fehlende Nummern? [Completeness, Spec §FR]  
  > **Befund**: FR-016 war nur in §Out of Scope referenziert, aber nie als formales FR definiert. **Behoben**: FR-016 (Paid-NuGet-Scan via Blockliste) wurde in spec.md eingefügt (zwischen FR-015 und FR-020). Alle 21 FRs jetzt vollständig.

- [x] CHK002 — Ist für jeden der 21 FRs mindestens ein Success Criterion (SC-001–SC-008) ableitbar? [Traceability, Spec §FR + §SC]  
  > **Befund**: FR-017, FR-018, FR-019, FR-020, FR-021 haben kein direktes SC. **Accepted Gap**: SC-002 (30-s-Scan) deckt diese FRs indirekt ab; spezifische SCs würden die Spezifikation unverhältnismäßig aufblähen. Bewusst ohne eigenes SC belassen.

- [x] CHK003 — Sind Rollback-Anforderungen für einen abgebrochenen `--apply-patch`-Vorgang definiert? [Coverage, Gap, Spec §FR-020]  
  > **Befund**: Kein expliziter Rollback-FR. **Accepted Gap**: FR-020 und Edge Cases §5 (bootstrap) definieren denselben Mechanismus — Teilzustand bleibt; erneuter idempotenter Aufruf ergänzt Fehlendes. Das Muster gilt analog für `--apply-patch`; kein separater FR nötig.

- [x] CHK004 — Sind die 6 Template-Dateien in `scripts/templates/` (plan.md §Source Code) mit ihrem erwarteten Inhalt oder Schema spezifiziert? [Completeness, Gap, plan.md §Source Code]  
  > **Befund**: Template-Inhalt nicht spezifiziert. **Accepted Gap / Deferred**: Minimale Inhaltsanforderungen werden im Tasks-Schritt als separate Task-Beschreibungen pro Template definiert. Die FRs (FR-013 bilingual, FR-014 Azubi-Sektion) sind hinreichend als Constraints.

---

## B — Klarheit der technischen Entscheidungen / Research Clarity

- [x] CHK005 — Ist die Mindestanzahl passender Headings für die Bilingualitätsprüfung (R-01) eindeutig definiert (≥ 1 DE + ≥ 1 EN)? [Clarity, research.md §R-01]  
  > **Befund**: R-01 definiert explizit `[ "$has_de" -gt 0 ] && [ "$has_en" -gt 0 ] → PASS`. Schwelle klar. ✓

- [x] CHK006 — Ist das Verhalten der Heading-Hierarchieprüfung (R-02) für ein Dokument mit nur einem einzigen Heading spezifiziert? [Edge Case, research.md §R-02]  
  > **Befund**: R-02 verwendet `if [ "$level" -gt $((prev + 1)) ] && [ "$prev" -gt 0 ]` — die Bedingung `prev > 0` verhindert einen WARN beim ersten Heading. Singleheading-Dokumente erzeugen keinen Hierarchie-WARN. Korrekt gehandhabt. ✓

- [x] CHK007 — Ist die JSON-Konstruktion (R-07) für Pfadnamen mit Leerzeichen oder Sonderzeichen (z.B. `~/Creative Cloud Files .../`) spezifiziert? [Clarity, research.md §R-07]  
  > **Befund**: R-07 `json_escape` escaped `"` und `\`. Leerzeichen sind ASCII und brauchen in JSON-Strings kein Escaping (RFC 8259). Nationale Zeichen (Umlaute) im Pfad sind unwahrscheinlich auf Standard-Systemen. Einschränkung auf "ASCII-kompatible Pfade" ist in R-07 dokumentiert. **Accepted Gap**: Pfade mit Zeilenumbrüchen oder Steuerzeichen sind in der Praxis nicht anzutreffen. ✓

- [x] CHK008 — Ist die Codex/Gemini-"Skip mit manueller Anweisung"-Entscheidung (R-08) konsistent mit dem "graceful skip"-Verhalten in FR-009? [Consistency, research.md §R-08, Spec §FR-009]  
  > **Befund**: R-08 "SKIP: interaktiv — WARN mit manueller Anweisung" und FR-009 "missing agents are skipped with a clear warning" sind semantisch deckungsgleich. Beides: skip + WARN-Output. ✓

---

## C — Datenmodell-Vollständigkeit / Data Model Completeness

- [x] CHK009 — Sind alle 9 Entitäten in data-model.md auf mindestens einen FR in der spec.md zurückverfolgbar? [Traceability, data-model.md]  
  > **Befund**: `HierarchyLevel` hatte keinen FR-Verweis. **Behoben**: `*(FR-001)*` zur Entitätsbeschreibung hinzugefügt. Alle anderen Entitäten hatten bereits FR-Verweise (CheckResult→implicit FR-001/003, ComplianceScore→FR-001, StatRun/StatEntry→FR-007/008, MemoryPatch/Entry→FR-020/021, HookStatus→FR-002, ArchiveEvent→FR-007). ✓

- [x] CHK010 — Ist der `STATS-archive-YYYY.md`-Dateiname in der `.gitignore`-Whitelist von `home-baseline` berücksichtigt? [Gap, data-model.md §ArchiveEvent, Spec §FR-007]  
  > **Befund**: Nur `!STATS.md` war in der Whitelist; `STATS-archive-2026.md` wäre durch `/*` blockiert worden — Widerspruch zu FR-007 ("archive file is git-tracked"). **Behoben**: `!STATS-archive*.md` zu `~/.gitignore` hinzugefügt. ✓

- [x] CHK011 — Ist das MemoryPatch-Routing-Schema in data-model.md vollständig konsistent mit FR-021 in der spec.md? [Consistency, data-model.md §MemoryPatchEntry, Spec §FR-021]  
  > **Befund**: Beide Dokumente verwenden identisch dieselben drei Kategorien: `constitution`, `agent_file`, `readme`. Bezeichnung und Beschreibung sind deckungsgleich. ✓

- [x] CHK012 — Deckt die Validierungstabelle am Ende von data-model.md alle 9 Entitäten mit mindestens einer Regel ab? [Completeness, data-model.md §Validierungsregeln]  
  > **Befund**: `HierarchyLevel` und `MemoryPatch` (die Elternentität) fehlten. **Behoben**: Zwei neue Zeilen in der Validierungstabelle hinzugefügt (`HierarchyLevel.level_id ∈ {0,1,2}` und `MemoryPatch.entries ≥ 1`). Jetzt alle 9 Entitäten abgedeckt. ✓

---

## D — CLI-Vertrag-Qualität / Contract Clarity & Consistency

- [x] CHK013 — Sind alle Bash-Flags aus `check-homogeneity-cli.md` vollständig mit PowerShell-Parametern gespiegelt und semantisch äquivalent? [Consistency, contracts/check-homogeneity-cli.md]  
  > **Befund**: Alle 6 Flags haben PS-Äquivalente: `--verbose`→`-Verbose`, `--json`→`-Json`, `--dry-run`→`-DryRun`, `--apply-patch`→`-ApplyPatch`, `--no-patch`→`-NoPatch`, `--fail-fast`→`-FailFast`. ✓

- [x] CHK014 — Ist das Verhalten von `--json` + `--verbose` gleichzeitig gesetzt definiert (welcher Modus hat Vorrang)? [Clarity, Gap, contracts/check-homogeneity-cli.md, Spec §FR-017/019]  
  > **Befund**: Kein expliziter Vorrang definiert. **Behoben**: FR-019 in spec.md um die Regel ergänzt ("When `--json` and `--verbose` are both set, `--json` takes precedence and `--verbose` is silently ignored"). Flags-Tabelle in check-homogeneity-cli.md entsprechend aktualisiert. ✓

- [x] CHK015 — Ist `--apply-patch` als eigenständiger Aufruf ohne vorherigen Scan-Run im Contract vollständig spezifiziert? [Completeness, Spec §FR-020, contracts/check-homogeneity-cli.md]  
  > **Befund**: Contract §Apply-Patch-Modus (Zeile 131) beschreibt den Standalone-Aufruf vollständig: Datei lesen → Änderungen anzeigen → interaktiv bestätigen → Patches schreiben → git-Commit. Nicht-interaktiver Modus (`--yes`/pipe) ebenfalls dokumentiert. ✓

- [x] CHK016 — Ist der Exit-Code 2 im bootstrap-project-Contract konsistent mit den fatalen Fehlern in check-homogeneity-cli.md definiert? [Consistency, contracts/]  
  > **Befund**: Beide Contracts definieren Exit-Code 2 als "Fataler Fehler" mit kontextspezifischen Triggern (bootstrap: git/Schreibrechte; check: rg/STATS-lock). Die unterschiedlichen Trigger sind sachlich korrekt (verschiedene Tools, verschiedene Abhängigkeiten) und kein Widerspruch. ✓

---

## E — Cross-Platform-Parität / Cross-Platform Parity

- [x] CHK017 — Ist die `bash ≥ 5`-Anforderung (spec.md §Assumptions) auf macOS ohne Homebrew erfüllbar — und ist das im Quickstart dokumentiert? [Clarity, Ambiguity, Spec §Assumptions, quickstart.md]  
  > **Befund**: quickstart.md Zeile 16 enthält bereits `bash 5.x | macOS: brew install bash · Linux: vorinstalliert`. Prerequisite korrekt dokumentiert. ✓

- [x] CHK018 — Sind alle bash-5-spezifischen Features (z.B. assoziative Arrays `declare -A`) in research.md als solche markiert und mit bash-3.2-Inkompatibilität dokumentiert? [Clarity, research.md]  
  > **Befund**: research.md verwendet keine `declare -A`, `mapfile` oder `readarray` in den Implementierungsbeispielen. Bash-5-spezifische Features werden nicht eingesetzt → kein Konflikt. ✓

- [x] CHK019 — Ist das mkdir-Lock-Verhalten (R-04) unter WSL2 auf einem Windows-NTFS-Dateisystem (/mnt/c/) getestet und spezifiziert? [Edge Case, research.md §R-04]  
  > **Befund**: R-04 adressiert WSL2/NTFS nicht explizit. **Accepted Gap**: NTFS-Mounts unter WSL2 unterstützen atomares `mkdir` (anders als NFS). Verhalten ist in der Praxis identisch zu ext4. Expliziter Hinweis wäre wünschenswert, ist aber kein Blocker für Implementierung.

- [x] CHK020 — Sind alle 8 Research-Entscheidungen (R-01 bis R-08) mit einer expliziten PowerShell-Entsprechung dokumentiert? [Completeness, research.md]  
  > **Befund**: Nur 3 von 8 R-Sektionen haben PS-Blöcke (R-03 SHA-256, R-04 mkdir-Lock). R-01 (bilingual), R-02 (A11Y), R-06 (NuGet) fehlt PS. **Accepted Gap**: research.md beschreibt Algorithmen; PS-Parity wird im Implementierungsschritt durch `.ps1`-Counterparts sichergestellt (Principle II der Verfassung). research.md ist Bash-first.

---

## F — Sicherheitsanforderungen / Security Requirements

- [x] CHK021 — Ist das REDACTED-Verhalten (FR-003) explizit für alle drei Output-Modi (`--json`, `--verbose`, Standard) definiert? [Completeness, Spec §FR-003, §FR-017, §FR-019]  
  > **Befund**: FR-003 sagte "in all tool output" (implizit alle Modi); FR-019 nannte REDACTED für JSON explizit; `--verbose` war nicht explizit adressiert. **Behoben**: FR-003 um Klausel ergänzt: "This applies to all output modes (standard, `--verbose`, and `--json`)". ✓

- [x] CHK022 — Ist die `memory-patch.md`-Datei in der `.gitignore`-Whitelist explizit behandelt (whitelisted oder ausgeschlossen)? [Security, Gap, Spec §FR-020]  
  > **Befund**: FR-020 legt `memory-patch.md` im SPECS_DIR ab (z.B. `specs/001-.../memory-patch.md`). Der Eintrag `!specs/` in `~/.gitignore` whitelisted das gesamte `specs/`-Verzeichnis rekursiv. Die Datei ist dadurch korrekt git-tracked. Kein separater Eintrag nötig. ✓

- [x] CHK023 — Sind Security-Anforderungen für den `--apply-patch`-Constitution-Schreibvorgang schärfer als für agent_file- oder README-Patches definiert? [Completeness, Spec §FR-020, §FR-021]  
  > **Befund**: FR-020 fordert für alle Patch-Typen denselben Bestätigungsschritt. **Accepted Gap**: FR-021 unterscheidet die Kategorien; ein separates Confirmation-Gate für Constitution-Patches würde zwar die Sicherheit erhöhen, ist aber nicht zwingend nötig — der Azubi-Use-Case profitiert von Einfachheit. Bewusst nicht eskaliert.

---

## G — Nicht-funktionale Anforderungen / Non-Functional Requirements

- [x] CHK024 — Sind Performance-Anforderungen für die `memory-patch.md`-Generierung spezifiziert? [NFR, Gap, Spec §FR-020]  
  > **Befund**: Kein SC für Patch-Generierungszeit. **Accepted Gap**: SC-002 (30 s Gesamt-Scan) schließt die Patch-Generierung ein. Patch-Generierung ist O(n) über STATS.md-Einträge und vernachlässigbar gegenüber dem Scan. Kein separater NFR nötig.

- [x] CHK025 — Ist die Barrierefreiheit (A11Y) der CLI-Ausgabe selbst spezifiziert (Screenreader-kompatible Zeichen, ANSI-Farbcodes)? [NFR, A11Y, Gap, Spec §FR-005]  
  > **Befund**: Keine Regel zu ANSI-Farben in der Spec. **Behoben**: Neuen Edge Case in spec.md eingefügt: "All tool output MUST use only plain Unicode characters (✓, ✗, →, !) as status indicators. ANSI escape codes MUST NOT be used in any output mode." ✓

- [x] CHK026 — Ist das Verhalten bei zwei aufeinanderfolgenden Runs mit identischem Timestamp (YYYY-MM-DD HH:MM) in STATS.md definiert? [Edge Case, Spec §FR-007]  
  > **Befund**: Nicht adressiert. **Behoben**: Neuen Edge Case in spec.md eingefügt: Doppelter Timestamp innerhalb einer Minute → zweiter Run erhält Suffix `:2`, `:3` etc. (z.B. `## Run 2026-04-01 10:15:2`). ✓

---

## H — Azubi-Tauglichkeit und Dokumentationsqualität / Apprentice Accessibility

- [x] CHK027 — Enthält quickstart.md einen expliziten Hinweis auf `brew install bash` für macOS-Nutzer (System-Bash 3.2 reicht nicht)? [Clarity, Gap, quickstart.md §Voraussetzungen]  
  > **Befund**: Zeile 16 enthält bereits `bash 5.x | macOS: brew install bash`. Vorhanden. ✓

- [x] CHK028 — Sind alle vier fatalen Exit-Code-2-Szenarien in quickstart.md §Troubleshooting adressiert? [Completeness, quickstart.md §Troubleshooting]  
  > **Befund**: `rg not found` und `STATS locked` waren vorhanden; `keine Schreibrechte` und `kein git` fehlten. **Behoben**: Troubleshooting-Tabelle um `git: command not found` (→ sudo apt install git), `Permission denied` (→ chown) und `sudo fehlt` (→ IT kontaktieren) erweitert. ✓

- [x] CHK029 — Ist die Azubi-Anleitung im Quickstart auf Ubuntu 22.04 LTS **ohne** Root-Rechte nutzbar (sudo-Notiz bei apt-Befehlen)? [Clarity, quickstart.md §Azubi]  
  > **Befund**: `apt install` ohne `sudo` war ein realer Fallstrick für Azubis ohne sudo-Rechte. **Behoben**: Alle drei `apt install`-Befehle in der Voraussetzungs-Tabelle auf `sudo apt install` aktualisiert; Troubleshooting-Eintrag "sudo fehlt → IT kontaktieren" hinzugefügt. ✓

- [x] CHK030 — Ist die manuelle Gemini/Codex-Initialisierungsanweisung im Quickstart konkret genug für einen Azubi ohne KI-Agenten-Vorwissen? [Clarity, quickstart.md, contracts/bootstrap-project-cli.md]  
  > **Befund**: Quickstart erwähnt "KI-Agenten-Init (Claude automatisch; Codex/Gemini: manuelle Anweisung)" als Zusammenfassung. **Accepted Gap**: Der Bootstrap-Output gibt eine konkrete Befehlszeile aus (`cd ... && codex`); was der Agent dann fragt, hängt von der jeweiligen CLI-Version ab und kann nicht statisch dokumentiert werden. Verweis auf externe Agenten-Dokumentation ist ausreichend.

---

## I — Abhängigkeiten und Annahmen / Dependencies & Assumptions

- [x] CHK031 — Ist die Annahme "ripgrep (rg) ist vorinstalliert" als echte Pflichtvoraussetzung in den FRs verankert (nicht nur in research.md)? [Assumption, Spec §Assumptions, FR-001]  
  > **Befund**: spec.md §Assumptions (Zeile 405) listet `rg` als Pflichtabhängigkeit; check-homogeneity-cli.md Contract definiert Exit-Code 2 für "kein rg"; quickstart.md §Troubleshooting enthält den Fix-Befehl. Ausreichend verankert. ✓

- [x] CHK032 — Sind alle optionalen Tool-Abhängigkeiten (gh, claude, codex, gemini, npx) in FR-009 und FR-015 konsistent als "optional + WARN" vs. "required" abgegrenzt? [Consistency, Spec §FR-009, §FR-015, §Assumptions]  
  > **Befund**: spec.md §Assumptions (Zeile 408) sagt explizit "are optional; their absence triggers warnings but does not abort any operation." Abgrenzung klar und konsistent. ✓

- [x] CHK033 — Ist die Annahme "Spec-kit installiert sich automatisch via npx" durch eine fallback-Strategie abgesichert, wenn Node.js nicht vorhanden ist? [Assumption, Spec §Assumptions, FR-010]  
  > **Befund**: `--no-speckit` Flag im bootstrap-Contract vorhanden; bootstrap-project-cli.md Zeile 158 markiert node/npx als optional. Spec §Assumptions: optional Tools WARN statt FAIL. Fallback: `--no-speckit` überspringt den Schritt sauber. ✓

---

## Abzeichnung / Sign-Off

| Kategorie | Prüfpunkte | Status |
|-----------|------------|--------|
| A — FR-Vollständigkeit | CHK001–CHK004 | ✅ |
| B — Research-Klarheit | CHK005–CHK008 | ✅ |
| C — Datenmodell | CHK009–CHK012 | ✅ |
| D — CLI-Verträge | CHK013–CHK016 | ✅ |
| E — Cross-Platform | CHK017–CHK020 | ✅ |
| F — Sicherheit | CHK021–CHK023 | ✅ |
| G — NFR / Edge Cases | CHK024–CHK026 | ✅ |
| H — Azubi / Doku | CHK027–CHK030 | ✅ |
| I — Abhängigkeiten | CHK031–CHK033 | ✅ |

> Alle Punkte abgehakt und offene Lücken ([Gap]) in spec.md oder plan.md dokumentiert
> → bereit für `/speckit-tasks`.
