<!-- intake-authoring:begin -->
# Lastenheft: Flottenweite GitHub-Copilot-Review-Governance und Kostenbegrenzung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review / Ready for Intake Review
**Version:** 1.0.0
**Stand:** 2026-08-19
**Aktive Serienrolle:** G4, `OrderedMember`, `Blocked`
**Bindender Vorgänger:** G3 Actions-Budget-Governance
**Bindender Nachfolger:** Position 7 Secure-Development-Container-Hardening
**Delivery Authority:** `LocalImplementation`
**Zielgruppe:** Maintainer, Repository-Verantwortliche, Flotten-Operator*innen und Reviewer
**Vorausgesetztes Wissen:** grundlegende GitHub- und Pull-Request-Kenntnisse; keine Spec-Kit- oder Copilot-Abrechnungserfahrung

## Deutscher Vertrag

### 1. Zweck und Zielzustand

Dieses Lastenheft reduziert automatische GitHub-Copilot-Code-Reviews auf eine
bewusst ausgewählte Referenzmenge. Es trennt Reviewqualität, AI-Credits und
GitHub-Actions-Runnerverbrauch, erhält die manuelle Anforderung von Copilot in
allen Repositories und macht Copilot niemals zum alleinigen Merge-Gate.

Der Live-Planungsstand zeigt 22 aktive Rulesets mit dem Regeltyp
`copilot_code_review`. Alle aktivieren derzeit sowohl Draft-Reviews als auch
erneute Reviews nach jedem Push. Sechs der acht Zielrepositories besitzen das
Ruleset bereits; `agent-operations-cockpit` und `tvision` noch nicht.

### 2. Abrechnungs- und Begriffsvertrag

- **AI Credit:** Nutzungsbasierte Abrechnungseinheit für den Modellanteil.
- **Actions-Minuten:** Runnerverbrauch für agentische Kontext- und Toolschritte
  eines Copilot-Reviews; er wird getrennt von AI Credits gemessen.
- **Lite:** Standard-Reviewaufwand für schnelle, gezielte Rückmeldung.
- **Automatisches Review:** Durch Account- oder Repository-Regel ausgelöste
  Prüfung ohne einzelne manuelle Reviewer-Anforderung.
- **Re-Review:** Erneute Prüfung desselben Pull Requests nach weiteren Änderungen.

Für den angegebenen monatlichen Copilot-Pro+-Tarif zu 39 USD gilt im aktuellen
nutzungsbasierten Modell ein Kontingent von 7.000 AI Credits, bestehend aus
3.900 Basis- und 3.100 Flex-Credits. Der spätere Preflight muss das tatsächlich
aktive Abrechnungsmodell und die Anzeige im persönlichen Usage-Dashboard
bestätigen. Jährliche Legacy-Verträge dürfen nicht stillschweigend gleichgesetzt
werden. Zusätzliche Budgets oder das Abonnement selbst werden nicht verändert.

Verbindliche Referenzen:

- https://docs.github.com/en/copilot/concepts/billing/usage-based-billing-for-individuals
- https://docs.github.com/en/copilot/reference/copilot-billing/models-and-pricing
- https://docs.github.com/en/copilot/how-tos/copilot-on-github/set-up-copilot/configure-automatic-review
- https://docs.github.com/en/copilot/concepts/agents/code-review

### 3. Verbindliche Zielmenge

Automatische Reviews bleiben ausschließlich auf diesen acht Repositories
aktiv:

1. `hindermath/home-baseline` (`main`)
2. `hindermath/agent-operations-cockpit` (`main`)
3. `hindermath/TuiVision` (`main`)
4. `hindermath/TinyPl0` (`main`)
5. `hindermath/TinyCalc` (`main`)
6. `hindermath/InventarWorkerService` (`main`)
7. `hindermath/cc65` (`master`)
8. `hindermath/tvision` (`master`)

`TuiVision` ist zugleich Canary und genanntes Public-Produkt und wird nur
einmal gezählt.

### 4. Verbindliche Anforderungen

- **CRG-001 – Live-Preflight:** Vor jeder Mutation werden Account-Automatik,
  Abrechnungsmodell, Default-Branches, Sichtbarkeit und alle aktiven
  `copilot_code_review`-Rulesets erneut read-only ermittelt.
- **CRG-002 – Accountgrenze:** Die persönliche accountweite automatische
  Copilot-Review-Einstellung wird deaktiviert, damit ausschließlich
  Repository-Rulesets die Automatik steuern.
- **CRG-003 – Genau acht:** Nach Abschluss besitzen genau die acht benannten
  Repositories ein aktives automatisches Copilot-Review-Ruleset.
- **CRG-004 – Bestehende sechs:** Die vorhandenen Rulesets in `home-baseline`,
  `TuiVision`, `TinyPl0`, `TinyCalc`, `InventarWorkerService` und `cc65` werden
  auf den Zielvertrag umgestellt.
- **CRG-005 – Neue zwei:** `agent-operations-cockpit` und `tvision` erhalten
  ein aktives Ruleset für ihren jeweiligen Default-Branch.
- **CRG-006 – Reversible Reduktion:** Die übrigen 16 derzeit aktiven Rulesets
  werden deaktiviert und nicht gelöscht. Dazu gehören zwölf Preset-Repositories
  sowie `hindermath`, `spec-kit`, `opencode` und `GUI64`.
- **CRG-007 – Ein Review:** Pro Pull Request wird höchstens ein automatisches
  Review ausgelöst: beim offenen Erstellen oder beim ersten Wechsel von Draft
  zu Ready.
- **CRG-008 – Keine Draft-Automatik:** `review_draft_pull_requests` ist auf den
  acht Rulesets `false`.
- **CRG-009 – Keine Push-Automatik:** `review_on_push` ist auf den acht
  Rulesets `false`; ein Re-Review wird nur bewusst manuell angefordert.
- **CRG-010 – Lite:** Der Standardaufwand für automatische Reviews ist `Lite`.
  Ein teurerer Aufwand benötigt eine bewusste manuelle Entscheidung.
- **CRG-011 – Manuelle Verfügbarkeit:** Copilot darf in allen Repositories
  weiterhin manuell als Reviewer angefordert werden.
- **CRG-012 – Advisory:** Copilot ist kein alleiniger Required Reviewer und
  ersetzt weder menschliche Bewertung noch technische CI- und Sicherheitsgates.
- **CRG-013 – Zwei Kostenachsen:** Evidence weist AI-Credit-Verbrauch und
  Copilot-Code-Review-Actions-Minuten getrennt aus.
- **CRG-014 – Keine Scheingenauigkeit:** Da GitHub das automatisch gewählte
  Reviewmodell nicht vorab offenlegt, wird kein fester Preis pro Review
  behauptet. Gemessen werden Auslösungen und tatsächlicher Verbrauch.
- **CRG-015 – Reproduzierbare Mutation:** Jede GitHub-Einstellungsänderung
  besitzt Vorher-/Nachher-Evidence, exakte Repository- und Ruleset-IDs sowie
  einen begrenzten Rollback-Pfad.
- **CRG-016 – Berechtigungsgrenze:** Read-only-Inventur und lokale
  Implementierung dürfen unter `LocalImplementation` erfolgen. Externe
  GitHub-Mutationen benötigen eine spätere ausdrückliche Delivery-Autorität.
- **CRG-017 – Datenschutz:** Evidence enthält keine Tokens, Cookies,
  vollständigen Abrechnungsbelege oder unnötigen personenbezogenen Daten.
- **CRG-018 – Dokumentation:** Documentation Impact ist `UpdateRequired`;
  Scope, manuelles Re-Review, Kostenachsen, Rollback und Re-Evaluation werden
  bilingual dokumentiert.

### 5. Ergebnisartefakte

- maschinenlesbarer Sollvertrag für acht aktive automatische Rulesets;
- read-only Inventur- und Driftbericht für Account und Repositories;
- idempotente, explizit autorisierbare Apply-/Rollback-Oberfläche;
- redigierte Vorher-/Nachher-Evidence mit Ruleset-IDs und Parametern;
- Nutzungsbericht für automatische und manuelle Reviews, AI Credits und
  Actions-Minuten;
- Betriebsdokumentation für Lite, manuelles Re-Review und Ausnahmefälle.

### 6. Qualitäts-, Sicherheits- und A11Y-Grenzen

Inventur, Vorschau und Ergebnis sind linear, textorientiert und ohne Farbe
verständlich. Jede Zeile nennt Repository, Default-Branch, Zustand, geplante
Aktion und Ergebnis. API- und Browserfehler dürfen keinen teilweisen Erfolg als
vollständigen Pass ausgeben. Mutationen erfolgen zielgenau anhand zuvor
gelesener IDs; unbekannte oder abweichende Rulesets führen zum Hard Stop.
WCAG 2.2 AA und CEFR B2 gelten für CLI und Dokumentation.

### 7. Nicht-Ziele und Hard Stops

- keine Änderung des Copilot-Pro+-Abonnements oder zusätzlicher AI-Credit-Budgets;
- keine Löschung der 16 deaktivierten Rulesets;
- keine automatische Reviewpflicht für private Repositories;
- kein `Balanced`-Standard und keine automatischen Re-Reviews je Push;
- kein Ersatz menschlicher Reviews, technischer CI oder Security-Gates;
- keine Self-hosted- oder größere Runnerarchitektur;
- keine GitHub-Mutation unter der aktuellen `LocalImplementation`-Autorität;
- kein automatisches Committen, Pushen, Mergen, Admin-Bypass oder Starten von
  Position 7.

### 8. Risiken und Gegenmaßnahmen

- Eine accountweite Automatik könnte Repo-Regeln überlagern; deshalb ist ihr
  Zustand ein Pflicht-Preflight und sie wird im Zielzustand deaktiviert.
- Default-Branches oder Ruleset-IDs können driften; deshalb werden sie vor der
  Mutation erneut ermittelt und hashgebunden dokumentiert.
- Weniger Re-Reviews können spätere Fehler übersehen; deshalb bleiben manuelle
  Re-Reviews sowie technische und menschliche Gates verfügbar.
- AI-Credit-Kosten schwanken je Modell und Kontext; deshalb werden echte
  Nutzung und Reviewanzahl getrennt gemessen.
- Eine unterbrochene Fleet-Mutation kann Mischzustände erzeugen; deshalb sind
  Vorschau, zielgenaue Apply-Schritte, Ergebnisinventur und Rollback Pflicht.

### 9. Messbare Abnahme

- **AC-CRG-001:** Der Preflight weist Abrechnungsmodell, Account-Automatik,
  Default-Branches und vollständige Ruleset-Menge nach.
- **AC-CRG-002:** Genau acht automatische Rulesets sind aktiv; ihre
  Repository-/Branch-Menge entspricht Abschnitt 3.
- **AC-CRG-003:** Die übrigen 16 früher aktiven Rulesets sind deaktiviert,
  weiterhin vorhanden und über ihre IDs rückrollbar.
- **AC-CRG-004:** Auf allen acht Rulesets sind Draft- und Push-Re-Reviews aus;
  der automatische Aufwand ist `Lite`.
- **AC-CRG-005:** Ein neuer Open-PR oder erster Draft-to-Ready-Wechsel erzeugt
  höchstens ein automatisches Review; ein weiterer Push erzeugt keines.
- **AC-CRG-006:** In jedem anderen Repository entsteht ohne manuelle
  Anforderung kein Copilot-Review.
- **AC-CRG-007:** Menschliche Review- und technische Merge-Gates bleiben
  unverändert und Copilot ist nicht allein required.
- **AC-CRG-008:** AI Credits und Copilot-Actions-Minuten werden getrennt und
  ohne geheime Abrechnungsdaten berichtet.
- **AC-CRG-009:** Apply und Rollback sind idempotent; ein zweiter Check meldet
  null Drift.
- **AC-CRG-010:** Position 7 wurde nicht gestartet.

### 10. Reihenfolge und Abschlussgrenze

G4 bleibt blockiert, bis G3 abgeschlossen und die `ActionsBudgetBaseline`
nachgewiesen ist. Nach einem später erfolgreich abgeschlossenen G4 liefert es
die `CopilotReviewGovernanceBaseline` für Position 7. Weder `Blocked` noch ein
späteres `Eligible` erteilt GitHub-Schreib-, Commit-, Push-, Merge- oder
Bypass-Autorität.

## English Contract

### 11. Purpose and target state

This intake reduces automatic GitHub Copilot code review to an explicit
reference set. It separates review quality, AI credits, and GitHub Actions
runner usage, preserves manual Copilot review in every repository, and never
makes Copilot the sole merge gate. The planning snapshot contains 22 active
automatic-review rulesets, all currently reviewing drafts and every new push.

### 12. Binding requirements

- **CRG-001–003:** Re-inventory billing mode, account automation, branches and
  rulesets; disable account-wide automation; keep exactly the eight named
  repository rulesets active.
- **CRG-004–006:** Reconfigure the existing six, add
  `agent-operations-cockpit` and `tvision`, and disable rather than delete the
  other sixteen rulesets.
- **CRG-007–010:** Run at most one automatic Lite review when a PR opens or
  first becomes Ready; disable draft and push-triggered reviews.
- **CRG-011–014:** Preserve manual review everywhere, keep Copilot advisory,
  report AI credits separately from Actions minutes, and do not claim a fixed
  per-review price.
- **CRG-015–018:** Use exact-ID before/after evidence and rollback, require
  explicit authority for GitHub writes, redact private billing data, and update
  bilingual documentation.

### 13. Acceptance and boundaries

Acceptance proves exactly eight active automatic rulesets, sixteen disabled
and recoverable former rulesets, `Lite` effort, no draft or push automation,
at most one automatic review per qualifying PR, no unrequested review
elsewhere, unchanged human and technical merge gates, separate usage metrics,
idempotent apply/rollback, and no Position-7 start. Subscription changes,
additional budgets, ruleset deletion, self-hosted runners, remote mutation
under `LocalImplementation`, commit, push, merge, and admin bypass are outside
this intake's current authority.

<!-- intake-authoring:prompts -->
## Kopierbare Spec-Kit-Prompts / Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Flottenweite-GitHub-Copilot-Review-Governance-und-Kostenbegrenzung.md` as the binding G4 intake after G3. Specify the exact eight-repository automatic-review set, disabled account-wide automation, six ruleset updates, two additions, sixteen reversible disables, one Lite review on open or first Draft-to-Ready, no draft or push rereviews, manual review availability, advisory-only Copilot status, separate AI-credit and Actions-minute evidence, exact-ID rollback, privacy, A11Y, and authority gates. Preserve CRG-001 through CRG-018 and AC-CRG-001 through AC-CRG-010. Do not implement, mutate GitHub, change billing, start Position 7, commit, push, merge, or use an admin bypass.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the reviewed Spec Kit feature for `Lastenheft_Flottenweite-GitHub-Copilot-Review-Governance-und-Kostenbegrenzung.md` with deliveryAuthority=LocalImplementation only after G3 is completed. Implement and verify repository-owned inventory, policy, dry-run, test, statistics, documentation, and redacted evidence surfaces locally. Do not mutate GitHub account or ruleset settings under this authority; stop at the external-write gate and do not claim full completion until separate current authority is granted. Do not change the subscription or budget, commit, push, merge, use an admin bypass, sync Home, or start Position 7.
```

<!-- intake-authoring:end -->
