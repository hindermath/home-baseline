# Lastenheft: Secure ServiceHarvester Professional Tracks Lernreihe

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt die 3.-Lehrjahr-Dachreihe von Secure ServiceHarvester als Spezialisierungslandkarte. Es ist nicht als einzelner großer Spec-Kit-Lauf gedacht, sondern verweist auf die vier Track-Übersichten AE, SI, DPA und DV.

**EN:** This master intake describes the third-year umbrella series of Secure ServiceHarvester as a specialization map. It is not meant as one large Spec Kit run; it points to the four track overviews AE, SI, DPA, and DV.

## Einordnung / Placement

**DE:** Die Familie Secure ServiceHarvester ist ein plattformübergreifender Sammel- und Worker-Dienst (sprachneutral, C#-Referenz `InventarWorkerService`). Die Professional Tracks führen die Basis-Reihe (Jahr 1) und die v2-Reihe (Jahr 2) fort und trennen die Arbeit nach Fachrichtung. Empfohlener Bezugspunkt ist der Tag `learning/year-2-complete` im jeweiligen Sprachrepo; die Level-1-Klammer ist `SecureServiceHarvesterProjects`.

**EN:** The Secure ServiceHarvester family is a cross-platform collector and worker service (language-neutral, C# reference `InventarWorkerService`). The Professional Tracks continue the base series (year 1) and the v2 series (year 2) and split the work by specialization. The recommended reference point is the tag `learning/year-2-complete` in the respective language repository; the level-1 bracket is `SecureServiceHarvesterProjects`.

## Track-Übersichten / Track Overviews

| Track | Datei | Schwerpunkt |
|---|---|---|
| AE | [`Secure-ServiceHarvester-Application-Track-Lernreihe.md`](Secure-ServiceHarvester-Application-Track-Lernreihe.md) | Feature-/API-Entwicklung, Persistenz-Adapter, Viewer/CLI, Tests und wartbare Erweiterbarkeit |
| SI | [`Secure-ServiceHarvester-Operations-Track-Lernreihe.md`](Secure-ServiceHarvester-Operations-Track-Lernreihe.md) | Dienst-Härtung, Deployment, CI/CD, Observability, Recovery und Betriebsnachweise |
| DPA | [`Secure-ServiceHarvester-Data-Process-Track-Lernreihe.md`](Secure-ServiceHarvester-Data-Process-Track-Lernreihe.md) | Datenqualität, Kennzahlen, Reporting, Aussagegrenzen und Datenschutz |
| DV | [`Secure-ServiceHarvester-Digital-Networking-Track-Lernreihe.md`](Secure-ServiceHarvester-Digital-Networking-Track-Lernreihe.md) | Maschinen-/Netzbezüge, Schnittstellen, Kommunikationsflüsse, Segmentierung und Verfügbarkeit |

## Roter Faden / Common Thread

**DE:** Alle vier Tracks arbeiten mit KI-Agenten und Spec Kit als begleitendem SDD-Werkzeug. Ab dem 3. Lehrjahr wird erwartet, dass KI-gestützte Entwicklungsarbeit in oder mit `absdd-image-sandbox` geplant, genutzt oder begründet abgegrenzt wird. Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente und sechs Governance-Presets bleiben die lokale Nachweisbasis.

**EN:** All four tracks use AI agents and Spec Kit as a companion SDD tool. From the third training year onward, AI-assisted development is expected to be planned, used, or explicitly bounded with `absdd-image-sandbox`. The secure development guideline, 12 individual checklists, compendium, related documents, and six governance presets remain the local evidence base.

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für alle vier Fachinformatiker-Tracks.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Kein Ersatz für Rahmenlehrplan, Berufsschule, betriebliche Ausbildung, Ausbilderentscheidung oder Prüfungsvorbereitung.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-ServiceHarvester-Professional-Tracks-Lernreihe.md nur als 3.-Lehrjahr-Gesamtlandkarte. Starte daraus keinen Sammellauf. Wähle später im passenden Spezialisierungs-Repo ein konkretes Aufgaben-Lastenheft aus dem Application, Operations, Data & Process oder Digital Networking Track und erstelle dafür eine fokussierte Feature-Spezifikation.
```
