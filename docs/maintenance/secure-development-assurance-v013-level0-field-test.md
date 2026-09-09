# Level-0-Feldtest: Assurance v0.1.3 / Level-0 field test

Stand / Date: 2026-09-09. Empfehlung / Recommendation: `ReleaseAccepted`
für die technisch geprüfte Preset-Funktion im unten begrenzten Scope.
Lieferstatus: PR-Prüfung und Merge stehen noch aus.

*Recommendation applies only to tested preset behavior in the scope below.
Delivery is pending PR checks and merge.*

## Umfang und Verantwortung / Scope and responsibility

Level 0 verwendet Secure Development Assurance Governance v0.1.3 statt v0.1.2,
Priorität 15, mit Security Governance v0.6.2 auf Priorität 10. Die übrigen zwölf
Preset-Versionen bleiben unverändert. Test-Owner und benannter menschlicher
technischer Reviewer: @hindermath; Ausführung und technische Befundprüfung:
Codex. Eine menschliche Sichtung wird dadurch nicht behauptet.

*Level 0 upgrades only Assurance; the other twelve preset versions remain
unchanged. @hindermath owns the test and designated human technical review;
Codex executes tests and inspects findings, without claiming human sign-off.*

Der [eigene Kontext](../security/secure-development/2026-09-09-home-baseline-assurance-v013/evidence-matrix.md)
prüft Baseline-Integrität, Installation und vier Gate-Verträge. Das ist keine
erneute Abnahme aller 157 Sicherheitsmaßnahmen. Historische Evidence bleibt
unverändert. Level 0 ist zugleich Quelle und Anwender des Presets; dieser
Selbsttest ist kein unabhängiger externer Feldnachweis.

*The context checks source integrity, installation and four gate contracts,
not all 157 controls. Historical evidence is preserved. Level 0 is both source
and consumer, so this is not independent external field evidence.*

## Paketbindung / Package binding

- [Unveränderliches Release v0.1.3](https://github.com/hindermath/spec-kit-preset-secure-development-assurance-governance/releases/tag/v0.1.3), weiterhin Pre-Release.
- Tag-Commit: `0d03aa9ebe8f74a26e331815bca5609fb48d7a14`.
- Tag-ZIP SHA-256: `9023b442b4d82e25bee5a7fe9b73efb7f591a4f265f54061ae6e4a56b9b5c75f`.
- Profil: `scripts/config/spec-kit-secure-development-assurance-governance-presets.json`.
- macOS / Darwin arm64; Spec Kit 0.12.8; PowerShell 7.6.5; Bash 3.2.57.
- [Tracker home-baseline#276](https://github.com/hindermath/home-baseline/issues/276);
  [AOC#43](https://github.com/hindermath/agent-operations-cockpit/issues/43).

*Archive integrity was checked before installation. Native Linux/Windows
execution is not claimed by local macOS cross-shell testing; remote CI is
recorded separately at the final PR head.*

## Ausgeführte Prüfungen / Executed checks

| Fall / Case | Ergebnis / Result | Exitcode |
|---|---|---|
| ZIP-Prüfsumme / archive hash | Exakte Übereinstimmung / exact match | 0 |
| 13-Preset-CheckOnly, Bash und PowerShell | Exakte Versionen und Prioritäten / exact matrix | 0 / 0 |
| preset list, info, resolve; specify check | v0.1.3-Vertrag aufgelöst / contract resolved | je / each 0 |
| Status und vier Gate-Reviews, beide Shells | Ready; gleiche fachliche Ausgabe / matching output | zehnmal / ten times 0 |
| Rohe Hashes, sortierte relative Pfade, versteckte Dateien | Vorher = nachher / unchanged | 0 |
| Installierte Vertrags-/Negativsuite | Alle Assertions bestanden / all assertions passed | 0 |
| Acht erzeugte Befehlsoberflächen aus Tag-ZIP | Kanonischer Inhalt, ausführbare Validatoren / canonical executable commands | Suite 0; Negativfälle / negatives 2 |
| LF, CRLF, BOM; echte Drift | Gleiche Ergebnisse; Drift blockiert / parity, drift blocked | Suite 0; Drift 2 |
| Disable/Enable, Remove, Zwölf-Preset-Profil, Wiederinstallation | Isolierte Arbeitskopie; Matrix wieder exakt / isolated composition | jeweils / each 0 |
| Generierter Secure-Development-Sammelband | Aktuell, unverändert / current and unchanged | 0 |
| Secret-Scan | Keine hohen Findings / no high findings | 0 |

Die Vertrags-/Negativsuite prüft Manifest- und Dokumenthashdrift, fehlende oder
doppelte Checklisten, falsche Versionen, Sammelbanddrift, offene Pflichtpunkte
bei Ready, unbegründetes N/A, abgelaufene Reviews, unvollständige Risiken,
fehlende Security Governance, unzulässige Zertifizierungsbehauptungen,
fehlende Runbooks und Image-Felder. Zusätzlich prüft v0.1.3 exakte/eindeutige
Kontextwahl, ID-/Mode-Bindung und ausschließlich Array-förmige Risiken.
Erwartete Fehler liefern 2; die vollständig bestandene Testsuite liefert 0.

*Negative fixtures cover all runbook failure categories, exact context/mode
binding and array-only risks. Expected failures exit 2; the successful test
runner exits 0. Fixtures are synthetic and never count as project acceptance.*

Die Rohhash- und Aufrufnachweise stehen in
[level0-context-verification.json](assurance-v013-level0-context-verification.json).
Kontext-Hashes gelten für den dort gebundenen Dateistand; nach Änderungen
sind diese Prüfungen erneut auszuführen.

*The linked verification record binds actual commands and unchanged raw
hashes to the checked context; rerun it after changes.*

Kompositionsnachweis / Composition record:
[isolierte Befehle und Exitcodes](assurance-v013-level0-composition-verification.json).

## Findings und Restrisiken / Findings and residual risks

1. Spec Kit 0.12.8 lässt nach `preset remove` in der temporären Kopie die
   beiden erzeugten Claude-Skills zurück. Das ist eine unvollständige
   CLI-Deinstallation, kein vollständiger Remove-Erfolg. Sie besitzen ohne
   Preset keinen Validator. Die Wiederinstallation stellt die geprüften
   Oberflächen wieder her. Kein CLI-Patch und keine produktive Entfernung.
2. Die CLI meldet die bestehende Legacy-Integration `.opencode/command`.
   Diese Migration ist nicht Teil dieses Auftrags; die geprüften Befehle
   funktionieren. Keine ungeprüfte Umbenennung.
3. Die erste neue Evidence-Fassung hatte nur ein Datum statt ISO-Zeitpunkt.
   Der Validator blockierte korrekt mit 2; die neue Evidence wurde korrigiert.
4. Strukturelle Integrität ersetzt weder fachliche Umsetzung noch menschliche
   Sichtung; aktive lokale Entwicklungswerkzeuge können reale Daten berühren.

*Observed limits: orphaned Claude skills after removal, existing legacy
OpenCode directory, an authoring timestamp error correctly blocked and fixed,
and the separation between structural proof and human/product acceptance.
No immutable package modification was needed.*

## Ausbildungs- und Freigabegrenze / Educational and approval boundary

Die sieben Kandidaten sind nichtproduktive, nichtkommerzielle Ausbildungs-
und Referenzprojekte. Primäre Zielgruppen sind die vier IHK-IT-Ausbildungsberufe
einschließlich aller vier FI-Fachrichtungen. Sichere KI-gestützte Entwicklung
beginnt im ersten Lehrjahr; barrierearme DE/EN-Erklärungen, Geheimnisschutz,
begrenzte Rechte, Tests und nachvollziehbare Entscheidungen wachsen didaktisch
mit. Bestehende Schutzmaßnahmen werden nicht reduziert.

C5-Test: N/A im genehmigten Scope. Keine neue rechtliche Freistellung.
Scope-Wiedervorlage: 2026-12-31; technische Wiedervorlage: 2027-09-09, früher
bei relevanter Änderung. `technicalValidation=Fulfilled` ist technisch;
`pilotAuthorization`, `projectAcceptance`, `generalRelease` bleiben `Open`.
Zentrale Preset-Abnahme erst separat nach sieben belegten Feldtest-Ergebnissen
und dem Ergebnis von [github/spec-kit#4455](https://github.com/github/spec-kit/issues/4455).

*These are educational reference projects for the four IT training occupations,
starting secure AI-assisted development in year one. No C5 test, legal exemption,
certification, production approval or human sign-off is inferred. Scope review:
2026-12-31; technical review: 2027-09-09 or earlier after material change.
Central acceptance remains a separate future decision.*

## Dokumentationsauswirkung / Documentation impact

`UpdateRequired`: Quellen sind dieser Feldbericht und der neue Evidence-Kontext;
Owner @hindermath; Zielgruppen Lernende, Maintainer und Reviewer.
Leserpfad: Tracker -> Feldbericht -> Matrix/Runbooks -> reproduzierbare Checks.
DE zuerst, EN danach; textorientierte Tabellen und beschreibende Links.
Preset-Quellen und Evidence sind sourceOnly; erzeugte Agentenoberflächen werden
nur nach dem manifestgebundenen Home-Vertrag verteilt. Home-Sync nach Merge,
Check und Vorschau. Statistik wird aus ihrer kanonischen Konfiguration gerendert.

*UpdateRequired: this report and its context are canonical, German-first with
English equivalents and text-oriented navigation. Source evidence is not copied
to Home; only manifest-listed runtime surfaces are synchronized after delivery.
Statistics use the canonical renderer.*
