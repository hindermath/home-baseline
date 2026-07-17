# Lastenheft: Mitgeltende Dokumente und Spec-Kit-Verzahnung

**Dokumenttyp:** Spec-Kit Intake / Lastenheft
**Status:** vorbereitet für separaten Spec-Kit-Lauf
**Stand:** 2026-06-20
**Zielgruppe:** Fachinformatiker*innen in Ausbildung, Entwickler*innen, Reviewer und KI-Agenten

## 1. Zweck

Dieses Lastenheft beschreibt einen späteren Spec-Kit-Lauf zur besseren Verzahnung der Richtlinie Sichere Entwicklung, der zwölf Checklisten, der mitgeltenden Dokumente und der sechs GitHub-Spec-Kit-Governance-Presets.

Der Lauf soll die vorhandene sichere-Entwicklung-Basis so verbessern, dass auch Auszubildende ab dem ersten Lehrjahr und Entwickler*innen ohne Sicherheits-Spezialwissen die Anforderungen verstehen, anwenden und auditfähig dokumentieren können.

## 2. Ausgangslage

Die sichere-Entwicklung-Basis liegt in `docs/secure-development/`. Sie enthält:

- die Richtlinie `Richtlinie_Sichere-Entwicklung.md`,
- zwölf Einzelchecklisten in `checklisten/`,
- den Sammelband `Checklistensammelband_Sichere-Entwicklung.md`,
- mitgeltende Dokumente in `mitgeltende-dokumente/`,
- Bezüge zu den sieben Governance-Presets `security-governance`, `architecture-governance`, `isaqb-architecture-governance`, `a11y-governance`, `cross-platform-governance` und `agent-parity-governance`.

Die CISA-Unterlage `THE-CASE-FOR-MEMORY-SAFE-ROADMAPS-TLP-CLEAR` beschreibt Swift ausdrücklich als Memory-Safe Language (MSL). Swift ist in der zentralen Constitution und in den Preset-Flächen bereits als MSL enthalten. Der spätere Lauf soll diese Einordnung in den mitgeltenden Dokumenten didaktisch sichtbarer machen.

## 3. Zielbild

Nach dem späteren Spec-Kit-Lauf soll eindeutig erkennbar sein:

- welches mitgeltende Dokument welche Richtlinienabschnitte konkretisiert,
- welche Checklisten-Prüfpunkte dadurch unterstützt werden,
- welches Spec-Kit-Preset die gleiche Prüf- oder Evidenzfläche erzeugt,
- welche Nachweise in einem Level-2-Projekt erwartet werden,
- wann ein Punkt `Applicable`, `N/A` oder `Open` ist,
- warum Swift eine MSL ist und trotzdem sprachspezifische Secure-Coding-Prüfung braucht.

## 4. Scope

Der spätere Lauf soll mindestens diese Artefakte prüfen und bei Bedarf aktualisieren:

- `docs/secure-development/README.md`
- `docs/secure-development/Richtlinie_Sichere-Entwicklung.md`
- `docs/secure-development/Checklistensammelband_Sichere-Entwicklung.md`
- `docs/secure-development/checklisten/`
- `docs/secure-development/mitgeltende-dokumente/`
- Agenten- und Template-Flächen, sofern sie auf die sichere-Entwicklung-Basis verweisen
- `scripts/templates/secure-development-hardening-lastenheft.md`

## 5. Nicht-Ziele

Dieses Lastenheft startet keinen Härtungslauf in Level-2-Repositories. Es erzeugt keine projektspezifischen Nachweise in `docs/security/`, keine Feature-Branch-Spezifikation und keine Implementierungsänderung an Produktcode.

Ein neuer Preset-Release ist nur erforderlich, wenn der Abgleich eine echte Änderung an Preset-Regeln, Templates oder Evidence-Pflichtfeldern ergibt. Reine Dokumentations- und Mapping-Klarstellungen bleiben in der Secure-Development-Basis.

## 6. Mindestanforderungen an den späteren Lauf

1. Eine zentrale Mapping-Datei für Richtlinie, Checklisten, mitgeltende Dokumente und Spec-Kit-Presets ist vorhanden.
2. Jedes mitgeltende Dokument hat eine verständliche Lern- und Prüfsektion mit Zweck, Anwendbarkeit, typischen Nachweisen und `N/A`-Regel.
3. Swift ist als MSL sichtbar erklärt und mit der CISA-Unterlage sowie der bestehenden Constitution/Preset-Logik abgeglichen.
4. Die Dokumente bleiben DE/EN, CEFR B2 und WCAG-2.2-AA-freundlich: klare Überschriften, beschreibende Links, keine rein visuelle Bedeutung.
5. Spec-Kit-Läufe können die Mapping-Datei als Intake nutzen, ohne eigene Zuordnungen erfinden zu müssen.
6. Level-2-Propagation kopiert nur die generische sichere-Entwicklung-Basis und die Intake-Artefakte; konkrete Projektnachweise bleiben Aufgabe der später separat gestarteten Härtungsläufe.

## 7. Erwartete Ergebnisartefakte

| Artefakt | Erwartung |
|---|---|
| Mapping-Datei | Richtlinie, CLs, mitgeltende Dokumente und Presets sind nachvollziehbar verbunden |
| Mitgeltende Dokumente | Lern-, Prüf- und Evidenzhinweise sind für Auszubildende verständlich |
| Richtlinie | Verweist auf Mapping, Swift/MSL-Einordnung und Spec-Kit-Nachweisführung |
| Sammelband | Weist auf Mapping als Hilfsmittel für CL-/Preset-Abdeckung hin |
| Agenten-/Template-Flächen | Verweisen auf Mapping, wenn sie Secure-Development-Basis propagieren |
| Level-2-Repos | Erhalten den aktualisierten Stand ohne projektspezifische `docs/security/`-Nachweise |

## 8. Akzeptanzkriterien

- Es gibt keine stille Auslassung relevanter Prüfbereiche.
- Jede Nichtanwendbarkeit bleibt als `N/A` mit kurzer Begründung dokumentierbar.
- Swift ist konsistent als MSL eingeordnet.
- Die sieben Governance-Presets bleiben fachlich widerspruchsfrei zur Richtlinie und den mitgeltenden Dokumenten.
- `git diff --check`, Secret-Scan und Propagations-Dry-run laufen ohne blockierende Befunde.

## 9. Spec-Kit-Intake-Reife

Dieses Lastenheft ist als direkte Eingabedatei fuer einen spaeteren
`/speckit-specify`-Lauf geeignet. Der Lauf soll zuerst die bestehende
Verzahnung pruefen und dann nur dort Aenderungen planen, wo Richtlinie,
Checklisten, mitgeltende Dokumente, Agenten-Guidance oder Preset-Evidenz
auseinanderlaufen.

Der spaetere Lauf muss ausdruecklich dokumentieren:

- welche Artefakte nur gelesen wurden,
- welche Artefakte geaendert werden sollen,
- ob eine reine Dokumentationskorrektur reicht,
- ob ein Preset-Release notwendig wird,
- welche Level-2-Propagation danach erforderlich ist,
- welche Punkte als `N/A` gelten und warum.

## 10. Kopierbarer `/speckit-specify`-Prompt

```text
/speckit-specify Nutze Lastenheft_Mitgeltende-Dokumente-Spec-Kit-Verzahnung.md als verbindliche Eingabedatei. Erstelle die Feature-Spezifikation fuer einen Spec-Kit-Lauf zur besseren Verzahnung von Richtlinie Sichere Entwicklung, den zwoelf Checklisten, dem Sammelband, den mitgeltenden Dokumenten und den sieben Governance-Presets.

Ziel: Die sichere-Entwicklung-Basis soll fuer Fachinformatiker*innen in Ausbildung, Entwickler*innen, Reviewer und KI-Agenten so klar werden, dass spaetere Level-2-Spec-Kit-Laeufe dieselbe Bewertungslogik fuer `Applicable`, `N/A`, `Open`, Evidenzpfad, Restrisiko und Follow-up verwenden.

Pflichtkontext:
- Pruefe `docs/secure-development/README.md`, `Richtlinie_Sichere-Entwicklung.md`, `Checklistensammelband_Sichere-Entwicklung.md`, `checklisten/`, `mitgeltende-dokumente/` und `scripts/templates/secure-development-hardening-lastenheft.md`.
- Pruefe die Konsistenz zu `security-governance`, `architecture-governance`, `isaqb-architecture-governance`, `a11y-governance`, `cross-platform-governance` und `agent-parity-governance`.
- Swift bleibt als Memory-Safe Language sichtbar, ersetzt aber keine sprachspezifische Secure-Coding-Pruefung.
- Inhalte bleiben DE/EN, CEFR B2 und WCAG-2.2-AA-freundlich.

Nicht-Ziele:
- Keinen Level-2-Haertungslauf starten.
- Keine projektspezifischen `docs/security/`-Nachweise befuellen.
- Kein Preset-Release planen, wenn nur Klarstellungen in der Secure-Development-Basis erforderlich sind.

Erzeuge eine Spezifikation mit Scope, Nicht-Zielen, betroffenen Artefakten, Anforderungen, Akzeptanzkriterien, Pruefstrategie und klarer Entscheidung, ob Presets, Agenten-Guidance, Templates oder nur Dokumentation betroffen sind.
```
