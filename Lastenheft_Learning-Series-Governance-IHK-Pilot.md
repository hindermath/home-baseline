<!-- intake-authoring:begin -->
# Lastenheft: Learning Series Governance – IHK-Pilot

**Dokumenttyp:** Spec-Kit Intake / Lastenheft  
**Status:** bereit für Intake Review  
**Stand:** 2026-07-28  
**Reihenfolge:** Position 36, nach Position 35  
**Delivery Mode:** `MergeAndSync`  
**Zielgruppe:** Lernende, Lehrende, Ausbildende, Bildungsplanende,
Preset-Maintainer und Reviewer  
**Vorausgesetztes Wissen:** Ergebnisse aus Positionen 33 bis 35; keine
Vorkenntnisse zur Preset-Veröffentlichung

## 1. Zweck / Purpose

Dieser Lauf validiert den Preset-Kandidaten aus Position 35 in realistischen
IHK-Berufsbildungsprofilen. Erst nach bestandenem Pilot dürfen Repository,
Release und Community-Einreichung veröffentlicht werden.

Die bestehenden Lernreihen für FI, ITSE, KITSM und KDM liefern die
Migrations- und Regressionsfälle. Zusätzlich beweisen kleine synthetische
Profile aus einem kaufmännischen und einem technischen Nicht-IT-Beruf, dass
das Preset nicht auf die heutige IT-Berufsfamilie fest codiert ist.

*This pilot validates the preset against existing IT learning series and
small non-IT vocational profiles before publication.*

## 2. Pilotgruppen / Pilot Groups

### Bestehende Profile

- FI/AE, FI/SI, FI/DPA und FI/DV;
- IT-System-Elektroniker*innen;
- Kaufleute für IT-System-Management;
- Kaufleute für Digitalisierungsmanagement;
- drei Secure-Trader-Produktfamilien und ihre Level-0-/1-/2-Rollouts.

### Portabilitätsprofile

- ein kleiner kaufmännischer IHK-Beispielberuf mit Kundenprozess,
  Datenschutz, Wirtschaftlichkeit und digitaler Zusammenarbeit;
- ein kleiner technischer IHK-Beispielberuf mit Arbeitssicherheit,
  Mess-/Prüfgrenze, Dokumentation und digital unterstützter Instandhaltung.

Die Portabilitätsprofile sind Test-Fixtures, keine vollständigen Lernreihen und
keine Aussage über einen konkreten Ausbildungsberuf.

## 3. Anforderungen / Requirements

- **LSP-001:** Alle bestehenden Profile werden ohne Inhaltsverlust,
  unerlaubtes Rename oder Änderung amtlicher Aussagen in den neuen
  Review-Vertrag eingelesen.
- **LSP-002:** Für jedes Profil werden interne, normative und
  Ökosystem-Konsistenz getrennt bewertet.
- **LSP-003:** `AIK001` bis `AIK008`, vier Lernphasen und vier Quellenstatus
  werden je Beruf auf Anwendbarkeit und Evidence geprüft.
- **LSP-004:** Eine fehlende explizite KI-Pflicht im Rahmenlehrplan wird nicht
  durch das Preset erfunden; lokale Zukunftskompetenz bleibt als
  `ProjectSupplement` oder `FutureSkillAssumption` sichtbar.
- **LSP-005:** FI-, ITSE-, KITSM- und KDM-spezifische Unterschiede bleiben
  erhalten und werden nur bei echter Inkonsistenz als Finding bewertet.
- **LSP-006:** Beide Portabilitätsprofile bestehen ohne IT-spezifische
  Pflichtfelder.
- **LSP-007:** Negative Fixtures prüfen Quellen-, Hash-, Reihenfolge-,
  Rollen-, Kompetenz-, Evidence-, A11Y- und Autoritätsfehler.
- **LSP-008:** Beide Commands bleiben read-only beziehungsweise
  review-schreibend innerhalb ihres Vertrags und starten keinen Folgelauf.
- **LSP-009:** Das Zwölferprofil wird in einem temporären Spec-Kit-Projekt mit
  Add, List, Info, Resolve, Disable/Enable, Remove/Reinstall geprüft.
- **LSP-010:** Commands und Skills erscheinen auf jeder unterstützten
  Agentenoberfläche genau einmal.
- **LSP-011:** Kanonischer Scaffold und Publikationskopie sind bytegleich;
  Bash und PowerShell liefern identische Statusklassen und Exitcodes.
- **LSP-012:** Nutzerseitige Artefakte erfüllen Deutsch-zuerst/
  Englisch-danach, CEFR B2, Ersterklärung, textorientierte Darstellung und
  WCAG 2.2 AA.
- **LSP-013:** Nur bei vollständig grünem Pilot wird das öffentliche
  MIT-Repository erzeugt und `v0.1.0` veröffentlicht.
- **LSP-014:** Tag-ZIP, SHA-256, Neuinstallation und Zwölferkomposition werden
  nach dem Release erneut geprüft.
- **LSP-015:** Erst danach wird das offizielle Spec-Kit-Preset-Submission-
  Template verwendet; `@mnriem` wird höchstens einmal freundlich
  angesprochen.
- **LSP-016:** Ein externer Katalog-Merge ist keine lokale
  Abschlussbedingung.
- **LSP-017:** Ein Pilotbefund blockiert Veröffentlichung oder wird in einem
  ausdrücklich genehmigten, nicht leeren Fix innerhalb dieses Features
  geschlossen; er wird nicht verschwiegen.
- **LSP-018:** Position 37 wird nicht automatisch gestartet.

## 4. Evidence und Entscheidungen / Evidence and Decisions

Jedes Pilotprofil dokumentiert:

- Profil- und Quellenidentität;
- geprüfte Artefakte und Hashes;
- Ergebnisse der drei Konsistenzebenen;
- KI-Kompetenz- und Lernphasenabdeckung;
- Sicherheits-, A11Y- und Agentenautoritätsgrenzen;
- positive und negative Validatorläufe;
- Restrisiko, Owner und Re-Evaluation-Trigger.

Hauptergebnisse:

- `PilotPassed`
- `PilotPassedWithAcceptedRisks`
- `NeedsRemediation`
- `Blocked`

Ein autonomer Agent darf `PilotPassedWithAcceptedRisks` nicht selbst
genehmigen.

## 5. Ergebnisartefakte / Expected Artifacts

- sieben reale Berufsprofil-Reviews und zwei synthetische
  Portabilitäts-Reviews;
- Migrations-, Regressions- und Negativtestbericht;
- Zwölferprofil- und Agent-Paritätsnachweis;
- Feldvalidierungszusammenfassung;
- öffentliches Preset-Repository, Tag und Release nur bei grünem Pilot;
- versionierter ZIP-Smoke und Prüfsumme;
- offizielle Community-Einreichung nach erfolgreichem Release-Smoke;
- aktualisierte Reihenfolge, Statistik und nachvollziehbarer Handoff an
  Position 37.

## 6. Akzeptanzkriterien / Acceptance Criteria

- **AC-LSP-001:** Alle sieben bestehenden Berufsprofile behalten ihre
  fachlichen Unterschiede und bestehen oder liefern konkrete Findings.
- **AC-LSP-002:** Beide Nicht-IT-Fixtures beweisen die Domänenportabilität.
- **AC-LSP-003:** Kein amtlicher und kein lokaler Quellenstatus wird
  verwechselt.
- **AC-LSP-004:** Bash-/PowerShell-, Preset- und Agent-Parität sind grün.
- **AC-LSP-005:** Bei Veröffentlichung sind Repository, `v0.1.0`, ZIP,
  Prüfsumme und Neuinstallation nachweisbar.
- **AC-LSP-006:** Null offene Critical-/High-Befunde und null ungeklärte
  Autoritäts- oder Evidence-Entscheidungen.
- **AC-LSP-007:** Position 37 wurde nicht automatisch gestartet.

## 7. Nicht-Ziele / Non-Goals

- Keine vollständige neue Lernreihe für die beiden Portabilitätsprofile.
- Keine pauschale Flotteninstallation außerhalb genehmigter Profile.
- Keine automatische Risikoakzeptanz, Prüfungsgarantie oder Zertifizierung.
- Kein Start des globalen Lernreihen-Abschlusses.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Learning-Series-Governance-IHK-Pilot.md` as position 36. Verify all seven existing occupation profiles, two bounded non-IT portability fixtures, three consistency axes, AIK001-AIK008, learning phases, source statuses, migration and negative tests, twelve-preset and agent parity, human risk authority, release-after-pilot boundary, community-submission boundary, and no automatic position-37 start.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Learning-Series-Governance-IHK-Pilot.md` as the binding intake for position 36. Specify the field validation, controlled migration proof, portability fixtures, publication, release and community-submission path for learning-series-governance v0.1.0. Preserve LSP-001 through LSP-018 and AC-LSP-001 through AC-LSP-007. Do not alter official claims, accept risk autonomously, perform an unapproved fleet rollout, or start position 37.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Learning-Series-Governance-IHK-Pilot.md` with deliveryAuthority=MergeAndSync after position 35 is complete. Validate the seven existing occupation profiles and two bounded portability fixtures, publish v0.1.0 only after all mandatory pilot gates pass, submit through the official preset template only after release ZIP validation, create only non-empty PRs, return all touched repositories to clean synchronized default branches, and do not start position 37.
```

<!-- intake-authoring:end -->
