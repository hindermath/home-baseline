# Lastenheft: Secure-Development-Hardening

**Repository:** {{PROJECT_NAME}}
**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** vorbereitet fuer separaten Spec-Kit-Haertungslauf
**Stand:** {{DATE}}

## 1. Zweck

Dieses Lastenheft beschreibt den Eingangsumfang fuer einen spaeteren Spec-Kit-Haertungslauf. Ziel ist zu pruefen, ob {{PROJECT_NAME}} den Vorgaben aus `docs/secure-development/`, der Projekt-Constitution und den installierten Governance-Presets genuegt, und wo Nachweise oder Haertungen noch fehlen.

Das Lastenheft selbst nimmt keine Umsetzung vor. Es erzeugt nur den verbindlichen Pruef- und Dokumentationsrahmen fuer den spaeteren Lauf.

## 2. Ausgangslage

{{PROJECT_NAME}} ist ein Level-2-Projekt mit deklarierter oder erkannter Memory-Safe-Language-Basis. Das Projekt ist didaktisch und fachlich sicherheitsrelevant, weil Eingaben, Ausgaben, Build-/Testpfade, Abhaengigkeiten, Dokumentationsartefakte und Agentenflaechen nachvollziehbar gegen sichere Entwicklung geprueft werden muessen.

Die wiederverwendbare sichere-Entwicklung-Basis liegt in `docs/secure-development/`. Projektspezifische Sicherheitsnachweise gehoeren weiterhin nach `docs/security/` oder in die jeweils erzeugten Spec-Kit-Artefakte.

## 3. Zielbild des spaeteren Haertungslaufs

Der spaetere Spec-Kit-Lauf soll alle relevanten Pruefpunkte klassifizieren und dokumentieren:

- `Applicable`: der Pruefpunkt gilt fuer {{PROJECT_NAME}} und muss mit Evidenzpfad, Entscheidung und Ergebnis dokumentiert werden.
- `N/A`: der Pruefpunkt gilt nicht fuer diesen Lauf und muss mit kurzer Begruendung dokumentiert werden.
- `Open`: der Pruefpunkt gilt, ist aber noch nicht ausreichend erfuellt; Folgeaufgabe, Risiko oder technische Haertung ist zu dokumentieren.

Nicht anwendbare Punkte duerfen nicht stillschweigend ausgelassen werden.

## 4. Pruefgrundlagen

Der spaetere Lauf muss mindestens diese Grundlagen beruecksichtigen:

- `docs/secure-development/Richtlinie_Sichere-Entwicklung.md`
- `docs/secure-development/checklisten/`
- `docs/secure-development/Checklistensammelband_Sichere-Entwicklung.md`
- `docs/secure-development/mitgeltende-dokumente/`
- `constitution.md` und `.specify/memory/constitution.md`
- `docs/security/` als Standard-Evidenzpfad fuer projektspezifische Nachweise
- installierte Governance-Presets, soweit sie Projekt-Policy sind

## 5. Scope

Im spaeteren Spec-Kit-Lauf sollen insbesondere geprueft werden:

- Eingabevalidierung, Fehlerbehandlung und sichere Ausgabeformen
- Datei-, Netzwerk-, Prozess-, UI-, Datenbank- oder API-Grenzen, soweit vorhanden
- Build-, Test-, CI/CD- und Release-Pfade
- Dependency-, Supply-Chain-, SBOM-, AI-SBOM-, VEX- und SLSA-Nachweise, soweit anwendbar
- A11Y-, Dokumentations- und didaktische Kommentar-Governance
- Agentenflaechen, Spec-Kit-Artefakte und Governance-Presets
- projektspezifische `docs/security/`-Evidenzpfade oder begruendete `N/A`-Eintraege

## 6. Abgrenzung

Dieses Lastenheft loest keinen Haertungslauf aus und aendert keine Produktionslogik. Es werden keine Tests, keine Security-Evidenzen in `docs/security/`, keine Spec-Kit-Feature-Branches und keine Implementierungsartefakte erzeugt. Diese Schritte folgen separat durch den spaeteren Spec-Kit-Lauf.

## 7. Mindestanforderungen an den spaeteren Spec-Kit-Lauf

1. Relevante Checklisten aus `docs/secure-development/` auswaehlen und jede Auswahl begruenden.
2. Alle Pruefpunkte als `Applicable`, `N/A` oder `Open` dokumentieren.
3. Fuer `Applicable`-Punkte konkrete Evidenzpfade in `docs/security/`, Testdateien, Codeverweisen oder Spec-Kit-Artefakten benennen.
4. Fuer `N/A`-Punkte eine kurze technische oder fachliche Begruendung erfassen.
5. Fuer `Open`-Punkte Risiko, Folgeaktion und Prioritaet festhalten.
6. Secure Coding und Secure Architecture gemeinsam bewerten; MSL-Status ersetzt keine sichere API-, I/O-, Auth-, Crypto-, Logging- oder Dependency-Pruefung.
7. Relevante Trust Boundaries projektbezogen benennen.
8. A11Y- und didaktische Kommentar-Governance fuer nutzerseitige Artefakte pruefen.
9. Supply-Chain-, SBOM-, AI-SBOM-, C3A-/C5- und regulatorische Punkte nur anwenden, wenn sie fachlich greifen; sonst als `N/A` mit Begruendung erfassen.
10. Am Ende eine nachvollziehbare Ergebnisuebersicht mit offenen Risiken, akzeptierten Restrisiken und Folgeaufgaben erstellen.

## 8. Erwartete Ergebnisartefakte des spaeteren Laufs

Der spaetere Spec-Kit-Lauf soll mindestens folgende Ergebnisarten erzeugen oder aktualisieren:

| Artefakt | Erwartung |
|---|---|
| Spec-Kit `spec.md` | Haertungsziel, Scope, Nicht-Ziele und Pruefgrundlagen dokumentiert |
| Spec-Kit `plan.md` | Pruefstrategie, Governance-Presets und Evidenzpfade dokumentiert |
| Spec-Kit `tasks.md` | Konkrete Pruef-, Dokumentations- und Haertungsaufgaben ableitbar |
| `docs/security/` | Projektspezifische Nachweise oder begruendete `N/A`-Eintraege |
| Tests/CI | Nur falls aus dem Haertungslauf erforderlich, mit klarer Begruendung |
| Abschlussnotiz | Ergebnis, offene Punkte und Restrisiken auditfaehig zusammengefasst |

## 9. Akzeptanzkriterien fuer den spaeteren Haertungslauf

- Alle relevanten Punkte aus `docs/secure-development/` sind sichtbar behandelt.
- Kein relevanter Sicherheitsstandard aus Constitution oder Governance-Presets wurde stillschweigend ausgelassen.
- Jeder ausgelassene Punkt ist als `N/A` begruendet.
- Jeder offene Punkt ist als `Open` mit Folgeaktion dokumentiert.
- Jede positive Aussage zur Einhaltung verweist auf konkrete Evidenz.
- Das Projekt bleibt nach moeglichen spaeteren Haertungen baubar und testbar.
