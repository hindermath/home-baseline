# Lastenheft: Secure CaseTracker Digital Networking Track 10 - Abschlussreview mit Vernetzungsrisiken und Übergabe

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 3. Lehrjahr
- **Spezialisierung / Specialization:** DV - Digitale Vernetzung
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Vernetzungsrisiken, Evidenz, offene Punkte, Restrisiko und Übergabeempfehlung werden zusammengeführt.

**EN:** Learners consolidate networking risks, evidence, open items, residual risk, and handover recommendation.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| DV | Schwerpunkt | Welcher Trade-off zwischen Verfügbarkeit, Sicherheit und Aufwand wird für den vernetzten CaseTracker empfohlen? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme bleibt als Restrisiko offen? |
| AE | mittel bis hoch | Welche Implementierungsentscheidung folgt aus dem Abschlussreview? |
| DPA | mittel bis hoch | Welche Aussagegrenze bleibt für die vernetzten Case- und Betriebsdaten bestehen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt DV im 3. Lehrjahr. Spec-Kit strukturiert Abschlussreview und Nachweise, ersetzt aber nicht die berufliche Abschlussbewertung.

**EN:** The task supports Digital Networking in year 3. Spec Kit structures final review and evidence but does not replace vocational assessment.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 12d („Kundenspezifisches cyber-physisches System optimieren")**; berührt LF 9 („Netzwerke und Dienste bereitstellen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_10_Abschlussreview-mit-Vernetzungsrisiken-und-Uebergabe.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 12d ("Kundenspezifisches cyber-physisches System optimieren")**; touched LF 9 ("Netzwerke und Dienste bereitstellen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker-Digital-Networking-Track_10_Abschlussreview-mit-Vernetzungsrisiken-und-Uebergabe.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** auditfähige Evidenz, sichere Architektur, sichere Entwicklung, Datenschutz, A11Y und Restrisiko.
- **Checklisten:** CL_01, CL_02, CL_04, CL_05, CL_08, CL_10, CL_12.
- **Mitgeltende Dokumente:** Richtlinie Secure Development Life Cycle, Leitlinie Sicheres Softwaredesign, Testmanagement, Leitlinie Sichere Entwicklungs-Sandbox.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Erarbeite ein Abschlussreview für den Digital Networking Track. Berücksichtige erledigte Nachweise, offene `Open`-Punkte, begründete `N/A`, Restrisiken, Übergabeempfehlung, Lernreflexion und Grenzen der Aussagekraft.

**EN:** Prepare a final review for the Digital Networking track. Keep later implementation separate from this intake.

## Anforderungen / Requirements

- **R-01:** Alle zentralen DV-Nachweise werden referenziert oder als fehlend markiert.
- **R-02:** Offene Punkte und Restrisiken sind priorisiert.
- **R-03:** Übergabeempfehlung und Grenzen der Aussagekraft sind beschrieben.
- **R-04:** `Applicable`, `N/A` und `Open` Punkte werden konsistent verwendet.
- **R-05:** Lernreflexion und Berufsbildbezug sind sichtbar.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine produktiven Daten, Secrets oder internen Betriebsdetails veröffentlichen.
- Restrisiken nicht beschönigen.
- Positive Sicherheits- oder Betriebsreifeaussagen nur mit Evidenz treffen.
- Datenschutzgrenzen und Monitoring-Aussagegrenzen erneut prüfen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Die Review- und Trade-off-Bewertung bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar.
- Sprachspezifische Entscheidungen dürfen einfließen, müssen aber als solche begründet werden.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Review-, Evidenz- und Übergabepfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Erwartete Evidenz: Abschlussmatrix, Restrisikoliste, Übergabeempfehlung, Lernreflexion.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Abschlussreview ist für Auszubildende im 3. Lehrjahr verständlich.
- [ ] Die Spezialisierung DV ist klar sichtbar.
- [ ] Restrisiken und offene Punkte sind ehrlich dokumentiert.
- [ ] Spec-Kit wird als begleitende SDD-Struktur eingeordnet.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker-Digital-Networking-Track_10_Abschlussreview-mit-Vernetzungsrisiken-und-Uebergabe.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für ein Abschlussreview mit Vernetzungsrisiken und Übergabe der EuFPA-Lernreihe Secure CaseTracker Digital Networking Track. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
