<!-- intake-authoring:begin -->
# Lastenheft: Registrierte Level-1/2-Dokumentationsarchitektur-Adoption

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Dokumentationsvorlauf D7, nach abgeschlossenem D6
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Auszubildende in IT-Berufen, Lehrende, Repository-Owner,
Maintainer, KI-Agenten und Reviewer

## 1. Zweck / Purpose

D7 übernimmt ausschließlich die in D4 bis D6 bestätigten portablen
Dokumentationsregeln in alle zum Laufbeginn registrierten Level-1- und
Level-2-Repositories. **Portabel** bedeutet: Die Regel funktioniert unabhängig
von Programmiersprache, Betriebssystem, Forge oder Projektdomäne. Lokale
Produktdokumentation bleibt projektspezifisch.

*D7 adopts only proven portable documentation-architecture rules across every
registered Level 1 and Level 2 repository while preserving project-specific
runtime, language, learning, security, and evidence contracts.*

## 2. Voraussetzungen und Flottenbarriere / Preconditions and Fleet Barrier

- D1 bis D6 sind abgeschlossen und gemergt.
- Level 0 ist sauber und exakt auf `origin/main`.
- Das versionierte Flottenmanifest und die lokale Registry sind validiert.
- Vor Änderungen wird für jedes erreichbare `origin` gefetcht.
- Pull ist nur als sicherer Fast-forward auf einem sauberen kanonischen
  Default-Branch zulässig.
- Dirty, Ahead, Diverged, Detached, Non-Default, fehlender Upstream oder
  unerreichbarer Remote blockieren Änderungen am jeweiligen Repository.
- Die read-only Bestandsaufnahme der übrigen Flotte läuft trotzdem weiter.

## 3. Repository-spezifische Adoption / Repository-Specific Adoption

Jedes Repository erhält:

- Repository-, Commit-, Remote- und Branch-Evidence;
- eigenes Dokumentationsinventar;
- Zuordnung seiner Leserpfade und Zielgruppen;
- Source-of-Truth-, Owner-, Sprach- und Generatorentscheidung;
- genau eine Documentation-Impact-Entscheidung pro Änderung;
- dokumentierte Abweichung von der Level-0-Architektur, wenn die Projektrolle
  dies erfordert;
- eigene Validierung und einen nicht leeren PR nur bei tatsächlicher Änderung.

Level-0-Einstiegsseiten werden nicht pauschal kopiert. Lernreihen,
Nicht-MSL-Projekte, Sandbox-Repositories und Technologieprojekte behalten ihre
fachlichen und sprachlichen Besonderheiten.

## 4. Anforderungen / Requirements

- **DFA-001:** Die Zielmenge wird aus dem aktuellen Flottenmanifest und der
  validierten Registry abgeleitet, nicht aus einer historischen Zahl.
- **DFA-002:** Level 0 wird vor der ersten und nach der letzten Flottenänderung
  revalidiert.
- **DFA-003:** Jedes Ziel wird gefetcht und sicher klassifiziert, bevor eine
  Änderung geplant wird.
- **DFA-004:** Jedes Repository erhält ein eigenes Git-abgeleitetes
  Dokumentationsinventar.
- **DFA-005:** Portable Regeln werden von projektspezifischen
  Dokumentationsinhalten getrennt.
- **DFA-006:** Root-README oder Sprachaufteilung wird nur bei einem
  repository-spezifisch belegten Finding geändert.
- **DFA-007:** Runtime-, Sprache-, Toolchain-, Plattform-, Lernreihen-,
  Nicht-MSL- und Sandbox-Grenzen bleiben erhalten.
- **DFA-008:** Generierte Dokumente werden ausschließlich über ihre
  repository-eigenen Quellen aktualisiert.
- **DFA-009:** Historische und archivierte Evidence bleibt unverändert und
  erhält höchstens externe Navigations- oder Provenienzkorrekturen.
- **DFA-010:** Agenten-Guidance wird nur als vollständiger gepflegter
  Oberflächensatz aktualisiert.
- **DFA-011:** Nutzerseitige Änderungen erfüllen die jeweilige
  Dokumentationssprache, CEFR B2, Begriffserklärung und WCAG 2.2 AA.
- **DFA-012:** Jeder tatsächlich geänderte Arbeitsbaum erhält einen eigenen
  nicht leeren Branch und PR.
- **DFA-013:** Gemeinsame Flotten-, Evidence-, Statistik- und
  Propagationsdateien werden serialisiert.
- **DFA-014:** Admin-Bypass bleibt auf grüne technische Gates,
  null umsetzbare Review-Threads und Human Approval als einziges offenes Gate
  begrenzt.
- **DFA-015:** Ein Preset-Follow-up benötigt denselben reproduzierbaren
  providerneutralen Defekt in mehr als einem geeigneten Repository oder einen
  unmittelbaren Korrektheits-/Sicherheitsfehler.
- **DFA-016:** D7 verändert kein Produktverhalten und startet keinen
  fachlichen Folge-Intake automatisch.

## 5. Validierung / Validation

Pro geändertem Repository werden mindestens geprüft:

- `git diff --check`;
- interne Links, Sprachpartner und Einstiegspfade;
- Documentation-Impact-Evidence;
- repository-eigene Homogeneity-, Secret-, Dokumentations- und A11Y-Gates;
- generierte Dokumente gegen ihre Quellen;
- gemeinsame Agentenflächen auf Parität;
- exakter PR-Head gegen Pflichtchecks und Review-Threads.

Native Plattformnachweise werden nur dort verlangt, wo die Änderung
plattformabhängige Bedienung oder Ausgabe betrifft.

## 6. Akzeptanzkriterien / Acceptance Criteria

- **AC-DFA-001:** Jeder registrierte Level-1-/Level-2-Eintrag ist geprüft,
  begründet blockiert oder nachweislich nicht anwendbar.
- **AC-DFA-002:** Kein Repository wurde wegen ähnlicher Dateinamen blind
  verändert.
- **AC-DFA-003:** Jede Änderung besitzt genau eine Documentation-Impact-
  Entscheidung und konkrete Evidence.
- **AC-DFA-004:** Projekt- und Lernreihenspezifika bleiben erhalten.
- **AC-DFA-005:** Alle geänderten Repositories sind über nicht leere PRs
  geliefert und anschließend sauber auf ihrem Default-Branch.
- **AC-DFA-006:** Unveränderte Repositories haben keinen Leer-PR erhalten.
- **AC-DFA-007:** Generierte und historische Dokumente wurden innerhalb ihrer
  jeweiligen Grenze behandelt.
- **AC-DFA-008:** Null offene Critical-/High-Dokumentationsfindings verbleiben
  in als abgeschlossen gemeldeten Repositories.
- **AC-DFA-009:** Level 0 ist am Ende sauber und exakt auf `origin/main`.
- **AC-DFA-010:** Kein Folge-Intake wurde automatisch gestartet.

## 7. Nicht-Ziele / Non-Goals

- Keine pauschale README- oder Sprachmigration.
- Keine Produkt-, API-, Runtime-, Abhängigkeits- oder Toolchain-Änderung.
- Keine Korrektur historischer Evidence-Inhalte.
- Kein Leer-PR und kein automatischer Preset-Release.
- Kein automatischer Start der bisherigen Position 5.

<!-- intake-authoring:prompts -->
## 8. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_Registrierte-Level-1-2-Dokumentationsarchitektur-Adoption.md` as documentation preflight D7. Verify its hard dependency on D4 through D6, registry-derived fleet scope, Remote Freshness Barrier, repository-specific evidence and ownership, portable-versus-project-specific boundary, non-empty PR rule, language and A11Y policy, generated and historical handling, bounded admin bypass, preset-promotion evidence, no-product-change scope, and measurable fleet completion. Do not modify the intake or start D7.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_Registrierte-Level-1-2-Dokumentationsarchitektur-Adoption.md` and the merged D4 through D6 evidence as binding input for documentation preflight D7. Create the feature specification for controlled adoption of proven portable documentation-architecture rules across every currently registered Level 1 and Level 2 repository. Preserve DFA-001 through DFA-016, AC-DFA-001 through AC-DFA-010, Remote Freshness, repository-specific inventories and PRs, project and learning boundaries, generated and historical limits, preset-promotion evidence, and no-product-change/no-follow-up-start constraints.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_Registrierte-Level-1-2-Dokumentationsarchitektur-Adoption.md` with deliveryAuthority=MergeAndSync after D4 through D6 are merged. Revalidate Level 0, inventory every currently registered Level 1 and Level 2 repository, adopt only proven portable rules through repository-specific non-empty PRs, preserve runtime, language, learning, non-MSL, sandbox, generated, and historical boundaries, serialize shared writes, converge exact-head checks and actionable review threads, return every changed repository and Level 0 to clean synchronized default branches, and do not start the previous position 5 or any other intake automatically.
```

<!-- intake-authoring:end -->
