<!-- intake-authoring:begin -->
# Lastenheft: Secure-Development-Baseline 3.3 Synchronisierung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-25
**Reihenfolge:** Position 16
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Auszubildende in IT-Berufen, Lehrende, Entwickler*innen,
Security-Verantwortliche, Maintainer und Reviewer

## 1. Zweck / Purpose

Dieser Intake synchronisiert die projektgeführte Secure-Development-
Dokumentfamilie von Home Baseline mit den bestätigten Audit- und
Preset-Ergebnissen aus Position 14 und 15. Geändert werden nur tatsächlich
betroffene Dokumente. Der generierte Sammelband bleibt aus seinen zwölf
Quelldateien reproduzierbar.

*This intake synchronizes the Home Baseline secure-development document family
with confirmed audit and preset results. Only materially affected documents
change, and the compendium remains reproducible from its twelve source
checklists.*

## 2. Reihenfolge und Voraussetzungen / Order and Prerequisites

Der Intake steht auf Position 16. Er beginnt erst nach abgeschlossenem
Gap-Audit auf Position 14 und veröffentlichtem, per ZIP validiertem Preset aus
Position 15. Er liefert die Baseline- und Installationsgrundlage für die
ABSDD-Adoption auf Position 17.

## 3. Zielversionen / Target Versions

Der Lauf prüft und begründet folgende Zielstände:

- Secure-Development-Baseline `3.3.0`;
- Richtlinie Sichere Entwicklung `3.3.0`;
- Sammelband `2.3.0`;
- `CL_09` und `CL_12` voraussichtlich `2.3.0`;
- Preset-Verzahnung voraussichtlich `1.3.0`;
- SDLC-Richtlinie voraussichtlich `1.3.0`.

„Voraussichtlich“ bedeutet: Die Version wird nur erhöht, wenn der Audit eine
inhaltliche Änderung belegt. Alle übrigen Checklisten und mitgeltenden
Dokumente behalten ihre Version, wenn ihr Inhalt unverändert bleibt.

## 4. Preset-Profile / Preset Profiles

Die Dokumentation unterscheidet drei Profile:

1. acht Standard-Presets;
2. elf Presets mit optionaler Intake-Governance;
3. zwölf Presets mit zusätzlicher
   `secure-development-assurance-governance` auf Priorität `15`.

Das allgemeine Acht-Preset-Profil und das bestehende Elf-Preset-Profil bleiben
unverändert. Home Baseline erhält das neue Preset ausschließlich im
Zwölferprofil.

## 5. Scope

- `docs/secure-development/README.md`;
- Richtlinie Sichere Entwicklung;
- tatsächlich betroffene Dateien `CL_01` bis `CL_12`;
- generierter Sammelband;
- `baseline-manifest.json`;
- tatsächlich betroffene mitgeltende Dokumente;
- Preset-Profile und Installationskonfiguration;
- gemeinsame Agenten-Guidance;
- Projektstatistik;
- reproduzierbare Build-, Hash-, Drift- und Profil-Evidence.

## 6. Nicht-Ziele / Non-Goals

- Keine pauschale Versionsanhebung unveränderter Dokumente.
- Keine Änderung von Produktcode oder Level-2-Projektevidence.
- Keine automatische ABSDD-Synchronisierung.
- Keine Verpflichtung des neuen Presets im allgemeinen Acht-Preset-Profil.
- Keine ISO-Zertifizierungsbehauptung oder organisationsweite SoA.
- Kein automatischer Start der Position 17.

## 7. Anforderungen / Requirements

- **SDB-001:** Der Lauf bindet die Findings und Abschluss-Evidence von Position
  14 und 15 an exakte Commits und Artefakthashes.
- **SDB-002:** Jede Versionsänderung besitzt eine konkrete inhaltliche
  Begründung; reine Metadatenangleichung erhöht keine Dokumentversion.
- **SDB-003:** Das Baseline-Manifest enthält genau zwölf Checklisten,
  vollständige mitgeltende Dokumente, Versionen und normalisierte Hashes.
- **SDB-004:** Der Sammelband wird ausschließlich aus den zwölf Quelldateien
  erzeugt und in Bash sowie PowerShell identisch geprüft.
- **SDB-005:** Die drei Preset-Profile werden für Lernende textorientiert
  erklärt; Priorität 15 und Komposition sind eindeutig.
- **SDB-006:** Das Zwölferprofil installiert
  `secure-development-assurance-governance` v0.1.0 auf Priorität 15.
- **SDB-007:** Bestehende Acht- und Elf-Preset-Profile bleiben unverändert
  auflösbar.
- **SDB-008:** Richtlinie, Checklisten, Sammelband, Manifest und mitgeltende
  Dokumente verwenden konsistente Begriffe und Statusmodelle.
- **SDB-009:** Alle gepflegten Agentenoberflächen werden gemeinsam geprüft und
  nur bei gemeinsamer Guidance-Änderung synchron aktualisiert.
- **SDB-010:** Dokumente erklären ISO/IEC 27001/27002, NIST SSDF, OWASP
  ASVS/SAMM, CRA und SoA nur in ihrem tatsächlichen Anwendungsrahmen.
- **SDB-011:** Deutsch steht vor Englisch; CEFR B2, Begriffserklärung,
  textorientierte Alternativen und WCAG 2.2 AA gelten.
- **SDB-012:** Keine Richtlinien- oder Evidence-Datei wird aus dem öffentlichen
  Preset zurück in Home Baseline überschrieben.

## 8. Evidence und Validierung

- Vorher-/Nachher-Version und Hash pro betroffenem Dokument;
- Begründung für unveränderte Dokumente;
- Sammelband-Build in Bash und PowerShell;
- positive und negative Manifest-/Hash-/Drift-Fixtures;
- Installation und Resolve aller drei Profile;
- genau eine Command-/Skill-Anzeige je Agentenoberfläche;
- `git diff --check`, Secret-Scan, Agent-Parität und Lernpaketprüfung;
- nachvollziehbarer PR-, Review- und Merge-Nachweis.

## 9. Akzeptanzkriterien / Acceptance Criteria

- **AC-SDB-001:** Baseline und Richtlinie stehen begründet auf `3.3.0`.
- **AC-SDB-002:** Sammelband und jede geänderte Quelle sind versions- und
  hashkonsistent; unveränderte Quellen behalten ihre Version.
- **AC-SDB-003:** Bash und PowerShell erzeugen beziehungsweise prüfen denselben
  Sammelband.
- **AC-SDB-004:** Acht-, Elf- und Zwölferprofil lassen sich unabhängig
  installieren und auflösen.
- **AC-SDB-005:** Das neue Preset ist nur im Zwölferprofil verpflichtend.
- **AC-SDB-006:** Alle Agentenoberflächen und die Projektstatistik sind
  konsistent.
- **AC-SDB-007:** Es verbleibt keine Critical-/High-Drift zwischen Richtlinie,
  Checklisten, Sammelband, Manifest und mitgeltenden Dokumenten.
- **AC-SDB-008:** Home Baseline ist nach Merge sauber und synchron; Position 17
  wurde nicht automatisch gestartet.

## 10. Qualitäts- und Schutzgrenzen

Die Baseline bleibt projektgeführt. Das öffentliche Preset darf sie prüfen,
aber nicht besitzen oder automatisch verändern. Lernende erhalten kurze
Erklärungen, konkrete Beispiele und textbasierte Statusausgaben. Secrets,
personenbezogene Daten und private absolute Pfade bleiben ausgeschlossen.

<!-- intake-authoring:prompts -->
## 11. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Secure-Development-Baseline-3.3-Synchronisierung.md` as Position 16 of the active ordered series. Verify dependencies on Positions 14 and 15, evidence-based version changes, three-profile compatibility, generated compendium reproducibility, manifest/hash integrity, agent parity, learner accessibility, no-certification boundary, and measurable acceptance criteria. Do not change the intake or start downstream work.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Secure-Development-Baseline-3.3-Synchronisierung.md` as the binding intake for Position 16. Create the feature specification for the evidence-based Secure Development Baseline 3.3 synchronization. Preserve SDB-001 through SDB-012, AC-SDB-001 through AC-SDB-008, conditional document versioning, the eight/eleven/twelve preset profiles, generated compendium parity, project-owned policy, no-certification, learner, A11Y, security, and non-goal boundaries. Do not modify ABSDD or start Position 17.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Secure-Development-Baseline-3.3-Synchronisierung.md` with deliveryAuthority=MergeAndSync after Positions 14 and 15 are complete. Change only evidence-confirmed Home Baseline documents, profiles, validators, guidance, and statistics. Converge all required and optional Spec Kit checks and reviews, create and merge a non-empty PR, return to clean synchronized main, and do not modify `absdd-image-sandbox` or start Position 17 automatically.
```

<!-- intake-authoring:end -->
