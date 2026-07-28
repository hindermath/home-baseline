<!-- intake-authoring:begin -->
# Lastenheft: KDM-/KITSM-Lernreihen-Gap-Audit

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** bereit für Intake Review
**Stand:** 2026-07-28
**Reihenfolge:** Position 18, nach Position 17
**Delivery Mode:** `MergeAndSync`
**Zielgruppe:** Kaufleute für Digitalisierungsmanagement (KDM), Kaufleute für
IT-System-Management (KITSM), Fachinformatiker*innen, Lehrende, Ausbildende,
Maintainer und Reviewer ab dem ersten Ausbildungsjahr
**Vorausgesetztes Wissen:** Grundverständnis von Ausbildung und
Softwareprojekten; keine vorherige Spec-Kit-Erfahrung

## 1. Zweck / Purpose

Dieser Intake beschreibt einen vollständigen, read-only ausgeführten
Gap-Audit der bestehenden KDM-/KITSM-Integration in den Secure-Trader-
Lernreihen. Ein **Gap** ist eine belegte Lücke zwischen dem vorhandenen
Lernmaterial und einer verbindlichen beruflichen Kompetenz.

Der Audit prüft, ob beide kaufmännischen IT-Berufe fachlich gleichwertig zu den
Fachinformatiker*innen berücksichtigt werden, ohne ihre unterschiedlichen
Berufsprofile gleichzusetzen. Er verändert weder Lernmaterial noch Produktcode.

*This intake defines a read-only gap audit of the existing KDM and KITSM
integration. It checks equivalent educational depth without treating the
occupations as identical.*

## 2. Verbindliche Grundlagen / Binding Sources

Zu prüfen und mit Stand, URL, Abrufdatum und normalisiertem SHA-256-Hash zu
dokumentieren sind:

- der gemeinsame KMK-Rahmenlehrplan der IT-Berufe vom 13. Dezember 2019;
- die Ausbildungsordnungen für KDM und KITSM;
- die BIBB-Berufsprofile und BIBB-Umsetzungshilfen beider Berufe;
- `docs/learning-units/Lernreihen-Blueprint.md`;
- `docs/learning-units/Lernreihen-Register.md`;
- `docs/learning-units/Rahmenlehrplan-Lernfeld-Mapping.md`;
- die drei `IT-Berufe-Secure-*-Mapping.md`;
- `Secure-Trader-Kaufmaennische-Berufsrollen-Linse.md`;
- alle betroffenen Lastenhefte, Lernbegleiter und Unterrichtsleitfäden.

Externe Quellen werden nicht vollständig kopiert. Historische Evidence wird
nicht modernisierend umgeschrieben.

## 3. Prüfumfang / Audit Scope

Der Audit erfasst:

- alle Lernfelder von KDM und KITSM;
- gemeinsame Lernfelder im ersten und zweiten Ausbildungsjahr;
- berufsspezifische Lernfelder im dritten Ausbildungsjahr;
- Aufgaben, Lernziele, Eigenleistung, C#-/SQL-Praxis, Tests und Evidence;
- kaufmännische, technische, organisatorische und kommunikative Kompetenzen;
- Prüfungsbereich-Bezüge ohne Prüfungsgarantie;
- Deutsch-zuerst/Englisch-danach, CEFR B2 und WCAG 2.2 AA;
- Container-first-Grenzen für agentische Secure-Trader-Arbeit;
- bestehende Rollout- und Level-0/1/2-Zuordnungen.

## 4. Bewertungsmodell / Decision Model

Jede Lernfeld-Kompetenz und jede geprüfte Dokumentfamilie erhält genau eine
Hauptentscheidung:

- `Covered`
- `Partial`
- `Missing`
- `IncorrectMapping`
- `ObsoleteAssumption`
- `DuplicateRisk`
- `N/A`

Eine Entscheidung nennt Quelle, Zielgruppe, Lernfeld, vorhandene Evidence,
Lücke, Risiko, Owner und Re-Evaluation-Trigger.

## 5. Anforderungen / Requirements

- **KKA-001:** Alle offiziellen KDM- und KITSM-Lernfelder werden vollständig
  inventarisiert.
- **KKA-002:** Jede Lernfeld-Kompetenz wird vorhandenen Aufgaben,
  Lernbegleitern, Leitfäden und Nachweisen zugeordnet.
- **KKA-003:** Gemeinsame und berufsspezifische Kompetenzen werden getrennt
  ausgewiesen.
- **KKA-004:** LF5 und das gemeinsame Softwareprojekt in LF7 werden auf echte
  eigene Implementierung, C#, SQL und Tests geprüft.
- **KKA-005:** Pauschale Programmierquoten werden als mögliche veraltete
  Annahmen geprüft und nicht als Kompetenznachweis akzeptiert.
- **KKA-006:** Agentenunterstützung und eigene Lernendenleistung werden getrennt
  bewertet.
- **KKA-007:** Alle bestehenden Jahr-1-, Jahr-2- und Professional-Track-
  Dokumentfamilien werden auf KDM-/KITSM-Bezug geprüft.
- **KKA-008:** Kaufmännische Lernfelder wie Beschaffung, Kosten, Verträge,
  Marketing, Datenqualität und Geschäftsmodelle werden vollständig erfasst.
- **KKA-009:** Prüfungsbereiche werden als Kompetenz-Mapping geprüft, ohne
  Prüfungsvorbereitung oder Prüfungsgarantie zu behaupten.
- **KKA-010:** Alle nutzerseitigen Dokumente werden auf Lernendenverständlichkeit
  und Barrierefreiheit geprüft.
- **KKA-011:** Der vorhandene C#-Referenzpfad und die drei Level-1-/drei
  C#-Level-2-Rolloutziele werden read-only inventarisiert.
- **KKA-012:** Der Audit erzeugt keine Lernmaterial-, Runtime-, Preset-,
  Rollout- oder Repository-Änderung.

## 6. Ergebnisartefakte / Expected Artifacts

- vollständige Lernfeld- und Kompetenzmatrix;
- Dokument- und Evidence-Inventar;
- C#-/SQL- und Test-Gap-Matrix;
- Berufsrollen- und Agentenleistungsanalyse;
- Accessibility- und Sprachbefunde;
- stabile Findings `KKA###`;
- belegte Eingaben für Position 19;
- textorientierter Abschlussbericht.

## 7. Akzeptanzkriterien / Acceptance Criteria

- **AC-KKA-001:** Jedes offizielle Lernfeld besitzt eine belegte Entscheidung.
- **AC-KKA-002:** Jede positive Abdeckungsbehauptung verweist auf konkrete
  Dateien und Evidence.
- **AC-KKA-003:** Es verbleibt keine Critical-/High-Ambiguität für Position 19.
- **AC-KKA-004:** C#-, SQL-, Test- und Eigenleistungsgrenzen sind separat
  bewertet.
- **AC-KKA-005:** Alle drei Secure-Trader-Familien und sechs vorgesehenen
  Rolloutziele sind inventarisiert.
- **AC-KKA-006:** Kein Lernmaterial und kein Produktcode wurde verändert.
- **AC-KKA-007:** Position 19 wurde nicht automatisch gestartet.

## 8. Nicht-Ziele und Stop-Grenzen / Non-Goals

- Keine Remediation innerhalb des Audits.
- Keine neuen Level-1-/Level-2-Repositories.
- Keine Gleichsetzung kaufmännischer und technischer Berufsprofile.
- Keine Prüfungssimulation.
- Keine vollständige Kopie externer Quellen.
- Bei unklarer Quelle, widersprüchlicher Lernfeldzuordnung oder fehlender
  berufspädagogischer Entscheidung wird ein Finding erzeugt statt geraten.

<!-- intake-authoring:prompts -->
## 9. Kopierbare Spec-Kit-Prompts / Copy-Ready Prompts

<!-- spec-kit-command-id: speckit.intake-review -->
### Intake Review

```text
$speckit-intake-review Review `Lastenheft_KDM-KITSM-Lernreihen-Gap-Audit.md` as position 18. Verify the read-only scope, complete KDM/KITSM learning-field coverage, official-source provenance, exact decision vocabulary, C#/SQL and learner-work boundaries, all three Secure Trader families, six rollout targets, measurable acceptance, learner accessibility, and the prohibition on remediation or automatic follow-up.
```

<!-- spec-kit-command-id: speckit.specify -->
### Specify

```text
$speckit-specify Use `Lastenheft_KDM-KITSM-Lernreihen-Gap-Audit.md` as the binding intake for position 18. Create a feature specification for a complete read-only audit of KDM and KITSM learning-field, competency, document, evidence, C#/SQL, assessment, accessibility, and rollout coverage. Preserve KKA-001 through KKA-012, AC-KKA-001 through AC-KKA-007, the exact decision model, official-source proof boundaries, no remediation, and no automatic start of position 19.
```

<!-- spec-kit-command-id: speckit.autonomous -->
### Autonomous

```text
$speckit-autonomous Execute the complete Spec Kit run for `Lastenheft_KDM-KITSM-Lernreihen-Gap-Audit.md` with deliveryAuthority=MergeAndSync after position 17 is complete. Keep learning materials, product code, presets, rollout scripts, and fleet repositories read-only except for accepted audit artifacts, deterministic audit-only validation, evidence, statistics, archive/order updates, and delivery evidence. Merge one non-empty Level-0 PR, return to clean synchronized main, and do not start position 19 automatically.
```

<!-- intake-authoring:end -->
