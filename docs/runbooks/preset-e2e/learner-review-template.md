# Leeres Lernprüfblatt / Blank learner review sheet

Das Blatt wird **vor einer späteren Bereinigung** in einem freigegebenen lokalen Testprojekt ausgefüllt. Es ist keine Test- oder Sicherheitsfreigabe. Der vollständige Flottentest bleibt eine Maintainer-Aufgabe.

Complete this sheet **before later cleanup** in an approved local test project. It is not a test or security approval. The full fleet test remains a maintainer task.

| Feld / Field | Eintrag / Entry |
|---|---|
| Run-ID, Szenario und Sprache / Run ID, scenario and language | _auszufüllen / to fill_ |
| Prüfende Person und Rolle / Reviewer and role | _auszufüllen / to fill_ |
| Geprüfter Commit oder lokaler Stand und Umgebung / Commit or local state and environment | _auszufüllen / to fill_ |
| Persönliche Lernprüfung / Personal learner review | _ausstehend oder Datum und selbst geprüfte Schritte / pending or date and steps personally checked_ |
| Betreuung oder freigegebenes Beispiel / Supervision or approved example | _auszufüllen / to fill_ |

## Deutsch: geführte Schritte

1. Finde die vier Lastenhefte und erkläre in eigenen Worten, warum 2 nach 1, 3 nach 2 und 4 nach 3 kommt.
2. Suche die Rechenlogik und den zugehörigen Unit-Test. Rechne `6 + 2` und `1 / 2` selbst nach.
3. Führe einen dokumentierten Integrationstest aus. Notiere Shell, Befehl, erwartetes und tatsächliches Ergebnis. Nutze bei Bedarf die [Bash- und PowerShell-7-Beispiele](shell-examples.md).
4. Bediene CLI und TUI oder HTTP und Webseite mit Tastatur. Prüfe einen Fehlerfall. Wenn ein Hilfsmittel nicht verfügbar ist, notiere `nicht geprüft` mit Grund.
5. Finde die textorientierte Handbuchquelle und das PDF. Prüfe, ob beide denselben Funktionsstand erklären und Deutsch vor Englisch steht.
6. Schreibe eine Frage, eine Abweichung oder `keine beobachtete Abweichung`. Sage ausdrücklich, was du selbst geprüft hast. Wenn eine Anleitung nicht funktioniert oder schwer zu finden ist, notiere Stelle, Schritt und Ergebnis sowie eine konkrete Verbesserung. Führe nicht selbst ausgeführte Schritte als ausstehend.

| Schritt | Erwartet | Beobachtet und Beleg | Offen / Frage |
|---|---|---|---|
| 1 – Serie | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| 2 – Rechenlogik | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| 3 – Integrationstest | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| 4 – Bedienung und Fehler | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| 5 – Handbuch | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |
| 6 – Eigene Bewertung | _auszufüllen_ | _auszufüllen_ | _auszufüllen_ |

## English: guided steps

1. Find the four intakes and explain in your own words why 2 follows 1, 3 follows 2 and 4 follows 3.
2. Find the calculator logic and its unit test. Check `6 + 2` and `1 / 2` yourself.
3. Run one documented integration test. Record the shell, command, expected result and actual result. See the [Bash and PowerShell 7 examples](shell-examples.md#english) if needed.
4. Use CLI and TUI or HTTP and web page with a keyboard. Check one error. If an assistive tool is unavailable, write `not tested` with a reason.
5. Find the text-first handbook source and PDF. Check that they describe the same product revision and place German before English.
6. Record one question, one difference or `no difference observed`. State exactly what you reviewed yourself. If an instruction fails or is hard to find, note its location, the step, the result and one concrete improvement. Mark steps you did not perform as pending.

Use the six rows above for the English review as well; do not copy CI success into the observed-result column without doing the step.

**Übergabe / Handoff:** Übernimm konkrete Rückmeldungen als menschliche Beobachtung in den [Laufbericht](run-report-template.md#deutsch-verbesserungen-für-den-nächsten-lauf). Eine ausstehende Lernprüfung ist kein negativer Produkttest und keine Freigabe zur Bereinigung. / Carry concrete feedback into the [run report](run-report-template.md#english-improvements-for-the-next-run) as human observation. Pending learner review is neither a product test failure nor cleanup approval.
