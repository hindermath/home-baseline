# Home Baseline Lastenheft Authoring Profile

## Identity

- Profile ID: `home-baseline-lastenheft`
- Applies when: A repository feature or governance package needs one binding
  requirements intake outside `docs/learning-units/`.
- Target path rule: Repository root, `Lastenheft_<descriptive-slug>.md`, unless
  an existing ordering contract names another path.
- Language rule: German first and English second, CEFR B2.

## Required Sections

In addition to the portable core, record document status, version, date,
binding predecessors, execution order, hard stop boundaries, affected
repositories, platform requirements, and completion boundary when applicable.

Every active Lastenheft ends with exactly one copy-ready Specify prompt and one
copy-ready Autonomous prompt. Both name the exact file. Creating the Lastenheft
starts no feature or implementation.

## Naming And Ordering

Use a stable descriptive filename. Preserve existing numbered intake order and
supersession markers. Do not invent a feature number when the repository has
not reserved it. A conflict between existing order and proposed scope is a
material clarification.

## Quality Gates

- Apply repository security, privacy, architecture, A11Y, agent-parity,
  cross-platform, statistics, and evidence rules.
- User-facing prose is German first, English second, CEFR B2, and text-first.
- Applicable WCAG 2.2 Level AA expectations remain explicit.
- Default Autonomous authority is `LocalImplementation`; broader authority
  requires current explicit evidence.
- Preserve the public standard preset profile while documenting optional local
  profile selection separately.

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
