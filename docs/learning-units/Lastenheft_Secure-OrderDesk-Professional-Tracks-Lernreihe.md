# Lastenheft: Secure OrderDesk Professional Tracks Lernreihe

<!-- learner-a11y-baseline -->
> **DE:** Diese Reihenwurzel erbt die [Lernenden- und A11Y-Basis](LERNENDEN-UND-A11Y-BASIS.md) für Fachinformatiker*innen, Kaufleute für IT-System-Management und Kaufleute für Digitalisierungsmanagement ab dem 1. Lehrjahr. Es werden keine Spec-Kit-Vorkenntnisse vorausgesetzt.
>
> **EN:** This series root inherits the [Learner and A11Y Baseline](LERNENDEN-UND-A11Y-BASIS.md) for IT specialist apprentices, IT system management trainees, and digitalisation management trainees from training year 1. No prior Spec Kit knowledge is assumed.

## Zweck / Purpose

**DE:** Dieses Master-Lastenheft beschreibt die 3.-Lehrjahr-Dachreihe von Secure OrderDesk als Spezialisierungslandkarte. Es ist nicht als einzelner großer Spec-Kit-Lauf gedacht, sondern verweist auf die vier Track-Übersichten AE, SI, DPA und DV.

**EN:** This master intake describes the third-year umbrella series of Secure OrderDesk as a specialization map. It is not meant as one large Spec Kit run; it points to the four track overviews AE, SI, DPA, and DV.

## Einordnung / Placement

**DE:** Die Familie Secure OrderDesk ist eine relationale Handels-/Bestellplattform (sprachneutral, C#-Referenz `SecureOrderDesk-CSharp`) für die fiktive Handelsfirma Secure Trader auf Northwind-Datenbasis inklusive Pflicht-Datensatz `ALFKI`. Die Professional Tracks führen die Basis-Reihe (Jahr 1) und die v2-Reihe (Jahr 2) fort und trennen die Arbeit nach Fachrichtung. Empfohlener Bezugspunkt ist der Tag `learning/year-2-complete` im jeweiligen Sprachrepo; die Level-1-Klammer ist `SecureOrderDeskProjects`.

**EN:** The Secure OrderDesk family is a relational trading/ordering platform (language-neutral, C# reference `SecureOrderDesk-CSharp`) for the fictional trading company Secure Trader on the Northwind data base including the mandatory record `ALFKI`. The Professional Tracks continue the base series (year 1) and the v2 series (year 2) and split the work by specialization. The recommended reference point is the tag `learning/year-2-complete` in the respective language repository; the level-1 bracket is `SecureOrderDeskProjects`.

## Track-Übersichten / Track Overviews

| Track | Datei | Schwerpunkt |
|---|---|---|
| AE | [`Secure-OrderDesk-Application-Track-Lernreihe.md`](Secure-OrderDesk-Application-Track-Lernreihe.md) | Feature-/API-Erweiterung der Plattform, Persistenz-Adapter, Viewer/CLI, Tests und wartbare Erweiterbarkeit |
| SI | [`Secure-OrderDesk-Operations-Track-Lernreihe.md`](Secure-OrderDesk-Operations-Track-Lernreihe.md) | Datenbank-Betrieb, Deployment, CI/CD, Observability, Backup/Restore und Betriebsnachweise |
| DPA | [`Secure-OrderDesk-Data-Process-Track-Lernreihe.md`](Secure-OrderDesk-Data-Process-Track-Lernreihe.md) | Umsatz-/Bestell-Auswertungen, Datenqualität, Kennzahlen, Aussagegrenzen und Datenschutz |
| DV | [`Secure-OrderDesk-Digital-Networking-Track-Lernreihe.md`](Secure-OrderDesk-Digital-Networking-Track-Lernreihe.md) | Schnittstellen der Bestell-Pipeline, Integration, Kommunikationsflüsse, Segmentierung und Verfügbarkeit |

## Roter Faden / Common Thread

**DE:** Alle vier Tracks arbeiten mit KI-Agenten und Spec Kit als begleitendem SDD-Werkzeug. Ab dem 3. Lehrjahr wird erwartet, dass KI-gestützte Entwicklungsarbeit in oder mit `absdd-image-sandbox` geplant, genutzt oder begründet abgegrenzt wird. Die verbindliche Northwind-Datenbasis inklusive `ALFKI` bleibt in jedem Track prüfbar; SQL-Zugriffe müssen parametrisiert sein. Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente und acht Governance-Presets bleiben die lokale Nachweisbasis.

**EN:** All four tracks use AI agents and Spec Kit as a companion SDD tool. From the third training year onward, AI-assisted development is expected to be planned, used, or explicitly bounded with `absdd-image-sandbox`. The binding Northwind data base including `ALFKI` stays verifiable in every track; SQL access must be parameterized. The secure development guideline, 12 individual checklists, compendium, related documents, and eight governance presets remain the local evidence base.

## Nicht-Ziele / Non-Goals

- Kein Sammellauf für alle vier Fachinformatiker-Tracks.
- Keine automatische Repository-Erstellung.
- Keine Implementierung in diesem Level-0-Vorbereitungsschritt.
- Kein Ersatz für Rahmenlehrplan, Berufsschule, betriebliche Ausbildung, Ausbilderentscheidung oder Prüfungsvorbereitung.
- Keine produktiven Daten, keine echten personenbezogenen Daten und keine produktive Cloud-Nutzung.

## Copy-Paste Spec-Kit Prompt / Copy-Paste Spec Kit Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-Professional-Tracks-Lernreihe.md nur als 3.-Lehrjahr-Gesamtlandkarte. Starte daraus keinen Sammellauf. Wähle später im passenden Spezialisierungs-Repo ein konkretes Aufgaben-Lastenheft aus dem Application, Operations, Data & Process oder Digital Networking Track und erstelle dafür eine fokussierte Feature-Spezifikation. Die verbindliche Datenbasis ist die Northwind-Sample-Datenbank inklusive `ALFKI`; SQL-Zugriffe müssen parametrisiert sein.
```
