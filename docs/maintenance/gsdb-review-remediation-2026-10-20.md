# GSDB-Reviewkorrektur / GSDB Review Remediation

Owner: Thorsten Hindermann. Datum / Date: 2026-10-20.
Ausgangscommit / Starting commit: `64508d265ac5c3163de9521e61cf21c168eafbe8`.

## Umfang und Ergebnis / Scope and Outcome

DE: Die vier Befunde der unabhaengigen Nachpruefung zu PR #337 werden in
Level 0 korrigiert. Baseline **3.4.2**, Sammelband **2.4.2**; alle **157**
Pruefpunkt-IDs bleiben erhalten. Dies ist eine begrenzte fachliche und
technische Nachpruefung, keine unabhaengige menschliche Freigabe.
Kein Merge, Home-Sync, Preset-Paketupdate, Mailversand oder Rollout.

EN: Correct the four independent re-review findings on PR #337 in Level 0.
Baseline **3.4.2**, compendium **2.4.2**; retain all **157** item IDs.
This is bounded semantic and technical revalidation, not independent human
approval. No merge, Home sync, preset package update, mail or rollout.

## Befunde und fachliche Gegenpruefung / Findings and Semantic Revalidation

| ID | Schwere / Severity | Korrektur und Gegenpruefung / Correction and revalidation |
|---|---|---|
| R01 | P1 | CL-09-16 trennt Produkt, KI-Werkzeugbetrieb und Organisation je Rechtsregime. Reine Werkzeugnutzung begruendet kein pauschales N/A; KI-VO Art. 2/4 schliessen Betreiberpflichten ein. N/A ist rollenspezifisch zu begruenden, unbekannte Anwendbarkeit bleibt Open. AI-Act-Quellenzuordnung von CL-09-17 auf CL-09-16 korrigiert. / Separate product, AI tool operation and organisation; tool-only use is no blanket exemption. Correct the source mapping to CL-09-16. |
| R02 | P2 | CL-07-03 umfasst nach Art. 32(4)(b) alle drei Pfade aus Art. 32(3): B+C, H oder ein verfuegbares/anwendbares europaeisches Schema nach Art. 27(9) mit mindestens substanziell. Die Pflicht nach Art. 8(1) bleibt gesondert. / Include all three conditional fallback routes; distinguish the mandatory Article 8(1) route. |
| R03 | P2 | Bash und PowerShell pruefen Baseline, Version und Dokument-ID im ersten zusammenhaengenden Metadatenblock auf vollstaendige, eindeutige Werte. Doppelte Felder und Ersatztreffer im Text bestehen nicht; Versionspraefixe stimmen nicht ueberein. CRLF/LF und echte historische Versionstabellen bleiben zulaessig. / Validate complete unique active fields; reject body matches, duplicates and version prefixes while allowing CRLF/LF and historical tables. |
| R04 | P2 | Englische NIS2-/DORA-/CRA-Absaetze enthalten jetzt dieselben Schwellen, Fristen und Ausloeser wie DE: Vertrauensdienste 24 Stunden, DORA 4/24/72 Stunden und ein Monat mit spaeterer Einstufung, CRA 24/72 Stunden plus getrennte Schlussfristen. DE/EN wurden paarweise mit den Quellen verglichen. / Restore equivalent English reporting thresholds, clocks and triggers; compare both languages against the sources. |

Primaerquellen / Primary sources:

- [KI-VO Art. 2/4 und 113 / AI Act](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02024R1689-20260727).
- [CRA Art. 14, 27 und 32](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02024R2847-20241120).
- [NIS2 Art. 23(4)](https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=CELEX:02022L2555-20221227).
- [DORA-Melde-RTS Art. 5 / DORA reporting RTS](https://eur-lex.europa.eu/eli/reg_del/2025/301/oj/eng).

DE: Gegenbeispiele fachlich geprueft: Ein Unternehmen nutzt einen KI-Assistenten
nur intern; Produkt-N/A entscheidet nicht ueber die Betreiberrolle. Ein
kritisches CRA-Produkt erfuellt Art. 8(1) nicht, hat aber einen anwendbaren
Art.-27(9)-Nachweis; CL-07-03 laesst diesen bedingten Pfad nun zu.
Fachliche Wahrheit wird nicht aus einem Regex-/Generator-Erfolg abgeleitet.

EN: Semantic counterexamples: a company uses AI only internally; product N/A
does not settle its deployer role. A critical CRA product falls outside
Article 8(1) conditions but has an eligible Article 27(9) certificate; CL-07-03
now permits that conditional route. Regex/generator success is not semantic proof.

## Quellen- und Versionsnachweis / Source and Version Evidence

DE: Das [fortgeschriebene Quellenprotokoll](gsdb-source-review-remediation-2026-10-20.json)
uebernimmt Capture-Fassungen und -Hashes aus dem vorherigen Quellenreview und
berichtigt die KI-Zuordnung. Die EUR-Lex-Captures wurden bei der unabhaengigen
Nachpruefung am 20.10.2026 erneut aus dem sichtbaren Textpanel abgerufen und
stimmten mit den protokollierten Hashes ueberein; die Korrektur wurde gegen
diese Volltexte gelesen. Das ist kein neuer Vollreview aller 27 Quellen.
TR-02102, C3A, C5, NIS2/BSIG, DORA, G7 AI-SBOM und DSGVO zeigten dort keine
weiteren wesentlichen Quellenfehler. ISO bleibt ausschliesslich bibliografisch.

EN: The updated source log retains captured editions/hashes and corrects the
AI mapping. During independent re-review on 2026-10-20 the EUR-Lex visible-text
captures were retrieved again and matched recorded hashes; corrections were
checked against those texts. This is not a new full review of all 27 sources.
No additional material source errors were found there for TR-02102, C3A, C5,
NIS2/BSIG, DORA, G7 AI-SBOM or GDPR. ISO remains bibliographic only.

DE: NCSC NZ lieferte bei der unabhaengigen Nachpruefung HTTP 403. Der lokale
Memory-Safe-Roadmaps-PDF-Hash stimmt weiterhin mit dem historischen Capture
ueberein. Inhalte/Herkunft sind ueber die
[offizielle australische Mitherausgeberseite](https://www.cyber.gov.au/publication/the-case-for-memory-safe-roadmaps)
pruefbar. Eine erneute Bestaetigung der damaligen Publisher-Bytes wird nicht
behauptet; diese Zugangsgrenze bleibt sichtbar und ist beim Quartalsreview
erneut zu pruefen.

EN: NCSC NZ returned HTTP 403 during independent re-review. The local memory
roadmaps PDF still matches the historical capture hash. Content/provenance
can be checked through the official Australian co-author page above. The
earlier publisher bytes are not claimed to have been retrieved again; retain
this access boundary and retry during quarterly review.

DE: Nur die fachlich geaenderten Checklisten erhalten eigene neue Versionen:
CL-07 2.0.3 und CL-09 2.2.3. Andere Vorlagen behalten ihre fachliche Version;
ihre Baseline-Bindung wird auf 3.4.2 synchronisiert. Das Standardsregister
erhaelt 1.1.2. Historische Berichte und hashgebundene Kontexte vom 19./20.10.
bleiben unveraendert. [Aktuelle Abdeckung](gsdb-coverage-remediation-2026-10-20.md),
[Inventar](gsdb-inventory-remediation-2026-10-20.json),
[neuer Assurance-Kontext](../security/secure-development/2026-10-20-gsdb-review-remediation/evidence-matrix.md).

EN: Only semantically changed checklists get new document versions: CL-07
2.0.3 and CL-09 2.2.3. Other templates retain their semantic version with
baseline binding updated to 3.4.2; the standards register becomes 1.1.2.
Historical reports and hash-bound contexts from 19/20 October remain unchanged.
Current coverage, inventory and assurance are linked above.

## Technische Validierung / Technical Validation

DE: Bestaetigte lokale Ergebnisse auf macOS; Bash zuerst, danach relevante
PowerShell-Paritaet. Semantische Gegenpruefung oben bleibt ein eigener Nachweis.
EN: Confirmed local results on macOS; Bash first, then relevant PowerShell
parity. The semantic revalidation above remains separate evidence.

| Pruefung / Check | Ergebnis / Result |
|---|---|
| Generator / compendium | PASS: Bash und PowerShell; wiederholter Generatorlauf SHA-256-identisch / parity and hash-identical repeat |
| Regressionen / regressions | PASS: 40/40, 20 je Shell; vier neue Negativfaelle scheitern am Metadatenfehler, zwei Positivfaelle bestehen; Dateinamen/Hashes unveraendert / four new metadata negatives and two positives per shell, read-only snapshots unchanged |
| IDs / inventory / coverage | PASS: 157 geordnete IDs unveraendert; 37 Inventar-Hashes passend; 157 Matrixzeilen / ordered IDs retained, inventory matches, coverage complete |
| Historische Evidence / historical evidence | PASS: bisherige Quellenberichte, Inventar und Assurance-Kontexte unveraendert / prior source reports, inventory and contexts unchanged |
| Preset-Matrix / preset matrix | PASS: exakt 14 installierte Pakete, keine Installation / exact match, no installation |
| Documentation Impact | PASS: beide Shells, vier Entscheidungen / both shells, four decisions |
| Assurance | PASS: beide Shells; Baseline/Delta/Image Ready, Closure/Gesamt Blocked; alle vier menschlichen Entscheidungen Open / all four human decisions remain Open |
| Links / anchors | PASS: 5161 Gesamtverweise, 2989 eindeutig, 0 Fehler / total, unique, no errors |
| PowerShell | PASS: PSScriptAnalyzer 1.25.0, 121 Dateien, 0 Error/Warning / files, no errors/warnings |
| Skriptreferenz / script reference | PASS: CURRENT; canonical=152, embedded=110 |
| Secret scan / whitespace | PASS: gitleaks im Aenderungsumfang ohne Treffer; high=0; git diff --check / no secret finding in change scope, no whitespace errors |

DE: Statistik wird nach dem Quellencommit aus sauberem Arbeitsbaum mit
unveraenderter Konfiguration gerendert und separat committet. Der PR bindet
die CI-Ergebnisse an seinen aktuellen Head; fruehere gruene Heads genuegen
nicht. Lokale PowerShell-Paritaet ersetzt keinen nativen Windows-Nachweis.
Statuswerte/Ergebnisse sind textuell, keine farbabhaengige Entscheidung;
keine physische Screenreader-/Braille-Abnahme wird behauptet.

EN: Render statistics after the source commit from a clean worktree using
unchanged configuration, then commit generated output separately. The PR
binds CI to its current head; earlier green heads are insufficient. Local
PowerShell parity does not establish native Windows proof. Status/results
are textual and colour-independent; no physical screen-reader/Braille
acceptance is claimed.

Reproduktion / Reproduction:

```bash
bash scripts/build-secure-development-docs.sh --check
bash scripts/validate-documentation-impact.sh --evidence docs/maintenance/gsdb-remediation-documentation-impact-2026-10-20.json
bash .specify/presets/secure-development-assurance-governance/scripts/validate-secure-development-assurance.sh status docs/security/secure-development/2026-10-20-gsdb-review-remediation
```

```powershell
pwsh -NoProfile -File scripts/tests/test-gsdb-consolidation.ps1
pwsh -NoProfile -File scripts/build-secure-development-docs.ps1 -Check
pwsh -NoProfile -File scripts/validate-documentation-impact.ps1 -Evidence docs/maintenance/gsdb-remediation-documentation-impact-2026-10-20.json
pwsh -NoProfile -File .specify/presets/secure-development-assurance-governance/scripts/validate-secure-development-assurance.ps1 -Action Status -EvidenceDirectory docs/security/secure-development/2026-10-20-gsdb-review-remediation
```

## Documentation Impact und Distribution / Documentation Impact and Distribution

[Entscheidungen / Decisions](gsdb-remediation-documentation-impact-2026-10-20.json).
DE: Leserpfad: GSDB-README -> aktueller Reviewnachweis -> Quelle/Checkliste ->
Assurance und menschliche Entscheidung. Dokumente und Evidence sind sourceOnly.
Generatoren und Regressionstest sind homeRuntime; ihr spaeterer Sync-Bedarf
wird nur vorgemerkt. Kein Sync-Lauf und kein Level-2-Eingriff in diesem Auftrag.

EN: Reader path: GSDB README -> current remediation report -> source/checklist
-> assurance and human decision. Documents/evidence are sourceOnly. Generators
and regression test are homeRuntime; record deferred sync need only. This task
performs no sync and changes no Level-2 repository.

## Verbleibende Entscheidungen / Remaining Decisions

DE: Baseline-/Delta-/Image-Pruefung ersetzt keine menschliche Entscheidung.
Technical Validation, Pilot Authorization, Project Acceptance und General
Release bleiben jeweils Open; Closure bleibt Blocked bis zur menschlichen
Pruefung. Naechste Aktion: PR #337 unabhaengig menschlich pruefen. Jede
spaetere Ausfuehrungsfreigabe ist ein eigener Auftrag. Review-Owner Thorsten
Hindermann; Wiedervorlage 10.01.2027 oder bei Quellen-/Baseline-/Presetaenderung.

EN: Baseline/delta/image validation does not grant human approval. Technical
Validation, Pilot Authorization, Project Acceptance and General Release each
remain Open; closure remains Blocked pending human review. Next action:
independent human review of PR #337. Later execution authority is separate.
Owner Thorsten Hindermann; re-review 2027-01-10 or on source/baseline/preset change.
