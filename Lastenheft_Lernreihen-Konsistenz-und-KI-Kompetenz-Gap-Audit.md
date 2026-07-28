<!-- intake-authoring:begin -->
# Lastenheft: Lernreihen-Konsistenz- und KI-Kompetenz-Gap-Audit

**Dokumenttyp:** Spec-Kit Intake / Lastenheft  
**Status:** bereit für Intake Review  
**Stand:** 2026-07-28  
**Reihenfolge:** Position 33, nach Position 32  
**Delivery Mode:** `MergeAndSync`  
**Zielgruppe:** Lernende, Lehrende, Ausbildende, Maintainer und Reviewer in
dualen IHK-Ausbildungsgängen ab dem ersten Ausbildungsjahr  
**Vorausgesetztes Wissen:** keine Spec-Kit- oder KI-Vorkenntnisse; Fachbegriffe
werden beim ersten Auftreten erklärt

## 1. Zweck / Purpose

Dieser Lauf prüft die bestehenden Lernreihen read-only auf drei Ebenen:

1. **in sich konsistent:** Aufbau, Ziele, Aufgaben, Lernbegleiter, Evidence und
   Abnahme einer einzelnen Reihe stimmen überein;
2. **an sich konsistent:** Die Reihe passt zu amtlichen Ausbildungsgrundlagen,
   Level-0-Governance, Sicherheit, Sprache und Barrierefreiheit;
3. **insgesamt konsistent:** Berufe, Lehrjahre, Produktfamilien und Rollouts
   bilden ein widerspruchsfreies Lernsystem.

Zusätzlich prüft der Lauf, ob Lernende den sicheren, überprüfbaren und
beruflich passenden Umgang mit KI und agentischer KI erlernen. **Agentische
KI** bezeichnet hier ein KI-System, das mit ausdrücklich begrenzter Autorität
mehrere Arbeitsschritte und Werkzeuge selbstständig ausführen kann.

*This read-only audit checks internal, normative, and ecosystem consistency.
It also identifies whether learners gain safe, verifiable, occupation-specific
competence in using AI and agentic AI.*

## 2. Verbindliche Quellen / Binding Sources

- die zum jeweiligen Beruf geltende Ausbildungsordnung, der
  Ausbildungsrahmenplan und der KMK-Rahmenlehrplan;
- BIBB-Umsetzungshilfen und die amtlichen Informationen zu den modernisierten
  IT-Berufen: <https://www.bibb.de/de/127913.php>;
- KMK-Strategie „Bildung in der digitalen Welt“ einschließlich der
  KI-Handlungsempfehlung:
  <https://www.kmk.org/bildungsministerkonferenz/bildungsthemen/bildung-in-der-digitalen-welt.html>;
- BIBB-Informationen zu KI in der beruflichen Bildung:
  <https://www.bibb.de/de/209400.php>;
- EU-Kommission zu KI-Kompetenz und Artikel 4 des AI Act:
  <https://digital-strategy.ec.europa.eu/en/policies/ai-talent-skills-and-literacy>;
- Level-0-Constitution, Lernreihen-Blueprint, Lernreihen-Register,
  IT-Berufe-Mapping, Secure-Development-Baseline und geltende
  Dokumentations-Governance.

Amtliche Anforderungen haben Vorrang. Projektseitige Zukunftskompetenzen
werden deutlich als Ergänzung markiert und niemals als bereits vorgeschriebener
Rahmenlehrplaninhalt ausgegeben.

## 3. KI-Kompetenzmodell / AI Competence Model

Das Audit verwendet acht stabile Kompetenz-IDs:

| ID | Kompetenz / Competence |
|---|---|
| `AIK001` | Grundlagen, Fähigkeiten und Grenzen von KI erklären |
| `AIK002` | Datenschutz, Informationssicherheit, Urheberrecht, Fairness und betriebliche Regeln anwenden |
| `AIK003` | Aufgaben, Kontext, Grenzen und Abnahmekriterien verständlich formulieren |
| `AIK004` | KI-Ausgaben, Quellen, Code, Berechnungen und Behauptungen unabhängig prüfen |
| `AIK005` | Werkzeuge, Sandbox, Secrets und Agentenautorität sicher begrenzen |
| `AIK006` | Agentische Abläufe planen, stoppen, fortsetzen und mit Evidence nachvollziehen |
| `AIK007` | Entscheidungen, menschliche Verantwortung und Übergaben dokumentieren |
| `AIK008` | Nutzen, Risiken, Bias, Nachhaltigkeit und Auswirkungen auf Arbeit reflektieren |

Jede Kompetenz wird einer Lernphase zugeordnet:

- `Orientieren`: erkennen, erklären und unter Anleitung einordnen;
- `Anwenden`: eine begrenzte Aufgabe mit überprüfbarem Ergebnis bearbeiten;
- `Delegieren`: Teilaufgaben mit klarer Autorität an einen Agenten übergeben;
- `Bewerten`: Ergebnis, Prozess, Risiko und berufliche Wirkung selbstständig
  beurteilen.

## 4. Quellenstatus / Source Status

Jede Aussage zur beruflichen KI-Kompetenz erhält genau einen Status:

- `OfficiallyRequired`: unmittelbar durch eine amtliche Grundlage verlangt;
- `Supported`: durch amtliche Digital-, Medien- oder Handlungskompetenz
  gestützt, aber dort nicht so konkret benannt;
- `ProjectSupplement`: bewusstes lokales Lernziel oberhalb der Mindestvorgabe;
- `FutureSkillAssumption`: begründete Zukunftsannahme mit Owner,
  Wiedervorlage und Re-Evaluation-Trigger.

`ProjectSupplement` und `FutureSkillAssumption` dürfen keine Prüfungs-,
Zertifizierungs- oder Rechtsbehauptung erzeugen.

## 5. Anforderungen / Requirements

- **LKA-001:** Alle aktiven FI-, ITSE-, KITSM- und KDM-Lernreihen,
  Lernbegleiter, Unterrichtsleitfäden, Mappings, Registereinträge und
  Rolloutziele werden genau einmal inventarisiert.
- **LKA-002:** Jede Reihe wird getrennt auf interne, normative und
  serienübergreifende Konsistenz geprüft.
- **LKA-003:** Jede Aussage zu Ausbildungsgrundlagen nennt Beruf, Quelle,
  Stand, betroffene Kompetenz und Quellenstatus.
- **LKA-004:** `AIK001` bis `AIK008` werden für jeden integrierten Beruf und
  jedes Ausbildungsjahr als vorhanden, teilweise vorhanden, fehlend,
  absichtlich nicht anwendbar oder klärungsbedürftig bewertet.
- **LKA-005:** Die Phasen `Orientieren`, `Anwenden`, `Delegieren` und
  `Bewerten` werden als Lernprogression geprüft; sie sind keine pauschalen
  Lehrjahreslabels.
- **LKA-006:** Aufgaben müssen Eigenleistung, zulässige KI-Hilfe,
  Prüfgrenze, Evidence und menschliche Verantwortung unterscheiden.
- **LKA-007:** Agentenarbeit muss Container-/Sandbox-Grenze, Secrets,
  Toolautorität, Stop/Resume, Review und nachvollziehbare Übergabe abdecken.
- **LKA-008:** Selbstberichte allein gelten nicht als Kompetenznachweis.
  Mindestens ein überprüfbares Arbeitsartefakt und eine begründete Reflexion
  sind erforderlich.
- **LKA-009:** Gemeinsame Kompetenzen werden kanonisch wiederverwendet;
  berufsspezifische Ausprägungen bleiben sichtbar und werden nicht
  gleichgemacht.
- **LKA-010:** Das Audit prüft Deutsch-zuerst/Englisch-danach, CEFR B2,
  Ersterklärung, textorientierte Abhängigkeiten und WCAG 2.2 AA.
- **LKA-011:** Das Audit bewertet die aktuelle Acht-Preset-Basis und die drei
  optionalen Intake-Presets nur auf Lernreihen-Anwendbarkeit; es verändert
  keine Presets.
- **LKA-012:** Findings erhalten stabile `LKA###`-IDs, Schweregrad, Evidence,
  Owner, betroffene Reihen, Follow-up-Grenze und Re-Evaluation-Trigger.
- **LKA-013:** Der Lauf bleibt read-only und ändert weder Lernmaterialien noch
  Presets, Produktcode, Ausbildungsbehauptungen oder Flottenrepositories.
- **LKA-014:** Position 34 wird nicht automatisch gestartet.

## 6. Ergebnisartefakte / Expected Artifacts

- vollständiges Lernreihen-, Berufs-, Lehrjahres- und Rolloutinventar;
- Drei-Ebenen-Konsistenzmatrix;
- `AIK001`-bis-`AIK008`-Matrix je Beruf und Lernphase;
- Quellen- und Quellenstatus-Ledger;
- Evidence-, Sicherheits-, A11Y- und Agentenautoritätsmatrix;
- dedupliziertes Finding- und Handoff-Ledger für Position 34.

## 7. Akzeptanzkriterien / Acceptance Criteria

- **AC-LKA-001:** Jede aktive Lernreihe ist genau einmal auf allen drei Ebenen
  bewertet.
- **AC-LKA-002:** Alle acht KI-Kompetenzen besitzen pro integriertem Beruf
  eine belegte Entscheidung oder ein Finding.
- **AC-LKA-003:** Keine Projektannahme wird als amtliche Pflicht dargestellt.
- **AC-LKA-004:** Gemeinsame und berufsspezifische Kompetenzen sind
  nachvollziehbar getrennt.
- **AC-LKA-005:** Jede positive Kompetenzentscheidung besitzt überprüfbare
  Evidence und eine menschliche Bewertungsgrenze.
- **AC-LKA-006:** Null offene Critical-/High-Befunde ohne Owner und
  Follow-up-Pfad.
- **AC-LKA-007:** Es wurden keine Lernmaterialien, Presets oder
  Produktartefakte verändert und Position 34 wurde nicht gestartet.

## 8. Nicht-Ziele / Non-Goals

- Keine Umsetzung der Findings.
- Keine Änderung amtlicher Berufsprofile.
- Keine Prüfungs-, Zertifizierungs- oder Beschäftigungsgarantie.
- Keine pauschale Gleichsetzung von KI-Kompetenz mit Prompt-Schreiben.
- Kein automatischer Preset-, Rollout- oder Folgefeature-Lauf.

<!-- intake-authoring:prompts -->
## 9. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Lernreihen-Konsistenz-und-KI-Kompetenz-Gap-Audit.md` as position 33. Verify the three consistency levels, official-source hierarchy, AIK001-AIK008 model, four learning phases, exact source-status vocabulary, complete FI/ITSE/KITSM/KDM inventory, human evidence and authority boundaries, DE-first/EN-second CEFR-B2 and WCAG 2.2 AA rules, read-only scope, stable findings, and no automatic position-34 start.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Lernreihen-Konsistenz-und-KI-Kompetenz-Gap-Audit.md` as the binding intake for position 33. Create a read-only audit specification for internal, normative, and ecosystem consistency and for occupation-specific AI and agentic-AI competence. Preserve LKA-001 through LKA-014, AC-LKA-001 through AC-LKA-007, AIK001 through AIK008, the four learning phases, and the exact source-status vocabulary. Do not change learning materials, presets, product code, fleet repositories, or start position 34.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete read-only Spec Kit run for `Lastenheft_Lernreihen-Konsistenz-und-KI-Kompetenz-Gap-Audit.md` with deliveryAuthority=MergeAndSync after position 32 is complete. Produce only audit evidence, deterministic validators, statistics, archive/order updates, and one non-empty PR. Return to clean synchronized main, do not remediate findings, and do not start position 34.
```

<!-- intake-authoring:end -->
