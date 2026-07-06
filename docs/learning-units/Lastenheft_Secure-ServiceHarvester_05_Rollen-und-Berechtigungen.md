# Lastenheft: Secure ServiceHarvester 05 - Rollen und Berechtigungen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-06
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA, DV
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer Spec-Kit-Intake
- **Sandbox-Bezug / Sandbox relation:** Vorbereitung für spätere Arbeit in `absdd-image-sandbox`

## Lernziel / Learning Goal

**DE:** Einfache Rollen und Berechtigungen für den Sammel-Dienst werden definiert, sichere Defaults festgelegt und Rechteausweitung durch Eingaben vermieden. Lernende schützen sensible Dienstaktionen wie Sammellauf-Steuerung, Export und Audit-Einsicht.

**EN:** Simple roles and permissions for the collection service are defined, secure defaults are set, and privilege escalation through input is prevented. Learners protect sensitive service actions such as collection-run control, export, and audit view.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche Implementierungsentscheidung folgt aus dieser Aufgabe? |
| SI | hoch | Welche Betriebs-, Toolchain- oder Sandbox-Annahme muss dokumentiert werden? |
| DPA | mittel | Welche Datenqualität, Datenschutzfrage oder Aussagegrenze ist betroffen? |
| DV | mittel | Welche Schnittstelle, Systemgrenze oder Kommunikationsannahme ist betroffen? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Zugangssteuerung, sichere Defaults, Schutzbedarf und rollenbezogene Datenverarbeitung auf dem Niveau ab dem 1. Lehrjahr.

**EN:** The task connects access control, secure defaults, protection needs, and role-based data processing at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-ServiceHarvester_05_Rollen-und-Berechtigungen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-ServiceHarvester_05_Rollen-und-Berechtigungen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Least Privilege, sichere Defaults, Zugangssteuerung, Fail-Safe Defaults.
- **Checklisten:** CL_01, CL_08, CL_10.
- **Mitgeltende Dokumente:** Richtlinie Zugangssteuerung, Leitlinie für sichere Programmierung.
- **Presets:** security-governance, architecture-governance, isaqb-architecture-governance, a11y-governance, cross-platform-governance, agent-parity-governance.

## Aufgabenstellung / Task

**DE:** Definiere eine Rollenmatrix für `learner`, `developer` und `reviewer` (bzw. passende Betriebsrollen). Lege fest, welche Rolle den Sammellauf starten und stoppen, die Konfiguration ändern, Statusdaten exportieren und Audit-Einträge ansehen darf. Eine vollständige Produktiv-Authentifizierung ist in dieser Aufgabe nicht Pflicht; falls sie nicht umgesetzt wird, muss dies als `N/A` begründet werden. Halte den Dienst im 1. Lehrjahr bewusst einfach.

**EN:** Define a role matrix for `learner`, `developer`, and `reviewer` (or matching operational roles). Define which role may start and stop the collection run, change the configuration, export status data, and view audit entries. Full production authentication is not mandatory in this task; if it is not implemented, document this as `N/A`. Keep the service deliberately simple in year 1.

## Anforderungen / Requirements

- **R-01:** Eine Rollenmatrix benennt je Rolle erlaubte und verbotene Aktionen.
- **R-02:** Die Standardrolle hat minimale Rechte (sichere Defaults, Fail-Safe Default).
- **R-03:** Keine geschützte Aktion verlässt sich allein auf UI-, CLI- oder Eingabeauswahl; die Rolle wird nie ungeprüft aus einer Eingabe übernommen.
- **R-04:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert.
- **R-05:** Die Rollenmatrix gilt vergleichbar für C#, Go, Java, Python, Rust und Swift.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Jede geschützte Aktion hat eine Autorisierungsregel, die in der Kernlogik geprüft wird.
- Export und Audit-Einsicht sind besonders restriktiv; Rollenentscheidung legt keine unnötigen personenbezogenen Daten offen.
- Rechteausweitung über Eingaben (z. B. `role=reviewer`) wird verhindert.
- Vereinfachte Lern-Authentifizierung wird klar von echter Produktiv-Authentifizierung getrennt; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Die Rollenmatrix und die geschützten Aktionen werden fachlich beschrieben, nicht durch ein bestimmtes Framework.
- Jede Sprache dokumentiert, wo Rollen geprüft werden; C#, Java und Swift können Framework-Policies nutzen, Go, Python und Rust können explizite Rollenprüfungen in der Kernlogik zeigen.
- Eine vereinfachte Authentifizierung muss klar von echter Produktiv-Authentifizierung getrennt werden.
- MSL-Status ersetzt keine sichere Auth-, Autorisierungs- oder Review-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- fokussierte `spec.md` für diese Aufgabe.
- `plan.md` mit Rollen-, Autorisierungs-, Test- und Nachweispfaden.
- `tasks.md` mit umsetzbaren Review-, Test- und Dokumentationsschritten.
- Projektspezifische Markdown-Nachweise oder begründete `N/A`-Einträge.
- Erwartete Evidenz: Rollenmatrix, Liste geschützter Aktionen, `N/A`-Begründung für echte Authentifizierung, Autorisierungstestideen.

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Ergebnis ist für Auszubildende ab dem 1. Lehrjahr verständlich.
- [ ] Jede Rolle hat erlaubte und verbotene Aktionen; die Standardrolle hat minimale Rechte.
- [ ] Keine geschützte Aktion verlässt sich allein auf UI- oder CLI-Auswahl.
- [ ] Rechteausweitung über Eingaben ist als Risiko behandelt und mit mindestens einem Test abgedeckt.
- [ ] Nicht umgesetzte echte Authentifizierung ist als `N/A` begründet; offene Punkte sind als `Open` mit Folgeaktion notiert.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester_05_Rollen-und-Berechtigungen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für Rollenmatrix, sichere Defaults, geschützte Dienstaktionen, Autorisierungstests und N/A-Begründung für nicht umgesetzte Authentifizierung des Secure ServiceHarvester der EuFPA-Lernreihe Secure ServiceHarvester. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
