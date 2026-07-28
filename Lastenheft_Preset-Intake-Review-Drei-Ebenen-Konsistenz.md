<!-- intake-authoring:begin -->
# Lastenheft: Preset Intake Review – Drei-Ebenen-Konsistenz

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 34, nach Position 33
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Preset-Maintainer, Requirements Engineers, Lehrende,
Ausbildende und Reviewer
**Vorausgesetztes Wissen:** Grundverständnis von Intake Review; Fachbegriffe
und Schemaänderungen werden beim ersten Auftreten erklärt

## 1. Zweck / Purpose

Dieser Lauf erweitert `intake-review-governance` von `v0.2.0` auf `v0.3.0`.
Das allgemeine Intake Review soll optional prüfen können, ob ein einzelner
Intake **in sich**, **an normativen Grundlagen** und **im Verhältnis zu einer
größeren Serie oder einem Ökosystem** konsistent ist.

Die Erweiterung bleibt domänenneutral. Berufsbilder, Lehrjahre und
KI-Kompetenzen gehören in ein späteres Lernreihen-Preset, nicht in das
allgemeine Intake Review.

*This run adds an optional, domain-neutral three-level consistency contract to
Intake Review while keeping existing schema-1.1 results valid.*

## 2. Öffentlicher Vertrag / Public Contract

- Bestehende Commands bleiben unverändert:
  `$speckit-intake-review` und `$speckit-intake-review-status`.
- Schema 1.1 für `Single`, `Series` und `Campaign` bleibt vollständig gültig.
- Schema 1.2 ergänzt optional `consistencyAssessment`.
- Die drei Achsen heißen:
  `InternalConsistency`, `NormativeConsistency` und
  `EcosystemConsistency`.
- Eine Policy oder ein Profil entscheidet, ob eine Achse `Required`,
  `Optional` oder `NotApplicable` ist.
- Achsenergebnisse sind genau:
  `Consistent`, `IntentionalDifference`, `Finding`, `NotAssessed` oder `N/A`.
- `IntentionalDifference` benötigt Grundlage, Begründung, Owner und
  Re-Evaluation-Trigger.
- `Finding` benötigt stabile ID, Schweregrad, Evidence, Owner und
  Follow-up-Grenze.
- `Ready` ist unzulässig, wenn eine erforderliche Achse `Finding` oder
  `NotAssessed` enthält.

## 3. Anforderungen / Requirements

- **IRC-001:** Bash- und PowerShell-Validatoren akzeptieren unveränderte
  Schema-1.1-Single-, Series- und Campaign-Ergebnisse weiter.
- **IRC-002:** Schema 1.2 bindet jede Achse an Policy, Zielmenge,
  Evidence-Pfade und Review-Zeitpunkt.
- **IRC-003:** Interne Konsistenz prüft Identität, Ziel, Scope, Nicht-Ziele,
  Anforderungen, Evidence, Abnahme, Prompts und nächste Aktion innerhalb des
  geprüften Artefakts.
- **IRC-004:** Normative Konsistenz prüft ausdrücklich benannte externe oder
  repositoryinterne Grundlagen und unterscheidet Pflicht, Unterstützung und
  lokale Ergänzung.
- **IRC-005:** Ökosystem-Konsistenz prüft Reihenfolge, gemeinsame Begriffe,
  Rollen, Übergaben, Duplikationen, Lücken und widersprüchliche Aussagen über
  mehrere Ziele.
- **IRC-006:** Fehlende oder nicht zugängliche normative Quellen dürfen nicht
  als `Consistent` geraten werden.
- **IRC-007:** Eine Achse darf nur mit dokumentierter Policy als `N/A`
  gelten.
- **IRC-008:** Der Status-Command bleibt strikt read-only und verändert weder
  Review noch Evidence.
- **IRC-009:** Der Review-Command akzeptiert kein Risiko stellvertretend für
  Menschen und startet keinen Specify-, Autonomous- oder Folgelauf.
- **IRC-010:** Fehlerklassen, Exitcodes und normalisierte Hashes sind zwischen
  Bash und PowerShell identisch.
- **IRC-011:** README, Runbook, Manpages, Templates, Checklist und
  Agent-Guidance erklären den Drei-Ebenen-Vertrag DE-first/EN-second auf
  CEFR-B2-Niveau.
- **IRC-012:** Jede unterstützte Agentenoberfläche zeigt jeden bestehenden
  Command und Skill genau einmal.
- **IRC-013:** Kanonischer Scaffold und Publikationskopie bleiben bytegleich.
- **IRC-014:** Position 35 und eine Preset-Veröffentlichung werden nicht
  automatisch gestartet.

## 4. Tests / Test Contract

Positive Fixtures:

- unveränderte Single-, Series- und Campaign-Ergebnisse mit Schema 1.1;
- Schema 1.2 mit drei erfolgreichen Achsen;
- begründete `IntentionalDifference`;
- Policy-gesteuertes `N/A`;
- LF-, CRLF- und UTF-8-BOM-Parität.

Negative Fixtures:

- `Ready` trotz erforderlichem `Finding` oder `NotAssessed`;
- fehlende Quelle, Evidence, Owner oder Re-Evaluation-Trigger;
- widersprüchliche Achsenergebnisse;
- unerlaubtes `N/A`;
- Schema- oder Hashdrift;
- Bash-/PowerShell-Abweichung;
- domänenspezifische Pflichtfelder im generischen Kern.

## 5. Ergebnisartefakte / Expected Artifacts

- aktualisierter kanonischer Scaffold und Publikationskopie;
- Schema-1.2-Request-/Result-/Policy-Vorlagen;
- paritätische Validatoren und Fixtures;
- aktualisierte Commands, Skills, Checklist, Runbook, README und Manpages;
- Feldvalidierungsbericht mit Schema-1.1-Rückwärtskompatibilität;
- vorbereiteter, aber nicht automatisch veröffentlichter Release-Kandidat
  `v0.3.0`.

## 6. Akzeptanzkriterien / Acceptance Criteria

- **AC-IRC-001:** Alle bestehenden Schema-1.1-Fixtures bleiben grün.
- **AC-IRC-002:** Beide Validatoren lehnen jede ungültige
  Drei-Ebenen-Kombination mit derselben Fehlerklasse ab.
- **AC-IRC-003:** Die Erweiterung enthält keine Lernreihen-, Berufs- oder
  KI-spezifischen Pflichtfelder.
- **AC-IRC-004:** Zehn-/Elf-/Zwölf-Preset-Kompositionen bleiben
  konfliktfrei; Standardprofile werden nicht still erweitert.
- **AC-IRC-005:** Keine doppelten Commands oder Skills.
- **AC-IRC-006:** Kein Release, Community-Issue oder Position-35-Lauf wurde
  automatisch gestartet.

## 7. Nicht-Ziele / Non-Goals

- Kein Lernreihen- oder IHK-Domänenmodell.
- Keine automatische Korrektur geprüfter Intakes.
- Keine Risikoakzeptanz durch einen Agenten.
- Keine Änderung anderer Presets außerhalb belegter Kompositionsanpassungen.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Preset-Intake-Review-Drei-Ebenen-Konsistenz.md` as position 34. Verify the domain-neutral schema-1.2 extension, exact three axes and outcomes, schema-1.1 compatibility, Ready blocking rules, Bash/PowerShell parity, documentation and agent parity, no learning-domain leakage, bounded v0.3.0 release candidate, and no automatic position-35 or publication action.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Preset-Intake-Review-Drei-Ebenen-Konsistenz.md` as the binding intake for position 34. Specify the backwards-compatible intake-review-governance v0.3.0 schema-1.2 consistency extension. Preserve IRC-001 through IRC-014 and AC-IRC-001 through AC-IRC-006. Keep the core domain-neutral, retain all existing commands, and do not publish a release or start position 35.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Preset-Intake-Review-Drei-Ebenen-Konsistenz.md` with deliveryAuthority=MergeAndSync after position 33 is complete. Implement and validate only the backwards-compatible Intake Review v0.3.0 candidate, create one non-empty PR, return to clean synchronized main, and do not publish a release or start position 35.
```

<!-- intake-authoring:end -->
