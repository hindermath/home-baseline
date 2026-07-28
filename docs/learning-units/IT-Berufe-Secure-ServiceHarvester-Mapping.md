# IT-Berufe und Secure ServiceHarvester / IT Occupations and Secure ServiceHarvester

**Stand / Date:** 2026-07-28

## Zweck / Purpose

**DE:** Diese Matrix ordnet die Secure-ServiceHarvester-Lernreihen den IT-Ausbildungsberufen nach der Neuordnung 2020 zu. Sie ist ein didaktischer Einstieg für Lehrende. Sie ersetzt keine Ausbildungsordnung, keinen Rahmenlehrplan, keine Berufsschule, keine betriebliche Ausbildung und keine Prüfungsvorbereitung.

**EN:** This matrix maps the Secure ServiceHarvester learning series to the IT training occupations after the 2020 reform. It is a didactic entry point for instructors. It does not replace training regulations, vocational school, workplace training, or exam preparation.

## Fachinformatiker*innen / IT Specialists

| Beruf / Fachrichtung | Passende Secure-ServiceHarvester-Pfade | Schwerpunkt im Lernprojekt |
|---|---|---|
| Fachinformatiker/-in Anwendungsentwicklung (FI/AE) | Basis, v2, Application Track | Domänenmodell, Feature-/API-Entwicklung, Persistenz-Adapter, Tests, sichere Schnittstellen |
| Fachinformatiker/-in Systemintegration (FI/SI) | Basis, v2, Operations Track | Dienst-Hosting, Laufzeit, Konfiguration, Betrieb, CI/CD, Observability, Recovery, Supply Chain |
| Fachinformatiker/-in Daten- und Prozessanalyse (FI/DPA) | Basis, v2, Data & Process Track | Datenqualität im Harvester, Kennzahlen, Datenschutz, Reporting, Aussagegrenzen |
| Fachinformatiker/-in Digitale Vernetzung (FI/DV) | Basis, v2, Digital Networking Track | Maschinen-/Netzbezüge, Schnittstellen, Kommunikationsflüsse, Segmentierung, Verfügbarkeit, Betriebsnachweise |

## Weitere IT-Berufe / Additional IT Occupations

| Ausbildungsberuf | Geeignete Lernpfade | Didaktischer Zuschnitt |
|---|---|---|
| IT-System-Elektroniker/-in | Operations Track, Digital Networking Track | Geräte, Netzwerke, Dienst-Inbetriebnahme, Sicherheitsprüfung, Betriebs- und Übergabenachweise |
| Kaufmann/-frau für IT-System-Management | Basis, ausgewählte Application-/Operations-Aufgaben | Kundenanforderungen, Services, Serviceanfragen, Verträge, Kosten/Nutzen und Übergabe |
| Kaufmann/-frau für Digitalisierungsmanagement | Data & Process Track, ausgewählte v2-Aufgaben | Geschäftsprozesse, Datenbedarf, Betriebskennzahlen, Datenschutz, Wirtschaftlichkeit |

## ITSE als eigenständiger Lernpfad / ITSE as a Dedicated Learning Path

**DE:** Secure ServiceHarvester ist der vollständige technische
Referenzkontext für die vorbereitete ITSE-Lernreihe. Der ITSE-Pfad vergleicht
mit allen vier FI-Fachrichtungen: FI/SI und FI/DV liefern die engsten
Betriebs-, Netzwerk- und Cyber-Physical-Bezüge; FI/AE und FI/DPA bleiben für
Softwareanpassung, Diagnose, Telemetrie und Messdatenauswertung sichtbar. C#
dient als Referenzsprache für Simulation, Diagnose und Tests. Elektrische
Schalt-, Mess- und Inbetriebnahmearbeit bleibt beaufsichtigte Fachpraxis und
wird niemals von einem KI-Agenten ausgeführt.

Die Positionen 26 bis 32 der zentralen Intake-Reihenfolge bereiten den
dreijährigen ITSE-Pfad und seinen kontrollierten C#-Rollout vor. Position 33
prüft danach die Konsistenz mit FI, KITSM und KDM. Diese Vorbereitung startet
keinen Spec-Kit- oder Lernendenlauf.

**EN:** Secure ServiceHarvester is the complete technical reference context for
the prepared ITSE learning series. The ITSE path compares with all four
IT-specialist tracks: FI/SI and FI/DV provide the closest operations, network,
and cyber-physical relations; FI/AE and FI/DPA remain visible for software
adaptation, diagnostics, telemetry, and measurement-data evaluation. C# is the
reference language for simulation, diagnostics, and tests. Electrical
switching, measurement, and commissioning remain supervised professional
practice and are never performed by an AI agent.

Positions 26 through 32 prepare the three-year ITSE path and its controlled C#
rollout. Position 33 then checks consistency with FI, KITSM, and KDM. This
preparation starts no Spec Kit or learner run.

## Kaufmännische Berufsrollen im agentischen SDD / Commercial IT Roles in Agentic SDD

**DE:** KITSM und KDM arbeiten an derselben Secure-ServiceHarvester-Familie wie die
Fachinformatiker-Fachrichtungen, aber in der Rolle **Auftraggeber:in und Abnehmer:in**. Wie viel
Programmierung dazugehört, beschreibt die
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md):
Der Beitrag liegt auf Spezifikation, Governance und Abnahme; der Agent trägt den imperativen Code.
Der Fokus auf Dienst-/Worker-Betrieb, Serviceanfragen und Betriebsnachweise macht ServiceHarvester
besonders **KITSM-nah** (Services, Verträge, Kosten/Nutzen, Übergabe).

**EN:** KITSM and KDM work on the same Secure ServiceHarvester family as the IT-specialist directions,
but in the role of **client and acceptor**. How much programming this involves is described in the
[`Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`](Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md):
the contribution is on specification, governance, and acceptance; the agent carries the imperative
code. The focus on service/worker operation, service requests, and operational evidence makes
ServiceHarvester especially **close to KITSM** (services, contracts, cost/benefit, handover).

| Beruf | Programmieranteil / Authoring | Pflicht-Touch (aktiv) | Beispiel-Units ServiceHarvester |
|---|---|---|---|
| KITSM | ~5–10 % | Konfig-/Parameter-Änderung plus minimaler SQL-Schreib-Touch | 01 Kundenauftrag/Dienstidee, 06 Persistenz/Import-Export, 11 Review/Übergabe |
| KDM | ~15–25 % | SQL-Authoring für eine Kennzahl (parametrisiert) | 06 Persistenz/Import-Export, 10 Betriebssicht/Kennzahlen, Data-&-Process-Track 03 |

**DE:** Verbindlich für beide: der SQL-Schreib-Pflicht-Touch (mindestens ein aktiver, parametrisierter
Schritt) und die evidenzbasierte Abnahme mit einer bewusst eingebauten Abweichung, die gefunden werden
muss. Details je Einheit stehen im Abschnitt „Kaufmännische Rollen-Umschaltung" der betroffenen
Lernbegleiter.

**EN:** Binding for both: the mandatory SQL write touch (at least one active, parameterized step) and
evidence-based acceptance with a deliberately built-in deviation that must be found. Per-unit details
are in the "Commercial Role Switch" section of the affected study companions.

## Besondere Eignung dieser Familie / Particular Fit of This Family

**DE:** Die Secure-ServiceHarvester-Familie hat durch ihren Fokus auf einen langlaufenden Dienst, Sammeln, Persistenz und Betrieb eine besonders starke Nähe zu **Systemintegration** und **Digitaler Vernetzung**. Anwendungsentwicklung findet ihren Schwerpunkt in Feature-, API- und Adapter-Entwicklung; Daten- und Prozessanalyse in der ehrlichen Auswertung der gesammelten Daten. Der durchgehende Faden über alle drei Lehrjahre ist das verantwortliche Arbeiten mit KI-Agenten und Spec Kit.

**EN:** Because of its focus on a long-running service, collection, persistence, and operation, the Secure ServiceHarvester family is especially close to **System Integration** and **Digital Networking**. Application Development finds its focus in feature, API, and adapter development; Data and Process Analysis in the honest evaluation of the collected data. The continuous thread across all three training years is responsible work with AI agents and Spec Kit.

## Nutzung im Unterricht / Classroom Use

- **DE:** Spec-Kit-Läufe werden pro Aufgabe und Repo bewusst gestartet. Sie begleiten Analyse, Planung, Umsetzung und Review, ersetzen aber nicht das Erlernen des Berufsbildes.
- **DE:** Lehrende wählen Aufgaben passend zur Klasse, zum Betriebskontext und zum Ausbildungsstand aus.
- **DE:** Nicht jede Aufgabe ist für jeden Beruf gleich tief. Ein Mapping "passend" bedeutet Eignung, nicht Pflichtumfang.
- **DE:** Die sechs MSL-Sprachpfade sind Vergleichs- und Lernpfade; der Berufsbildbezug entsteht durch Aufgabenwahl, Nachweise und Reviewfragen.
- **EN:** Spec Kit runs are started deliberately per task and repository. They support analysis, planning, implementation, and review but do not replace learning the occupation.

## Quellenhinweis / Source Note

**DE:** Berufsbildbezeichnungen und 2020-Neuordnung werden bei fachlicher Aktualisierung gegen offizielle Quellen wie BIBB Berufesuche, BIBB "Ausbildung gestalten", BERUFENET und die einschlägigen Ausbildungsordnungen geprüft. Relevante öffentliche Einstiegspunkte sind:

- BIBB Fachinformatiker/Fachinformatikerin: <https://www.bibb.de/dienst/berufesuche/de/index_berufesuche.php/profile/apprenticeship/80000?page=3>
- BIBB IT-System-Elektroniker/-in: <https://www.bibb.de/dienst/publikationen/de/16664>
- KMK-Rahmenlehrplan FI/ITSE: <https://www.kmk.org/service/servicebereich-berufliche-schulen/downloadbereich-rahmenlehrplaene?tx_fedownloads_single%5Baction%5D=forceDownload&tx_fedownloads_single%5Bcontroller%5D=Downloads&tx_fedownloads_single%5Bdownload%5D=45009&type=150>
- BIBB Verzeichnis der anerkannten Ausbildungsberufe 2026: <https://www.bibb.de/dienst/publikationen/de/21008>
