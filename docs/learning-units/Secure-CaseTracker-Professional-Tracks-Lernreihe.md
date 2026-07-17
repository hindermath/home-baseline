# Secure CaseTracker Professional Tracks Lernreihe / Learning Series

**Stand / Date:** 2026-07-05
**Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
**Zielgruppe / Audience:** Fachinformatiker*innen ab dem 3. Lehrjahr / IT specialist apprentices from the third training year onward
**Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
**Ausrichtung / Orientation:** DE-first, EN-second, CEFR B2, WCAG 2.2 AA

## Zielbild / Target Picture

**DE:** Die Professional Tracks führen `Secure CaseTracker` im 3. Lehrjahr fort. Der gemeinsame fachliche Kern bleibt erhalten, aber die Lernenden spezialisieren sich sichtbar auf AE, SI, DPA oder DV.

**EN:** The Professional Tracks continue `Secure CaseTracker` in the third training year. The shared domain stays the same, but learners specialize visibly into Application Development, System Integration, Data and Process Analysis, or Digital Networking.

## Track-Übersicht / Track Overview

| Track | Lernreihe | Spezialisierung | Schwerpunkt |
|---|---|---|---|
| AE | [Secure CaseTracker Application Track](Secure-CaseTracker-Application-Track-Lernreihe.md) | AE - Anwendungsentwicklung | Feature-Entwicklung, Architektur, sichere APIs, Persistenz, Tests und wartbare Erweiterbarkeit |
| SI | [Secure CaseTracker Operations Track](Secure-CaseTracker-Operations-Track-Lernreihe.md) | SI - Systemintegration | Betrieb, Härtung, CI/CD, Sandbox, Observability, Recovery und Betriebsnachweise |
| DPA | [Secure CaseTracker Data & Process Track](Secure-CaseTracker-Data-Process-Track-Lernreihe.md) | DPA - Daten- und Prozessanalyse | Datenqualität, Datenschutz, Kennzahlen, Reporting, Prozessfeedback und Aussagegrenzen |
| DV | [Secure CaseTracker Digital Networking Track](Secure-CaseTracker-Digital-Networking-Track-Lernreihe.md) | DV - Digitale Vernetzung | Systemkontext, Schnittstellen, Kommunikationsflüsse, Segmentierung, Verfügbarkeit und Betriebsnachweise |

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

## Sandbox und Arbeitswerkzeuge / Sandbox and Work Tools

**DE:** Die Sandbox ist das Referenzprofil für KI-Agenten, reproduzierbare Toolchains, Schreibgrenzen, Netzwerkgrenzen und Nachweise. Normale IDE-Arbeit, Lesen, Review, Dokumentation und Bedienung von JetBrains IDEs, VS Code oder Windows-only Visual Studio können außerhalb der Sandbox stattfinden. Wird im 3. Lehrjahr außerhalb der Sandbox mit KI-Agenten geschrieben, muss die Abweichung begründet und als Risiko oder `N/A` dokumentiert werden.

**EN:** The sandbox is the reference profile for AI agents, reproducible toolchains, write boundaries, network boundaries, and evidence. Normal IDE work, reading, review, documentation, and use of JetBrains IDEs, VS Code, or Windows-only Visual Studio may happen outside the sandbox. If third-year AI-assisted write work happens outside the sandbox, the deviation must be justified and documented as a risk or `N/A`.

## Jahr-2-Baseline und Track-Ableitung / Year-2 Baseline and Track Derivation

**DE:** Die Jahr-3-Tracks starten aus einem abgeschlossenen Jahr-2-Stand, nicht aus einem leeren Projekt. Der empfohlene Bezugspunkt ist der Tag `learning/year-2-complete` im jeweiligen Sprachrepo. Der Jahr-2-Stand dokumentiert `YEAR2_BASELINE.md`; ein später abgeleiteter Track dokumentiert `TRACK_BASELINE.md` mit Herkunftsrepo, Herkunfts-Commit, Sprache, Track-Ziel, übernommenen Nachweisen und bewusst offenen Punkten.

**EN:** The year-3 tracks start from a completed year-2 state, not from an empty project. The recommended reference point is the tag `learning/year-2-complete` in the respective language repository. The year-2 state documents `YEAR2_BASELINE.md`; a later derived track documents `TRACK_BASELINE.md` with source repository, source commit, language, track target, inherited evidence, and intentionally open points.

**DE:** Ein Plattform-Fork ist möglich, wenn die Plattformhistorie sichtbar bleiben soll. Für die Ausbildung reicht häufig eine geschützte Baseline mit Tag und ein abgeleitetes Track-Repo oder eine Track-Kopie. Es werden nur die wirklich benötigten Track-/Sprachkombinationen vorbereitet.

**EN:** A platform-native fork is possible when the platform history should stay visible. For training, a protected baseline with a tag and a derived track repository or track copy is often sufficient. Only the actually needed track/language combinations are prepared.

## Abgrenzung zu Jahr 1 und Jahr 2 / Relation to Earlier Years

**DE:** Jahr 1 vermittelt Grundlagen und einfache Nachweise. Jahr 2 vertieft Architektur, Persistenz, Schnittstellen, Tests und Betrieb. Jahr 3 trennt die Arbeit nach Spezialisierung und verlangt stärkere Trade-off-Begründungen, Review-Nachweise und Abschlussbewertungen.

**EN:** Year 1 teaches foundations and simple evidence. Year 2 deepens architecture, persistence, interfaces, tests, and operation. Year 3 separates the work by specialization and requires stronger trade-off reasoning, review evidence, and final assessments.

<!-- lernbegleiter-verweis -->
## Lernbegleiter und Lernfeldbezug / Study Companions and Learning-Field Relation

**DE:** Zu jeder Aufgaben-Einheit dieser Reihe gibt es einen ausführlichen Lernbegleiter unter [`lernbegleiter/`](lernbegleiter/). Er erklärt das Thema (CEFR B2), nennt Kernbegriffe, geht Schritt für Schritt vor und enthält Verständnisfragen mit Musterantworten. Die konkreten Lernfelder je Einheit stehen in der [Rahmenlehrplan-Lernfeld-Zuordnung](Rahmenlehrplan-Lernfeld-Mapping.md). Die Lastenhefte bleiben schlanke Spec-Kit-Intakes; die Erklärtiefe liegt im Lernbegleiter. Das Zusatzmaterial ersetzt nicht Berufsschule, betriebliche Ausbildung, Rahmenlehrplan oder Prüfungsvorbereitung.

**EN:** Every task unit of this series has a detailed study companion under [`lernbegleiter/`](lernbegleiter/). It explains the topic (CEFR B2), names key terms, proceeds step by step, and includes comprehension questions with model answers. The concrete learning fields per unit are documented in the [curriculum learning-field mapping](Rahmenlehrplan-Lernfeld-Mapping.md). The intake files stay lean Spec Kit intakes; the explanatory depth lives in the companion. This additional material does not replace vocational school, workplace training, the curriculum, or exam preparation.
