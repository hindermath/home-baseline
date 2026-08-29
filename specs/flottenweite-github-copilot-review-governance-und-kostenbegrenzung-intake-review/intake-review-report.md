# Intake Review: Flottenweite GitHub-Copilot-Review-Governance und Kostenbegrenzung

## Identität / Identity

- Review-ID: `d76c8231-c875-41ee-9dfc-65afe756f626`
- Modus / Mode: `Single`
- Policy: `home-baseline-active-lastenhefte-v1`
- Ergebnis / Outcome: `Ready`
- Ziel / Target:
  `Lastenheft_Flottenweite-GitHub-Copilot-Review-Governance-und-Kostenbegrenzung.031-github-copilot-review-governance.md`
- Normalized SHA-256:
  `303ef5b04b259389006d32f0c565cd335b2ff4d126aebc084d77ae124f96d6c5`
- Git-Blob: `a132e04115f06ec7e3591c5dee179e437ab3415d`
- Ziele / Targets: `1`
- Worker: `0`
- Supersedes: `N/A`

## Ergebnis / Outcome

Das G4-Lastenheft ist für den autonomen Spec-Kit-Lauf bereit. Der vollständige
Single-Review hat keine Findings, offenen Fragen, akzeptierten Risiken oder
Operator-Ausnahmen ergeben. Zweck, Zielgruppe, Scope, acht Zielrepositories,
18 atomare Anforderungen, zehn messbare Abnahmekriterien, reversible
Ruleset-Reduktion, Kostenachsen, Datenschutz, A11Y, Risiken und Copy-Ready-
Prompts sind konsistent.

Die im Lastenheft dokumentierten Zahlen `22`, `6`, `2` und `16` bleiben ein
Planungssnapshot und werden nicht als aktuelle Providerfakten übernommen.
`CRG-001` verlangt vor jeder Mutation ausdrücklich eine frische read-only
Inventur; unbekannte oder abweichende IDs stoppen fail-closed.

*The G4 intake is ready for an autonomous Spec Kit run. The complete single
review found no findings, open questions, accepted risks, or operator
exceptions. Historical inventory counts remain planning evidence only and
must be replaced by the live read-only preflight required by CRG-001.*

## Aktuelle Lifecycle- und Autoritätsbindung / Current Lifecycle and Authority Binding

Die im Intake enthaltenen Felder `OrderedMember`, `Blocked` und
`LocalImplementation` dokumentieren den authoring-zeitlichen Ausgangszustand
und erteilen selbst keine weitere Autorität. Die aktuell autoritativen,
getrennten Nachweise lauten:

- Stage B ist operativ mit `194/194` Tasks abgeschlossen; T194 weist null
  G4-, Serien-, Copilot-, Account- oder Subscription-Mutation vor dem
  Sequencing-Handoff nach.
- Das aktive Serienmanifest ist in Bash und PowerShell gültig und erklärt G4
  als `Primary` sowie einzigen bevorzugten `Eligible`-Kandidaten.
- Die aktuelle Benutzerfreigabe setzt für diesen Run
  `deliveryMode=MergeAndSync` und autorisiert einen zielgebundenen
  Admin-Bypass nach regulärem protection-only Merge-Refusal.
- Diese Delivery-Freigabe erteilt nicht stillschweigend Secret-Zugriff,
  Abonnement- oder Budgetänderungen beziehungsweise allgemeine
  Provider-Administration. Solche Operationen bleiben am External-Write-Gate
  exakt und aktuell zu binden.

## Vollständige Checklistenabdeckung / Complete Checklist Coverage

- Identität, Zielgruppe, Zweck, Scope und Nicht-Ziele: `PASS`
- Vorausgesetztes Wissen und erstmalige Begriffserklärung: `PASS`
- Atomare Anforderungen `CRG-001` bis `CRG-018`: `PASS`
- Messbare Abnahme `AC-CRG-001` bis `AC-CRG-010`: `PASS`
- Exakte Acht-Repository-Menge und Default-Branches: `PASS`
- Einmalige Lite-Automatik ohne Draft- oder Push-Re-Review: `PASS`
- Reversible Deaktivierung statt Löschung: `PASS`
- Manuelle Review-Verfügbarkeit und Advisory-Grenze: `PASS`
- AI Credits und Actions-Minuten als getrennte Kostenachsen: `PASS`
- Exact-ID-Apply, Idempotenz, Rollback und Hard Stops: `PASS`
- Datenschutz, Secret-Redaktion und Datenminimierung: `PASS`
- WCAG 2.2 AA, CEFR B2 und lineare Textausgabe: `PASS`
- Deutsch zuerst, Englisch danach: `PASS`
- Plattform- und Providerfehlergrenzen: `PASS`
- Specify-/Autonomous-Prompt-Ausrichtung: `PASS`
- UTF-8, kein Binärinhalt und keine eingebetteten Secrets: `PASS`

## Referenz- und Kostenprüfung / Reference and Cost Review

Die vier GitHub-Referenzen wurden am 28. August 2026 gegen die aktuelle
offizielle Dokumentation geprüft. Sie bestätigen das individuelle
Automatic-Review-Setting, repositoryseitige Rulesets, die Optionen für Drafts
und neue Pushes, `Lite`/`Balanced`, getrennte AI-Credit- und Actions-Minuten
sowie für Copilot Pro+ den Monatspreis von 39 USD und insgesamt 7.000
enthaltene AI Credits aus 3.900 Basis- und 3.100 Flex-Credits. Legacy-
Jahresverträge bleiben ausdrücklich ein separater Pfad.

## Risiken und Fragen / Risks and Questions

- Critical: `0`
- High: `0`
- Medium: `0`
- Low: `0`
- Akzeptierte Risiken / Accepted risks: `0`
- Offene Fragen / Open questions: `0`
- Operator-Ausnahmen / Operator exceptions: `0`

## Dokumentationsauswirkung / Documentation Impact

`UpdateRequired`, durch Intake, Reviewbericht und nachfolgende G4-Artefakte zu
erfüllen:

- Kanonische fachliche Quelle: G4-Lastenheft; Owner: Fleet Governance Owner.
- Leserpfad: Lastenheft → Ready-Review → Spezifikation → Betriebsdokumentation
  → redigierte Evidence → Retrospektive.
- Dokumentklasse: bilinguales source-only Spec-Kit-Feature mit lokaler und
  Provider-Evidence.
- Home-Sync wird nur bei tatsächlich geänderten `homeRuntime`-Pfaden notwendig.
- Re-Evaluation: Intake-Hash, Zielmenge, Ruleset-/Account-API, Billingmodell,
  Delivery Authority, Merge-Head, Review-/Gatezustand oder Serienposition
  ändern sich.

## Nächste Aktion / Next Action

```text
$speckit-autonomous Lastenheft_Flottenweite-GitHub-Copilot-Review-Governance-und-Kostenbegrenzung.031-github-copilot-review-governance.md deliveryMode=MergeAndSync adminBypass=Authorized
```

Diese Aktion ist durch den aktuellen Benutzerauftrag ausdrücklich freigegeben.

*The current user request explicitly authorizes this next action.*
