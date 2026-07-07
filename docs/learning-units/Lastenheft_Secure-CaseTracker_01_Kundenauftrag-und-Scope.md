# Lastenheft: Secure CaseTracker 01 - Kundenauftrag und Scope

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Lernende können einen Kundenauftrag verstehen, den fachlichen Scope begrenzen und erste Datenschutz- und Sicherheitsannahmen dokumentieren.

**EN:** Learners can understand a customer task, limit functional scope, and document first privacy and security assumptions.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche spätere Implementierungsentscheidung hängt vom Scope ab? |
| SI | mittel bis hoch | Welche Laufzeit- oder Sandbox-Annahme muss früh geklärt werden? |
| DPA | mittel bis hoch | Welche Daten dürfen für spätere Kennzahlen genutzt werden, ohne unnötige personenbezogene Daten zu verarbeiten? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt Kundenorientierung, Projektabgrenzung, Schutzbedarf, Datenschutz und dokumentierte Arbeitsplanung.

**EN:** The task supports customer orientation, scope definition, protection needs, privacy, and documented work planning.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 1 („Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; berührt LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"), LF 6 („Serviceanfragen bearbeiten"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_01_Kundenauftrag-und-Scope.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 1 ("Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; touched LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen"), LF 6 ("Serviceanfragen bearbeiten"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_01_Kundenauftrag-und-Scope.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Anforderungen, Datenschutz, N/A-Begründung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Kompetenzprofile und Schulungsplan, Datenschutzleitlinie.
- **Presets:** security-governance, a11y-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Beschreibe den Kundenauftrag für EuFPA. Lege fest, welche Funktionen der Secure CaseTracker in dieser Lernreihe behandeln soll und welche bewusst außerhalb des Scopes bleiben. Erfasse die Rollen `learner`, `developer` und `reviewer` als fachliche Rollen, noch nicht als fertiges Authentifizierungssystem. Halte den Umfang im 1. Lehrjahr bewusst einfach.

**EN:** Describe the customer task for EuFPA. Define which Secure CaseTracker functions are part of this learning series and which are intentionally out of scope. Capture `learner`, `developer`, and `reviewer` as business roles, not yet as a finished authentication system. Keep the scope deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Der Kundenauftrag und der fachliche Umfang sind klar beschrieben; In-Scope und Out-of-Scope sind getrennt.
- **R-02:** Die Rollen `learner`, `developer` und `reviewer` sind fachlich erklärt, ohne fertiges Authentifizierungssystem.
- **R-03:** Datenschutz-, Sicherheits- und Betriebsannahmen sind getrennt dokumentiert.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder kurzer Begründung dokumentiert.
- **R-05:** Die Lösung bleibt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten verwenden; alle personenbezogenen Beispieldaten müssen fiktiv sein.
- Datenarten benennen (Kontaktname, Fallbeschreibung, Asset-Bezug, Bearbeitungsnotiz) und je Datenart den Zweck beschreiben.
- Datenminimierung als frühes Akzeptanzkriterium festlegen.
- Risiken aus unklarem Scope als offene Punkte notieren; positive Sicherheitsbehauptungen nur mit Nachweis treffen.
- Nicht anwendbare Standards als `N/A` mit kurzer technischer Begründung dokumentieren (z. B. Authentifizierung, Cloud, KI-Runtime, produktiver Betrieb, solange nur das Lernprojekt geschnitten wird).

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt unabhängig von Programmiersprache und UI-Form; keine Festlegung auf CLI, API oder GUI.
- Keine technische Persistenzentscheidung in dieser Aufgabe.
- C#, Go, Java, Python, Rust und Swift werden nur als spätere Zielsprachen benannt; sprachspezifische Frameworks, Paketmanager und Testwerkzeuge sind noch nicht festzulegen.
- Löst eine Sprache besondere Plattformannahmen aus, wird dies als `Open` für spätere Aufgaben notiert.

## Erwartete Artefakte / Expected Artifacts

- Kundenauftrag in kurzer, verständlicher Form.
- In-Scope-/Out-of-Scope-Liste und fachliche Rollenbeschreibung.
- erste Akzeptanzkriterien sowie erste Datenschutz- und Sicherheitsnotiz.
- dokumentierte offene Punkte mit Owner oder Folgeaufgabe und begründete `N/A`-Einträge.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Der Kundenauftrag ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] In-Scope und Out-of-Scope sind getrennt beschrieben; jede Rolle ist fachlich erklärt.
- [ ] Mindestens eine Datenschutzannahme und eine Sicherheitsannahme sind dokumentiert.
- [ ] Ein Review-Pfad ist benannt (Scope und Nicht-Ziele eindeutig, keine echten Daten genannt).
- [ ] Offene Punkte sind als `Open` mit Owner oder Folgeaufgabe notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_01_Kundenauftrag-und-Scope.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Kundenauftrag, Scope, Rollen, Akzeptanzkriterien und erste Datenschutz-/Sicherheitsannahmen der EuFPA-Lernreihe Secure CaseTracker. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
