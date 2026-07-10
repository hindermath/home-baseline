# Lastenheft: Secure OrderDesk 00 - Sprachrepo-Projekt-Scaffold

## Metadaten / Metadata

- **Stand / Date:** 2026-07-07
- **Übungsfirma / Training company:** EuFPA - Europäische Firma Programmiert Alles
- **Fiktive Kundenfirma / Fictional client company:** Secure Trader
- **Lehrjahr / Training year:** ab dem 1. Lehrjahr
- **Zielsprachen / Target languages:** C#, Go, Java, Python, Rust, Swift
- **Primär geeignet für / Primary fit:** AE, SI, DPA
- **Spec-Kit-Nutzung / Spec Kit use:** eigenständiger späterer technischer Spec-Kit-Intake vor der ersten fachlichen Aufgabe
- **Sandbox-Bezug / Sandbox relation:** Container-First-Gate ab Unit 00 verbindlich — jeder KI-Agenten-Aufruf im Container/der Sandbox `absdd-image-sandbox`, nie auf dem Arbeitsplatz-Rechner; Grundlage `Secure-Trader-Sandbox-Preflight.md`
- **Datensatzquelle / Dataset source:** `Secure-OrderDesk-Datensatzquelle.md`, `Secure-Trader-Systemlandschaft.md`

> **Vorbedingung / Prerequisite:** Zuerst
> [`START-HERE-FUER-LERNENDE.md`](START-HERE-FUER-LERNENDE.md) und den
> [`Secure-Trader-Sandbox-Preflight`](Secure-Trader-Sandbox-Preflight.md)
> durcharbeiten. Dieser Intake startet noch keinen Spec-Kit-Lauf.

## Lernziel / Learning Goal

**DE:** Lernende können ein minimales, lauffähiges Sprachrepo so vorbereiten, dass spätere fachliche
Secure-OrderDesk-Aufgaben auf einer sauberen Build-, Test-, Dokumentations- und Governance-Basis starten. Das
Gerüst enthält noch keine Handels- oder Datenbanklogik; es stellt nur sicher, dass die Werkzeugkette vor der
ersten fachlichen Einheit funktioniert.

**EN:** Learners can prepare a minimal runnable language repository so later Secure OrderDesk tasks start from a
clean build, test, documentation, and governance baseline. The scaffold contains no trading or database logic
yet; it only ensures that the toolchain works before the first functional unit.

## Fachrichtungsbezug / Specialization Fit

| Fachrichtung | Eignung | Reflexionsfrage |
|---|---|---|
| AE | hoch | Welche minimale Projektstruktur braucht die Sprache, damit spätere Domänen- und Datenzugriffslogik sauber ergänzt werden kann? |
| SI | hoch | Welche Toolchain-, Sandbox- oder Pfadannahme muss vor dem ersten Fachlauf klar sein? |
| DPA | mittel bis hoch | Welche Annahmen zu Kunden- und Bestelldaten dürfen im reinen Gerüst noch nicht vorweggenommen werden? |

## Rahmenlehrplanbezug / Curriculum Relation

**DE:** Die Aufgabe unterstützt Arbeitsorganisation, Einrichtung einer Entwicklungsumgebung, Versionsverwaltung,
Qualitätssicherung und dokumentierte Vorbereitung für spätere Kundenaufträge der Handelsfirma auf dem Niveau ab
dem 1. Lehrjahr.

**EN:** The task supports work organization, development environment setup, version control, quality assurance,
and documented preparation for later customer tasks of the trading company at first-year level.

<!-- lf-konkret -->
**DE:** Konkrete Lernfelder (Quelle: `Rahmenlehrplan-Lernfeld-Mapping.md`, Abschnitt „Secure OrderDesk Basis"):
**primär LF 1 („Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; berührt LF 2 („Arbeitsplätze
nach Kundenwunsch ausstatten") und LF 4 („Schutzbedarfsanalyse im eigenen Arbeitsbereich durchführen", wegen
Container-First-Gate). Vertiefte Erklärung und Verständnisfragen:
`lernbegleiter/Secure-OrderDesk_00_Sprachrepo-Projekt-Scaffold.Lernbegleiter.md`.

**EN:** Concrete learning fields (source: `Rahmenlehrplan-Lernfeld-Mapping.md`, section "Secure OrderDesk
Base"): **primary LF 1 ("Das Unternehmen und die eigene Rolle im Betrieb beschreiben")**; touched LF 2
("Arbeitsplätze nach Kundenwunsch ausstatten") and LF 4 ("Schutzbedarfsanalyse im eigenen Arbeitsbereich
durchführen", because of the container-first gate). Deeper explanation and comprehension questions:
`lernbegleiter/Secure-OrderDesk_00_Sprachrepo-Projekt-Scaffold.Lernbegleiter.md`.

## Bezug zur Richtlinie Sichere Entwicklung / Relation to Secure Development Guideline

- **Prinzipien:** sichere Entwicklungsumgebung, MSL-Präferenz, sichere Code-Erzeugung, auditfähige Evidenz.
- **Checklisten:** CL_01, CL_05, CL_08, CL_09, CL_10, CL_12.
- **Mitgeltende Dokumente:** Leitlinie Sichere Programmierung, Leitlinie Sichere Entwicklungs-Sandbox, `Secure-Trader-Sandbox-Preflight.md` (Container-First-Gate), Kompetenzprofile und Schulungsplan.
- **Presets:** alle sechs Governance-Presets als lokale Arbeits- und Nachweisbasis.

## Aufgabenstellung / Task

**DE:** Erzeuge oder prüfe in einem bereits vorbereiteten Level-2-Sprachrepo ein minimales lauffähiges Projekt
für genau eine Zielsprache. Dieses Projekt enthält noch keine fachliche Secure-OrderDesk-Logik (keine Kunden-,
Produkt- oder Bestellverwaltung, keine Datenbankzugriffe, kein Reporting). Es stellt nur sicher, dass Build,
Tests, Dokumentation, Secure-Development-Basis und Governance-Presets vor der ersten fachlichen Lerneinheit
funktionieren. Die spätere Datenbasis ist die klassische Northwind-Sample-DB inkl. Pflicht-Datensatz `ALFKI`,
wird in diesem Schritt aber nur benannt und noch nicht angebunden. Halte das Gerüst im 1. Lehrjahr bewusst
einfach.

**EN:** Create or verify a minimal runnable project in one prepared level-2 language repository for exactly one
target language. This project does not contain Secure OrderDesk domain logic yet (no customer, product, or
order management, no database access, no reporting). It only ensures that build, tests, documentation, the
secure-development baseline, and governance presets work before the first functional learning unit. The later
data base is the classic Northwind sample database incl. the mandatory record `ALFKI`, but in this step it is
only named and not yet connected. Keep the scaffold deliberately simple in year 1.

**DE:** Wenn im Scaffold-Schritt ein KI-Agent genutzt wird, gilt das Container-First-Gate: Der Agenten-Aufruf
erfolgt in der freigegebenen Sandbox/im Container (`absdd-image-sandbox`), nie auf dem Arbeitsplatz-Rechner.
Führe vor dem ersten Agenten-Aufruf die Preflight-Checkliste aus `Secure-Trader-Sandbox-Preflight.md` durch.

**EN:** If an AI agent is used in the scaffold step, the container-first gate applies: the agent invocation
happens in the approved sandbox/container (`absdd-image-sandbox`), never on the workstation. Run the preflight
checklist from `Secure-Trader-Sandbox-Preflight.md` before the first agent invocation.

## Anforderungen / Requirements

- **R-01:** Ein minimales lauffähiges Projekt für genau eine der sechs Zielsprachen ist vorhanden oder wird angelegt.
- **R-02:** Lokale Build- und Testbefehle sind vollständig dokumentiert und reproduzierbar.
- **R-03:** Die sechs Governance-Presets sind installiert oder als Blocker mit konkretem Behebungsweg dokumentiert.
- **R-04:** Die Secure-Development-Basis unter `docs/secure-development/` ist vorhanden oder als fehlend mit Folgeaufgabe dokumentiert.
- **R-05:** Alle `Applicable`, `N/A` und `Open` Punkte werden mit Evidenzpfad oder Begründung dokumentiert; die Northwind-Datenbasis inkl. `ALFKI` ist als spätere Quelle benannt, aber noch nicht angebunden.
- **R-06 (Container-First-Gate):** Wird ein KI-Agent genutzt, erfolgt der Aufruf ausschließlich in der freigegebenen Sandbox/im Container (`absdd-image-sandbox`), nie auf dem Arbeitsplatz-Rechner. Die Preflight-Checkliste aus `Secure-Trader-Sandbox-Preflight.md` ist vor dem ersten Agenten-Aufruf abgearbeitet; wird kein Agent genutzt, wird dies als `N/A` mit Begründung dokumentiert.

## Sicherheits- und Datenschutzanforderungen / Security and Privacy Requirements

- Keine echten Kundendaten, Secrets oder produktiven Konfigurationen anlegen; Secrets nur als `<PLATZHALTER-KEIN-ECHTER-WERT>`.
- Keine Fachlogik und keine echten Northwind-Kundendaten vorwegnehmen, die in den späteren Aufgaben spezifiziert werden.
- Beispielausgaben bleiben neutral und enthalten keine echten Namen, E-Mail-Adressen, Tokens, Verbindungszeichenketten oder privaten Pfade.
- Datenbankzugangsdaten, Netzwerkzugriffe und externe Dienste bleiben ausgeschaltet oder werden als `N/A` mit kurzer Begründung dokumentiert.
- KI-Agenten werden nur im Container/der Sandbox gestartet, nie direkt auf dem Arbeitsplatz-Rechner; Schreibgrenzen, Mounts und Secret-Regeln folgen `Secure-Trader-Sandbox-Preflight.md`.

## Sprachneutrale Anforderungen / Language-Neutral Requirements

- Der Gerüst-Zweck bleibt für C#, Go, Java, Python, Rust und Swift vergleichbar: bauen, testen, dokumentieren.
- Sprachspezifische Projekt-, Datenbanktreiber- und Testwerkzeuge dürfen gewählt werden, müssen aber begründet werden; die Anbindung erfolgt erst in späteren Einheiten.
- MSL-Status ersetzt keine sichere API-, I/O-, Auth-, SQL-, Crypto-, Logging- oder Dependency-Prüfung.

## Erwartete Artefakte / Expected Artifacts

- Minimale Projektstruktur für eine der sechs Zielsprachen.
- Dokumentierte lokale Build- und Testbefehle.
- Nachweis der installierten Governance-Presets, zum Beispiel durch Ausgabe von `specify preset list`.
- Lokale Secure-Development-Basis oder dokumentierter Blocker.
- Kurze Entscheidung, warum dieses Projektgerüst für die spätere OrderDesk-Lernreihe mit Northwind-Datenbasis ausreicht.
- Kurzer Nachweis der Container-First-Preflight-Entscheidung (Agent im Container genutzt oder `N/A` mit Begründung).

## Akzeptanzkriterien / Acceptance Criteria

- [ ] Das Projekt baut lokal oder der Blocker ist konkret dokumentiert.
- [ ] Der Basistest läuft lokal oder der Blocker ist konkret dokumentiert.
- [ ] Es gibt keine fachliche OrderDesk-Logik und keine Datenbankanbindung in diesem Schritt.
- [ ] Die spätere Aufgabe `01` kann auf dem Projektgerüst aufsetzen.
- [ ] `N/A` und `Open` werden sichtbar mit Begründung dokumentiert.
- [ ] Wird ein KI-Agent genutzt, erfolgt der Aufruf im Container/der Sandbox (nie auf dem Arbeitsplatz-Rechner); die Preflight-Checkliste ist abgearbeitet oder als `N/A` begründet.
- [ ] Markdown bleibt DE-first, EN-second, CEFR B2 und WCAG-2.2-AA-orientiert.

## Optimaler Specify-Prompt / Optimal Specify Prompt

```text
/speckit-specify Nutze docs/learning-units/Lastenheft_Secure-OrderDesk_00_Sprachrepo-Projekt-Scaffold.md als verbindliche Eingabedatei. Erstelle eine Feature-Spezifikation für den technischen Sprachrepo-Scaffold der EuFPA-Lernreihe Secure OrderDesk (Kundenfirma Secure Trader, spätere Northwind-Datenbasis inkl. ALFKI). Lege ein minimales lauffähiges Projekt für die gewählte MSL-Sprache mit Build-/Teststruktur, Secure-Development-Basis und Preset-Nachweis an, aber erzeuge keine fachliche OrderDesk- oder Datenbanklogik. Halte das Container-First-Gate fest: Wird ein KI-Agent genutzt, erfolgt der Aufruf im Container/der Sandbox absdd-image-sandbox (nie auf dem Arbeitsplatz-Rechner) gemäß Secure-Trader-Sandbox-Preflight.md, sonst als N/A begründet. Erzeuge keine Implementierung und starte keinen Sammellauf für die gesamte Lernreihe.
```
