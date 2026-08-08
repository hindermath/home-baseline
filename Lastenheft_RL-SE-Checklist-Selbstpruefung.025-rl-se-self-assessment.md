<!-- intake-authoring:begin -->
# Lastenheft: RL-SE-/Checklist-Selbstpruefung

**Repository:** home-baseline
**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** vorbereitet fuer separaten RL-SE-/CL-Selbstpruefungslauf
**Stand:** 2026-08-08
**Zielgruppe:** Maintainer und Ausbildungsverantwortliche; sekundaer Auszubildende
**Delivery Authority:** `MergeAndSync`

## 1. Zweck

Dieses Lastenheft beschreibt einen spaeteren Spec-Kit-Prueflauf gegen die
generische Secure-Development-Basis. Ziel ist nicht sofortige Haertung, sondern
eine nachvollziehbare Selbstpruefung, ob ein Zielrepository die Anforderungen
aus Richtlinie Sichere Entwicklung, Checklisten, Sammelband, mitgeltenden
Dokumenten und Governance-Presets behandelt, begruendet oder als offen markiert.

Das Lastenheft ist die Level-0-Referenz fuer spaetere repo-spezifische
`Lastenheft_RL-SE-Checklist-Selbstpruefung.md`-Dateien. Es startet keinen
Spec-Kit-Lauf und erzeugt keine projektspezifischen `docs/security/`-Nachweise.

### Reihenfolge und Abhaengigkeiten / Order and Dependencies

Dieser Intake steht auf Position 6. Die frueher bindende Assessment Baseline
auf Position 5 ist als Feature 024 abgeschlossen. Die aktuelle Quelle ist
`Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.024-mitgeltende-dokumente-verzahnung.md`;
der unveraenderliche Abschlussnachweis steht in
`specs/024-mitgeltende-dokumente-verzahnung/pr-evidence.md`. Vor einem
nachgelagerten Lauf muss dieser Abschlussnachweis gelesen werden. Im aktiven
Series-Manifest ist Position 6 deshalb jetzt eine Root und der einzige
bevorzugte `Eligible`-Kandidat. `Eligible` erteilt keine Start- oder
Delivery-Autoritaet.

Feature 024 wurde ueber PR #208 geliefert und ueber den kausalen Closeout-PR
#209 abgeschlossen. Diese Evidence bindet zwoelf Checklisten, 157
Pruefpunkte, 15 mitgeltende Dokumente und das Acht-plus-drei-Presetprofil. Der
spaetere Lauf validiert diese Zuordnung, statt sie neu zu erfinden.

*This intake is item 6. The formerly binding assessment baseline at item 5 was
completed as Feature 024. The current source and immutable completion evidence
are named above and must be read before downstream work. Item 6 is therefore a
root and the sole preferred `Eligible` candidate in the active Series.
Eligibility grants neither start nor delivery authority.*

## 2. Ausgangslage

Die Secure-Development-Basis unter `docs/secure-development/` ist als
wiederverwendbare, auditfaehige Grundlage fuer Level-2-Repositories vorhanden.
Sichere Entwicklung ist fuer heutige, geopolitisch angespannte
Softwareentwicklung ein Muss. Deshalb wird die Selbstpruefung unabhaengig davon
vorbereitet, ob eine Primaersprache als Memory-Safe Language (MSL) erkannt wird.

MSL-Status bleibt ein Pruefpunkt. Er ersetzt aber keine Pruefung von
Programmierschnittstellen (APIs), Ein- und Ausgabe (I/O), Authentifizierung,
Autorisierung, Kryptografie, Logging,
Abhaengigkeiten, Build-/Release-Pfaden oder agentischer Entwicklung.

## 3. Zielgruppe, Vorwissen und Sprachvertrag / Audience, Prior Knowledge, and Language Contract

Primäre Zielgruppe sind Maintainer und Ausbildungsverantwortliche, sekundäre
Zielgruppe sind Auszubildende. Vorausgesetzt werden grundlegende Git-,
Markdown- und Repository-Kenntnisse, aber keine Spec-Kit-Erfahrung und keine
Kenntnis der verwendeten Sicherheitsabkürzungen. Spec Kit bezeichnet hier den
anforderungsgeleiteten Workflow aus Spezifikation, Plan, Aufgaben und
kontrollierter Umsetzung.

Fachbegriffe werden bei der ersten Verwendung erklärt. Nutzerseitige
Ergebnisartefakte bleiben linear und textorientiert, sind auf die anwendbaren
Kriterien der Web Content Accessibility Guidelines (WCAG) 2.2 Level AA
ausgerichtet, verwenden Sprache auf Niveau B2 des Gemeinsamen Europäischen
Referenzrahmens für Sprachen (CEFR) und enthalten den vollständigen Inhalt
zuerst auf Deutsch und danach auf Englisch. Beide Sprachfassungen müssen
dieselben Entscheidungen, Grenzen, Risiken, Evidenzen und nächsten Aktionen
enthalten.

*The primary audience is maintainers and training leads; apprentices are the
secondary audience. Basic Git, Markdown, and repository knowledge is assumed,
but no Spec Kit experience or knowledge of security abbreviations is assumed.
Terms are explained on first use. User-facing results remain linear and
text-first, target applicable WCAG 2.2 Level AA criteria, use CEFR-B2 language,
and provide the complete content in German first and English second. Both
language versions carry the same decisions, boundaries, risks, evidence, and
next actions.*

## 4. Pruefgrundlagen

Der spaetere Spec-Kit-Lauf muss mindestens diese Grundlagen beruecksichtigen:

- `docs/secure-development/Richtlinie_Sichere-Entwicklung.md`
- `docs/secure-development/Checklistensammelband_Sichere-Entwicklung.md`
- `docs/secure-development/checklisten/CL_01_*.md` bis `CL_12_*.md`
- `docs/secure-development/mitgeltende-dokumente/`
- `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`
- `constitution.md` und `.specify/memory/constitution.md`, soweit vorhanden
- installierte Governance-Presets, soweit sie Projekt-Policy sind
- vorhandene Spec-Kit-Artefakte, `docs/security/`, Tests, CI und Review-Notizen

## 5. Begriffe / Terms

- **Evidenz:** ein konkret benannter und pruefbarer Nachweis, zum Beispiel ein
  Repository-Pfad, Testergebnis oder Review-Bericht.
- **Owner:** die fuer Klaerung oder Folgearbeit verantwortliche Rolle oder
  Person; private Kontaktdaten werden nicht verlangt.
- **Follow-up:** eine begrenzte Folgeaktion ausserhalb des aktuellen
  Pruefschritts.
- **Re-Evaluation-Trigger:** ein pruefbares Ereignis, bei dem eine Entscheidung
  erneut bewertet werden muss.
- **Software Bill of Materials (SBOM):** maschinenlesbare Liste der
  Softwarebestandteile und Abhaengigkeiten; eine AI-SBOM erweitert diese Sicht
  um relevante KI-Modelle, Daten- oder Dienstkomponenten.
- **Vulnerability Exploitability eXchange (VEX):** Aussage, ob eine bekannte
  Schwachstelle ein Produkt tatsaechlich betrifft.
- **Supply-chain Levels for Software Artifacts (SLSA):** Rahmen fuer
  nachvollziehbare Build-Provenienz und Artefaktintegritaet.
- **BSI C3A/C5:** Bewertungsrahmen des Bundesamts fuer Sicherheit in der
  Informationstechnik fuer Cloud-Autonomie beziehungsweise
  Cloud-Compliance-Assurance.
- **NIS2, CRA, EU AI Act und DORA:** europaeische Regulierungsrahmen, deren
  Anwendbarkeit nur anhand des konkreten Projekts entschieden wird.
- **A11Y:** Kurzform fuer Barrierefreiheit; die Ziffern stehen fuer die elf
  ausgelassenen Buchstaben im englischen Wort `accessibility`.
- **QISMS:** Informationssicherheitsmanagement im jeweiligen
  Qualitaetsmanagement-Kontext; eine formale Wirksamkeitsaussage braucht
  unabhaengige Evidenz.

*Evidence is a concrete, verifiable proof. Owner, follow-up, and re-evaluation
trigger identify responsibility, bounded later work, and the event that causes
a decision to be reviewed again. SBOM, VEX, SLSA, cloud-assurance frameworks,
regulation, accessibility, and QISMS applicability must be explained and
decided for the target repository rather than assumed.*

## 6. Zielbild des spaeteren Prueflaufs

Der spaetere Lauf erzeugt eine Evidenz- und Anwendbarkeitsmatrix. Jeder
relevante Pruefpunkt erhaelt einen Status:

- `Applicable`: gilt fuer das Zielrepository und braucht Evidenz oder Umsetzung.
- `AlreadySatisfied`: ist im aktuellen Stand bereits nachweisbar erfuellt.
- `N/A`: gilt fuer diesen Lauf nicht und braucht eine kurze Begruendung.
- `Open`: gilt, ist aber noch nicht ausreichend geklaert oder belegt.
- `FollowUp`: fachlich relevant, aber bewusst ausserhalb dieses Laufs.

Jede Matrixzeile enthaelt eine eindeutige Pruefpunkt-ID, die normative Quelle,
den Status und eine kurze Begruendung. Zusaetzlich gelten folgende
statusabhaengige Pflichtfelder:

- `Applicable`: geplanter Evidenz- oder Umsetzungspfad, Owner, Prioritaet,
  Risiko und Re-Evaluation-Trigger.
- `AlreadySatisfied`: konkreter Evidenzpfad.
- `N/A`: fachliche oder technische Begruendung und Re-Evaluation-Trigger.
- `Open`: Owner, Klaerungs- oder Folgeaktion, Prioritaet, Risiko und
  Re-Evaluation-Trigger.
- `FollowUp`: Owner, begruendete Folgeaktion, Prioritaet, Risiko und
  Re-Evaluation-Trigger.

## 7. Scope

Im spaeteren Prueflauf werden insbesondere behandelt:

- Standards-Anwendbarkeit, MSL-Status und sprachspezifische Secure-Coding-Regeln
- Eingabevalidierung, Trust Boundaries, Fehlerbehandlung und sichere Ausgabe
- Authentifizierung, Autorisierung, Rollen, Secrets und Konfiguration
- Datei-, Netzwerk-, Datenbank-, UI-, CLI-, API- oder Prozessgrenzen
- Dependency-, Supply-Chain-, SBOM-, AI-SBOM-, VEX- und SLSA-Punkte
- BSI C3A/C5, NIS2, CRA, EU AI Act und DORA nur bei fachlicher Anwendbarkeit
- A11Y/WCAG 2.2 AA, DE-first/EN-second, CEFR B2 und didaktische Kommentare
- Sandbox, agentische Entwicklung, Toolchain und Spec-Kit-Governance

## 8. Abgrenzung

- Keine automatische Haertung des Repositorys.
- Kein Sammellauf ueber mehrere Repositories.
- Keine Feature-Branch-Erzeugung durch dieses Lastenheft.
- Keine erfundene formale Freigabe, kein QISMS-/Audit-Claim ohne Evidenz.
- Keine Repo-Sichtbarkeit, Branch-Protection, Secrets, Provider oder Modelle konfigurieren.
- Keine echten Kundendaten, produktiven Tokens oder privaten Pfade dokumentieren.

## 9. Mindestanforderungen an den spaeteren Spec-Kit-Lauf

1. Aktuellen Repository-Stand lesen und bereits erledigte Punkte nicht neu umsetzen.
2. Die Verzahnungsdatei zuerst nutzen, um Richtlinie, CLs, Presets und Evidenzpfade zuzuordnen.
3. Jede Matrixzeile mit Pruefpunkt-ID, normativer Quelle, Status und kurzer
   Begruendung erfassen.
4. Alle relevanten Pruefpunkte als `Applicable`, `AlreadySatisfied`, `N/A`,
   `Open` oder `FollowUp` klassifizieren.
5. Fuer `Applicable` den geplanten Evidenz- oder Umsetzungspfad, Owner,
   Prioritaet, Risiko und Re-Evaluation-Trigger festhalten.
6. Fuer `AlreadySatisfied` einen konkreten Evidenzpfad benennen.
7. Fuer `N/A` eine fachliche oder technische Begruendung und einen
   Re-Evaluation-Trigger erfassen.
8. Fuer `Open` Owner, Klaerungs- oder Folgeaktion, Prioritaet, Risiko und
   Re-Evaluation-Trigger festhalten.
9. Fuer `FollowUp` Owner, begruendete Folgeaktion, Prioritaet, Risiko und
   Re-Evaluation-Trigger festhalten.
10. Positive Aussagen zur Einhaltung nur mit konkreter Evidenz treffen.
11. Human-only-Punkte sichtbar abgrenzen und nicht als erledigt behaupten.
12. Jedes nutzerseitige Ergebnisartefakt vollstaendig Deutsch zuerst und
    Englisch danach, textorientiert, WCAG-2.2-AA-tauglich und auf
    CEFR-B2-Niveau ablegen.
13. Nur tatsaechliche, reproduzierbare und nicht leere Befunde als
    Remediation-Bedarf ausweisen.
14. Jeden Remediation-Befund mit stabiler ID, Scope, Owner, Prioritaet,
    Risiko, Evidence und Re-Evaluation-Trigger versehen.
15. Unterschiedliche Owner, Liefergrenzen oder Sicherheitsgrenzen nicht in
    einen pauschalen Sammel-Intake zwingen.
16. Keine Remediation innerhalb dieses Selbstpruefungslaufs implementieren
    und keinen Folge-Intake oder Folgelauf automatisch starten.
17. Den Lauf mit `MergeAndSync` liefern. Der enge Admin-Bypass ist nur bei
    gruenen technischen Gates, null umsetzbaren Review-Threads und Human
    Approval als einzigem verbleibenden Gate zulaessig.

### 9.1 Remediation-Handoff / Remediation Handoff

Ein bestaetigter Befund wird nach Abschluss dieses Laufs in dieser Reihenfolge
weiterbehandelt:

1. `$speckit-intake-create` erzeugt aus den benannten Findings und ihrer
   Evidence genau einen fachlich zusammenhaengenden Remediation-Intake.
2. `$speckit-intake-review` prueft jeden neuen Intake einzeln. Nur `Ready` oder
   ein ausdruecklich menschlich akzeptiertes `ReadyWithAcceptedRisks` darf
   weitergegeben werden.
3. `$speckit-intake-series-update` ordnet einen nicht leeren und geprueften
   Intake mit begruendeten Kanten in die aktive Series ein.
4. `$speckit-intake-series-status` und `$speckit-intake-series-next`
   bestaetigen Hashes, Abhaengigkeiten und den zulaessigen naechsten Kandidaten.
5. Erst eine neue ausdrueckliche Benutzeranweisung startet den betreffenden
   `$speckit-autonomous`-Lauf mit aktueller Delivery Authority.

Ein leerer, spekulativer oder bereits erledigter Befund erzeugt keinen Intake.
Die dokumentierte Intake-Idee ist deshalb noch keine Ausfuehrungsautoritaet.

*Confirmed findings become bounded remediation intakes only after this audit.
Create, review, series admission, and autonomous delivery remain separate
governance steps. A later autonomous remediation run requires a new explicit
user instruction and current delivery authority.*

## 10. Erwartete Ergebnisartefakte

| Artefakt | Erwartung |
|---|---|
| Spec-Kit `spec.md` | Ziel, Scope, Nicht-Ziele, Pruefgrundlagen und Statuslogik dokumentiert |
| Spec-Kit `plan.md` | Pruefstrategie, Evidenzpfade, Standards und Presets nachvollziehbar |
| Spec-Kit `tasks.md` | Konkrete Pruef-, Dokumentations- und Follow-up-Aufgaben ableitbar |
| Evidenzmatrix | Gemeinsame Felder und die festgelegten statusabhaengigen Pflichtfelder fuer `Applicable`, `AlreadySatisfied`, `N/A`, `Open` und `FollowUp` |
| `docs/security/` | Projektspezifische Nachweise oder begruendete N/A-/Open-Eintraege |
| Abschlussnotiz | Ergebnis, offene Risiken, Restrisiken und Re-Evaluation-Trigger |
| Remediation-Handoff | Stabile Finding-IDs und getrennte, nicht automatisch ausgefuehrte Intake-Vorschlaege nur bei echtem Bedarf |

Alle nutzerseitigen Artefakte enthalten den vollständigen Inhalt Deutsch
zuerst und Englisch danach. Die Sprachfassungen besitzen denselben
Informationsgehalt und bleiben ohne Farbe, Diagramm oder visuelle Position
verständlich.

## 11. Akzeptanzkriterien

- Alle relevanten Punkte aus Richtlinie, Sammelband, CL_01 bis CL_12 und mitgeltenden Dokumenten sind sichtbar behandelt.
- Kein relevanter Governance-Preset-Pruefpunkt wurde stillschweigend ausgelassen.
- Jede Matrixzeile besitzt Pruefpunkt-ID, normative Quelle, Status und kurze
  Begruendung.
- Jeder `Applicable`-Eintrag besitzt geplanten Evidenz- oder Umsetzungspfad,
  Owner, Prioritaet, Risiko und Re-Evaluation-Trigger.
- Jeder `AlreadySatisfied`-Eintrag besitzt einen konkreten Evidenzpfad.
- Jeder `N/A`-Eintrag besitzt fachliche oder technische Begruendung und
  Re-Evaluation-Trigger.
- Jeder `Open`-Eintrag besitzt Owner, Klaerungs- oder Folgeaktion, Prioritaet,
  Risiko und Re-Evaluation-Trigger.
- Jeder `FollowUp`-Eintrag besitzt Owner, begruendete Folgeaktion, Prioritaet,
  Risiko und Re-Evaluation-Trigger.
- Jede positive Aussage verweist auf konkrete Evidenz.
- Das Projekt bleibt nach der Pruefung baubar und testbar.
- Jedes nutzerseitige Ergebnisartefakt ist vollstaendig Deutsch zuerst und
  Englisch danach, textorientiert, WCAG-2.2-AA-tauglich, auf CEFR-B2-Niveau
  und fuer die erklaerte Zielgruppe ohne Spec-Kit-Vorwissen nachvollziehbar.
- Die Feature-024-Baseline ist mit Feature-, PR- und Merge-Evidence
  nachvollziehbar gebunden.
- Jeder bestaetigte Remediation-Befund besitzt stabile Identitaet, Scope,
  Owner, Prioritaet, Risiko, Evidence und Re-Evaluation-Trigger.
- Kein leerer oder spekulativer Remediation-Intake und kein automatischer
  Folgelauf entstehen.
- Der Feature-Lauf wird mit `MergeAndSync` abgeschlossen und startet keinen
  Nachfolger.

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze Lastenheft_RL-SE-Checklist-Selbstpruefung.md als verbindliche Eingabedatei. Pruefe zuerst die abgeschlossene Assessment Baseline in Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.024-mitgeltende-dokumente-verzahnung.md und ihren Abschlussnachweis specs/024-mitgeltende-dokumente-verzahnung/pr-evidence.md; bewahre Position 6 als einzigen bevorzugten Eligible-Kandidaten ohne daraus Start- oder Delivery-Autoritaet abzuleiten.
Nutze Lastenheft_RL-SE-Checklist-Selbstpruefung.md als verbindlichen Intake fuer einen separaten RL-SE-/Checklist-Selbstpruefungslauf.
Nutze PRs #208 und #209 sowie specs/024-mitgeltende-dokumente-verzahnung/ als bindende Zuordnungs- und Abschluss-Evidence.
Starte keinen Sammellauf ueber mehrere Repositories, erzeuge keine automatische Haertung und befuelle keine docs/security/-Nachweise ohne konkrete Spec-Kit-Aufgabe.
Erstelle eine fokussierte Feature-Spezifikation, die docs/secure-development/, Richtlinie_Sichere-Entwicklung.md, Checklistensammelband_Sichere-Entwicklung.md, CL_01 bis CL_12, mitgeltende Dokumente, Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md, constitution.md, .specify/memory/constitution.md und installierte Governance-Presets als Pruefgrundlagen beruecksichtigt.
Dokumentiere jede Matrixzeile mit Pruefpunkt-ID, normativer Quelle, Status und kurzer Begruendung. Fuer Applicable: geplanter Evidenz- oder Umsetzungspfad, Owner, Prioritaet, Risiko und Re-Evaluation-Trigger. Fuer AlreadySatisfied: konkreter Evidenzpfad. Fuer N/A: fachliche oder technische Begruendung und Re-Evaluation-Trigger. Fuer Open: Owner, Klaerungs- oder Folgeaktion, Prioritaet, Risiko und Re-Evaluation-Trigger. Fuer FollowUp: Owner, begruendete Folgeaktion, Prioritaet, Risiko und Re-Evaluation-Trigger.
Bewahre die Zielgruppe und das Vorwissen. Erklaere Fachbegriffe bei der ersten Verwendung und erstelle alle nutzerseitigen Ergebnisartefakte vollstaendig Deutsch zuerst und Englisch danach, textorientiert, WCAG-2.2-AA-tauglich und auf CEFR-B2-Niveau.
Verlange fuer bestaetigte, nicht leere Remediation-Bedarfe stabile Finding-IDs und abgegrenzte Intake-Vorschlaege. Intake-Erzeugung, Intake Review, Series-Aufnahme und Autonomous-Ausfuehrung bleiben getrennte Governance-Schritte und starten nicht automatisch.
Behandle sichere Entwicklung als Must-have. MSL-Status ist ein Pruefpunkt, aber keine Voraussetzung fuer diesen Selbstpruefungslauf.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_RL-SE-Checklist-Selbstpruefung.md` in delivery mode `MergeAndSync`. Use the completed Feature-024 assessment baseline, PRs #208 and #209, and `specs/024-mitgeltende-dokumente-verzahnung/` as binding evidence. Preserve Position 6, the learner and language contract, the status-dependent matrix contract, and every requirement, non-goal, security, A11Y, platform, evidence, and acceptance boundary. Record only reproducible, non-empty remediation needs with stable finding IDs, owners, priorities, risks, evidence, and bounded intake proposals. Do not create or execute remediation intakes automatically and do not start a successor feature. Commit, push, create and converge the feature PR, merge it, and return to a clean synchronized `main`. The narrow admin bypass is authorized only when all technical gates are green, zero actionable review threads remain, and Human Approval is the sole open gate.
```

<!-- intake-authoring:end -->
