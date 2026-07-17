# Secure OrderDesk Professional Tracks Lernreihe / Learning Series

**Stand / Date:** 2026-07-07
**Übungsfirma / Training company:** EuFPA – Europäische Firma Programmiert Alles
**Kundenfirma / Client company:** Secure Trader (fiktive Handelsfirma / fictional trading company)
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 3. Lehrjahr / IT specialist apprentices from the third training year onward
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Einordnung in die Familie / Placement in the Family

**DE:** Diese Datei beschreibt die **Professional Tracks (3. Lehrjahr)** der Familie **Secure OrderDesk**. Sie führen die [Basis-Reihe (Jahr 1)](Secure-OrderDesk-Lernreihe.md) und die [v2-Reihe (Jahr 2)](Secure-OrderDesk-v2-Lernreihe.md) fort und trennen die Arbeit nach Fachrichtung.

**EN:** This file describes the **Professional Tracks (year 3)** of the **Secure OrderDesk** family. They continue the [base series (year 1)](Secure-OrderDesk-Lernreihe.md) and the [v2 series (year 2)](Secure-OrderDesk-v2-Lernreihe.md) and separate the work by specialization.

## Zielbild / Target Picture

**DE:** Die Professional Tracks führen `Secure OrderDesk` im 3. Lehrjahr fort. Der gemeinsame fachliche Kern – die Northwind-Bestelldomäne für die Kundenfirma Secure Trader – bleibt erhalten, aber die Lernenden spezialisieren sich sichtbar auf AE, SI, DPA oder DV. Das Arbeiten mit KI-Agenten und Spec Kit wird ab Jahr 3 mit stärkeren Trade-off-Begründungen, Review-Nachweisen und Abschlussbewertungen verlangt.

**EN:** The Professional Tracks continue `Secure OrderDesk` in the third training year. The shared domain – the Northwind ordering domain for the client company Secure Trader – stays the same, but learners specialize visibly into Application Development, System Integration, Data and Process Analysis, or Digital Networking. From year 3, working with AI agents and Spec Kit requires stronger trade-off reasoning, review evidence, and final assessments.

## Track-Übersicht / Track Overview

| Track | Lernreihe | Spezialisierung | Schwerpunkt |
|---|---|---|---|
| AE | [Secure OrderDesk Application Track](Secure-OrderDesk-Application-Track-Lernreihe.md) | AE – Anwendungsentwicklung | Feature-/API-Erweiterung der Plattform, Persistenz-Adapter, Viewer/TUI, Tests und wartbare Erweiterbarkeit |
| SI | [Secure OrderDesk Operations Track](Secure-OrderDesk-Operations-Track-Lernreihe.md) | SI – Systemintegration | Datenbank-Betrieb, Deployment, CI/CD, Backup/Restore, Observability und Betriebsnachweise |
| DPA | [Secure OrderDesk Data & Process Track](Secure-OrderDesk-Data-Process-Track-Lernreihe.md) | DPA – Daten- und Prozessanalyse | Umsatz-/Bestell-Auswertungen, Datenqualität, Kennzahlen, Aussagegrenzen und Datenschutz |
| DV | [Secure OrderDesk Digital Networking Track](Secure-OrderDesk-Digital-Networking-Track-Lernreihe.md) | DV – Digitale Vernetzung | Schnittstellen der Bestell-Pipeline, Integration, Kommunikationsflüsse, Segmentierung und Verfügbarkeit |

## Gemeinsame Regeln / Shared Rules

- Kein Track startet automatisch einen Spec-Kit-Lauf.
- Jede spätere Umsetzung bleibt pro Track, pro Sprachpfad und pro Aufgaben-Lastenheft getrennt.
- Spec-Kit-Läufe begleiten die Aufgaben pro Lehrjahr, Track, Sprachpfad und Aufgaben-Lastenheft; sie ersetzen nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan, Ausbilderentscheidung oder Prüfungsvorbereitung.
- C#, Go, Java, Python, Rust und Swift bleiben die Standard-MSL-Pfade.
- Ab dem 3. Lehrjahr wird erwartet, dass KI-gestützte Entwicklungsarbeit in oder mit `absdd-image-sandbox` geplant, genutzt oder begründet abgegrenzt wird.
- Richtlinie Sichere Entwicklung, 12 Einzel-Checklisten, Checklistensammelband, mitgeltende Dokumente und sieben Governance-Presets werden als lokale Nachweisbasis erwartet.
- Positive Aussagen zur Sicherheit, Qualität oder Compliance brauchen konkrete Evidenz.
- Nicht anwendbare Punkte werden als `N/A` mit Begründung dokumentiert.

**EN:** From the third training year onward, AI-assisted development work is expected to be planned, used, or explicitly bounded with `absdd-image-sandbox`. The public reference repository is <https://github.com/hindermath/absdd-image-sandbox>.

## Jahr-2-Baseline und Track-Ableitung / Year-2 Baseline and Track Derivation

**DE:** Die Jahr-3-Tracks starten aus einem abgeschlossenen Jahr-2-Stand, nicht aus einem leeren Projekt. Der empfohlene Bezugspunkt ist der Tag `learning/year-2-complete` im jeweiligen Sprachrepo. Der Jahr-2-Stand dokumentiert `YEAR2_BASELINE.md`; ein später abgeleiteter Track dokumentiert `TRACK_BASELINE.md` mit Herkunftsrepo, Herkunfts-Commit, Sprache, Track-Ziel, übernommenen Nachweisen und bewusst offenen Punkten. Der Pflicht-Datensatz `ALFKI` bleibt in jedem Track prüfbar.

**EN:** The year-3 tracks start from a completed year-2 state, not from an empty project. The recommended reference point is the tag `learning/year-2-complete` in the respective language repository. The year-2 state documents `YEAR2_BASELINE.md`; a later derived track documents `TRACK_BASELINE.md` with source repository, source commit, language, track target, inherited evidence, and intentionally open points. The mandatory record `ALFKI` stays verifiable in every track.

## Abgrenzung zu Jahr 1 und Jahr 2 / Relation to Earlier Years

**DE:** Jahr 1 vermittelt Grundlagen der relationalen Bestelldomäne und einfache Nachweise. Jahr 2 vertieft Architektur, Hosting, relationale Persistenz, SQL-Sicherheit, Schnittstellen, Tests und Betrieb. Jahr 3 trennt die Arbeit nach Spezialisierung und verlangt stärkere Trade-off-Begründungen, Review-Nachweise und Abschlussbewertungen.

**EN:** Year 1 teaches foundations of the relational ordering domain and simple evidence. Year 2 deepens architecture, hosting, relational persistence, SQL safety, interfaces, tests, and operation. Year 3 separates the work by specialization and requires stronger trade-off reasoning, review evidence, and final assessments.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
