<!-- intake-authoring:begin -->
# Lastenheft: ITSE-Jahr-1-Retrofit

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 28, nach Position 27
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** ITSE- und FI-Lernende, Lehrende, Ausbildende und Maintainer ab
dem ersten Ausbildungsjahr
**Vorausgesetztes Wissen:** freigegebenes ITSE-Kompetenzmodell; keine
Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake ergänzt ITSE-Pfade in den vorhandenen Secure-Trader-Grundreihen
für LF1 bis LF5. Gemeinsame FI-/ITSE-Inhalte bleiben erhalten; ITSE-spezifische
Differenzierung beginnt entsprechend dem Rahmenlehrplan bereits in LF2.

*This intake adds complete ITSE year-1 paths to the existing Secure Trader base
series while preserving all FI content.*

## 2. Betroffene Lernreihen / Affected Series

- Secure OrderDesk;
- Secure ServiceHarvester;
- Secure CaseTracker.

Aufgaben, Lernbegleiter, Unterrichtsleitfäden und Mappings werden paarweise
geprüft. Nur fachlich betroffene Dokumente werden geändert.

## 3. Anforderungen / Requirements

- **IY1-001:** LF1 bis LF5 werden vollständig gegen das Kompetenzmodell und
  alle vier FI-Fachrichtungen geprüft.
- **IY1-002:** Gemeinsame FI-/ITSE-Ziele werden nicht dupliziert, sondern
  berufsbezogen angewendet.
- **IY1-003:** LF2 ergänzt Geräteauswahl, Datenblätter, Normen,
  Kennzeichnung, Energiebedarf und elektrische Sicherheit.
- **IY1-004:** Bestehende FI/AE-, FI/SI-, FI/DPA- und FI/DV-Inhalte bleiben
  in Aussage, Reihenfolge und Anspruch erhalten.
- **IY1-005:** KDM-/KITSM-Aspekte zu Kundenwunsch, Beschaffung,
  Wirtschaftlichkeit und Übergabe werden nur ergänzend wiederverwendet.
- **IY1-006:** Jede betroffene Einheit benennt ITSE-Rolle, Lernziel,
  Eigenleistung, Agentenbeitrag, Ausführungskontext, Evidence und Bewertung.
- **IY1-007:** `SoftwareSandbox` und `Simulation` dürfen keine
  `SupervisedLab`- oder `TrainingCompany`-Evidence ersetzen.
- **IY1-008:** Aufgaben zu elektrischen Gefährdungen bleiben erklärend,
  planend oder simuliert, sofern keine befugte Fachaufsicht nachgewiesen ist.
- **IY1-009:** Zu jedem geänderten Aufgaben-Lastenheft wird der zugehörige
  Lernbegleiter gemeinsam aktualisiert.
- **IY1-010:** Alle drei Unterrichtsleitfäden erklären den ITSE-Jahr-1-Pfad
  und den Vergleich mit den FI-Pfaden.
- **IY1-011:** Blueprint, Register, Lernfeld-Mapping und drei Berufsmappings
  werden synchron fortgeschrieben.
- **IY1-012:** Keine Lernendenlösung oder Produktcodeänderung wird
  vorweggenommen.
- **IY1-013:** Position 29 wird nicht automatisch gestartet.

## 4. Ergebnisartefakte / Expected Artifacts

- aktualisierte LF1–LF5-Aufgaben und Lernbegleiter;
- aktualisierte Unterrichtsleitfäden;
- FI-/ITSE-Kompetenz- und Evidence-Matrix;
- LF2-Sicherheits- und Energieprofil;
- aktualisierte Register und Mappings;
- Änderungs- und Abgrenzungsbericht.

## 5. Akzeptanzkriterien / Acceptance Criteria

- **AC-IY1-001:** Jedes LF1–LF5-Ziel besitzt ITSE-Aufgabe, Eigenleistung,
  Ausführungskontext, Evidence und Bewertung.
- **AC-IY1-002:** Alle vier FI-Fachrichtungen sind als Vergleich nachgewiesen.
- **AC-IY1-003:** Aufgaben und Lernbegleiter stimmen semantisch überein.
- **AC-IY1-004:** LF2 enthält verständliche Energie- und
  Sicherheitsrandbedingungen.
- **AC-IY1-005:** FI-Inhalte und Produktrepositories sind unverändert.
- **AC-IY1-006:** Links, Sprache und Accessibility bestehen.
- **AC-IY1-007:** Position 29 wurde nicht gestartet.

## 6. Nicht-Ziele / Non-Goals

- Keine neue Grundreihe oder neues Repository.
- Keine Jahr-2- oder Jahr-3-Materialien.
- Keine Durchführung elektrischer Praxis.
- Kein Flotten-Rollout.

<!-- intake-authoring:prompts -->
## 7. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_ITSE-Jahr1-Retrofit.md` as position 28. Verify LF1-LF5 coverage, comparison with all four FI tracks, ITSE differentiation from LF2, paired task/companion updates, teaching guides, evidence and execution contexts, electrical-safety boundaries, accessibility, and no product or fleet change.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_ITSE-Jahr1-Retrofit.md` as the binding intake for position 28. Create a feature specification for every affected LF1-LF5 task, companion, guide, mapping, register, FI comparison, LF2 energy/safety boundary, and learner-agent evidence rule. Preserve IY1-001 through IY1-013 and AC-IY1-001 through AC-IY1-007. Do not implement learner solutions, modify product code, roll out to the fleet, or start position 29.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_ITSE-Jahr1-Retrofit.md` with deliveryAuthority=MergeAndSync after position 27 is complete. Update only accepted Level-0 year-1 learning materials, mappings, evidence, statistics, archive/order state, and one non-empty PR. Preserve all FI content, return to clean synchronized main, and do not start position 29.
```

<!-- intake-authoring:end -->
