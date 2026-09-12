# Accessibility and Language Checklist

- [x] WCAG 2.2 Level AA is the review baseline where criteria apply.
- [x] Every five-column table must remain meaningful in source order and after
  linearisation; each row exposes position, status, full intake name,
  dependencies, feature state, and a textual next action where relevant.
- [x] Full filenames, not generic phrases such as “here”, are link text.
- [x] Meaning does not depend on color, emoji, glyph, pointer interaction,
  visual grouping, or column position alone.
- [x] User-facing explanations are German first and English second at CEFR B2
  where the local language contract applies.
- [x] Spec Kit, feature proof, binding edge, check mode, and generated view are
  explained on first use; no prior Spec Kit experience is assumed.
- [x] Markdown and CLI output remain usable with keyboard-only operation,
  screen readers, Braille displays, and text browsers.
- [x] Non-trivial path, ambiguity, atomicity, idempotence, parity, and proof
  boundaries receive concise didactic why-comments when implemented.
- [x] HTML/UI is `N/A` for the Foundation artifacts; trigger: generated HTML,
  application UI, or DocFX navigation enters the diff.
- [x] Image is `N/A`; trigger: a non-text visual is added.
- [x] Audio/video is `N/A`; trigger: time-based media is added.
- [x] Native Linux/Windows text-oriented usability and parity evidence passed
  at the exact reviewed heads.

## Home evidence through T066

- [x] Five linearized references cover root, one edge, multiple edges, linked
  feature, and missing feature; both actual test runners consume all five.
- [x] All twelve `LIE001`–`LIE012` references preserve stable code, safe
  repository-relative subject, German-first/English-second remediation, and
  contain no credential, private-root, control-sequence, or stack disclosure.
- [x] Executable Bash and PowerShell public-CLI tests capture stdout and stderr
  separately and cover safe plus credential-shaped relative subjects for both
  `LIE004` missing-file and `LIE007` unknown-endpoint errors.
- [x] Both public help paths expose the five-column contract without private
  paths; both public safe-mode paths report `Current` and zero writes.
- [x] The source-order review dispositions WCAG 2.2 AA 1.3.1, 1.4.1, 2.1.1,
  2.4.6, 3.1.2, 3.3.1, and 3.3.2 in
  `docs/accessibility/linked-intake-evidence.md`.
- [x] A separate named assistive-device lab is `N/A` for these Markdown and CLI
  source artifacts: linearized text, keyboard-only operation, full link text
  and native shell output are the applicable acceptance surface. Trigger:
  generated HTML/UI, a non-text artifact, user-reported barrier or an explicit
  device-lab requirement enters scope.
- [x] Independent or explicitly authorized compensating review and native
  Linux/Windows evidence are terminal for all seven candidates.

The checklist and seven-repository acceptance evidence are complete. Owner:
Accessibility/Language Reviewer. Residual risk: future renderers may change
linearized reading order or diagnostics. Re-evaluate on wording, view
structure, link, diagnostic, platform, artifact type or reported barrier.

The current diagnostic claim is bound to
`diagnostic-remediation-2026-09-10.md`; it supersedes the earlier
absolute-`LIE003`-only proof without rewriting its historical report.
