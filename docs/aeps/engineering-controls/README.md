# AEPS Engineering Controls Framework – ruhender Arbeitsstrang / Dormant Workstream

## Zweck und Status / Purpose and status

Dieser Level-0-Arbeitsstrang bereitet einen allgemeinen Rahmen fuer
Engineering Controls vor. Ein Engineering Control beschreibt eine
nachweisbare Engineering-Eigenschaft, nicht deren konkrete Ausfuehrung durch
ein Preset, einen Validator oder einen KI-Agenten. / *This level-0 workstream
prepares a general Engineering Controls framework. A control describes an
evidenced engineering property, not its concrete execution through a preset,
validator, or AI agent.*

Der aktuelle Zustand ist `BlockedPreconditions`. Der
[Aktivierungsaudit vom 2. August 2026](activation-audits/2026-08-02.json) hat
keinen Analyse- oder Authoring-Lauf gestartet. / *The current state is
`BlockedPreconditions`. The activation audit did not start analysis or
authoring.*

## Verbindliche Reihenfolge / Binding sequence

1. Die AOC-RAW-Reihe RAW-01 bis RAW-09 wird vollstaendig abgeschlossen.
2. Die Analysephase des AEPS Preset Engineering Program wird im kanonischen
   Level-0-Repository abgeschlossen.
3. Erst danach darf das Engineering Controls Framework analysiert werden.
4. Das Completion Receipt des Frameworks wird zum Eingangsgate fuer den
   spaeteren Entwurf der AEPS-Preset-Lastenheft-Reihe.

*Complete the AOC RAW series and the canonical Preset Engineering analysis
before analysing the Controls Framework. Its Completion Receipt becomes an
input gate for the later preset-engineering intake-series draft.*

Der [maschinenlesbare Aktivierungsvertrag](activation-contract.json) ist fuer
Gates, Evidence-Mindestwerte, Deliverables, Lastenheft-Landkarte und
Stop-Grenzen verbindlich. / *The machine-readable activation contract is
binding for gates, evidence thresholds, deliverables, the proposed intake
map, and stop boundaries.*

## Evidence-Grenze / Evidence boundary

- `hindermath/home-baseline` ist das System of Record.
- AOC ist die primaere, read-only Evidence-Quelle.
- TuiVision, TinyCalc und TinyPl0 sind qualifizierte Vergleichsprojekte.
- Eine Eigenschaft wird nur Control-Kandidat, wenn mindestens zwei Projekte,
  zwei unabhaengige Evidence-Ereignisse, Review- oder Completion-Bindung sowie
  positive und negative Evidence vorliegen.
- Nicht qualifizierte Beobachtungen bleiben als Eigenschaftscluster sichtbar,
  werden aber nicht als Engineering Control bezeichnet.
- AOC-spezifische Technologien, Pfade und Produktentscheidungen bleiben
  ausgeschlossen.

*AOC alone never establishes a control candidate. Unqualified observations
remain visible without being labelled as controls, and product-specific
technology decisions remain excluded.*

## Geplante Ergebnisse nach Aktivierung / Planned post-activation outputs

Nach einem vollstaendig bestandenen Audit darf der Arbeitsstrang
ausschliesslich folgende Analyseartefakte erzeugen: / *After a fully passing
audit, the workstream may produce only these analysis artefacts:*

1. Engineering Control Landscape
2. Engineering Control Taxonomy
3. Control-to-Preset Matrix
4. Control-to-Finding Matrix
5. vorgeschlagene AEPS-EC-Lastenheft-Landkarte und Series Map
6. Roadmap
7. hashgebundenes Completion Receipt

Die Landkarte beschreibt zwoelf spaetere Themen von Engineering Control Model
bis Control Deprecation. Sie erzeugt keine aktiven Lastenhefte. / *The map
describes twelve later topics from Engineering Control Model through Control
Deprecation. It creates no active intakes.*

## Stop-Grenze / Stop boundary

Der Analyse-Lauf endet mit `AwaitingEngineeringControlsAuthoringApproval`.
Bis zu einer neuen menschlichen Freigabe sind Control- und
Lastenheft-Authoring, Preset-Aenderung oder -Promotion, Produktimplementierung,
Spec-Kit-Ausfuehrung, Remote Write, Push, Merge und Bypass verboten. / *The
analysis ends in `AwaitingEngineeringControlsAuthoringApproval`. No control or
intake authoring, preset mutation or promotion, product implementation,
Spec-Kit execution, remote write, push, merge, or bypass follows without new
human approval.*

## Dokumentationsauswirkung / Documentation impact

Entscheidung: `UpdateRequired`. Kanonische Quelle und Owner sind dieser
Level-0-Vertrag und der Level-0-AEPS-Maintainer. Zielgruppe sind Maintainer,
Reviewer und KI-Agenten; der Leserpfad fuehrt vom Dokumentationsportal zu
diesem Charter, danach zum Aktivierungsvertrag und aktuellen Audit.
Distributionsklasse ist `sourceOnly`; ein Home-Sync ist nicht erforderlich.
Evidence und Re-Evaluation stehen in
[documentation-impact-evidence.json](documentation-impact-evidence.json). /
*Decision: `UpdateRequired`. This level-0 contract is source-only and requires
no Home sync. Re-evaluate it after the RAW series and Preset Engineering
analysis are complete.*
