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

- [ ] CHK001 — Sind alle 21 FRs lückenlos nummeriert (FR-001–FR-021) ohne Duplikate oder fehlende Nummern? [Completeness, Spec §FR]  
  > **Hinweis**: `grep "^\- \*\*FR-" ~/specs/001-workspace-homogeneity-guardian/spec.md | sort -V`  
  > Prüfe ob FR-012 bis FR-016 *nach* FR-017–019 erscheinen (bekannte Reihenfolge-Anomalie aus der Entstehungsgeschichte). Die Nummerierung muss vollständig sein, die Reihenfolge im Dokument ist sekundär.

- [ ] CHK002 — Ist für jeden der 21 FRs mindestens ein Success Criterion (SC-001–SC-008) ableitbar? [Traceability, Spec §FR + §SC]  
  > **Hinweis**: Erstelle manuell eine Mapping-Tabelle SC→FR. Beispiel: SC-001→FR-009, SC-002→FR-001, SC-003→FR-002. Prüfe insbesondere FR-017 (--verbose), FR-019 (--json), FR-020/021 (memory-patch) — haben diese keinen SC, ist das eine Lücke.

- [ ] CHK003 — Sind Rollback-Anforderungen für einen abgebrochenen `--apply-patch`-Vorgang definiert? [Coverage, Gap, Spec §FR-020]  
  > **Hinweis**: `grep "apply-patch.*fail\|rollback\|interrupted.*patch" ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > FR-020 definiert `--apply-patch` und einen interaktiven Bestätigungsschritt, aber keinen definierten Zustand wenn die Schreibvorgänge halbfertig abbrechen. Ist das absichtlich Out of Scope?

- [ ] CHK004 — Sind die 6 Template-Dateien in `scripts/templates/` (plan.md §Source Code) mit ihrem erwarteten Inhalt oder Schema spezifiziert? [Completeness, Gap, plan.md §Source Code]  
  > **Hinweis**: `grep "\.tmpl" ~/specs/001-workspace-homogeneity-guardian/plan.md`  
  > Die 6 Templates (z.B. `CLAUDE.md.tmpl`, `README.md.tmpl`) sind im Verzeichnisbaum genannt, aber weder in research.md noch in data-model.md ist ihr Pflichtinhalt beschrieben. Eine minimale Inhaltsanforderung ist nötig, damit der Bootstrap immer A11Y- und Bilingualitäts-konform erzeugt.

---

## B — Klarheit der technischen Entscheidungen / Research Clarity

- [ ] CHK005 — Ist die Mindestanzahl passender Headings für die Bilingualitätsprüfung (R-01) eindeutig definiert (≥ 1 DE + ≥ 1 EN)? [Clarity, research.md §R-01]  
  > **Hinweis**: `grep -A20 "R-01" ~/specs/001-workspace-homogeneity-guardian/research.md`  
  > Prüfe ob die Schwelle ("≥1 DE-Heading UND ≥1 EN-Heading = PASS") explizit dokumentiert ist. Fehlt diese Grenze, könnte die Implementierung abweichende Grenzwerte wählen.

- [ ] CHK006 — Ist das Verhalten der Heading-Hierarchieprüfung (R-02) für ein Dokument mit nur einem einzigen Heading spezifiziert? [Edge Case, research.md §R-02]  
  > **Hinweis**: `grep -A25 "R-02" ~/specs/001-workspace-homogeneity-guardian/research.md`  
  > Edge Case: Eine Datei mit nur `# Titel` (H1 ohne Unterabschnitte) sollte keinen Hierarchie-WARN erzeugen. Ist dieser Sonderfall explizit behandelt?

- [ ] CHK007 — Ist die JSON-Konstruktion (R-07) für Pfadnamen mit Leerzeichen oder Sonderzeichen (z.B. `~/Creative Cloud Files .../`) spezifiziert? [Clarity, research.md §R-07]  
  > **Hinweis**: `grep -A20 "R-07" ~/specs/001-workspace-homogeneity-guardian/research.md`  
  > R-07 erwähnt "ASCII-kompatible Pfadzeichen" — aber macOS-Home-Verzeichnisse können Leerzeichen und nationale Sonderzeichen enthalten. Ist das Escape-Verhalten für Leerzeichen, `\n`, und `"` vollständig spezifiziert?

- [ ] CHK008 — Ist die Codex/Gemini-"Skip mit manueller Anweisung"-Entscheidung (R-08) konsistent mit dem "graceful skip"-Verhalten in FR-009? [Consistency, research.md §R-08, Spec §FR-009]  
  > **Hinweis**: `grep -n "Codex\|Gemini\|interactive\|skip" ~/specs/001-workspace-homogeneity-guardian/research.md ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > FR-009 sagt "missing agents are skipped with a clear warning"; R-08 spezifiziert "SKIP: interaktiv — WARN mit manueller Anweisung". Stimmt der Wortlaut der Warnung überein?

---

## C — Datenmodell-Vollständigkeit / Data Model Completeness

- [ ] CHK009 — Sind alle 9 Entitäten in data-model.md auf mindestens einen FR in der spec.md zurückverfolgbar? [Traceability, data-model.md]  
  > **Hinweis**: `grep "FR-" ~/specs/001-workspace-homogeneity-guardian/data-model.md | grep -c "FR-"`  
  > Prüfe ob jede Entität einen FR-Verweis hat. Insbesondere `ArchiveEvent` (→ FR-007) und `MemoryPatch` (→ FR-020) sollten explizit referenziert sein.

- [ ] CHK010 — Ist der `STATS-archive-YYYY.md`-Dateiname in der `.gitignore`-Whitelist von `home-baseline` berücksichtigt? [Gap, data-model.md §ArchiveEvent, Spec §FR-007]  
  > **Hinweis**: `grep "STATS" ~/.gitignore`  
  > Derzeit ist nur `!STATS.md` in der Whitelist. `STATS-archive-2026.md` würde durch `/*` blockiert und wäre nicht git-tracked — obwohl FR-007 explizit sagt die Archivdatei wird "git-tracked". Dies ist ein echter Spec-Widerspruch.

- [ ] CHK011 — Ist das MemoryPatch-Routing-Schema in data-model.md vollständig konsistent mit FR-021 in der spec.md? [Consistency, data-model.md §MemoryPatchEntry, Spec §FR-021]  
  > **Hinweis**: `grep -A12 "Routing-Schema" ~/specs/001-workspace-homogeneity-guardian/data-model.md` vs. `grep -A15 "routing schema" ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > Prüfe ob die drei Kategorien (constitution / agent_file / readme) identisch in beiden Dokumenten benannt und beschrieben sind.

- [ ] CHK012 — Deckt die Validierungstabelle am Ende von data-model.md alle 9 Entitäten mit mindestens einer Regel ab? [Completeness, data-model.md §Validierungsregeln]  
  > **Hinweis**: `grep -c "^\|" ~/specs/001-workspace-homogeneity-guardian/data-model.md`  
  > Zähle die Zeilen in der Validierungsregel-Tabelle und vergleiche mit der Entitätenzahl. Entitäten wie `StatEntry` und `HierarchyLevel` fehlen möglicherweise.

---

## D — CLI-Vertrag-Qualität / Contract Clarity & Consistency

- [ ] CHK013 — Sind alle Bash-Flags aus `check-homogeneity-cli.md` vollständig mit PowerShell-Parametern gespiegelt und semantisch äquivalent? [Consistency, contracts/check-homogeneity-cli.md]  
  > **Hinweis**: `grep "^\| \`--" ~/specs/001-workspace-homogeneity-guardian/contracts/check-homogeneity-cli.md`  
  > Zähle Bash-Flags (6 Stück: --verbose, --json, --dry-run, --apply-patch, --no-patch, --fail-fast) und prüfe ob jeder ein PS-Äquivalent hat. `--fail-fast` fehlt möglicherweise als `-FailFast` in der PS-Spalte.

- [ ] CHK014 — Ist das Verhalten von `--json` + `--verbose` gleichzeitig gesetzt definiert (welcher Modus hat Vorrang)? [Clarity, Gap, contracts/check-homogeneity-cli.md, Spec §FR-017/019]  
  > **Hinweis**: `grep "json.*verbose\|verbose.*json\|mutual.exclusive\|kombiniert" ~/specs/001-workspace-homogeneity-guardian/contracts/check-homogeneity-cli.md ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > FR-019 sagt "When --json is set, no human-readable output is produced" — impliziert Vorrang vor --verbose. Ist das explizit als Regel im Contract oder in der Spec dokumentiert?

- [ ] CHK015 — Ist `--apply-patch` als eigenständiger Aufruf ohne vorherigen Scan-Run im Contract vollständig spezifiziert? [Completeness, Spec §FR-020, contracts/check-homogeneity-cli.md]  
  > **Hinweis**: `grep -B2 -A15 "apply-patch" ~/specs/001-workspace-homogeneity-guardian/contracts/check-homogeneity-cli.md`  
  > Der Contract beschreibt `--apply-patch` als Option von `check-homogeneity.sh`. Ist der Fall `check-homogeneity.sh --apply-patch patch.md` (ohne Scan, nur Patch anwenden) als gültig und vollständig beschrieben?

- [ ] CHK016 — Ist der Exit-Code 2 im bootstrap-project-Contract konsistent mit den fatalen Fehlern in check-homogeneity-cli.md definiert? [Consistency, contracts/]  
  > **Hinweis**: `grep "Exit-Code\|exit.*2\|fataler\|Fatal" ~/specs/001-workspace-homogeneity-guardian/contracts/bootstrap-project-cli.md ~/specs/001-workspace-homogeneity-guardian/contracts/check-homogeneity-cli.md`  
  > Beide Tools verwenden Exit-Code 2 für fatale Fehler — ist die Definition von "fatal" in beiden Contracts identisch formuliert?

---

## E — Cross-Platform-Parität / Cross-Platform Parity

- [ ] CHK017 — Ist die `bash ≥ 5`-Anforderung (spec.md §Assumptions) auf macOS ohne Homebrew erfüllbar — und ist das im Quickstart dokumentiert? [Clarity, Ambiguity, Spec §Assumptions, quickstart.md]  
  > **Hinweis**: `bash --version` auf macOS liefert System-Bash 3.2.57; `grep "brew install bash\|bash.*5\|macOS.*bash" ~/specs/001-workspace-homogeneity-guardian/quickstart.md`  
  > macOS-System-Bash ist 3.2 (zu alt). `brew install bash` wäre nötig. Ist dieser Prerequisite explizit in der Voraussetzungs-Tabelle des Quickstart für macOS genannt?

- [ ] CHK018 — Sind alle bash-5-spezifischen Features (z.B. assoziative Arrays `declare -A`) in research.md als solche markiert und mit bash-3.2-Inkompatibilität dokumentiert? [Clarity, research.md]  
  > **Hinweis**: `grep "declare -A\|mapfile\|readarray\|associative" ~/specs/001-workspace-homogeneity-guardian/research.md`  
  > Bash 3.2 unterstützt keine assoziativen Arrays. Falls research.md solche Features plant, muss entweder ein Fallback oder ein explizites "Requires bash 5" an der Verwendungsstelle dokumentiert sein.

- [ ] CHK019 — Ist das mkdir-Lock-Verhalten (R-04) unter WSL2 auf einem Windows-NTFS-Dateisystem (/mnt/c/) getestet und spezifiziert? [Edge Case, research.md §R-04]  
  > **Hinweis**: `grep -A20 "R-04" ~/specs/001-workspace-homogeneity-guardian/research.md | grep -i "WSL\|NTFS\|windows\|/mnt"`  
  > NTFS-Mounts unter WSL2 verhalten sich bei atomaren mkdir-Operationen anders als native ext4-Filesysteme. Ist dieses Verhalten explizit adressiert oder bewusst als "untested" markiert?

- [ ] CHK020 — Sind alle 8 Research-Entscheidungen (R-01 bis R-08) mit einer expliziten PowerShell-Entsprechung dokumentiert? [Completeness, research.md]  
  > **Hinweis**: `grep -c "PowerShell\|PS:" ~/specs/001-workspace-homogeneity-guardian/research.md`  
  > Prüfe ob jede R-0x-Sektion einen PowerShell-Implementierungsblock enthält. R-01 (bilingual), R-02 (A11Y) und R-06 (NuGet) könnten fehlen, da sie grep/rg-basiert sind.

---

## F — Sicherheitsanforderungen / Security Requirements

- [ ] CHK021 — Ist das REDACTED-Verhalten (FR-003) explizit für alle drei Output-Modi (`--json`, `--verbose`, Standard) definiert? [Completeness, Spec §FR-003, §FR-017, §FR-019]  
  > **Hinweis**: `grep -n "REDACTED" ~/specs/001-workspace-homogeneity-guardian/spec.md ~/specs/001-workspace-homogeneity-guardian/contracts/check-homogeneity-cli.md`  
  > FR-003 sagt "all tool output"; FR-019 wiederholt REDACTED für JSON. Ist `--verbose` explizit adressiert? Insbesondere: zeigt --verbose nur Dateiname+Zeile (REDACTED) oder auch Muster-Details?

- [ ] CHK022 — Ist die `memory-patch.md`-Datei in der `.gitignore`-Whitelist explizit behandelt (whitelisted oder ausgeschlossen)? [Security, Gap, Spec §FR-020]  
  > **Hinweis**: `grep "memory-patch\|patch\.md" ~/.gitignore ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > `memory-patch.md` enthält Workspace-Pfade und könnte Workspace-Namen enthalten. Soll die Datei git-tracked sein (für Review-Workflow) oder ephemeral (nicht getrackt)? FR-020 sagt "SPECS_DIR" — das würde `specs/001-.../memory-patch.md` bedeuten, das bereits durch `!specs/` whitelisted ist.

- [ ] CHK023 — Sind Security-Anforderungen für den `--apply-patch`-Constitution-Schreibvorgang schärfer als für agent_file- oder README-Patches definiert? [Completeness, Spec §FR-020, §FR-021]  
  > **Hinweis**: `grep -A5 "constitution\|apply.*constitution" ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > FR-021 beschreibt drei Kategorien gleich; FR-020 fordert einen Bestätigungsschritt für alle. Ist für constitution-Patches ein zweiter Bestätigungsschritt oder eine höhere Schranke (z.B. explizites Eintippen von "CONFIRM") spezifiziert?

---

## G — Nicht-funktionale Anforderungen / Non-Functional Requirements

- [ ] CHK024 — Sind Performance-Anforderungen für die `memory-patch.md`-Generierung spezifiziert? [NFR, Gap, Spec §FR-020]  
  > **Hinweis**: `grep "memory-patch.*second\|patch.*time\|performance.*patch" ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > SC-002 definiert 30 s für den Scan, aber kein SC deckt die Patch-Generierungszeit ab. Da Patch-Trigger einen STATS.md-Vergleich erfordern, könnte die Laufzeit bei großen Histories relevant sein.

- [ ] CHK025 — Ist die Barrierefreiheit (A11Y) der CLI-Ausgabe selbst spezifiziert (Screenreader-kompatible Zeichen, ANSI-Farbcodes)? [NFR, A11Y, Gap, Spec §FR-005]  
  > **Hinweis**: `grep "ANSI\|color.*code\|terminal.*a11y\|screen.*reader" ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > FR-005 betrifft Markdown-Dokumente, nicht die CLI-Ausgabe. Die Unicode-Zeichen ✓/✗ in der Ausgabe sind Screenreader-kompatibel; ANSI-Farbcodes (z.B. rot für ✗) wären es nicht. Ist das spezifiziert?

- [ ] CHK026 — Ist das Verhalten bei zwei aufeinanderfolgenden Runs mit identischem Timestamp (YYYY-MM-DD HH:MM) in STATS.md definiert? [Edge Case, Spec §FR-007]  
  > **Hinweis**: `grep "same timestamp\|duplicate.*run\|identical.*heading" ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > STATS.md erlaubt theoretisch doppelte `## Run YYYY-MM-DD HH:MM`-Headings (z.B. zwei Runs in derselben Minute). Ist das explizit erlaubt, verboten oder wird ein Sekundenanteil hinzugefügt?

---

## H — Azubi-Tauglichkeit und Dokumentationsqualität / Apprentice Accessibility

- [ ] CHK027 — Enthält quickstart.md einen expliziten Hinweis auf `brew install bash` für macOS-Nutzer (System-Bash 3.2 reicht nicht)? [Clarity, Gap, quickstart.md §Voraussetzungen]  
  > **Hinweis**: `grep -A5 "macOS\|brew" ~/specs/001-workspace-homogeneity-guardian/quickstart.md`  
  > Die Voraussetzungstabelle nennt `bash 5.x` mit `macOS: brew install bash` — prüfe ob der Eintrag tatsächlich vorhanden ist. (Bekannte Lücke: wurde beim Generieren nicht explizit eingefügt.)

- [ ] CHK028 — Sind alle vier fatalen Exit-Code-2-Szenarien in quickstart.md §Troubleshooting adressiert? [Completeness, quickstart.md §Troubleshooting]  
  > **Hinweis**: `grep "Exit-Code 2\|fataler\|kein.*rg\|locked\|Schreibrecht\|kein.*git" ~/specs/001-workspace-homogeneity-guardian/quickstart.md`  
  > Contract definiert Exit-Code 2 für: kein `rg`, STATS.md locked, keine Schreibrechte, kein `git`. Prüfe ob alle vier in der Troubleshooting-Tabelle erscheinen.

- [ ] CHK029 — Ist die Azubi-Anleitung im Quickstart auf Ubuntu 22.04 LTS **ohne** Root-Rechte nutzbar (sudo-Notiz bei apt-Befehlen)? [Clarity, quickstart.md §Azubi]  
  > **Hinweis**: `grep "apt\|sudo" ~/specs/001-workspace-homogeneity-guardian/quickstart.md`  
  > Azubis auf frisch installierten Ubuntu-Systemen haben möglicherweise kein sudo-Recht. Prüfe ob `sudo apt install ripgrep` mit `sudo` formuliert ist und ob ein Hinweis auf fehlende sudo-Rechte (z.B. Kontakt mit IT) vorhanden ist.

- [ ] CHK030 — Ist die manuelle Gemini/Codex-Initialisierungsanweisung im Quickstart konkret genug für einen Azubi ohne KI-Agenten-Vorwissen? [Clarity, quickstart.md, contracts/bootstrap-project-cli.md]  
  > **Hinweis**: `grep -B1 -A5 "manuell\|manually\|codex\|gemini" ~/specs/001-workspace-homogeneity-guardian/quickstart.md`  
  > Der Bootstrap-Output gibt "Bitte manuell ausführen: cd ... && codex" aus. Ist erklärt *was* Codex/Gemini dann fragt und *was* der Azubi eingeben soll? Oder verweist der Quickstart auf externe Dokumentation?

---

## I — Abhängigkeiten und Annahmen / Dependencies & Assumptions

- [ ] CHK031 — Ist die Annahme "ripgrep (rg) ist vorinstalliert" als echte Pflichtvoraussetzung in den FRs verankert (nicht nur in research.md)? [Assumption, Spec §Assumptions, FR-001]  
  > **Hinweis**: `grep "rg\|ripgrep\|required\|MUST.*install" ~/specs/001-workspace-homogeneity-guardian/spec.md`  
  > research.md R-01 und R-02 setzen `rg` voraus. In spec.md §Assumptions ist `rg` genannt, aber kein FR explizit macht `rg` zur formalen Voraussetzung. Ist das Fehlen von `rg` als Exit-Code-2-Szenario verankert?

- [ ] CHK032 — Sind alle optionalen Tool-Abhängigkeiten (gh, claude, codex, gemini, npx) in FR-009 und FR-015 konsistent als "optional + WARN" vs. "required" abgegrenzt? [Consistency, Spec §FR-009, §FR-015, §Assumptions]  
  > **Hinweis**: `grep "optional\|WARN.*not installed\|required" ~/specs/001-workspace-homogeneity-guardian/spec.md | head -15`  
  > Prüfe ob zwischen "graceful skip mit WARN" (gh, KI-Agenten, npx) und "Fatal Error" (git, bash, rg) in der Spec eindeutig unterschieden wird.

- [ ] CHK033 — Ist die Annahme "Spec-kit installiert sich automatisch via npx" durch eine fallback-Strategie abgesichert, wenn Node.js nicht vorhanden ist? [Assumption, Spec §Assumptions, FR-010]  
  > **Hinweis**: `grep "npx\|node.*not\|nodejs\|--no-speckit" ~/specs/001-workspace-homogeneity-guardian/spec.md ~/specs/001-workspace-homogeneity-guardian/contracts/bootstrap-project-cli.md`  
  > FR-010 sagt Spec-kit wird automatisch installiert. `--no-speckit` ist im Contract vorhanden. Ist der Fehlerfall "npx/node nicht vorhanden" mit Exit-Code und WARN vs. FAIL spezifiziert?

---

## Abzeichnung / Sign-Off

| Kategorie | Prüfpunkte | Status |
|-----------|------------|--------|
| A — FR-Vollständigkeit | CHK001–CHK004 | ☐ |
| B — Research-Klarheit | CHK005–CHK008 | ☐ |
| C — Datenmodell | CHK009–CHK012 | ☐ |
| D — CLI-Verträge | CHK013–CHK016 | ☐ |
| E — Cross-Platform | CHK017–CHK020 | ☐ |
| F — Sicherheit | CHK021–CHK023 | ☐ |
| G — NFR / Edge Cases | CHK024–CHK026 | ☐ |
| H — Azubi / Doku | CHK027–CHK030 | ☐ |
| I — Abhängigkeiten | CHK031–CHK033 | ☐ |

> Alle Punkte abgehakt und offene Lücken ([Gap]) in spec.md oder plan.md dokumentiert
> → bereit für `/speckit-tasks`.
