# Lastenheft: Secure CaseTracker 05 - Rollen und Berechtigungen

## Metadaten / Metadata

- **Stand / Date:** 2026-07-05
- **Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift

## Lernziel / Learning Goal

**DE:** Lernende können einfache Rollen und Berechtigungen definieren, sichere Defaults festlegen und Rechteausweitung durch Eingaben vermeiden.

**EN:** Learners can define simple roles and permissions, set secure defaults, and prevent privilege escalation through input.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Warum |
|---|---|---|
| AE | Primär | Autorisierung muss in der Anwendung und Kernlogik geprüft werden. |
| SI | Sekundär | Rollen beeinflussen Betrieb, Konfiguration und spätere Zugriffskontrolle. |
| DPA | Ergänzend | Rollen bestimmen, wer welche Daten sehen oder auswerten darf. |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe verbindet Zugangssteuerung, sichere Defaults, Schutzbedarf und rollenbezogene Datenverarbeitung.

**EN:** The task connects access control, secure defaults, protection needs, and role-based data processing.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primär LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; berührt LF 5 („Software zur Verwaltung von Daten anpassen"). Vertiefte Erklärung und Verständnisfragen: `lernbegleiter/Secure-CaseTracker_05_Rollen-und-Berechtigungen.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`): **primary LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen")**; touched LF 5 ("Software zur Verwaltung von Daten anpassen"). Deeper explanation and comprehension questions: `lernbegleiter/Secure-CaseTracker_05_Rollen-und-Berechtigungen.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** Least Privilege, sichere Defaults, Zugangssteuerung.
- **Checklisten:** CL_01, CL_08, CL_10.
- **Mitgeltende Dokumente:** Richtlinie Zugangssteuerung.

## Aufgabenstellung / Task

**DE:** Definiere eine Rollenmatrix für `learner`, `developer` und `reviewer`. Lege fest, welche Rolle Fälle erstellen, ändern, schließen, exportieren und Audit-Einträge ansehen darf. Eine vollständige Authentifizierung ist in dieser Aufgabe nicht Pflicht; falls sie nicht umgesetzt wird, muss dies als `N/A` begründet werden.

**EN:** Define a role matrix for `learner`, `developer`, and `reviewer`. Define which role may create, update, close, export, and view audit entries. Full authentication is not mandatory in this task; if it is not implemented, document this as `N/A`.

## Sicherheitsanforderungen / Security Requirements

- Standardrolle hat minimale Rechte.
- Rolle darf nicht ungeprüft aus einem Eingabeparameter übernommen werden.
- Jede geschützte Aktion hat eine Autorisierungsregel.

## Datenschutzanforderungen / Privacy Requirements

- Export und Audit-Einsicht sind besonders restriktiv.
- Rollenentscheidung darf keine unnötigen personenbezogenen Daten offenlegen.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Die Rollenmatrix gilt in allen sechs Zielsprachen gleich.
- Geschützte Aktionen werden fachlich beschrieben, nicht durch ein bestimmtes Framework.
- Eine vereinfachte Authentifizierung muss klar von echter Produktiv-Authentifizierung getrennt werden.

## Sprachspezifische Hinweise / Language-Specific Notes

- Framework-spezifische Authentifizierung wird nur beschrieben, wenn sie im späteren Spec-Kit-Lauf wirklich umgesetzt wird.
- C#, Java und Swift können Framework-Policies nutzen; Go, Python und Rust können zunächst explizite Rollenprüfungen in der Kernlogik zeigen.
- Jede Sprache dokumentiert, wo Rollen geprüft werden.

## Erwartete Artefakte / Expected Artifacts

- Rollenmatrix.
- Liste geschützter Aktionen.
- `N/A`-Begründung für echte Authentifizierung, falls nicht Teil der Aufgabe.
- Autorisierungstestideen.

## Akzeptanzkriterien / Acceptance Criteria

- Jede Rolle hat erlaubte und verbotene Aktionen.
- Die Standardrolle hat minimale Rechte.
- Keine geschützte Aktion verlässt sich allein auf UI- oder CLI-Auswahl.
- Nicht umgesetzte echte Authentifizierung ist begründet.

## Tests und Nachweise / Tests and Evidence

- Tests für erlaubte Aktionen je Rolle.
- Tests für verbotene Aktionen je Rolle.
- Review, ob sichere Defaults dokumentiert sind.

## Reflexionsfragen / Reflection Questions

- **AE:** Wo muss Autorisierung geprüft werden, damit keine UI-Umgehung möglich ist?
- **SI:** Welche Rollenannahmen wären im Betrieb zu dokumentieren?
- **DPA:** Welche Auswertungen dürfen Lernende sehen, ohne Datenschutz zu verletzen?

## N/A-Regeln / N/A Rules

- Echte Benutzerverwaltung ist `N/A`, wenn dieser Lauf nur Autorisierungsregeln lehrt.
- Externe Identity Provider sind `N/A`, solange keine reale Betriebsintegration vorgesehen ist.
- Jede `N/A`-Entscheidung grenzt Lernvereinfachung von Produktivanforderung ab.

## Offene Punkte / Open Follow-Ups

- Rollen, die später echte Authentifizierung benötigen, werden als Folgeaufgabe markiert.
- Unklare Exportrechte werden vor Persistenz und Prozessanalyse erneut geprüft.

## Copy-Paste Spec-Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-CaseTracker_05_Rollen-und-Berechtigungen.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für Rollenmatrix, sichere Defaults, geschützte Aktionen, Autorisierungstests und N/A-Begründung für nicht umgesetzte Authentifizierung des Secure CaseTracker. Erzeuge keine Implementierung.
```
