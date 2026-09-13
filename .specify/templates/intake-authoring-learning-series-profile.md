# Home Baseline Learning-Series Intake Authoring Profile

## Identity

- Profile ID: `home-baseline-learning-series`
- Applies when: A learning task under `docs/learning-units/` becomes one later
  manually started Spec Kit intake.
- Target path rule:
  `docs/learning-units/Lastenheft_<series>_<NN>_<descriptive-slug>.md`.
- Language rule: German first and English second, CEFR B2.

## Required Sections

In addition to the portable core, include learning goal, learner audience,
prior knowledge, professional-role and learning-field relation, scenario,
learner tasks, evidence, reflection, security/privacy/A11Y applicability,
teacher or trainer boundary, and links to the matching study companion and
series register.

The intake remains concise. Explanatory depth and model answers belong in the
study companion, not in the task intake.

## Naming And Ordering

Use the registered series name and two-digit unit order. Verify the Learning
Series Register, Blueprint, curriculum mapping, predecessor unit, and package
manifest. Never create a whole-series Spec Kit run from one unit.

## Quality Gates

- Learner documentation must not require a GitHub account unless the selected
  route actually uses GitHub or optional Copilot sign-in.
- Agent use for Secure Trader systems is Container-First from Unit 00 and must
  pass the documented sandbox preflight before the first agent invocation.
- Spec Kit supports the learning task but does not replace vocational school,
  workplace training, trainer decisions, curriculum, or exam preparation.
- The copy-ready prompts must prohibit a whole-series run and preserve manual
  learner-run authorization.
- Apply CEFR B2, semantic Markdown, stable reading order, keyboard/text-first
  evidence, and applicable WCAG 2.2 Level AA.

<!-- BEGIN spec-kit-diagrams-completion -->
## Mermaid und Spec-Kit-Abschlussbericht / Mermaid and Spec Kit completion report

Neue Lastenhefte enthalten bei hilfreichen Abläufen, Zuständen oder Abhängigkeiten
lesbaren Mermaid-Quelltext im Markdown und eine gleichwertige Textalternative.
Bei einfachen Inhalten die Nichtanwendung kurz begründen. Diagramme bilden die
verbindlichen Text-/Manifestquellen ab; Farbe allein trägt keine Bedeutung.
Nach jedem vollständig abgeschlossenen Spec-Kit-Feature-Lauf den vollständigen
Ergebnisbericht im Chat anzeigen und im Feature-Verzeichnis als
`completion-report.md` versionieren. Einzelne Planungs-/Status-/Review-Kommandos
lösen keinen solchen Bericht aus; blockierte oder pausierte Läufe als
Zwischenbericht kennzeichnen. Vorlage: `.specify/templates/completion-report-template.md`;
Regel: `docs/spec-kit-diagrams-and-completion-reports.md`.
Ergebnis, Tests, Dokumentation, Git-gebundene Umfangszahlen, Verlauf und Restpunkte
belegen. Programmlogik von generierter Evidence, Git-Wandzeit von aktiver
Arbeitszeit und bestandene von ausgefallenen Prüfungen unterscheiden. Finale
Merge-/Sync-Evidence im Chat und bestehenden Closeout-Nachweis ergänzen; keine
zusätzlichen Commits allein für selbstreferenzielle Berichts-/Statistikwerte.
Diese Projektregel und lokale Vorlagen bei Spec-Kit-Updates erhalten.

*New intakes use readable Mermaid Markdown and equivalent text alternatives for
useful workflows, states or dependencies; justify omission for simple content.
Diagrams reflect authoritative text/manifests and never rely on color alone.
After each completed feature run, show the full outcome report in chat and
version completion-report.md in the feature directory using the shared template
and rule above. Individual planning/status/review commands do not trigger it;
paused/blocked runs receive interim reports. Evidence outcomes, tests, docs,
Git-bound counts, delivery history and remaining work. Distinguish code from
volume generated as evidence, elapsed from active time, and passed from failed
checks. Add final merge/sync proof in chat and existing closeout evidence, without
commits solely for self-referential counts or IDs. Preserve local rules/templates
across Spec Kit updates.*
<!-- END spec-kit-diagrams-completion -->
