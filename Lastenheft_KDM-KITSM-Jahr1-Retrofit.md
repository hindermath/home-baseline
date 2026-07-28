<!-- intake-authoring:begin -->
# Lastenheft: KDM-/KITSM-Jahr-1-Retrofit

**Dokumenttyp:** Spec-Kit Intake / Lastenheft  
**Status:** bereit für Intake Review  
**Stand:** 2026-07-28  
**Reihenfolge:** Position 20, nach Position 19  
**Delivery Mode:** `MergeAndSync`  
**Zielgruppe:** KDM- und KITSM-Lernende, Fachinformatiker*innen, Lehrende,
Ausbildende und Maintainer ab dem ersten Ausbildungsjahr  
**Vorausgesetztes Wissen:** freigegebenes Kompetenzmodell aus Position 19;
keine vorherige Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake integriert KDM und KITSM vollständig in die vorhandenen
Secure-Trader-Grundreihen des ersten Ausbildungsjahres. Ein **Retrofit** ergänzt
eine bestehende Struktur kontrolliert, ohne ihre bewährten Inhalte neu zu
erfinden.

*This intake adds complete KDM and KITSM year-1 paths to the existing Secure
Trader base series while preserving the FI material.*

## 2. Betroffene Lernreihen / Affected Series

- Secure OrderDesk
- Secure ServiceHarvester
- Secure CaseTracker

Alle vorhandenen Aufgaben-Lastenhefte, Lernbegleiter, Unterrichtsleitfäden und
Mappings mit Bezug zu LF1 bis LF5 werden anhand des Audit-Inventars geprüft.
Nur fachlich betroffene Dokumente werden geändert.

## 3. Didaktischer Vertrag / Teaching Contract

Jede betroffene Einheit erklärt:

- die KDM- und KITSM-Rolle im Szenario;
- das gemeinsame Lernziel und den berufsspezifischen Blick;
- vorausgesetztes Wissen und neue Fachbegriffe;
- konkrete eigene Tätigkeit;
- Agentenbeitrag und Reviewpflicht;
- Evidence, Bewertung und sichere nächste Aktion.

LF5 verlangt in jedem verwendeten C#-Referenzszenario eine begrenzte,
verständliche C#-/SQL-Änderung mit automatisierten Tests. Die Lernmaterialien
beschreiben die Aufgabe; sie erledigen sie nicht für die Lernenden.

## 4. Anforderungen / Requirements

- **KY1-001:** Alle LF1–LF5-Zuordnungen der drei Grundreihen werden gegen das
  Kompetenzmodell geprüft.
- **KY1-002:** Jede fachlich betroffene Einheit erhält vollständige KDM- und
  KITSM-Kompetenzziele.
- **KY1-003:** Bestehende FI-Inhalte bleiben in Aussage, Reihenfolge und
  Anspruch erhalten.
- **KY1-004:** Rollenhinweise ohne Aufgabe, Evidence und Bewertung werden nicht
  als vollständige Integration gewertet.
- **KY1-005:** LF5 beschreibt eine begrenzte eigene C#-/SQL-Implementierung,
  Positiv- und Negativtests sowie Fehlerkorrektur.
- **KY1-006:** Die Lernendenleistung wird von `AgentAssisted`,
  `InstructorProvided` und Referenzmaterial getrennt.
- **KY1-007:** Kundenauftrag, Kommunikation, Datenschutz, Sicherheit,
  Wirtschaftlichkeit und Barrierefreiheit werden berufsbezogen verbunden.
- **KY1-008:** Zu jedem geänderten Aufgaben-Lastenheft wird der zugehörige
  Lernbegleiter gemeinsam aktualisiert.
- **KY1-009:** Alle drei Unterrichtsleitfäden erklären den KDM-/KITSM-Pfad und
  die Auswahl des C#-Referenzrepos.
- **KY1-010:** Blueprint, Register, Lernfeld-Mapping und drei Berufsmappings
  werden synchron fortgeschrieben.
- **KY1-011:** Die kaufmännische Berufsrollen-Linse wird entweder auf die neue
  Architektur ausgerichtet oder nachvollziehbar als abgelöst markiert.
- **KY1-012:** Keine Lernendenlösung und keine Produktcodeänderung wird in
  Level 0 vorweggenommen.
- **KY1-013:** Position 21 wird nicht automatisch gestartet.

## 5. Ergebnisartefakte / Expected Artifacts

- aktualisierte Jahr-1-Aufgaben und Lernbegleiter;
- aktualisierte drei Unterrichtsleitfäden;
- LF1–LF5-Kompetenz- und Evidence-Matrix;
- C#-/SQL-Aufgabenvertrag für LF5;
- aktualisierte zentrale Mappings und Register;
- Änderungs- und Abgrenzungsbericht.

## 6. Akzeptanzkriterien / Acceptance Criteria

- **AC-KY1-001:** Jedes LF1–LF5-Ziel besitzt für KDM und KITSM Aufgabe,
  Eigenleistung, Evidence und Bewertung.
- **AC-KY1-002:** Jedes geänderte Aufgaben-Lastenheft und sein Lernbegleiter
  stimmen semantisch überein.
- **AC-KY1-003:** Alle drei Unterrichtsleitfäden enthalten einen vollständigen
  kaufmännischen Jahr-1-Pfad.
- **AC-KY1-004:** LF5 enthält C#, SQL, Positiv-/Negativtests und eine
  verständliche Proof-Grenze.
- **AC-KY1-005:** Bestehende FI-Inhalte und Produktrepositories sind
  unverändert.
- **AC-KY1-006:** Links, Mappings, Sprache und Accessibility bestehen.
- **AC-KY1-007:** Position 21 wurde nicht gestartet.

## 7. Nicht-Ziele / Non-Goals

- Keine neuen Grundreihen oder Repositories.
- Keine Durchführung der Lernendenaufgaben.
- Keine Änderungen an Jahr-2- oder Jahr-3-Material in diesem Lauf.
- Kein Rollout in Level 1 oder Level 2.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_KDM-KITSM-Jahr1-Retrofit.md` as position 20. Verify complete LF1-LF5 coverage across all three Secure Trader base series, preservation of FI material, paired intake/companion updates, teaching-guide updates, LF5 C#/SQL and test proof, learner-versus-agent evidence, accessibility, and no product-code or fleet rollout.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_KDM-KITSM-Jahr1-Retrofit.md` as the binding intake for position 20. Create a feature specification for updating every affected LF1-LF5 task, companion, teaching guide, mapping, register, and role-lens surface across Secure OrderDesk, Secure ServiceHarvester, and Secure CaseTracker. Preserve KY1-001 through KY1-013 and AC-KY1-001 through AC-KY1-007. Do not implement learner solutions, modify product code, perform fleet rollout, or start position 21.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_KDM-KITSM-Jahr1-Retrofit.md` with deliveryAuthority=MergeAndSync after position 19 is complete. Update only accepted Level-0 year-1 learning materials, mappings, evidence, statistics, archive/order state, and delivery evidence. Preserve FI content and keep all Level-1/Level-2 repositories and product code unchanged. Merge one non-empty PR, return to clean synchronized main, and do not start position 21.
```

<!-- intake-authoring:end -->
