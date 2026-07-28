# IT-Berufe und Secure OrderDesk / IT Occupations and Secure OrderDesk

**Stand / Date:** 2026-07-28

## Zweck / Purpose

**DE:** Diese Matrix ordnet die Secure-OrderDesk-Lernreihen den IT-Ausbildungsberufen nach der Neuordnung 2020 zu. Sie ist ein didaktischer Einstieg für Lehrende. Sie ersetzt keine Ausbildungsordnung, keinen Rahmenlehrplan, keine Berufsschule, keine betriebliche Ausbildung und keine Prüfungsvorbereitung.

**EN:** This matrix maps the Secure OrderDesk learning series to the IT training occupations after the 2020 reform. It is a didactic entry point for instructors. It does not replace training regulations, vocational school, workplace training, or exam preparation.

## Fachinformatiker*innen / IT Specialists

| Beruf / Fachrichtung | Passende Secure-OrderDesk-Pfade | Schwerpunkt im Lernprojekt |
|---|---|---|
| Fachinformatiker/-in Anwendungsentwicklung (FI/AE) | Basis, v2, Application Track | Domänenmodell, Feature-/API-Entwicklung, relationale Persistenz, parametrisierte Queries, Tests, sichere Schnittstellen |
| Fachinformatiker/-in Systemintegration (FI/SI) | Basis, v2, Operations Track | Datenbank-Betrieb, Laufzeit, Konfiguration, CI/CD, Backup/Restore, Monitoring, Supply Chain |
| Fachinformatiker/-in Daten- und Prozessanalyse (FI/DPA) | Basis, v2, Data & Process Track | Datenqualität der Bestell-/Kundendaten, Kennzahlen, Umsatzauswertungen, Datenschutz, Aussagegrenzen |
| Fachinformatiker/-in Digitale Vernetzung (FI/DV) | Basis, v2, Digital Networking Track | Schnittstellen der Bestell-Pipeline, Kommunikationsflüsse, Segmentierung, Verfügbarkeit, Betriebsnachweise |

## Weitere IT-Berufe / Additional IT Occupations

| Ausbildungsberuf | Geeignete Lernpfade | Didaktischer Zuschnitt |
|---|---|---|
| IT-System-Elektroniker/-in | Operations Track, Digital Networking Track | Geräte, Netzwerke, Datenbank-Inbetriebnahme, Sicherheitsprüfung, Betriebs- und Übergabenachweise |
| Kaufmann/-frau für IT-System-Management | Basis, ausgewählte Application-/Operations-Aufgaben | Kundenanforderungen der Handelsfirma, Services, Bestellprozesse, Verträge, Kosten/Nutzen und Übergabe |
| Kaufmann/-frau für Digitalisierungsmanagement | Data & Process Track, ausgewählte v2-Aufgaben | Geschäftsprozesse im Handel, Datenbedarf, Umsatz-/Betriebskennzahlen, Datenschutz, Wirtschaftlichkeit |

## ITSE als eigenständiger Lernpfad / ITSE as a Dedicated Learning Path

**DE:** Secure OrderDesk ist ein begrenzter ergänzender ITSE-Kontext. Der Pfad
nutzt passende Aufgaben zu Arbeitsplatz, Netzwerk, Datenbank-Inbetriebnahme,
Schutzbedarf und technischer Übergabe, übernimmt aber nicht die vollständige
ITSE-Professional-Reihe. Der Vergleich umfasst alle vier FI-Fachrichtungen;
FI/SI und FI/DV liefern die engsten Betriebsbezüge, FI/AE und FI/DPA die
Software-, Daten- und Diagnoseperspektive. C# unterstützt Simulation und
Tests, ersetzt aber keine beaufsichtigte elektrotechnische Praxis.

Die Positionen 26 bis 32 der zentralen Intake-Reihenfolge bestimmen den
ITSE-Umfang und den kontrollierten C#-Rollout. Position 33 prüft anschließend
die Konsistenz mit FI, KITSM und KDM. Diese Vorbereitung startet keinen
Spec-Kit- oder Lernendenlauf.

**EN:** Secure OrderDesk is a bounded supporting ITSE context. It uses suitable
tasks for workplaces, networks, database commissioning, protection needs, and
technical handover, but does not receive the complete ITSE professional
series. Comparison covers all four IT-specialist tracks; FI/SI and FI/DV
provide the closest operational relations, while FI/AE and FI/DPA provide the
software, data, and diagnostic perspectives. C# supports simulation and tests
but does not replace supervised electrical practice.

Positions 26 through 32 define the ITSE scope and controlled C# rollout.
Position 33 then checks consistency with FI, KITSM, and KDM. This preparation
starts no Spec Kit or learner run.

## Kaufmännische Berufsrollen im agentischen SDD / Commercial IT Roles in Agentic SDD

**DE:** KITSM und KDM arbeiten an derselben Secure-OrderDesk-Plattform wie die
Fachinformatiker-Fachrichtungen, aber in der Rolle **Auftraggeber:in und Abnehmer:in**. Wie viel
Programmierung dazugehört, beschreibt die
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md):
Der Beitrag liegt auf Spezifikation, Governance und Abnahme; der Agent trägt den imperativen Code.
Die relationale Handels-/Bestell-Domäne mit SQL-Sicherheit und Umsatzauswertungen macht OrderDesk
besonders **KDM-nah** (Datenbedarf, Kennzahlen).

**EN:** KITSM and KDM work on the same Secure OrderDesk platform as the IT-specialist directions, but
in the role of **client and acceptor**. How much programming this involves is described in the
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md):
the contribution is on specification, governance, and acceptance; the agent carries the imperative
code. The relational trading/ordering domain with SQL security and revenue reporting makes OrderDesk
especially **close to KDM** (data needs, key figures).

| Beruf | Programmieranteil / Authoring | Pflicht-Touch (aktiv) | Beispiel-Units OrderDesk |
|---|---|---|---|
| KITSM | ~5–10 % | Konfig-/Parameter-Änderung plus minimaler SQL-Schreib-Touch | 01 Kundenauftrag/Scope, 06 Persistenz-SQL, 11 Review/Übergabe |
| KDM | ~15–25 % | SQL-Authoring für eine Kennzahl (parametrisiert) | 06 Persistenz-SQL, 10 Auswertungen/Kennzahlen, Data-&-Process-Track 03 |

**DE:** Verbindlich für beide: der SQL-Schreib-Pflicht-Touch (mindestens ein aktiver, parametrisierter
Schritt) und die evidenzbasierte Abnahme mit einer bewusst eingebauten Abweichung, die gefunden werden
muss. Details je Einheit stehen im Abschnitt „Kaufmännische Rollen-Umschaltung" der betroffenen
Lernbegleiter.

**EN:** Binding for both: the mandatory SQL write touch (at least one active, parameterized step) and
evidence-based acceptance with a deliberately built-in deviation that must be found. Per-unit details
are in the "Commercial Role Switch" section of the affected study companions.

## Besondere Eignung dieser Familie / Particular Fit of This Family

**DE:** Die Secure-OrderDesk-Familie hat durch ihren Fokus auf eine relationale Bestell-/Handelsplattform, SQL-Sicherheit und Auswertungen eine besonders starke Nähe zu **Anwendungsentwicklung** und **Daten- und Prozessanalyse**. Systemintegration findet ihren Schwerpunkt im Datenbank-Betrieb und in der Betriebssicherheit; Digitale Vernetzung in den Schnittstellen der Bestell-Pipeline. Der durchgehende Faden über alle drei Lehrjahre ist das verantwortliche Arbeiten mit KI-Agenten und Spec Kit. Die verbindliche Datenbasis ist die klassische Northwind-Sample-Datenbank (Kundenfirma Secure Trader, Pflicht-Datensatz `ALFKI`).

**EN:** Because of its focus on a relational ordering/trading platform, SQL security, and reporting, the Secure OrderDesk family is especially close to **Application Development** and **Data and Process Analysis**. System Integration finds its focus in database operation and operational security; Digital Networking in the interfaces of the order pipeline. The continuous thread across all three training years is responsible work with AI agents and Spec Kit. The binding data base is the classic Northwind sample database (client company Secure Trader, mandatory record `ALFKI`).

## Nutzung im Unterricht / Classroom Use

- **DE:** Spec-Kit-Läufe werden pro Aufgabe und Repo bewusst gestartet. Sie begleiten Analyse, Planung, Umsetzung und Review, ersetzen aber nicht das Erlernen des Berufsbildes.
- **DE:** Lehrende wählen Aufgaben passend zur Klasse, zum Betriebskontext und zum Ausbildungsstand aus.
- **DE:** Nicht jede Aufgabe ist für jeden Beruf gleich tief. Ein Mapping "passend" bedeutet Eignung, nicht Pflichtumfang.
- **DE:** Die sechs MSL-Sprachpfade sind Vergleichs- und Lernpfade; der Berufsbildbezug entsteht durch Aufgabenwahl, Nachweise und Reviewfragen.
- **EN:** Spec Kit runs are started deliberately per task and repository. They support analysis, planning, implementation, and review but do not replace learning the occupation.

## Quellenhinweis / Source Note

**DE:** Berufsbildbezeichnungen und 2020-Neuordnung werden bei fachlicher Aktualisierung gegen offizielle Quellen wie BIBB Berufesuche, BIBB "Ausbildung gestalten", BERUFENET und die einschlägigen Ausbildungsordnungen geprüft. Die relationale Datenbasis geht auf die klassische Northwind-Traders-Sample-Datenbank (historisch als Microsoft-Beispiel bekannt) zurück und wird markenneutral, rein didaktisch genutzt. Relevante öffentliche Einstiegspunkte sind:

- BIBB Fachinformatiker/Fachinformatikerin: <https://www.bibb.de/dienst/berufesuche/de/index_berufesuche.php/profile/apprenticeship/80000?page=3>
- BIBB IT-System-Elektroniker/-in: <https://www.bibb.de/dienst/publikationen/de/16664>
- KMK-Rahmenlehrplan FI/ITSE: <https://www.kmk.org/service/servicebereich-berufliche-schulen/downloadbereich-rahmenlehrplaene?tx_fedownloads_single%5Baction%5D=forceDownload&tx_fedownloads_single%5Bcontroller%5D=Downloads&tx_fedownloads_single%5Bdownload%5D=45009&type=150>
- BIBB Verzeichnis der anerkannten Ausbildungsberufe 2026: <https://www.bibb.de/dienst/publikationen/de/21008>
