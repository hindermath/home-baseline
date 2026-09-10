# Feature 032 – Diagnosegrenzen-Korrektur / Diagnostic Boundary Correction

## Ergebnis / Result

Die begrenzte Korrektur für die wieder geöffneten Home-Aufgaben T059, T060,
T061, T065 und T066 ist abgeschlossen. Die öffentlichen Bash- und
PowerShell-Diagnosen entfernen credential-förmige Werte jetzt unabhängig von
der `LIE`-Fehlerfamilie. Harmlose repositoryrelative Subjects bleiben als
nützlicher Kontext sichtbar. Jede Familie `LIE001` bis `LIE012` erhält eine
sichere deutsche und danach englische Abhilfe.

*The bounded correction for reopened Home tasks T059, T060, T061, T065, and
T066 is complete. Public Bash and PowerShell diagnostics now remove
credential-shaped values independently of the `LIE` error family. Ordinary
repository-relative subjects remain visible as useful context. Every family
from `LIE001` through `LIE012` receives safe German-first and English-second
remediation.*

## Regressionsnachweis / Regression proof

Vor der Implementierung erweiterten die Paar-Tests die echte öffentliche
CLI-Grenze um getrennt erfasstes Standard-Output und Standard-Error. Der
unveränderte Stand scheiterte in beiden Suiten an genau fünf neuen Assertions:
`LIE003`, sicheres `LIE004`, credential-förmiges `LIE004`, sicheres `LIE007`
und credential-förmiges `LIE007`. Damit ist die vom Parent beobachtete
`LIE004`-Reflexion als Regression erhalten; der frühere absolute
`LIE003`-Test wird nicht als ausreichender Nachweis umgedeutet.

Nach der Korrektur bestanden zuerst die macOS-Bash-Suite und danach die
PowerShell-7-Suite. Beide prüfen:

- fehlende sichere relative Datei: Code, Subject und Abhilfe bleiben sichtbar;
- fehlende credential-förmige relative Datei: Code und redigiertes Subject
  bleiben sichtbar, der synthetische Wert fehlt in beiden Streams;
- unbekannter sicherer Dependency-Endpoint: Code, Subject und Abhilfe bleiben
  sichtbar;
- unbekannter credential-förmiger Dependency-Endpoint: Code und redigiertes
  Subject bleiben sichtbar, der synthetische Wert fehlt in beiden Streams;
- Kontrollzeichen, synthetischer privater Root und PowerShell-Stack-Metadaten
  gelangen nicht in die öffentliche Ausgabe.

*The paired executable tests preserve the pre-fix failure and then pass in the
required order: macOS Bash first, PowerShell 7 second. They inspect stdout and
stderr separately instead of trusting a pre-redacted JSON reference.*

## Implementierungsgrenze / Implementation boundary

Die Bash-Bibliothek redigiert ausschließlich Meldungen mit einem stabilen
`LIEddd:`-Präfix im bestehenden öffentlichen Logpfad. Die PowerShell-Bibliothek
stellt dieselbe Transformation bereit; der vorhandene Top-Level-Catch gibt nur
die transformierte Exception-Nachricht aus. Prozess-Exitcodes und
Standard-Error bleiben erhalten. Es wurde keine Diagnosefamilie umbenannt,
kein Prozessfehler versteckt, keine Dependency ergänzt und keine
Renderer-/Publication-Semantik verändert.

Die didaktischen Kommentare erklären die Diagnose als Trust Boundary:
einzeilige Ausgabe gegen Terminal-Control-Injection, Redaktion
credential-förmiger Werte und Erhalt sicherer repositoryrelativer Kontexte.

*The implementation changes only the public diagnostic boundary. Exit codes,
stderr delivery, existing code families, and renderer transaction behaviour
remain intact. No dependency was added.*

## Evidence und Lineage

Ausgeführt wurden der Bash-Syntaxcheck, die vollständige Bash-Suite, danach
die vollständige PowerShell-Suite, der konfigurierte PSScriptAnalyzer 1.25.0
für 107 getrackte repositoryeigene Dateien, derselbe Analyzer explizit für das
neue ungetrackte PowerShell-Testskript, der `--fail-on-high`-Secret-Check, der
Dependency-Nullcheck und ein begrenzter Diff-Check. Die aktualisierte
Maschinen-Evidence liegt in `governance-macos.json` im ignorierten operativen
Evidence-Root.

Diese Evidence supersediert nur die Diagnosebehauptung des früheren
`implement-assurance-20260910`-Payloads. Dessen Resultat und Payload bleiben
byteidentisch und historisch `NeedsRevalidation`; Result-SHA-256
`d9e401beaa3254abe31b9ea406782245fa5ad8b81716e0025086c09c42421c66`,
normalisierter Payload-SHA-256
`b43744f1279ffe0353451252c65499361d07927e9d3d5f88e6a1fd40e5b7bf15`.

Owner: Home Repository Owner. Reviewer: Feature-032 diagnostic repair runner.
Re-Evaluation: neue Diagnosefamilie, neuer öffentlicher Wrapper, geänderte
Stream-/Exit-Semantik, weitere Secretform, Eingabegrenze oder native
Plattform-Evidence.

## Verbleibende Grenzen / Remaining limits

Native Linux-/Windows-Evidence, benannte Screenreader-/Braille-Prüfung,
unabhängiger menschlicher Accessibility-/Security-/Architecture-Review,
Statistik-current und die Delivery ab T067 bleiben `Open`. Der separate
Raw-Whitespace-Validator-Blocker für drei unveränderliche historische Reports
wurde weder behoben noch ignoriert. Es gab kein Staging, keinen Commit, keine
Remote-Aktion, keine Downstream-/Preset-Änderung und keinen Home-Sync.

*Native platforms, named assistive-device operation, independent human review,
current statistics, delivery, and the separate immutable-report validator
blocker remain open. This correction makes no certification or delivery-ready
claim.*
