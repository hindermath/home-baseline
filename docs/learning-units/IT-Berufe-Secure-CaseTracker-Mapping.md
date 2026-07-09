# IT-Berufe und Secure CaseTracker / IT Occupations and Secure CaseTracker

**Stand / Date:** 2026-07-05

## Zweck / Purpose

**DE:** Diese Matrix ordnet die Secure-CaseTracker-Lernreihen den IT-Ausbildungsberufen nach der Neuordnung 2020 zu. Sie ist ein didaktischer Einstieg für Lehrende. Sie ersetzt keine Ausbildungsordnung, keinen Rahmenlehrplan, keine Berufsschule, keine betriebliche Ausbildung und keine Prüfungsvorbereitung.

**EN:** This matrix maps the Secure CaseTracker learning series to the IT training occupations after the 2020 reform. It is a didactic entry point for instructors. It does not replace training regulations, vocational school, workplace training, or exam preparation.

## Fachinformatiker*innen / IT Specialists

| Beruf / Fachrichtung | Passende Secure-CaseTracker-Pfade | Schwerpunkt im Lernprojekt |
|---|---|---|
| Fachinformatiker/-in Anwendungsentwicklung (FI/AE) | Secure CaseTracker, v2, Application Track | Domänenmodell, Implementierung, APIs, Tests, sichere Feature-Gates |
| Fachinformatiker/-in Systemintegration (FI/SI) | Secure CaseTracker, v2, Operations Track | Laufzeit, Toolchain, Betrieb, CI/CD, Monitoring, Recovery, Supply Chain |
| Fachinformatiker/-in Daten- und Prozessanalyse (FI/DPA) | Secure CaseTracker, v2, Data & Process Track, InventoryHub | Datenbedarf, Datenqualität, Kennzahlen, Datenschutz, Aussagegrenzen |
| Fachinformatiker/-in Digitale Vernetzung (FI/DV) | Secure CaseTracker, v2, Digital Networking Track, InventoryHub | Schnittstellen, Kommunikationsflüsse, Segmentierung, Verfügbarkeit, Netzwerk- und Betriebsnachweise |

## Weitere IT-Berufe / Additional IT Occupations

| Ausbildungsberuf | Geeignete Lernpfade | Didaktischer Zuschnitt |
|---|---|---|
| IT-System-Elektroniker/-in | Operations Track, Digital Networking Track, Secure InventoryHub | Geräte, Netzwerke, Inbetriebnahme, Sicherheitsprüfung, Betriebs- und Übergabenachweise |
| Kaufmann/-frau für IT-System-Management | Secure CaseTracker, Secure InventoryHub, ausgewählte Application-/Operations-Aufgaben | Kundenanforderungen, Angebote, Beschaffung, Services, Verträge, Kosten/Nutzen und Übergabe |
| Kaufmann/-frau für Digitalisierungsmanagement | Data & Process Track, Secure InventoryHub, ausgewählte v2-Aufgaben | Geschäftsprozesse, Digitalisierung, Datenbedarf, Kennzahlen, Datenschutz, Wirtschaftlichkeit |

## Kaufmännische Berufsrollen im agentischen SDD / Commercial IT Roles in Agentic SDD

**DE:** KITSM und KDM arbeiten an derselben Secure-CaseTracker-Familie wie die
Fachinformatiker-Fachrichtungen, aber in der Rolle **Auftraggeber:in und Abnehmer:in**. Wie viel
Programmierung dazugehört, beschreibt die
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md):
Der Beitrag liegt auf Spezifikation, Governance und Abnahme; der Agent trägt den imperativen Code.
Der Fokus auf Support-Cases, Beschaffung, Prozessanalyse und kundenverständliche Übergabe passt zu
beiden kaufmännischen Berufen (KITSM: Services/Übergabe; KDM: Datenbedarf/Kennzahlen).

**EN:** KITSM and KDM work on the same Secure CaseTracker family as the IT-specialist directions, but
in the role of **client and acceptor**. How much programming this involves is described in the
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md):
the contribution is on specification, governance, and acceptance; the agent carries the imperative
code. The focus on support cases, procurement, process analysis, and customer-friendly handover fits
both commercial occupations (KITSM: services/handover; KDM: data needs/key figures).

| Beruf | Programmieranteil / Authoring | Pflicht-Touch (aktiv) | Beispiel-Units CaseTracker |
|---|---|---|---|
| KITSM | ~5–10 % | Konfig-/Parameter-Änderung plus minimaler SQL-Schreib-Touch | 01 Kundenauftrag/Scope, 06 Persistenz/Import-Export, 11 Review/Übergabe |
| KDM | ~15–25 % | SQL-Authoring für eine Kennzahl (parametrisiert) | 06 Persistenz/Import-Export, 10 Prozessanalyse/Kennzahlen, Data-&-Process-Track 05 |

**DE:** Verbindlich für beide: der SQL-Schreib-Pflicht-Touch (mindestens ein aktiver, parametrisierter
Schritt) und die evidenzbasierte Abnahme mit einer bewusst eingebauten Abweichung, die gefunden werden
muss. Details je Einheit stehen im Abschnitt „Kaufmännische Rollen-Umschaltung" der betroffenen
Lernbegleiter.

**EN:** Binding for both: the mandatory SQL write touch (at least one active, parameterized step) and
evidence-based acceptance with a deliberately built-in deviation that must be found. Per-unit details
are in the "Commercial Role Switch" section of the affected study companions.

## Nutzung im Unterricht / Classroom Use

- **DE:** Spec-Kit-Läufe werden pro Aufgabe und Repo bewusst gestartet. Sie begleiten Analyse, Planung, Umsetzung und Review, ersetzen aber nicht das Erlernen des Berufsbildes.
- **DE:** Lehrende wählen Aufgaben passend zur Klasse, zum Betriebskontext und zum Ausbildungsstand aus.
- **DE:** Nicht jede Aufgabe ist für jeden Beruf gleich tief. Ein Mapping "hoch" bedeutet Eignung, nicht Pflichtumfang.
- **DE:** Die sechs MSL-Sprachpfade sind Vergleichs- und Lernpfade; der Berufsbildbezug entsteht durch Aufgabenwahl, Nachweise und Reviewfragen.
- **EN:** Spec Kit runs are started deliberately per task and repository. They support analysis, planning, implementation, and review but do not replace learning the occupation.

## Quellenhinweis / Source Note

**DE:** Berufsbildbezeichnungen und 2020-Neuordnung werden bei fachlicher Aktualisierung gegen offizielle Quellen wie BIBB Berufesuche, BIBB "Ausbildung gestalten", BERUFENET und die einschlägigen Ausbildungsordnungen geprüft. Relevante öffentliche Einstiegspunkte sind:

- BIBB Fachinformatiker/Fachinformatikerin: <https://www.bibb.de/dienst/berufesuche/de/index_berufesuche.php/profile/apprenticeship/80000?page=3>
- BIBB Kaufmann/Kauffrau für IT-System-Management: <https://www.bibb.de/dienst/berufesuche/de/index_berufesuche.php/profile/apprenticeship/dsafsf?page=3>
- BIBB Verzeichnis der anerkannten Ausbildungsberufe 2026: <https://www.bibb.de/dienst/publikationen/de/21008>
