---
lang: de-DE
---

<!--
Markdown-Vorlage für eine PowerPoint-Präsentation.
Folientrennung: ---  |  Sprecher-/Vorbereitungsnotizen: ::: notes ... :::
Kompatibel u. a. mit Pandoc (PPTX), Marp und Slidev.
Stand: 2026-07-07
-->

# Secure OrderDesk v2

## Handels-Edition ab dem 2. Lehrjahr

EuFPA - Europäische Firma Programmiert Alles · Kundenfirma Secure Trader

Fachinformatiker*innen ab dem 2. Lehrjahr · DE-first/EN-second · CEFR B2 · WCAG 2.2 AA

::: notes
Diese Präsentation führt in die Lernreihe ein. Sie ersetzt keinen Spec-Kit-Lauf und legt keine Repositories an.
:::

---

# Warum diese Reihe?

- EuFPA möchte den bisherigen Secure OrderDesk von einem einfachen Bestell-Programm zu einer sauber geschnittenen relationalen Handelsplattform ausbauen. Die Reihe vertieft Architektur, Hosting, relationale Persistenz, Bestellannahme, API-/Service-Vertrag, Autorisierung, Audit-Logging, Betrieb, Konfiguration und MSL-Vergleich.
- Die Reihe vertieft sichere Entwicklung nach der Richtlinie und den Checklisten.
- Der fachliche Kernvertrag der Basis-Reihe - die Northwind-Bestelldomäne für Secure Trader inklusive `ALFKI` - bleibt gültig und wird technisch tiefer umgesetzt.
- C#, Go, Java, Python, Rust und Swift werden als MSL-Pfade vorbereitet; als C#-Referenz dient der OrderDesk-Referenzpfad.
- `absdd-image-sandbox` ist die öffentliche Sandbox-Referenz, im 2. Lehrjahr aber noch kein harter Pflichtlauf.

---

# Zielbild

- Klare Systemgrenzen zwischen Bestellannahme, Katalog, relationaler Ablage und Schnittstelle
- Plattformübergreifendes Hosting und ein sicher geführter Lebenszyklus
- Eine austauschbare Backend-Abstraktion über relationale Backends
- Sichere, ausschließlich parametrisierte SQL-Zugriffe
- Beobachtbarer Betrieb mit Logging, Health und einfachen Umsatz-/Bestell-Kennzahlen

::: notes
v2 macht aus dem kleinen Bestell-Beispiel eine tiefer geschnittene Plattform. Der fachliche Kernvertrag bleibt gleich, die technische Umsetzung wird sauberer und beobachtbarer.
:::

---

# Fachrichtungsbezug

| Fachrichtung | Fokus |
|---|---|
| AE | Architektur, Backend-Abstraktion, API-Vertrag, Fehler-/Response-Modell und Tests. |
| SI | Datenbank-Betrieb, Konfiguration, Secrets, Logging, Health, Monitoring und Nachweispfade. |
| DPA | Datenqualität in Bestellungen und Positionen, Umsatz-Kennzahlen, Datenschutz und Aussagegrenzen. |
| DV | Systemgrenzen, Schnittstellen der Bestell-Pipeline, Kommunikationsflüsse und Verfügbarkeit. |

---

# Architektur und Systemgrenzen

- Bestellannahme, Katalog, relationale Ablage und Schnittstelle sind bewusst getrennte Bausteine
- Trust Boundaries liegen an jeder Eingangsstelle: Eingaben gelten als nicht vertrauenswürdig
- Die Backend-Abstraktion kapselt den Datenzugriff und hält Fachlogik SQL-frei
- Defense in Depth: Validierung, parametrisierte Zugriffe und Autorisierung greifen ineinander
- Least Privilege und Fail-Safe Defaults sind architektonische Vorgaben, nicht Ad-hoc-Entscheidungen

::: notes
Sichere Architektur (Prinzip XIII) und sicherer Code (Prinzip XII) müssen zusammenwirken. Die Systemgrenzen sind der rote Faden der ersten Einheiten.
:::

---

# Datenbasis: Northwind und ALFKI

- Verbindliche Datenbasis bleibt die klassische **Northwind-Sample-Datenbank**
- Layout und Daten inklusive Pflicht-Datensatz **`ALFKI`**
- Original-Bestelldaten (~1996-1998), erweitert um fiktive Datensätze bis 2026
- Alle Daten sind fiktiv und werden markenneutral genutzt
- „Microsoft“ wird nur als historischer Quellhinweis erwähnt

::: notes
Der Datensatz `ALFKI` ist Pflicht, damit alle Sprachpfade denselben Bezugspunkt haben. Es dürfen keine echten personenbezogenen Daten oder Secrets verwendet werden.
:::

---

# Systemlandschaft Secure Trader

- **Secure OrderDesk**: die relationale Bestell-/Handelsplattform (diese Reihe)
- **Secure ServiceHarvester**: sammelt System-/Bestandsdaten der PCs und Server
- **Secure CaseTracker**: Support-Plattform für Support-Cases
- Die Verzahnung ist bewusst leicht: anreichernder Kontext, keine harte Abhängigkeit
- Jede Lernreihe bleibt eigenständig bearbeitbar

::: notes
EuFPA baut für Secure Trader drei ineinandergreifende, aber je eigenständige Systeme. v2 vertieft die OrderDesk-Ecke dieser Landschaft.
:::

---

# Relationales Persistenzmodell

- Persistenz liegt hinter einer klaren Abstraktion, nicht verstreut in der Fachlogik
- Relationale Backends werden bewusst gewechselt: SQLite, PostgreSQL, SQL Server
- Kunden, Produkte, Bestellungen und Positionen bleiben im Northwind-Layout
- Datenzugriffe sind ausschließlich parametrisiert (keine SQL-Injection)
- Migrationen und Schema-Entscheidungen bleiben nachvollziehbar dokumentiert

::: notes
Der austauschbare Backend-Schnitt ist ein zentraler Lernpunkt. Er zeigt, dass sich Fachlogik und Datenzugriff sauber trennen lassen.
:::

---

# Bestellannahme: Idempotenz und Import-Härtung

- Bestellannahme und Katalogzugriffe werden idempotent gestaltet
- Wiederholte Läufe erzeugen keine Doppelbuchungen
- Eingaben werden an der Trust Boundary validiert und normalisiert
- Import-Pfade sind gegen fehlerhafte, unvollständige oder bösartige Daten gehärtet
- Fehlerfälle führen in einen sicheren Zustand, nicht in halbfertige Bestellungen

::: notes
Idempotenz und Import-Härtung sind der Kern robuster Bestellannahme. Negative Tests gehören hier ausdrücklich dazu.
:::

---

# API- und Service-Vertrag

- Ein klarer API-/Service-Vertrag beschreibt Ein- und Ausgaben eindeutig
- OpenAPI dokumentiert den Vertrag maschinen- und menschenlesbar
- Ein einheitliches Fehler-, Validierungs- und Response-Modell trägt durch alle Endpunkte
- Fehlermeldungen geben keine internen Details, Stack-Traces oder Verbindungszeichenketten preis
- Rollen `learner`, `developer` und `reviewer` steuern den Zugriff (Least Privilege)

::: notes
Der Vertrag ist die Außensicht der Plattform. Saubere Fehlerbehandlung ohne interne Details ist eine bewusste Sicherheitsentscheidung.
:::

---

# Betrieb, Logging, Health und Monitoring

- Strukturiertes Logging ohne Secrets und ohne Kundendaten im Klartext
- Health-/Status-Endpunkte machen den Zustand sichtbar
- Einfache Umsatz-/Bestell-Metriken unterstützen Betrieb und Auswertung
- Sichere Konfiguration: Secrets in geeigneten Stores, nie im Quellcode oder in Git
- Betriebsnachweise belegen, dass der Betrieb prüfbar und nachvollziehbar ist

::: notes
Sichere Entwicklung endet nicht beim Code. Beobachtbarer Betrieb und saubere Konfiguration sind Teil des Nachweises.
:::

---

# Aufgabenfolge

- 01: Architekturzielbild und Systemgrenzen
- 02: Plattformübergreifendes Hosting und Lebenszyklus
- 03: Relationales Persistenzmodell und Backend-Abstraktion
- 04: Bestellannahme: Idempotenz und Import-Härtung
- 05: API- und Service-Vertrag und OpenAPI
- 06: Fehler-, Validierungs- und Response-Modell
- 07: Rollen-, Autorisierung und Audit-Logging
- 08: Betrieb, Logging, Health und Monitoring
- 09: Sichere Konfiguration, Secrets und Betriebsnachweise
- 10: MSL-Vergleich und Abschlussreview

---

# MSL-Vergleich

- C#, Go, Java, Python, Rust und Swift werden als MSL-Pfade umgesetzt
- Alle sechs Sprachen gelten in dieser Reihe als Memory-Safe Languages
- MSL reduziert bestimmte Speicherfehler
- MSL ersetzt keine Prüfung von Eingaben, SQL, I/O, Auth, Crypto, Logging oder Dependencies
- Die Umsetzungen bleiben sprachneutral vergleichbar; das Verhalten muss übereinstimmen

::: notes
Gerade bei einer relationalen Domäne zeigt sich, dass MSL keine vollständige Sicherheitsgarantie ist. SQL-Sicherheit muss in jeder Sprache sauber sein.
:::

---

# Nachweise

- Richtlinie Sichere Entwicklung
- 12 Einzel-Checklisten und Checklistensammelband
- mitgeltende Dokumente
- sechs Governance-Presets
- `Applicable`, `N/A`, `Open` mit Begründung
- Sandbox-Entscheidung: `Applicable`, `N/A` oder `Open`
- IDE-Arbeit außerhalb der Sandbox bleibt zulässig

---

# Startpunkt für später

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk-v2_01_Architekturzielbild-und-Systemgrenzen.md als verbindliche Eingabedatei. Erstelle eine fokussierte Feature-Spezifikation für die erste Aufgabe der Lernreihe Secure OrderDesk v2. Die Datenbasis ist Northwind inklusive ALFKI. Erzeuge keine Implementierung.
```

::: notes
Der Prompt ist ein Beispiel für den ersten späteren Einzel-Lauf. Lehrende oder Lernende starten diesen Lauf bewusst manuell im passenden Sprach-Repo.
:::
