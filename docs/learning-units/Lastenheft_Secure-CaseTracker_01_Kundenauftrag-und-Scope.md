# Lastenheft: Secure CaseTracker 01 - Kundenauftrag und Scope

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Spec-Kit-Nutzung / Spec Kit use:** Eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Lernende können einen Kundenauftrag verstehen, den fachlichen Scope begrenzen und erste Datenschutz- und Sicherheitsannahmen dokumentieren.

**EN:** Learners can understand a customer task, limit functional scope, and document first privacy and security assumptions.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Anforderungen und Akzeptanzkriterien steuern spätere Implementierung. |
| SI | Sekundär | Betriebs- und Sandbox-Annahmen müssen früh sichtbar sein. |
| DPA | Sekundär | Datenarten, Zweckbindung und spätere Kennzahlen werden eingegrenzt. |

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

**DE:** Beschreibe den Kundenauftrag für EuFPA. Lege fest, welche Funktionen der Secure CaseTracker in dieser Lernreihe behandeln soll und welche bewusst außerhalb des Scopes bleiben. Erfasse die Rollen `learner`, `developer` und `reviewer` als fachliche Rollen, noch nicht als fertiges Authentifizierungssystem.

**EN:** Describe the customer task for EuFPA. Define which Secure CaseTracker functions are part of this learning series and which are intentionally out of scope. Capture `learner`, `developer`, and `reviewer` as business roles, not yet as a finished authentication system.

## Sicherheitsanforderungen / Security Requirements

- Keine echten Kundendaten verwenden.
- Alle späteren personenbezogenen Beispieldaten müssen fiktiv sein.
- `N/A`, `Applicable` und `Open` werden ab der ersten Aufgabe dokumentiert.
- Risiken aus unklarem Scope werden als offene Punkte notiert.

## Datenschutzanforderungen / Privacy Requirements

- Datenarten benennen: Kontaktname, Fallbeschreibung, Asset-Bezug, Bearbeitungsnotiz.
- Zweck je Datenart beschreiben.
- Datenminimierung als frühes Akzeptanzkriterium festlegen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der fachliche Vertrag bleibt unabhängig von Programmiersprache und UI-Form.
- Noch keine Festlegung auf CLI, API oder GUI.
- Keine technische Persistenzentscheidung in dieser Aufgabe.

## Sprachspezifische Hinweise / Language-Specific Notes

- C#, Go, Java, Python, Rust und Swift werden in dieser Aufgabe nur als spätere Zielsprachen benannt.
- Sprachspezifische Frameworks, Paketmanager und Testwerkzeuge sind noch nicht festzulegen.
- Wenn eine Sprache besondere Plattformannahmen auslöst, wird dies als `Open` für spätere Aufgaben notiert.

## Erwartete Artefakte / Expected Artifacts

- Kundenauftrag in kurzer, verständlicher Form.
- In-Scope-/Out-of-Scope-Liste.
- erste Akzeptanzkriterien.
- erste Datenschutz- und Sicherheitsnotiz.

## Akzeptanzkriterien / Acceptance Criteria

- Der Kundenauftrag ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- In-Scope und Out-of-Scope sind getrennt beschrieben.
- Jede Rolle ist fachlich erklärt.
- Mindestens eine Datenschutzannahme und eine Sicherheitsannahme sind dokumentiert.

## Tests und Nachweise / Tests and Evidence

- Review prüft, ob Scope und Nicht-Ziele eindeutig sind.
- Review prüft, ob keine echten Daten genannt werden.
- Offene Punkte haben Owner oder Folgeaufgabe.

## Reflexionsfragen / Reflection Questions

- **AE:** Welche spätere Implementierungsentscheidung hängt vom Scope ab?
- **SI:** Welche Laufzeit- oder Sandbox-Annahme muss früh geklärt werden?
- **DPA:** Welche Daten dürfen für Kennzahlen genutzt werden, ohne unnötige personenbezogene Daten zu verarbeiten?

## N/A-Regeln / N/A Rules

- Authentifizierung ist in dieser Aufgabe `N/A`, wenn nur Rollen als fachliches Konzept beschrieben werden.
- Cloud, KI-Runtime und produktiver Betrieb sind `N/A`, solange nur das Lernprojekt geschnitten wird.
- Jede `N/A`-Entscheidung nennt kurz, warum sie für diesen Spec-Kit-Lauf nicht greift.

## Offene Punkte / Open Follow-Ups

- Offene fachliche Fragen werden in die nächste passende Lerneinheit übernommen.
- Offene Datenschutz- oder Sicherheitsfragen werden nicht gelöscht, sondern als `Open` mit Folgeaufgabe dokumentiert.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_01_Kundenauftrag-und-Scope.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Kundenauftrag, Scope, Rollen, Akzeptanzkriterien und erste Datenschutz-/Sicherheitsannahmen der EuFPA-Lernreihe Secure CaseTracker. Erzeuge keine Implementierung.
```
