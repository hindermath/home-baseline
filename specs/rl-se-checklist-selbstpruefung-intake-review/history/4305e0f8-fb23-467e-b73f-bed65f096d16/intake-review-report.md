# Intake Review: RL-SE-/Checklist-Selbstpruefung

## Identitaet / Identity

- Review-ID: `4305e0f8-fb23-467e-b73f-bed65f096d16`
- Modus / Mode: `Single`
- Policy: `home-baseline-active-lastenhefte-v1`
- Ergebnis / Outcome: `NeedsRemediation`
- Ziel / Target:
  `Lastenheft_RL-SE-Checklist-Selbstpruefung.md`
- Normalized SHA-256:
  `1262012be63c2cf97da3acfa687fa0694698e8c91bd9c5001221e585543a7463`
- Git-Blob: `68aed4838c3ffe42ef6774eb5d88af48d0688885`
- Ziele / Targets: `1`
- Worker: `0`
- Supersedes: `N/A`; der neue Single-Review ueberschreibt keine bestehende
  Series-Review.

## Ergebnis / Outcome

Der Intake ist noch nicht bereit fuer Specify oder Autonomous. Die
Requirements-Governance, der Authoring-Receipt und der aktuelle Target-Hash
sind gueltig. Die bindende Position-5-Baseline verweist im Lastenheft jedoch
auf einen nicht mehr vorhandenen Dateinamen, obwohl die abgeschlossene
Feature-024-Quelle und ihre Evidence im Repository vorhanden sind. Daneben
bleiben der Lernenden-/Sprachvertrag und die statusabhaengigen Pflichtfelder
der Evidenzmatrix widerspruechlich beziehungsweise unvollstaendig.

*The intake is not yet ready for Specify or Autonomous. Requirements
governance, the authoring receipt, and the current target hash are valid. The
binding item-5 baseline nevertheless refers to a path that no longer exists,
although the completed Feature 024 source and its evidence are present. The
learner/language contract and status-dependent evidence-matrix fields also
remain incomplete or inconsistent.*

## Findings

| ID | Severity | Category | Disposition |
|---|---|---|---|
| `IR001` | High | DependenciesAndReferences | Current completed position-5 source and immutable completion evidence must replace the missing baseline path in normative text and both prompts. |
| `IR002` | Medium | LearnerAccessibilityAndLanguage | Audience, prior knowledge, first-use terminology, and the DE-first/EN-second boundary must be explicit and synchronized. |
| `IR003` | Medium | RequirementsAndPromptAlignment | One status-dependent matrix-field contract must govern requirements, acceptance, and the Specify prompt. |

### IR001: Bindende Baseline-Referenz / Binding baseline reference

Das Lastenheft nennt in Zeilen 23 bis 25
`Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.md`. Dieser Pfad fehlt.
Die abgeschlossene Quelle ist
`Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.024-mitgeltende-dokumente-verzahnung.md`;
die Abschluss-Evidence liegt unter
`specs/024-mitgeltende-dokumente-verzahnung/`. Die Specify- und
Autonomous-Prompts verlangen zwar die Baseline-Pruefung, binden aber weder den
aktuellen Pfad noch einen Abschlussnachweis. Da das Lastenheft diese
Abhaengigkeit selbst als fachlich bindend einstuft, blockiert die Luecke die
Uebergabe.

*Lines 23 through 25 name a missing file as the binding baseline. The completed
source and Feature 024 evidence exist, but neither downstream prompt binds
them. Because the intake itself declares this a functional prerequisite, the
reference drift blocks handoff.*

### IR002: Lernenden-, A11Y- und Sprachvertrag / Learner, A11Y, and language contract

Der erwartete Nachweis soll fuer Auszubildende verstaendlich sein und nennt
A11Y, WCAG 2.2 AA, DE-first/EN-second sowie CEFR B2. Zielgruppe und
vorausgesetztes Vorwissen fehlen jedoch. Mehrere Fachkuerzel werden nicht bei
der ersten Verwendung erklaert. Ausser dem Abhaengigkeitsabschnitt besitzt das
Lastenheft keine englische Parallelfassung, obwohl der Authoring-Receipt
`GermanFirstEnglishSecond` deklariert.

*The expected evidence is learner-facing and names accessibility, WCAG 2.2 AA,
German-first/English-second, and CEFR B2. The audience and assumed prior
knowledge are missing, several acronyms are not explained on first use, and
the declared bilingual boundary is not applied consistently.*

### IR003: Statusfelder und Prompt-Ausrichtung / Status fields and prompt alignment

Zeilen 67 bis 68 verlangen Owner, Follow-up und Re-Evaluation fuer jeden
Pruefpunkt. Zeilen 97 bis 99 beschraenken diese Felder auf `Open`. Der
Specify-Prompt verlangt sie erneut fuer alle Statuswerte und fuegt Restrisiko
hinzu. Eine einzige statusabhaengige Feldmatrix muss festlegen, welche Evidence
fuer `Applicable`, `AlreadySatisfied`, `N/A`, `Open` und `FollowUp` jeweils
verbindlich ist.

*The normative sections and Specify prompt define incompatible mandatory
fields for the five statuses. One status-dependent field matrix must govern
requirements, acceptance, and prompt behavior.*

## Checklistenabdeckung / Checklist Coverage

- Identitaet, Zweck, Scope und Nicht-Ziele: `PASS`
- Atomare Anforderungen und messbare Abnahme: `FAIL`, siehe `IR003`
- Abhaengigkeiten, Reihenfolge und Referenzen: `FAIL`, siehe `IR001`
- Sicherheit, Datenschutz und Secret-Grenzen: `PASS`
- Supply Chain und Standards-Anwendbarkeit: `PASS` als Pruefumfang
- Barrierefreiheit, Lernendenvertrag und Sprachgrenze: `FAIL`, siehe `IR002`
- Plattformgrenzen: `PASS`; generische Repo-Anwendbarkeit ist ausdruecklich
  vorgesehen
- Delivery Authority: `PASS`, `LocalImplementation` ohne Commit-, Push-, PR-
  oder Merge-Autoritaet
- Specify-/Autonomous-Prompt-Ausrichtung: `FAIL`, siehe `IR001` und `IR003`
- Striktes UTF-8, kein NUL, keine Secrets oder unnoetigen personenbezogenen
  Daten: `PASS`

## Governance- und Series-Grenze / Governance and series boundary

Die Schema-2.0-Requirements-Governance ist `Aligned`; Bash und PowerShell
melden 33 aktive Intakes, vier Roots, 36 Abhaengigkeiten und Position 6 als
einzigen bevorzugten `Eligible`-Kandidaten. Der Authoring-Receipt ist aktuell.
`Eligible` ist nur Reihenfolge-Evidence und heilt die Findings dieses
Single-Reviews nicht. Der Review erneuert auch keine vollstaendige
Series-DAG-Review.

*Schema-2.0 requirements governance is aligned, and the authoring receipt is
current. Item 6 remains the sole preferred Eligible target. Eligibility is
ordering evidence only; it does not resolve these findings or refresh a full
Series DAG review.*

## Findings, Risiken und Fragen / Findings, risks, and questions

- Critical: `0`
- High: `1`
- Medium: `2`
- Low: `0`
- Akzeptierte Risiken / Accepted risks: `0`
- Offene Fragen / Open questions: `0`

Es wurde kein Risiko akzeptiert. Der High-Befund blockiert ein akzeptiertes
Review-Ergebnis; die beiden Medium-Befunde werden ebenfalls nicht durch einen
autonomen Agenten akzeptiert.

*No risk was accepted. The High finding blocks an accepted review outcome, and
an autonomous agent does not accept the two Medium findings either.*

## Naechste Aktion / Next action

```text
$speckit-intake-repair Lastenheft_RL-SE-Checklist-Selbstpruefung.md
```

Dieser Schritt wird nicht automatisch gestartet.

*This step is not started automatically.*
