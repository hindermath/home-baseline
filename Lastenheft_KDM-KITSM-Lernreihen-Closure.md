<!-- intake-authoring:begin -->
# Lastenheft: KDM-/KITSM-Lernreihen-Closure

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 25, nach Position 24
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** KDM-/KITSM-Lernende, Fachinformatiker*innen, Lehrende,
Ausbildende, Maintainer, Flotten-Operatoren und Reviewer
**Vorausgesetztes Wissen:** gemergte Positionen 18 bis 24; keine vorherige
Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake führt die unabhängige Abschlussprüfung der KDM-/KITSM-
Lernarchitektur, Lernmaterialien und C#-Rollouts durch. **Closure** bedeutet,
dass Umfang, Nachweise, Restrisiken und nächste Schritte vollständig und
wahrheitsgetreu abgeschlossen sind.

*This intake independently validates the completed KDM/KITSM learning
architecture, document packages, and C# rollout.*

## 2. Prüfumfang / Closure Scope

- Positionen 18 bis 24 und ihre Exact-Head-Evidence;
- alle KDM-/KITSM-Lernfelder und Prüfungsbereich-Mappings;
- Jahr-1-Retrofit und drei neue Lernreihen;
- 24 neue Aufgaben-Lastenhefte und 24 Lernbegleiter;
- drei Lernreihen-Übersichten und drei Unterrichtsleitfäden;
- Kompetenz-, Bewertungs- und Evidence-Verträge;
- C#-/SQL- und Test-Untergrenzen;
- sechs Rolloutziele und ihre Receipts;
- zentrale Register, Mappings, Vorlagen und Berufsrollen-Linse;
- Sprache, Accessibility, Links, Secrets und Agent-Parität.

## 3. Abschlussentscheidungen / Closure Decisions

Jede geprüfte Einheit erhält genau eine Entscheidung:

- `Accepted`
- `AcceptedWithDocumentedBoundary`
- `CandidateFinding`
- `ProductDecision`

Ein `CandidateFinding` benötigt reproduzierbare Evidence, Owner, Risiko und
Re-Evaluation-Trigger. Eine `ProductDecision` stoppt den Abschluss; sie wird
nicht im Closure-Lauf geraten oder umgesetzt.

## 4. Anforderungen / Requirements

- **KCL-001:** Alle offiziellen KDM-/KITSM-Lernfelder werden unabhängig gegen
  die gemergten Materialien revalidiert.
- **KCL-002:** Jede Kompetenz besitzt Aufgabe, Eigenleistungsgrenze, Evidence
  und Bewertung.
- **KCL-003:** Zu jedem neuen Aufgaben-Lastenheft existiert genau ein
  semantisch passender Lernbegleiter.
- **KCL-004:** Zu jeder neuen Reihe existiert genau eine Übersicht und ein
  Unterrichtsleitfaden.
- **KCL-005:** LF5 und LF7 besitzen eindeutige C#-, SQL-, Test- und
  Fehlerkorrektur-Nachweise.
- **KCL-006:** Kaufmännische Kompetenzen sind vollständig und nicht auf
  Programmierung reduziert.
- **KCL-007:** Lernenden- und Agentenbeiträge sind in allen bewerteten Aufgaben
  unterscheidbar.
- **KCL-008:** Alle sechs Zielrepositories entsprechen ihren
  Rollout-Receipts.
- **KCL-009:** Andere MSL-Repositories und Produktcode sind unverändert.
- **KCL-010:** Zentrale Register, Mappings, Rollenlinse und Links sind
  konsistent.
- **KCL-011:** Deutsch zuerst, Englisch danach, CEFR B2, Begriffserklärung und
  WCAG 2.2 AA sind nachgewiesen.
- **KCL-012:** Die Reihen behaupten weder Prüfungsgarantie noch Ersatz für
  Berufsschule oder betriebliche Ausbildung.
- **KCL-013:** Der Closure-Lauf erzeugt keine fachliche Remediation.
- **KCL-014:** Ein Folge-Intake entsteht nur für ein reproduzierbares,
  nicht leeres Finding.
- **KCL-015:** Kein Folgelauf wird automatisch gestartet.

## 5. Ergebnisartefakte / Expected Artifacts

- vollständige Closure-Matrix;
- Lernfeld-, Dokument- und Evidence-Cardinality-Bericht;
- C#-/SQL-Proof-Bericht;
- Rollout-Hash- und Exact-Head-Bericht;
- Accessibility- und Sprachbericht;
- Findings oder nachgewiesene Null-Finding-Entscheidung;
- textorientierter Abschlussbericht und Projektstatistik.

## 6. Akzeptanzkriterien / Acceptance Criteria

- **AC-KCL-001:** Alle Lernfelder, Kompetenzen, 24 Einheiten und sechs
  Rolloutziele sind vollständig geprüft.
- **AC-KCL-002:** Es bestehen null Critical-/High-Findings und null offene
  Produktentscheidungen.
- **AC-KCL-003:** Alle Cardinality-, Hash-, Link-, Secret-, Accessibility-,
  Agent-Paritäts- und Bash-/PowerShell-Prüfungen bestehen.
- **AC-KCL-004:** Alle bearbeiteten Repositories stehen sauber auf ihrem
  synchronisierten Default-Branch.
- **AC-KCL-005:** Keine Remediation wurde innerhalb des Closure-Laufs
  durchgeführt.
- **AC-KCL-006:** Es wurde kein Folgefeature automatisch gestartet.

## 7. Nicht-Ziele / Non-Goals

- Keine Lernmaterial- oder Produktkorrektur.
- Keine Erweiterung auf weitere Sprachen.
- Keine Prüfungssimulation.
- Kein neues Preset ohne reproduzierbaren providerneutralen Defekt.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_KDM-KITSM-Lernreihen-Closure.md` as position 25. Verify complete predecessor evidence, exact closure decisions, all learning fields and competencies, 24 unit-intake/companion pairs, three series overviews and teaching guides, C#/SQL proof, six rollout receipts, unchanged other MSL and product code, accessibility, measurable acceptance, and no remediation or automatic follow-up.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_KDM-KITSM-Lernreihen-Closure.md` as the binding intake for position 25. Create a feature specification for an independent read-only closure of positions 18 through 24, all KDM/KITSM learning fields, 24 units, document packages, learner/agent evidence, C#/SQL proof, six C# rollout targets, accessibility, and exact closure decisions. Preserve KCL-001 through KCL-015 and AC-KCL-001 through AC-KCL-006. Do not remediate findings, expand language scope, create a preset without evidence, or start a follow-up.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_KDM-KITSM-Lernreihen-Closure.md` with deliveryAuthority=MergeAndSync after position 24 and all six rollout PRs are merged. Keep learning materials, rollout scripts, target repositories, and product code read-only except for accepted closure artifacts, deterministic validation, evidence, statistics, archive/order updates, and delivery evidence. Merge one non-empty Level-0 PR, return all repositories to clean synchronized default branches, report findings truthfully, and do not start any follow-up automatically.
```

<!-- intake-authoring:end -->
