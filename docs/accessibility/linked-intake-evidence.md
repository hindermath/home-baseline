# Barrierearme verlinkte Intake-Evidence / Accessible Linked Intake Evidence

## Ergebnis und Prüfgrenze / Result and review boundary

Die Home-Ansicht, die öffentliche CLI-Hilfe und repräsentative Fehler wurden
am 10. September 2026 in Quellreihenfolge und als linearer Text geprüft. Alle
fünf Felder, direkte Kanten, Bindungsstatus, vollständige Dateinamen,
Featurezustand und nächste Aktion bleiben ohne Farbe und räumliches
Tabellenverständnis erkennbar. Die Bash- und PowerShell-Fixtures prüfen
dieselben Referenzen.

*The Home view, public CLI help, and representative errors were reviewed in
source order and as linear text on 10 September 2026. All five fields, direct
edges, binding state, complete filenames, feature state, and next action remain
available without colour or spatial table interpretation. The Bash and
PowerShell fixtures check the same references.*

Die supersedierende Diagnoseprüfung erfasst Standard-Output und Standard-Error
getrennt. Sichere relative Subjects bleiben für `LIE004` und `LIE007`
verständlich; credential-förmige Varianten werden redigiert. Code und
DE-vor-EN-Abhilfe bleiben in Standard-Error, während Standard-Output keine
Fehlerdiagnose oder synthetischen Credentialwert enthält.

*The superseding diagnostic review captures stdout and stderr separately.
Safe relative subjects remain understandable for `LIE004` and `LIE007`, while
credential-shaped variants are redacted without losing code or remediation.*

Dies ist eine ehrliche Quelltext-/Linearisierungsprüfung auf macOS. Es wurde
kein bestimmter Screenreader und keine Braille-Zeile bedient, kein unabhängiger
menschlicher Accessibility-Review durchgeführt und keine native Windows- oder
Linux-Evidence erzeugt. Diese assistiven und nativen Prüfungen bleiben spätere
Delivery-Gates.

*This is an honest source-order and linearisation review on macOS. No named
screen reader or Braille display was operated, no independent human
accessibility review occurred, and no native Windows or Linux evidence was
created. Those assistive and native checks remain later delivery gates.*

## WCAG-2.2-AA-Disposition

| Kriterium | Anwendung auf den Text-Renderer | Nachweis / Grenze |
|---|---|---|
| 1.3.1 Info und Beziehungen | Überschriften und die fünf Spalten besitzen stabile Quellreihenfolge; linearisierte Referenzen wiederholen die Feldnamen. | Paired Fixture-Test; keine Behauptung über erzeugtes HTML. |
| 1.4.1 Farbe | Status und Gate-Bedeutung stehen als Text; Farbe oder Glyph allein trägt keine Information. | ANSI-/Farbsteuerung wird in Referenzen abgelehnt. |
| 2.1.1 Tastatur | Markdown- und CLI-Prüfung erfordert keine Zeigeraktion; Links bleiben textuell vollständig. | Statische Textoberfläche; interaktive Webnavigation ist nicht im Scope. |
| 2.4.6 Überschriften und Beschriftungen | Bilinguale Überschrift sowie vollständige Intake-Dateinamen benennen Zweck und Ziel. | Quell- und Testprüfung. |
| 3.1.2 Sprache von Teilen | Deutsche Erklärung steht vor der englischen Fassung; technische Literale bleiben unverändert. | `languageOrder: [de, en]` im Diagnostikvertrag. |
| 3.3.1 Fehlererkennung | `LIE001`–`LIE012` benennen die Fehlerfamilie stabil und textuell. | Zwölf eindeutige Fixturecodes. |
| 3.3.2 Beschriftungen/Anweisungen | Jede Referenzdiagnose enthält eine sichere deutsche und englische Remediation. | Keine Credentials, privaten Roots oder Stacks. |

Der ausführbare Nachweis hierzu steht in
`specs/032-linked-intake-evidence/diagnostic-remediation-2026-09-10.md`. Er
ersetzt die zu enge frühere `LIE003`-Aussage, nicht die offenen nativen oder
assistiven Gates.

*The applicable controls are satisfied at the Markdown/CLI source boundary:
stable structure, text independent of colour, keyboard-neutral static output,
descriptive headings and filenames, German-before-English language order, and
identified errors with safe instructions. Generated HTML, assistive-device
behaviour, and native platforms are not inferred from this evidence.*

## Linearisierungsbeobachtung / Linearisation observation

Die erste Datenzeile mit zwei direkten Kanten liest sich nach Ersetzen des
renderer-eigenen `<br>` durch einen Zeilenwechsel in dieser Reihenfolge:
Position, Status, vollständiger Intake-Dateiname, erste Kante mit `kind` und
`binding`, zweite Kante mit `kind` und `binding`, Featurezustand. Harmlose
synthetische HTML-Tags in Status und Kantenlabel werden als `&lt;...&gt;` und
`&amp;` ausgegeben; nur der vertrauenswürdige Renderer-Separator bleibt `<br>`.

*After replacing the renderer-owned `<br>` with a line break, a row with two
direct edges reads as position, status, complete intake filename, first edge
with kind and binding, second edge with kind and binding, and feature state.
Harmless synthetic HTML tags in status and edge labels are emitted as data;
only the trusted renderer separator remains raw.*

Owner ist der Home-Repository-Owner, Reviewer für diesen Slice der
Feature-032-Runner. Restrisiko sind Unterschiede realer Screenreader- und
Braille-Konfigurationen. Re-Evaluation: geänderte Spalten-/Heading-Reihenfolge,
Linktexte, Sprache, Diagnoseform, HTML-Ausgabe oder native Plattform-Evidence.

*The Home repository owner owns this evidence; the Feature 032 runner reviewed
this slice. Residual risk is variation across real screen-reader and Braille
configurations. Re-evaluate on structure, links, language, diagnostics, HTML,
or native-platform evidence.*
