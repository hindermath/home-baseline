<!-- intake-authoring:begin -->
# Lastenheft: Preset Secure Development Assurance Governance

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-08-29
**Reihenfolge:** Position 15
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Fachinformatiker*innen, IT-Kaufleute, Lehrende, Maintainer,
Security-Verantwortliche und Reviewer ab dem ersten Ausbildungsjahr

## 1. Zweck / Purpose

Dieser Intake produktisiert die bestätigten Findings aus Position 14 als
optionales, stackbares Spec-Kit-Preset
`secure-development-assurance-governance` v0.1.0. Das Preset prüft den
kontrollierten Zusammenhang aus Richtlinie, Checklisten, Sammelband,
mitgeltenden Dokumenten, Standardsanwendbarkeit und Evidence.

Es ergänzt `security-governance`, statt technische Sicherheitsanforderungen zu
duplizieren. **Stackbar** bedeutet, dass mehrere Presets in festgelegter
Prioritätsreihenfolge gemeinsam auf ein Spec-Kit-Projekt wirken können.

*This intake productizes confirmed Position 14 findings as the optional,
stackable `secure-development-assurance-governance` v0.1.0 preset. The preset
assesses policy-to-evidence consistency and complements, rather than
duplicates, technical security governance.*

## Verbindliche Handoff-Ergänzung 2026-08-29

Das Preset ergänzt das bestehende Zwölfer-Profil als optionales
Dreizehner-Assurance-Profil. Acht-Preset-Standardprofil sowie Profile 9 bis 12
bleiben unverändert. Es verwendet Evidence unter
docs/security/secure-development/<datum>-<kontext>/ und Runbooks unter
docs/runbooks/secure-development/. HOSK/GWDG ist ausschließlich externer
Vergleich.

## 2. Reihenfolge und Voraussetzungen / Order and Prerequisites

Der Intake steht auf Position 15 und benötigt den abgeschlossenen Gap-Audit auf
Position 14. Nur dort als portabel und nicht duplizierend bestätigte Regeln
dürfen in das Preset übernommen werden. Position 15 liefert Preset, Release und
Installationsnachweis für Position 16.

## 3. Öffentliche Schnittstelle / Public Interface

- Preset-ID: `secure-development-assurance-governance`
- Version: `v0.1.0`
- Priorität: `15`
- Mindestversion Spec Kit: `>=0.8.3`
- Öffentliches Modell: optional und stackbar
- Verbindlich nur in ausdrücklich ausgewählten Assurance-, GSDB-, Sandbox-,
  Ausbildungs- oder regulierten Projektprofilen
- Fachliche Kompositionsvoraussetzung:
  `security-governance >=0.6.1`

Das Preset stellt genau zwei Commands bereit:

- `$speckit-secure-development-status [<evidence-dir>]`
- `$speckit-secure-development-review <baseline|delta|closure|image-impact> <context-id> <training|mixed|development>`

## 4. Portabler Vertrag / Portable Contract

Der Standardpfad lautet
`docs/secure-development/baseline-manifest.json`. Ein Projektprofil darf ihn
ausdrücklich überschreiben.

Jeder Review-Punkt besitzt zwei getrennte Achsen:

- Anwendbarkeit: `Applicable`, `N/A`, `Open`;
- Umsetzung: `Fulfilled`, `Partly Fulfilled`, `Not Fulfilled`,
  `Not Assessed`.

Zulässige Review-Ergebnisse:

- `Ready`;
- `ReadyWithAcceptedRisks`;
- `NeedsRemediation`;
- `Blocked`.

Review-Evidence enthält mindestens Owner, Reviewer, Reviewdatum, Evidence-Pfad,
Restrisiko, Wiedervorlage, Baseline-Version und normalisierte
SHA-256-Bindung. Das Preset synchronisiert Richtlinien niemals automatisch.
Die Gates heißen `baseline`, `delta`, `closure` und `image-impact`.
Technische Validierung, Pilotfreigabe, Projektabnahme und allgemeine Freigabe
bleiben vier getrennte Entscheidungen.

## 5. Scope

- kanonischer Preset-Scaffold;
- getrennte, bytegleich validierte Publikationskopie;
- Constitution-, Spec-, Plan-, Tasks- und Agent-Addenda;
- Assurance-Profil-, Review-, Evidence- und Statusvorlagen;
- Bash- und PowerShell-Validatoren mit identischem Verhalten;
- bilinguale README, Runbook, Manpages und Feldvalidierungsbericht;
- positives und negatives Fixture-Set;
- öffentliches Repository
  `hindermath/spec-kit-preset-secure-development-assurance-governance`;
- Tag und Release `v0.1.0`;
- versionierter GitHub-ZIP-Smoke-Test;
- Community-Einreichung über das offizielle Spec-Kit-Template.

## 6. Nicht-Ziele / Non-Goals

- Keine Kopie der vollständigen projektgeführten RL-/CL-Baseline in das Preset.
- Keine technische Neuimplementierung von Security-, Architecture-, A11Y-,
  Cross-Platform- oder Agent-Parity-Regeln.
- Keine automatische Richtlinien- oder Evidence-Synchronisierung.
- Keine ISO-Zertifizierung oder organisationsweite SoA.
- Keine automatische Installation in alle Repositories.
- Kein automatischer Start von Review, Specify, Autonomous oder Folge-Intakes.

## 7. Anforderungen / Requirements

- **SDA-001:** Preset-Metadaten verwenden ID, Version, Priorität und
  Mindestversion exakt wie festgelegt.
- **SDA-002:** Die beiden Commands erscheinen auf jeder unterstützten
  Agentenoberfläche genau einmal.
- **SDA-003:** Status ist nachweislich read-only; Review verändert nur
  ausdrücklich autorisierte Review-Evidence.
- **SDA-004:** Der Validator prüft Manifestpfad, Dokumentversionen,
  normalisierte Hashes, zwölf eindeutige Checklisten-IDs, Sammelband und
  mitgeltende Dokumente.
- **SDA-005:** `Ready` ist bei `Open`, `Partly Fulfilled`,
  `Not Fulfilled` oder `Not Assessed` für anwendbare Pflichtpunkte,
  fehlender Evidence oder abgelaufenem Review unzulässig.
- **SDA-006:** `N/A` benötigt Begründung und Re-Evaluation-Trigger.
- **SDA-007:** Akzeptierte Risiken benötigen Owner, Reviewer, Reviewdatum,
  Restrisiko und Wiedervorlage.
- **SDA-008:** Unzulässige Zertifizierungsbehauptungen werden fail-closed
  abgelehnt.
- **SDA-009:** `security-governance >=0.6.1` wird als fachliche
  Kompositionsvoraussetzung geprüft.
- **SDA-010:** Architecture, iSAQB, A11Y, Cross-Platform und Agent Parity
  dürfen nur mit begründetem `N/A` fehlen.
- **SDA-011:** Bestehende Profile 8 bis 12 bleiben unverändert installierbar;
  das Assurance-Profil enthält genau 13 Presets.
- **SDA-012:** Alle Dokumente erfüllen Deutsch-zuerst/Englisch-danach,
  CEFR B2, Begriffserklärung und anwendbare WCAG-2.2-AA-Kriterien.
- **SDA-013:** Community-Kommunikation spricht `@mnriem` höchstens einmal
  freundlich an und behandelt externes Merge nicht als lokale
  Abschlussbedingung.
- **SDA-014:** Branch- und Tag-Rulesets entsprechen den bestehenden öffentlichen
  Preset-Repositories.

## 8. Validierungsfixtures / Validation Fixtures

Positive und negative Fixtures prüfen:

- fehlende, doppelte oder unbekannte `CL_01` bis `CL_12`;
- Manifest-, Versions- und Hashdrift;
- Sammelbanddrift gegenüber zwölf Quelldateien;
- fehlende mitgeltende Dokumente;
- ungültige Kombinationen beider Bewertungsachsen;
- `Ready` trotz offener oder fehlgeschlagener Pflichtpunkte;
- fehlende Evidence und abgelaufene Reviews;
- unzulässige Zertifizierungsbehauptungen;
- LF, CRLF und UTF-8-BOM;
- Bash-/PowerShell-Parität.

## 9. Akzeptanzkriterien / Acceptance Criteria

- **AC-SDA-001:** Kanonischer Scaffold und Publikationskopie sind bytegleich.
- **AC-SDA-002:** Beide Validatoren liefern für alle Fixtures dieselben
  Statusklassen und Exitcodes.
- **AC-SDA-003:** Alle dreizehn Presets eines temporären Zielprofils lassen sich
  installieren, auflösen, deaktivieren, reaktivieren und entfernen.
- **AC-SDA-004:** Jede Agentenoberfläche zeigt beide neuen Commands genau
  einmal.
- **AC-SDA-005:** Profile 8 bis 12 bleiben unverändert funktionsfähig.
- **AC-SDA-006:** `v0.1.0` ist über die versionierte GitHub-ZIP-Datei
  installierbar und durch SHA-256 belegt.
- **AC-SDA-007:** Das öffentliche Repository besitzt MIT-Lizenz und die
  vereinbarten Branch- und Tag-Rulesets.
- **AC-SDA-008:** Die Community-Einreichung ist nachvollziehbar; ihr externer
  Abschluss blockiert nicht Position 16.

## 10. Qualitäts- und Schutzgrenzen

Das Preset muss für Lernende ohne Spec-Kit- oder ISO-Vorkenntnisse verständlich
sein. Es verwendet textorientierte Statusmeldungen, keine ausschließlich
farbige oder visuelle Bedeutung und keine echten Secrets, Kundendaten oder
persönlichen absoluten Pfade.

<!-- intake-authoring:prompts -->
## 11. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Preset-Secure-Development-Assurance-Governance.md` as Position 15 of the active ordered series. Verify the dependency on the completed Position 14 audit, exact public interface, non-duplication of existing governance presets, status semantics, validator fixtures, release and ZIP evidence, learner accessibility, no-certification boundary, and measurable acceptance criteria. Do not modify the intake or start downstream work.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Preset-Secure-Development-Assurance-Governance.md` as the binding intake for Position 15. Create the feature specification for optional preset `secure-development-assurance-governance` v0.1.0 at priority 15 with exactly `$speckit-secure-development-status [<evidence-dir>]` and `$speckit-secure-development-review <baseline|delta|closure|image-impact> <context-id> <training|mixed|development>`. Preserve SDA-001 through SDA-014, AC-SDA-001 through AC-SDA-008, `security-governance >=0.6.1`, all status vocabularies, Bash/PowerShell parity, non-duplication, no-certification, accessibility, publication, and remote-authority boundaries. Do not install the preset fleet-wide or start Position 16.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Preset-Secure-Development-Assurance-Governance.md` with deliveryAuthority=MergeAndSync after Position 14 is complete. Build, test, publish, release, and ZIP-validate only the accepted portable preset scope. Converge all required and optional Spec Kit checks and reviews, create and merge non-empty PRs in authorized repositories, return each changed repository to clean synchronized main, and do not start Position 16 automatically. External community-catalog acceptance is not a local completion condition.
```

<!-- intake-authoring:end -->
