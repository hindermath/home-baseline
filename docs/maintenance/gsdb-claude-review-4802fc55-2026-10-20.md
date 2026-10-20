# Erneute Prüfung von PR #337 (Head `4802fc55`)

**Ergebnis:** Alle sechs Befunde I01–I06 aus meinen früheren Berichten sind fachlich behoben, ebenso die meisten P3-Punkte. Ich finde keinen offenen P1- oder P2-Befund mehr. Es bleiben acht P3-Befunde: vier sind durch die Korrekturrunde neu entstanden, vier waren schon vorher da. Aus meiner Sicht kann der PR zur menschlichen Prüfung gehen; die P3-Punkte sollten vorher oder im selben Zug behoben werden. Freigaben leite ich daraus nicht ab: Alle vier menschlichen Entscheidungen bleiben Open.

## Kontext
- **System und Stand:** macOS (Darwin), Arbeitsbaum sauber. Lokaler Head und PR-Head sind beide `4802fc55d839…`, Base ist `63ab18d6…`. Der Head weicht nicht von der Vorgabe ab.
- **Gelesen:** der Teil-Diff `a943d7f9..4802fc55` (Dokumente und Skripte) vollständig, aus dem Gesamt-Diff in `pr.diff` die Guidance-Abschnitte (AGENTS/CLAUDE/GEMINI/Copilot) und die CI-Änderung, dazu alle fünf genannten Einstiegsdateien und die früheren Berichte.
- **CI am Head:** 17 von 18 Checks bestanden. „Assurance contracts (windows-2022)“ war beim letzten Abruf noch pending. Das ist kein fachliches Ergebnis.
- **Abweichungen von der Freigabeliste:** Einige reine Lese-Aufrufe mit `sed` liefen über die exakte Liste hinaus; die Umgebung hat sie zugelassen. Ein `awk/grep`-Aufruf wurde abgelehnt, ich habe ihn durch Grep/Read ersetzt. Geändert, kommentiert oder veröffentlicht habe ich nichts.

## Befunde (nach Schwere)

**P3-1 (neu) – Fehlerhafte Versionshistorien der Checklisten**
- **Fundstellen:**
  - `CL_08…md:15` nennt Version 2.0.3. Der neue Historieneintrag `:1595` heißt aber „Version 2.0.2 … Unabhängige Reviewkorrekturen“; einen Eintrag 2.0.3 gibt es nicht, obwohl CL-08-13 inhaltlich geändert wurde.
  - `CL_04:866`, `CL_05:1292`, `CL_06:1093`, `CL_10:1553`, `CL_12:556` und `CL_09:1511/1514` führen dieselbe Versionsnummer je zweimal mit unterschiedlichem Inhalt.
- **Auswirkung:** Die Änderungshistorie der kontrollierten Dokumente ist nicht eindeutig. Der Bericht behauptet für I03 dagegen reparierte Historien. Der Generator prüft Historien nicht.
- **Korrektur:** CL-08 bekommt einen Eintrag 2.0.3. Für Dokumente ohne Versionssprung das Muster der mitgeltenden Dokumente übernehmen: „Baseline-Bindung 3.4.3, redaktionell; Dokumentversion unverändert“.

**P3-2 (neu) – Kein Test deckt den Fall „korrektes Feld plus zusätzliches Duplikat“ ab**
- **Fundstellen:** `test-gsdb-consolidation.ps1:92-93` und `:122/:125`, geprüfte Logik in `build-secure-development-docs.sh:52/:96` und `.ps1:62/:105`.
- **Fehler:** Alle vier Duplikatfälle setzen zuerst das aktive Feld auf einen falschen Wert und hängen dann den richtigen an. Sie scheitern deshalb schon an `matched == 0`. Die Bedingung `count == 1` wird nie isoliert geprüft, und die Fehlermeldung „mismatch or duplicate“ unterscheidet die beiden Ursachen nicht.
- **Gegenprobe (nicht ausgeführt, weil kein Schreibzugriff):** Im Fixture `$source + "`n$de`n"` ohne Ersetzung erzeugen. Erwartet: Exit ≠ 0 mit „Active guideline metadata mismatch or duplicate: Richtlinie_Sichere-Entwicklung.md (Versionsnummer)“. Entfernt man testweise `count == 1 &&`, bleiben alle 30 vorhandenen Fälle grün, nur der neue Fall schlägt fehl. Dasselbe gilt für `baseline-`/`version-duplicate`.

**P3-3 (neu) – Memory-Safe Roadmaps → CL-08-12 ohne eigenen Text**
- **Fundstellen:** `CL_08:701-790` (CL-08-12 „Tests“) enthält weder MSL noch unsichere Grenzen. Die Verbindung entsteht nur durch einen Querverweis in CL-08-13 (`:1398-1399`). Trotzdem führen Matrix (`coverage…:106`), Quellenprotokoll (`:393-396`) und Verzahnung CL-08-12 als Träger.
- **Auswirkung:** Es ist derselbe Fehlertyp wie bei I02, nur in kleinerem Umfang. Der eigentliche MSL-Nachweis in CL-08-13 ist korrekt.
- **Korrektur:** Entweder in CL-08-12 Prüfungen für unsichere, FFI- und Nicht-MSL-Grenzen aufnehmen (Fuzzing, Sanitizer) oder CL-08-12 aus der Zuordnung streichen.

**P3-4 (neu) – Vorlagen der gemeinsamen Agenten-Guidance nicht angeglichen**
- **Fundstellen:** `scripts/templates/AGENTS.md.tmpl:202,217`, `CLAUDE.md.tmpl:192,207`, `GEMINI.md.tmpl:184,199`, `copilot-instructions.tmpl:181,196`. Sie pinnen weiter „Basis 3.1.0“.
- **Fehler:** Die fünf Level-0-Dateien wurden korrekt auf die manifestgebundene Formulierung umgestellt. Der Bericht (`gsdb-independent-fixes…:45`) suggeriert aber eine vollständig einheitliche Guidance.
- **Korrektur:** Die Vorlagen identisch anpassen oder die Vorlagengrenze ausdrücklich dokumentieren.

**P3-5 (verblieben) – Abdeckungsmatrix weicht weiter vom Quellenprotokoll ab**
- **Fehlende Quellen:**
  - CL-06-07 (`coverage:78`) nennt nur „CRA; CVD“. Der Text (`CL_06:631`) enthält aber DSGVO Art. 33, NIS2/BSIG und DORA, und das Protokoll ordnet NIS2/DORA CL-06-07 zu (`:312-315`, `:341-344`).
  - CL-09-13 und CL-10-12 (`:120`, `:136`) nennen die DSGVO nicht, obwohl Protokoll (`:448-450`) und Text es tun.
- **Zu pauschale Zuordnungen:** „TR-02102 (Reviewed)“ steht bei allen CL-03-Punkten (`:34-48`), auch beim HSM-/FIPS-Punkt CL-03-12. Laut Protokoll gehören nur 01/02/04/07/14/15 dazu. Ebenso steht „CRA (Reviewed)“ bei allen CL-06-Punkten, laut Protokoll gehören nur 07 und 09 dazu.
- **Korrektur:** Matrix und Protokoll je Prüfpunkt angleichen.

**P3-6 (verblieben) – CL-08-06 widerspricht der korrigierten TLS-Vorgabe CL-03-07**
- **Fundstelle:** `CL_08:359-381` und `:382-404`.
- **Fehler:** CL-08-06 verlangt „TLS 1.3 als Minimum (Fallback 1.2 nur mit AEAD)“ und nennt ChaCha20, Ed25519 und X25519 mit „Referenz BSI TR-02102-1“.
- **Gegenprobe:** Im Capture von TR-02102-1 (2026-01) kommen „chacha“ und „25519“ null Mal vor. CL-03-07 ist dagegen jetzt korrekt an TR-02102-2 ausgerichtet.
- **Korrektur:** Auf CL-03-07 verweisen und die abweichende Auswahl als lokale Policy kennzeichnen, wie es CL-03-02 schon tut.

**P3-7 (verblieben) – Wortlaut des geänderten KI-VO Art. 4**
- **Primärquelle:** Art. 4 in der Fassung (EU) 2026/1744 (Capture `ai.txt:554`, Änderungsakt `ai-amendment.txt:470`) lautet: „take measures to support the development of AI literacy … does not require … guarantee any specific level“.
- **Fehler:**
  - CL-01-12 (`:624-625`) sagt verkürzt „Maßnahmen zur KI-Kompetenz“.
  - CL-09-12 (`CL_09:1031-1035`, Akzeptanz `:1075-1078`) verbindet lokale Schwellen mit „EU AI Act Art. 4“: Zugriff erst nach Schulung und ≥ 95 % Erfüllungsquote. Dass es sich um lokale Vorgaben handelt, steht dort nicht.
- **Korrektur:** Den geänderten Wortlaut übernehmen und die Schwellen in CL-09-12 als lokale Baseline-Regel kennzeichnen.

**P3-8 (neu, gering) – CL-07-12 führt Art. 2(8) als N/A-Grund**
- **Fundstelle:** `CL_07:394-395`.
- **Primärquelle:** `cra.txt:137`. Art. 2(8) begrenzt nur die Pflicht, Informationen herauszugeben; es ist kein Ausschluss vom Anwendungsbereich.
- **Korrektur:** Art. 2(8) gesondert als Begrenzung von Auskunftspflichten benennen.

## Bestätigte Behebungen
- **I01:** CL-01-12 verlangt jetzt getrennte Zeilen für Produkt, Werkzeugbetrieb und Organisation, jeweils mit Rolle, Land, Rechtsfassung, Owner und Wiedervorlage. Die Betreiberrolle und Art. 4 sind genannt, das pauschale N/A für interne Werkzeuge ist entfernt. CL-09-16 ist damit konsistent.
- **I02:** Zuordnungen geprüft:
  - C3A → CL-02-12 und C5 → CL-02-13, beide `architecture-governance`. Die Cloud-Vorlagen existieren dort, die Editionen stimmen mit den Captures (v1.0 vom 27.04.2026; 1.1.0 vom 11.08.2026; SOV-7/8 ausgenommen).
  - G7 steht textlich in CL-05-13 und CL-09-15.
  - Memory-Safe Roadmaps → CL-08-13 belegt, CL-08-12 nicht (siehe P3-3).
- **I03:** Deutsche und englische Metadaten nennen beide 3.4.3. Beide Historientabellen haben vier Spalten, keine verwaisten Zeilen. Die Prüfung ist an den Abschnitt gebunden, verlangt einen exakten Wert und lässt CRLF und Historienzeilen zu. Alle Negativfälle prüfen die konkrete Meldung samt Pfad und Feld.
- **I04:** 2025/1535 Art. 1 habe ich selbst am spanischen Amtsblatt-PDF mit ELI über den BOE-Spiegel bestätigt: Ausschluss der Produkte nach VO 168/2013, Rückausnahme für L1e-Pedalfahrzeuge nach deren Art. 3 Nr. 94 lit. b, Rechtsgrundlage CRA Art. 2(5) UAbs. 2. Für 2026/881 Art. 1 (nur Aufschub der CSIRT-Weiterleitung nach Art. 16(2)) habe ich nur eine Sekundärquelle (springlex). EUR-Lex lieferte auch mir leere Seiten.
- **I05:** Art. 2(2)(a)–(c), (3), (4), (5), (6) und (7) entsprechen `cra.txt:102-137`. FOSS wird über Art. 2(1)/3(22) abgegrenzt, die Steward-Rolle gesondert.
- **I06:** Art. 69(2)/(3) und 71(2) sind wörtlich korrekt wiedergegeben (`cra.txt:1689-1706`), ebenso Art. 13(18)/(19) (`:540-543`).
- **P3-Punkte aus den früheren Berichten:**
  - DORA-RTS Art. 5(1)–(6) inklusive der getrennten Erleichterung für den Schlussbericht stimmen mit `dora-rts.txt` überein.
  - NIS2-Abschluss- und Fortschrittsbericht sind ergänzt, Deutsch und Englisch sind gleichwertig.
  - CL-03-07 entspricht TR-02102-2 (Tabellen 3/7/11–13, PKCS#1 v1.5 nur bis 2025, PSS, TLS 1.2 bis 2031).
  - Ebenfalls behoben: Art. 32(5), Inverkehrbringen nach Art. 13(12), Anhang I 2(b), Kennzeichnung der lokalen Regel in CL-11-07, Version und Historie der Verzahnung, Querverweise und die Navigation im deutschen Richtlinienteil.

## Technische Ergebnisse (Bash zuerst, dann PowerShell)

| Prüfung | Ergebnis |
|---|---|
| Generator `--check` / `-Check` | aktuell (beide Shells) |
| Regressionstest | 60/60 PASS (30 je Shell) |
| Documentation Impact | PASS, 4 Einträge (beide Shells) |
| Assurance-Status | Baseline, Delta und Image Ready; Closure und Gesamt Blocked; 4 Entscheidungen Open (beide Shells) |
| Preset-Matrix | 14 Presets exakt |
| Skriptreferenz und Statistik | CURRENT (Bash und PowerShell) |
| PSScriptAnalyzer | 0 Befunde |
| gitleaks (PR-Commitbereich), Secret-Scan | high = 0 |
| lychee offline | 0 Fehler, Anker `shared-regulatory-evidence` aufgelöst |
| Inventar | 37/37 `consolidatedSha256` stimmen mit `shasum` überein; die Kette zum Vorgängerinventar ist korrekt (4 Stichproben) |
| Historische Evidence | 3 Kontexte seit `a943d7f9` unverändert |

**NCSC NZ:** Ich habe das PDF heute erneut abgerufen. Es war erreichbar, der Inhalt ist bestätigt (Titel, Dezember 2023, acht Behörden), die Größe von 972,5 KiB passt zu 995 846 Byte. Einen eigenen SHA-256 konnte ich nicht bilden, weil für diese Datei kein Hash-Kommando freigegeben ist. `publisherBytesRevalidated: true` stützt sich auf den früheren Abruf und die vom Parent kopierte Datei; diese Grenze ist dokumentiert.

## Ungeprüft und Unsicherheiten
- **Primärquellen:**
  - Den vollständigen Text von 2026/881 und 2025/2392 konnte ich nicht selbst an der Primärquelle prüfen.
  - Laut Sekundärquellen sind die NIS2-Änderung und der Digital Omnibus Stand heute noch nicht im Amtsblatt veröffentlicht. Nicht primär verifiziert.
- **Rechtliche Lesart:** Ob die Meldepflicht der Stewards (Art. 24(3) i. V. m. Art. 14) ab dem 11.12.2027 gilt, ist vertretbar, aber nicht eindeutig.
- **Captures:** Die rechtlichen Abgleiche beruhen überwiegend auf den Codex-Captures, deren Herkunft ich nicht selbst nachgerechnet habe. ISO ist nur bibliografisch belegt.
- **Außerhalb des Scopes:**
  - Die Preset-Vorlage `regulatory-applicability` hat keine eigene Spalte für Betreiberrolle und Art. 4.
  - Das Assurance-Paket 0.1.4 prüft Versionen weiterhin per Teiltextsuche. Das ist gesondert dokumentiert und kein Level-0-Befund.
- **Nicht beansprucht:** physische Prüfung mit Assistenztechnik.

## Einordnung
- **Fachlich:** keine P1- oder P2-Befunde mehr, acht P3-Befunde.
- **Technisch:** lokal alles grün. Das belegt keine fachliche Richtigkeit.
- **Menschliche Freigabe:** steht vollständig aus. Grüne Checks oder dieses Review ersetzen sie nicht.

**Empfehlung:** Bereit zur menschlichen Prüfung. P3-1 bis P3-4 sind vor dem Merge empfohlen, die übrigen nach Ermessen.

Quellen (eigene Abrufe):
- [BOE-Spiegel des ABl. L, VO (EU) 2025/1535 (ES)](https://www.boe.es/doue/2025/1535/L00001-00002.pdf)
- [springlex: (EU) 2026/881 Art. 1 (sekundär)](https://www.springlex.eu/en/packages/cra/tcdn-regulation/article-1/)
- [NCSC NZ: The Case for Memory Safe Roadmaps](https://www.ncsc.govt.nz/assets/OLD/The-Case-for-Memory-Safe-Roadmaps-508c.pdf)
- Status Omnibus und NIS2 (sekundär): [Taylor Wessing](https://www.taylorwessing.com/en/global-data-hub/2026/the-digital-omnibus-proposal/gdh---the-digital-omnibus-and-incident-reporting), [CENTR Summer 2026](https://www.centr.org/policy/policy-updates/item/eu-policy-update---summer-2026.html), [ISC2 06/2026](https://www.isc2.org/Insights/2026/06/EU-CSA2-NIS2-Updates-Proposals-and-the-ISC2-Response), [Inside Privacy](https://www.insideprivacy.com/data-security/cybersecurity/european-commission-proposes-targeted-amendments-to-nis2-to-simplify-compliance-and-align-with-proposed-cybersecurity-act-2/)