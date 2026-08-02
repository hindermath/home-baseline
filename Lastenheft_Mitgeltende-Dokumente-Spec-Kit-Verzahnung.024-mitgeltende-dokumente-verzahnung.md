<!-- intake-authoring:begin -->
# Lastenheft: Mitgeltende Dokumente und Spec-Kit-Verzahnung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** vorbereitet fuer Intake Review
**Stand:** 2026-08-02
**Position:** 5, bevorzugter `Eligible`-Kandidat
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Fachinformatiker*innen, IT-System-Elektroniker*innen,
Kaufleute fuer IT-System-Management und Kaufleute fuer
Digitalisierungsmanagement ab dem ersten Ausbildungsjahr sowie
Entwickler*innen, Reviewer, Ausbildungsverantwortliche und KI-Agenten

## 1. Zweck / Purpose

Dieses Lastenheft beschreibt einen Spec-Kit-Lauf zur nachweisbaren
Verzahnung der Richtlinie Sichere Entwicklung, der zwoelf Checklisten, des
erzeugten Checklistensammelbands, der mitgeltenden Dokumente und der aktuell
verwalteten Spec-Kit-Preset-Profile.

Die Zuordnungsdatei existiert bereits. Der Lauf erstellt deshalb keine zweite
Mapping-Struktur, sondern prueft und haertet die vorhandene Version. Das
Ergebnis soll fuer Lernende ab dem ersten Ausbildungsjahr und fuer
Maintainer ohne Sicherheitsspezialisierung verstaendlich, anwendbar und
auditfaehig sein.

*This intake governs a verifiable alignment of the secure-development
guideline, twelve checklists, generated compendium, related documents, and
managed Spec Kit profiles. The mapping already exists and must be reviewed and
hardened rather than duplicated.*

## 2. Reihenfolge und Abhaengigkeiten / Order and Dependencies

Dieser Intake bleibt die Root auf Position 5. Er liefert die bindende
Assessment Baseline fuer:

- Position 6, RL-SE-Checklist-Selbstpruefung;
- Position 7, Secure-Development-Container-Hardening;
- Position 13, Script-and-Config-GSDB-Pruefung.

Die Positionen 6, 7 und 13 duerfen die Bewertungslogik nicht stillschweigend
ersetzen. Position 5 uebernimmt umgekehrt keine Aufgaben der spaeteren
Assurance-Kette auf den Positionen 14 bis 17. Der Status `Eligible` ist nur
Reihenfolge-Evidence und erteilt keine Implementierungs-, Remote-, Merge- oder
Bypass-Autoritaet.

## 3. Verbindliche Ausgangslage / Binding Current State

### 3.1 Secure-Development-Basis

Die kanonische Basis liegt unter `docs/secure-development/`:

- Baseline `3.2.0` mit `157` stabilen Checklistenpunkten;
- Richtlinie Sichere Entwicklung `3.2.0`;
- zwoelf Einzelchecklisten als kanonische Quellen;
- deterministisch erzeugter Checklistensammelband `2.2.0`;
- mitgeltende Dokumente und Lernpfad;
- vorhandene Zuordnungsdatei
  `mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`
  in Version `1.2.0`;
- `baseline-manifest.json` als kontrolliertes Versions- und Dateiinventar.

Der Sammelband wird nicht direkt gepflegt. Aenderungen erfolgen in den
kanonischen Checklisten und werden mit den vorhandenen Bash- und
PowerShell-Renderern erzeugt und geprueft.

### 3.2 Preset-Profile

Das oeffentliche Standardprofil besteht weiterhin aus acht Presets:

| Preset | Version | Prioritaet |
|---|---:|---:|
| `security-governance` | `v0.6.1` | `10` |
| `architecture-governance` | `v0.5.1` | `20` |
| `isaqb-architecture-governance` | `v0.2.1` | `30` |
| `a11y-governance` | `v0.4.2` | `40` |
| `cross-platform-governance` | `v0.2.1` | `50` |
| `agent-parity-governance` | `v0.4.1` | `60` |
| `autonomous-run-governance` | `v0.3.3` | `70` |
| `parallel-autonomous-run-governance` | `v0.2.4` | `80` |

Die verwaltete Thorsten-Flotte ergaenzt drei optionale Intake-Presets:

| Preset | Version | Prioritaet |
|---|---:|---:|
| `intake-authoring-governance` | `v0.3.0` | `64` |
| `intake-review-governance` | `v0.2.0` | `65` |
| `intake-sequencing-governance` | `v0.2.2` | `66` |

Damit umfasst das verwaltete Profil elf Presets. Das Elf-Preset-Profil ist
eine Flottenentscheidung und veraendert das oeffentliche Acht-Preset-Profil
nicht. Preset-Prioritaeten regeln die deterministische Komposition; sie
erteilen keine Ausfuehrungs- oder Remote-Rechte.

### 3.3 Seit der ersten Intake-Fassung gelieferte Governance

Der Lauf muss insbesondere folgende inzwischen verbindliche Regeln verwenden:

- Requirements-Intake-Konfiguration Schema 2.0 und hashgebundene Receipts;
- Intake Review vor Specify beziehungsweise Autonomous, wenn die Projektpolicy
  den Review verlangt;
- dokumentierte Intake-Reihenfolge mit typisierten Abhaengigkeiten;
- Documentation-Impact-Entscheidungen `UpdateRequired`,
  `NoUpdateRequired`, `GeneratedUpdate` oder `FollowUp`;
- kanonische Quelle, Owner, Leserpfad, Navigation, Sprachpartner,
  Distributionsklasse und Neubewertung fuer geaenderte Dokumentation;
- Remote-Freshness, exakte Head-Bindung, keine Leer-PRs und kein Eingriff in
  fremde oder schmutzige Arbeitsbaeume bei einer spaeteren Verteilung;
- ausdrueckliche Authority-Revalidierung fuer autonome Resume- und
  Remote-Phasen;
- gemeinsame Pflege aller verwalteten Agentenoberflaechen, wenn gemeinsame
  Guidance betroffen ist.

## 4. Zielbild / Target State

Nach Abschluss ist eindeutig und maschinenpruefbar erkennbar:

- welches mitgeltende Dokument welche Richtlinienabschnitte konkretisiert;
- welche stabilen Checklisten-IDs dadurch unterstuetzt werden;
- welche der acht Standard-Presets und drei optionalen Intake-Presets passende
  Pruef- oder Evidence-Artefakte liefern;
- welches Preset-Profil fuer eine Aussage gilt;
- wann `Applicable`, `N/A` oder `Open` gilt und wie davon getrennt der
  Umsetzungsstatus bewertet wird;
- welche Evidenz, welcher Owner, welches Restrisiko, welcher Follow-up und
  welcher Neubewertungs-Trigger erforderlich sind;
- welche Dokumente kanonische Quellen und welche erzeugte Ableitungen sind;
- welche Regeln generisch verteilt werden duerfen und welche Evidence im
  jeweiligen Projekt verbleiben muss;
- warum Swift eine Memory-Safe Language (MSL) ist und trotzdem eine
  sprachspezifische Secure-Coding-Pruefung benoetigt.

## 5. Scope

Der Lauf prueft mindestens:

- `docs/secure-development/README.md`;
- `docs/secure-development/Richtlinie_Sichere-Entwicklung.md`;
- `docs/secure-development/baseline-manifest.json`;
- die zwoelf Dateien unter `docs/secure-development/checklisten/`;
- den erzeugten `Checklistensammelband_Sichere-Entwicklung.md`;
- alle Dateien unter `docs/secure-development/mitgeltende-dokumente/`;
- `docs/secure-development/Lernpfad_Sichere-Entwicklung_Lehrjahr-1-bis-3.md`;
- `docs/secure-development/mitgeltende-dokumente/Verzahnung_Richtlinie_Checklisten_Spec-Kit-Presets.md`;
- `docs/documentation-governance.md` und die aktuelle Constitution als
  uebergeordnete Dokumentations- und Governance-Quelle;
- `scripts/templates/secure-development-hardening-lastenheft.md`;
- Agenten-, Spec-Kit-Template- und Preset-Flaechen nur dann, wenn der Abgleich
  dort eine konkrete Inkonsistenz nachweist;
- die Anwendbarkeit einer kontrollierten Verteilung an registrierte
  Level-0-, Level-1-, Level-2- und Lernreihen-Repositories.

## 6. Nicht-Ziele und Follow-up-Grenzen / Non-Goals and Follow-up Boundaries

- Keine Produktcode-, Runtime-, API-, Dependency- oder Toolchain-Aenderung.
- Kein Level-2-Produkthaertungslauf und keine automatische Folgeserie.
- Keine projektspezifische Befuellung von `docs/security/`.
- Keine pauschale Flottenmutation und kein Leer-PR.
- Keine direkte Aenderung erzeugter Dokumente ohne kanonische Quelle und
  Renderer.
- Keine ISO-Zertifizierungsbehauptung und kein Ersatz fuer eine
  organisationsweite Statement of Applicability.
- Keine vorgezogene Umsetzung der Positionen 14 bis 17: Gap Audit,
  `secure-development-assurance-governance`, Baseline `3.3.0` und
  ABSDD-Adoption bleiben separate Intakes.
- Kein Preset-Release allein wegen redaktioneller Mapping-Klarstellungen.

Entdeckte Assurance-, Produkt-, Flotten- oder Projektluecken werden mit
Evidence, Owner, Risiko und Follow-up-Grenze dokumentiert. Sie werden nicht
unter Position 5 verdeckt umgesetzt.

## 7. Anforderungen / Requirements

- **MDV-001:** Der Lauf inventarisiert alle kontrollierten Dokumente aus
  `baseline-manifest.json` und meldet fehlende, unbekannte oder versionell
  abweichende Dateien.
- **MDV-002:** Die vorhandene Zuordnungsdatei wird als kanonische Mapping-
  Oberflaeche geprueft und nur bei nachgewiesenem Bedarf aktualisiert.
- **MDV-003:** Jede Mapping-Zeile verbindet Richtlinienbezug, stabile
  Checklisten-IDs, mitgeltendes Dokument, Preset-Profil und typische Evidence.
- **MDV-004:** Standard-Acht und optionale Intake-Drei werden getrennt und mit
  aktuellen Versionen und Prioritaeten dargestellt.
- **MDV-005:** Anwendbarkeit und Umsetzung bleiben zwei getrennte Statusachsen.
  Jeder positive Status braucht Evidence; `N/A` braucht eine Begruendung und
  einen Neubewertungs-Trigger; `Open` braucht Owner und Follow-up.
- **MDV-006:** NIST SSDF und CWE Top 25 werden fuer Level-2-Arbeit nicht als
  `N/A` behandelt. ASVS, SAMM, STRIDE/CAPEC, Zero Trust, BSI C3A/C5,
  SBOM/VEX/SLSA/AI-SBOM sowie NIS2, CRA, EU AI Act und DORA erhalten eine
  triggerbasierte Anwendbarkeitsentscheidung.
- **MDV-007:** Die Zuordnung erklaert, dass MSL-Status sichere APIs,
  Eingabepruefung, Fehlerbehandlung, I/O-, Dependency- und Security-Review
  nicht ersetzt.
- **MDV-008:** Fuer jede technische oder fachliche Aenderung wird genau eine
  Documentation-Impact-Entscheidung mit Quelle, Owner und Evidence erfasst.
- **MDV-009:** Erzeugte Dokumente werden nur ueber ihre kanonische Quelle und
  den dokumentierten Renderer geaendert.
- **MDV-010:** Gemeinsame Guidance wird auf allen verwalteten
  Agentenoberflaechen gemeinsam geprueft; intentionale Abweichungen werden
  dokumentiert.
- **MDV-011:** Inhalte stehen Deutsch zuerst und Englisch danach, verwenden
  ungefaehr CEFR B2 und erklaeren Sicherheits-, Spec-Kit- und
  Ausbildungsbegriffe beim ersten Auftreten.
- **MDV-012:** Abhaengigkeiten, Status, Entscheidungen, Evidenz und naechste
  Aktionen bleiben textorientiert nutzbar. WCAG 2.2 AA und `Programmierung
  #include<everyone>` bilden die anwendbare Review-Basis.
- **MDV-013:** Die vier IT-Ausbildungsberufe und das erste Ausbildungsjahr
  werden in Zielgruppe, Beispielen und Lernpfaden fachlich angemessen
  beruecksichtigt, ohne identische Berufsprofile zu behaupten.
- **MDV-014:** Eine Verteilungsentscheidung inventarisiert aktuelle Ziele,
  trennt `Applicable`, `N/A` und `Open` und veraendert keine fremden oder
  schmutzigen Arbeitsbaeume.
- **MDV-015:** Commit, Push und PR verwenden Exact-Head-Evidence. Ein enger
  Admin-Bypass ist nur mit ausdruecklicher aktueller Autoritaet, gruenen
  technischen Gates, null umsetzbaren Review-Threads und Human Approval als
  einzigem offenen Gate zulaessig.
- **MDV-016:** Der Lauf erzeugt keine zweite Mapping-Datei und dupliziert keine
  bereits von einem Preset oder einer nachgelagerten Intake-Serie verantwortete
  Governance.

## 8. Erwartete Ergebnisartefakte / Expected Deliverables

| Artefakt | Erwartung |
|---|---|
| Current-State-Inventar | Baseline, Checklisten, mitgeltende Dokumente, Profile und Versionen sind belegt |
| Mapping-Datei | Bestehende Zuordnung ist bestaetigt oder finding-basiert gehaertet |
| Dokumentationsauswirkungs-Matrix | Jede gepruefte Flaeche hat genau eine Impact-Entscheidung |
| Preset-Anwendbarkeits-Matrix | Acht Standard- und drei optionale Presets sind getrennt bewertet |
| Evidence | Status, Owner, Reviewer, Pfad, Restrisiko, Follow-up und Neubewertung sind nachvollziehbar |
| Verteilungsentscheidung | Aktuelle Zielmenge, No-empty-PR und Worktree-Grenzen sind dokumentiert |
| Folgegrenzen | Positionen 14 bis 17 und projektspezifische Haertung bleiben getrennt |

## 9. Validierung / Validation

Der Lauf fuehrt mindestens aus:

- Bash- und PowerShell-Pruefung von Baseline-Manifest, Checklisten-IDs und
  erzeugtem Sammelband;
- Preset `list`, `info` und `resolve` fuer das verwaltete Elf-Preset-Profil;
- Intake-Authoring-, Intake-Review- und Intake-Series-Validatoren;
- Dokumentations-Impact-, Sprachpartner-, Link-, Navigation-, UTF-8- und
  textorientierte A11Y-Pruefung;
- Agenten- und Command-Paritaet ohne doppelte Skills;
- `git diff --check` und Secret-Scan;
- Propagationsvorschau, falls portable Quellen geaendert wurden;
- Exact-Head-Pruefung vor Merge und erneute Pruefung nach einer Head-Aenderung.

DocFX, Playwright/Axe oder weitere projektspezifische Gates laufen nur, wenn
ihre dokumentierten Trigger durch die tatsaechlich geaenderten Flaechen
ausgeloest werden. Ein nicht ausgeloester Gate wird mit Begruendung
dokumentiert, nicht stillschweigend ausgelassen.

## 10. Akzeptanzkriterien / Acceptance Criteria

- **AC-001:** Genau eine kontrollierte Mapping-Oberflaeche ist vorhanden; es
  gibt keine konkurrierende Zuordnungsdatei.
- **AC-002:** Alle `157` stabilen Checklistenpunkte bleiben vorhanden und der
  erzeugte Sammelband stimmt mit den zwoelf kanonischen Quellen ueberein.
- **AC-003:** Alle kontrollierten mitgeltenden Dokumente sind genau einmal im
  Manifest und in der Anwendbarkeitspruefung vertreten.
- **AC-004:** Das Acht-Preset-Standardprofil und das verwaltete Elf-Preset-
  Profil werden korrekt unterschieden.
- **AC-005:** Alle elf aktuell installierten Presets werden mit Version,
  Prioritaet, Scope und anwendbarer Evidence-Grenze erfasst.
- **AC-006:** Es gibt keine positive Anwendbarkeits- oder Umsetzungsbehauptung
  ohne aktuellen Evidence-Pfad.
- **AC-007:** Jede `N/A`-Entscheidung besitzt Begruendung und
  Neubewertungs-Trigger; jedes `Open` besitzt Owner und Follow-up.
- **AC-008:** Swift und alle weiteren MSL-Einordnungen bleiben konsistent zur
  Constitution und zur sprachspezifischen Secure-Coding-Pruefung.
- **AC-009:** Deutsch/Englisch, CEFR B2, Begriffserklaerungen, textorientierte
  Statusdarstellung und WCAG 2.2 AA sind nachvollziehbar geprueft.
- **AC-010:** Die vier IT-Ausbildungsberufe sind als Zielgruppen beruecksichtigt
  und ihre unterschiedlichen Kompetenzperspektiven werden nicht eingeebnet.
- **AC-011:** Jede gepruefte Dokumentflaeche hat genau eine Documentation-
  Impact-Entscheidung.
- **AC-012:** Erzeugte Dateien stimmen nach dem Renderer-Lauf mit ihren
  kanonischen Quellen ueberein.
- **AC-013:** Gemeinsame Agenten-Guidance und generierte Commands sind auf den
  verwalteten Oberflaechen parity-gruen.
- **AC-014:** Eine erforderliche Verteilung verwendet nur aktuelle registrierte
  Ziele, erzeugt keine Leer-PRs und respektiert schmutzige Arbeitsbaeume.
- **AC-015:** Keine Aenderung gehoert fachlich zu Position 14, 15, 16 oder 17;
  solche Befunde sind als Follow-up belegt.
- **AC-016:** Alle ausgelösten lokalen und Remote-Gates bestehen am exakten
  Head; Provider-Ausfall, fehlender Review und technischer Pass bleiben
  getrennte Ergebnisse.
- **AC-017:** Der Lauf endet auf sauberem, synchronisiertem `main`, archiviert
  den abgeschlossenen Intake und startet keinen Folgeintake automatisch.

## 11. Risiken und Annahmen / Risks and Assumptions

- Preset-Versionen koennen sich vor dem Feature-Start erneut aendern. Deshalb
  ist die installierte Matrix im Preflight erneut zu pruefen.
- Die Baseline `3.2.0` ist der Ist-Stand, nicht das vorweggenommene Ziel
  `3.3.0` der spaeteren Assurance-Serie.
- Eine vorhandene Mapping-Zeile kann fachlich korrekt und deshalb
  `NoUpdateRequired` sein. Ein Review muss nicht kuenstlich Aenderungen
  erzeugen.
- Externe Standards werden mit Version und Quelle eingeordnet; das Repository
  verteilt keine urheberrechtlich geschuetzten Volltexte ohne Erlaubnis.

## 12. Spec-Kit-Intake-Reife / Spec Kit Intake Readiness

Vor Specify oder Autonomous muss ein aktueller Intake Review `Ready` melden.
Specify erhaelt keine Implementierungs- oder Remote-Autoritaet. Der spaetere
autonome Lauf verwendet `MergeAndSync`; dieses Lastenheft allein erteilt aber
keinen Admin-Bypass und keine Secret- oder Provider-Administration.

<!-- intake-authoring:prompts -->
## Copy-Ready Spec Kit Prompts

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Nutze `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.md` als verbindliche Eingabedatei. Erstelle die Feature-Spezifikation fuer die finding-basierte Pruefung und Haertung der vorhandenen Verzahnung von Richtlinie Sichere Entwicklung, zwoelf Checklisten, erzeugtem Sammelband, mitgeltenden Dokumenten sowie dem Acht-Preset-Standardprofil und den drei optionalen Intake-Presets. Bewahre Identitaet, Root-Position 5 und die bindenden Assessment-Baselines fuer die Positionen 6, 7 und 13.

Nutze Baseline 3.2.0, 157 stabile Checklistenpunkte, Mapping-Version 1.2.0, Requirements-Governance Schema 2.0 und die im Preflight tatsaechlich installierten Preset-Versionen als Ist-Stand. Die Mapping-Datei existiert bereits und darf nicht dupliziert werden. Dokumentiere fuer jede gepruefte Flaeche Documentation Impact, beide Statusachsen, Evidence, Owner, Reviewer, Restrisiko, Follow-up und Neubewertungs-Trigger.

Beachte Deutsch zuerst/Englisch danach, CEFR B2, Begriffserklaerungen beim ersten Auftreten, textorientierte Status- und Abhaengigkeitsdarstellung, die vier IT-Ausbildungsberufe ab dem ersten Ausbildungsjahr, `Programmierung #include<everyone>` und WCAG 2.2 AA. Bewahre kanonische Quellen und erzeugte Ableitungen, Agenten-Paritaet, No-empty-PR-, Worktree- und Exact-Head-Grenzen.

Nicht-Ziele: keine Produktcode-, Runtime-, API-, Dependency- oder Toolchain-Aenderung; kein Level-2-Produkthaertungslauf; keine projektspezifischen `docs/security/`-Nachweise; keine automatische Folgeausfuehrung; keine vorgezogene Umsetzung der Assurance-Positionen 14 bis 17. Specify erteilt keine Implementierungs-, Commit-, Push-, PR-, Merge-, Bypass-, Secret- oder Provider-Autoritaet.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.md` in delivery mode `MergeAndSync`. Use the current Intake Review as the gate and preserve identity, Root position 5, the binding baselines for positions 6, 7, and 13, and every scope, non-goal, learner, security, accessibility, documentation, evidence, generated-source, fleet, worktree, and exact-head boundary in the intake.

Review and harden the existing mapping; do not create a duplicate. Revalidate the installed eleven-preset managed profile in preflight while keeping the public eight-preset default distinct. Record `Applicable`, `N/A`, or `Open` separately from implementation status, with rationale, evidence, owner, reviewer, residual risk, follow-up, and re-evaluation trigger. Route findings owned by positions 14 through 17 to explicit follow-up instead of implementing them here.

Converge Specify, Clarify, Checklists, Plan, Tasks, Analyze, Implement, validation, PR review, merge, local main synchronization, and retrospective. Do not create an empty PR and do not start a successor intake. This prompt grants no admin bypass, secret access, provider administration, or authority beyond this feature's `MergeAndSync` delivery.
```

<!-- intake-authoring:end -->
