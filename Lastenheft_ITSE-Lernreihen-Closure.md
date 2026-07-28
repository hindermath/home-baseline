<!-- intake-authoring:begin -->
# Lastenheft: ITSE-Lernreihen-Closure

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 32, nach Position 31
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** ITSE- und FI-Lernende, Lehrende, Ausbildende, Maintainer und
Reviewer
**Vorausgesetztes Wissen:** abgeschlossene Positionen 28 bis 31; keine
Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser read-only Lauf schließt die ITSE-Lernreihe unabhängig ab. Er prüft
Vollständigkeit, FI-Wiederverwendung, ITSE-Abgrenzung, Evidence,
Sicherheitsgrenzen und Rollout, ohne Findings zu beheben.

*This read-only closure independently validates the complete ITSE learning
series and its rollout.*

## 2. Anforderungen / Requirements

- **ICL-001:** LF1 bis LF12 und alle Prüfungsbereiche werden vollständig
  revalidiert.
- **ICL-002:** Der Vergleich umfasst FI/AE, FI/SI, FI/DPA und FI/DV.
- **ICL-003:** Gemeinsame Kompetenzen besitzen eine eindeutige kanonische
  Quelle.
- **ICL-004:** ITSE-spezifische Energie-, Betriebssicherheits- und
  Instandhaltungskompetenzen sind vollständig.
- **ICL-005:** Jede Aufgabe, jeder Lernbegleiter, jeder Leitfaden und jedes
  Mapping besitzt konsistente IDs, Lernziele und Evidence.
- **ICL-006:** `LearnerWork`, `TeamWork`, `AgentAssisted`,
  `ReferenceMaterial` und `InstructorProvided` werden korrekt verwendet.
- **ICL-007:** `SoftwareSandbox`, `Simulation`, `SupervisedLab` und
  `TrainingCompany` sind eindeutig und beweisbar.
- **ICL-008:** Simulierte oder agentisch erzeugte Ergebnisse gelten nicht als
  reale Mess- oder Praxisnachweise.
- **ICL-009:** Die acht Jahr-3-Einheiten und alle Jahr-1-/Jahr-2-Pfade sind
  vollständig.
- **ICL-010:** Alle sechs Rolloutziele besitzen aktuelle Hash-, Commit- und
  Rollen-Evidence.
- **ICL-011:** Andere Sprachpfade und Produktcode sind unverändert.
- **ICL-012:** Sprache, Ersterklärung, CEFR B2, Accessibility und Links
  bestehen.
- **ICL-013:** Findings erhalten stabile `ITC###`-IDs, Owner, Evidence,
  Auswirkung und Follow-up-Grenze.
- **ICL-014:** Der Lauf führt keine Remediation aus.
- **ICL-015:** Position 33 wird nicht automatisch gestartet.

## 3. Ergebnisartefakte / Expected Artifacts

- vollständige ITSE-Closure-Matrix;
- LF-, FI-Vergleichs- und Abgrenzungsnachweis;
- Dokumentpaket- und Evidence-Inventar;
- Rollout-Paritätsbericht;
- Finding- und Restrisiko-Ledger;
- Handoff an die Gesamtkonsistenzprüfung.

## 4. Akzeptanzkriterien / Acceptance Criteria

- **AC-ICL-001:** Alle ITSE-Kompetenzen und Artefakte sind inventarisiert und
  nachgewiesen.
- **AC-ICL-002:** Es gibt keine ungeklärte kanonische Duplikation.
- **AC-ICL-003:** Agenten-, Simulations- und Praxis-Evidence ist konsistent.
- **AC-ICL-004:** Alle Rolloutziele sind sauber und synchron.
- **AC-ICL-005:** Null offene Critical-/High-Findings.
- **AC-ICL-006:** Der Lauf enthält keine fachliche Remediation.
- **AC-ICL-007:** Position 33 wurde nicht gestartet.

## 5. Nicht-Ziele / Non-Goals

- Keine Korrektur entdeckter Findings.
- Keine neue Lernreihe oder Produktänderung.
- Keine Durchführung praktischer Aufgaben.
- Keine globale Konsistenzentscheidung; diese gehört zu Position 33.

<!-- intake-authoring:prompts -->
## 6. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_ITSE-Lernreihen-Closure.md` as position 32. Verify complete LF1-LF12 and examination coverage, all-four-FI comparison, canonical reuse, ITSE-specific competencies, document packages, evidence and execution contexts, six rollout targets, read-only scope, stable finding rules, and no automatic global closure.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_ITSE-Lernreihen-Closure.md` as the binding intake for position 32. Create a read-only closure specification covering every ITSE competency, FI comparison, document package, evidence context, safety boundary, rollout target, finding rule, and handoff to position 33. Preserve ICL-001 through ICL-015 and AC-ICL-001 through AC-ICL-007. Do not remediate findings, change product code, or start position 33.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete read-only Spec Kit closure for `Lastenheft_ITSE-Lernreihen-Closure.md` with deliveryAuthority=MergeAndSync after position 31 is complete. Produce only closure evidence, deterministic validators, statistics, archive/order updates, and one non-empty PR. Return to clean synchronized main, do not remediate findings, and do not start position 33.
```

<!-- intake-authoring:end -->
