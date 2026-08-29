<!-- intake-authoring:begin -->
# Lastenheft: ABSDD Secure Development Assurance Adoption

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-25
**Reihenfolge:** Position 17
**Delivery Mode:** `MergeAndSync`
**Pilot-Repository:** `absdd-image-sandbox`
**Zielgruppe:** Auszubildende in IT-Berufen, Lehrende, Maintainer,
Security-Verantwortliche und Reviewer

## 1. Zweck / Purpose

Dieser Intake adoptiert die in Position 16 freigegebene
Secure-Development-Baseline 3.3.0 und das in Position 15 veröffentlichte
Assurance-Preset kontrolliert in `absdd-image-sandbox`.

**ABSDD** bezeichnet die im Projekt verwendete sichere, barrierearme
agentische Entwicklungsumgebung. Die Adoption bewahrt alle
sandbox-spezifischen Nachweise und ersetzt sie nicht durch generische
Home-Baseline-Dateien.

*This intake adopts Secure Development Baseline 3.3.0 and the published
assurance preset into `absdd-image-sandbox` while preserving project-specific
sandbox evidence. The result is a field validation, not a certification claim.*

## 2. Reihenfolge und Voraussetzungen / Order and Prerequisites

Der Intake steht auf Position 17 und benötigt:

- den abgeschlossenen Audit auf Position 14;
- das veröffentlichte und ZIP-validierte Preset aus Position 15;
- die gemergte Home-Baseline-Synchronisierung aus Position 16.

Erst nach diesem Pilot darf über weitere GSDB-, Secure-Trader- oder
Lernreihen-Adoptionen entschieden werden. Dieser Intake startet keine solche
Flottenverteilung.

## 3. Ausgangslage / Current State

`absdd-image-sandbox` besitzt bereits die elf aktuellen Presets sowie eine
eigene Secure-Development-Dokumentfamilie und projektspezifische Evidence.
Zwischen Home Baseline und ABSDD können Metadaten-, Versions-, Mapping- oder
Verzahnungsunterschiede bestehen. Diese Unterschiede werden einzeln
klassifiziert und nicht durch pauschales Kopieren überschrieben.

## 4. Zielbild / Target State

- ABSDD verwendet die freigegebene Baseline `3.3.0`.
- Die sechs grundlegenden Governance-Presets sind mit ihren aktuellen,
  veröffentlichten Versionen bestätigt.
- Das neue `secure-development-assurance-governance` v0.1.0 ist auf Priorität
  `15` installiert.
- Das vollständige Zwölferprofil ist installierbar und auflösbar.
- Sandbox-Isolation, Secret-Trennung, Mount- und Netzwerkgrenzen,
  reproduzierbare Toolstände und Lernendenzugänglichkeit sind mit
  projektspezifischer Evidence belegt.

## 5. Scope

- kontrollierter Abgleich der generischen Baseline-Dateien;
- Erhalt und Aktualitätsprüfung sandbox-spezifischer Dokumentation;
- Installation und Resolve des Zwölferprofils;
- Assurance-Status und Assurance-Review als Feldnachweis;
- Prüfung der ISO/IEC-27001/27002-Bezüge:
  - A.5.23 Cloud-Dienste;
  - A.8.25 sicherer Entwicklungslebenszyklus;
  - A.8.27 sichere Systemarchitektur;
  - A.8.28 sichere Codierung;
  - A.8.31 Trennung von Entwicklung, Test und Produktion;
  - A.8.34 Schutz bei Audit-Prüfungen;
- lokale und CI-basierte Sandbox-, Secret-, Mount-, Netzwerk-, Toolchain-,
  A11Y- und Dokumentationsnachweise.

## 6. Nicht-Ziele / Non-Goals

- Keine ISO-Zertifizierung oder organisationsweite SoA.
- Keine pauschale Überschreibung projektspezifischer ABSDD-Evidence.
- Keine Änderung an Produktrepositories oder Secure-Trader-Anwendungen.
- Keine automatische Flottenverteilung.
- Keine neue Sandbox-Architektur ohne separates Finding und eigene Freigabe.
- Kein automatischer Start eines Folge-Intakes.

## 7. Anforderungen / Requirements

- **ABA-001:** Der Lauf bindet Home-Baseline-3.3.0, Preset v0.1.0 und den
  ABSDD-Ausgangsstand an exakte Commits und normalisierte Hashes.
- **ABA-002:** Generische und projektspezifische Dateien werden vor jeder
  Änderung klassifiziert; Projekt-Evidence hat Vorrang vor blindem Kopieren.
- **ABA-003:** Die sechs grundlegenden Governance-Presets werden mit Version,
  Priorität, Resolve-Ergebnis und Evidence bestätigt.
- **ABA-004:** Das Assurance-Preset wird auf Priorität 15 installiert und
  erscheint je Agentenoberfläche genau einmal.
- **ABA-005:** Alle zwölf Presets lassen sich gemeinsam installieren, auflösen,
  deaktivieren, reaktivieren und entfernen.
- **ABA-006:** Jeder der sechs genannten ISO-Kontrollbezüge erhält
  `Applicable`, `N/A` oder `Open` sowie `Pass`, `Fail` oder `NotAssessed`.
- **ABA-007:** `N/A`, `Open`, `Fail` und akzeptierte Risiken besitzen die
  erforderlichen Begründungen, Owner, Reviewer, Evidence und Wiedervorlagen.
- **ABA-008:** Sandbox-Isolation, Secret-Trennung, Mount- und Netzwerkgrenzen
  werden durch reproduzierbare positive und negative Nachweise geprüft.
- **ABA-009:** Toolstände und Container-/Image-Herkunft sind reproduzierbar
  dokumentiert.
- **ABA-010:** Lernende können Preflight, Status, Fehlergrund und nächste Aktion
  ohne Spec-Kit-Vorkenntnisse verstehen.
- **ABA-011:** Kein Ergebnis behauptet ISO-Zertifizierung oder ersetzt eine
  organisationsweite SoA.
- **ABA-012:** Erst ein abgeschlossener Pilot darf eine separate Entscheidung
  über weitere Adoptionen auslösen.

## 8. Evidence und Validierung

- Vorher-/Nachher-Inventar und Hashes;
- dokumentierte Konfliktentscheidungen für projektspezifische Dateien;
- Status- und Review-Evidence des neuen Presets;
- positive und negative Isolation-, Secret-, Mount- und Netzwerk-Fixtures;
- Toolchain- und Image-Provenienz;
- zwölf-Preset Add/List/Info/Resolve/Disable/Enable/Remove/Reinstall;
- Agent-Parität, Secret-Scan, Dokumentations-, Lern- und A11Y-Prüfung;
- CI-Nachweis des exakten PR-Heads;
- PR-, Review-, Merge- und lokaler Synchronisationsnachweis.

## 9. Akzeptanzkriterien / Acceptance Criteria

- **AC-ABA-001:** ABSDD verwendet nachweislich Baseline `3.3.0`, ohne
  projektspezifische Evidence zu verlieren.
- **AC-ABA-002:** Alle zwölf Presets lösen gemeinsam auf; alle Commands und
  Skills erscheinen genau einmal.
- **AC-ABA-003:** Die sechs ISO-Kontrollbezüge sind vollständig und gültig
  bewertet.
- **AC-ABA-004:** Isolation, Secrets, Mounts, Netzwerk und Toolstände besitzen
  reproduzierbare Nachweise.
- **AC-ABA-005:** `Ready` ist bei offenem Pflichtpunkt, fehlender Evidence oder
  abgelaufenem Review ausgeschlossen.
- **AC-ABA-006:** Dokumentation erfüllt Deutsch-zuerst/Englisch-danach,
  CEFR B2, Begriffserklärung und anwendbare WCAG-2.2-AA-Kriterien.
- **AC-ABA-007:** Der Abschlussbericht erklärt ausdrücklich, dass keine
  ISO-Zertifizierung nachgewiesen wird.
- **AC-ABA-008:** Home Baseline und ABSDD stehen nach ihren MergeAndSync-
  Lieferungen sauber und synchron auf dem jeweiligen Default-Branch.
- **AC-ABA-009:** Eine weitere Flottenadoption wurde nicht automatisch
  gestartet.

## 10. Qualitäts- und Schutzgrenzen

`Programmierung #include<everyone>` gilt für CLI, Dokumentation und Evidence.
Status darf nicht ausschließlich durch Farbe vermittelt werden. Tests
verwenden keine produktiven Secrets, Kundendaten oder unkontrollierten
Netzwerkziele. Alle Remote- und Merge-Rechte werden unmittelbar vor ihrer
Nutzung erneut geprüft.

<!-- intake-authoring:prompts -->
## 11. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_ABSDD-Secure-Development-Assurance-Adoption.md` as Position 17 of the active ordered series. Verify dependencies on Positions 14 through 16, preservation of project-specific ABSDD evidence, exact twelve-preset adoption, ISO control applicability without certification claims, reproducible sandbox and accessibility evidence, MergeAndSync boundaries, and measurable acceptance criteria. Do not change the intake or start downstream work.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_ABSDD-Secure-Development-Assurance-Adoption.md` as the binding intake for Position 17. Create the feature specification for controlled adoption of Secure Development Baseline 3.3.0 and `secure-development-assurance-governance` v0.1.0 in `absdd-image-sandbox`. Preserve ABA-001 through ABA-012, AC-ABA-001 through AC-ABA-009, project-evidence precedence, the six ISO control references, twelve-preset validation, sandbox proof, learner accessibility, no-certification, no-fleet-rollout, and all remote-authority boundaries.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_ABSDD-Secure-Development-Assurance-Adoption.md` with deliveryAuthority=MergeAndSync after Positions 14, 15, and 16 are complete. Preserve project-specific ABSDD evidence, apply only reviewed generic baseline changes, install and validate the twelve-preset profile, converge all required and optional checks and reviews, create and merge non-empty authorized PRs, return Home Baseline and ABSDD to clean synchronized default branches, and do not start any fleet adoption or follow-up feature automatically.
```

<!-- intake-authoring:end -->
