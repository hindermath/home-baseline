# Secure development: lessons from security reviews

[Deutsche Fassung: Sicher entwickeln](praxisleitfaden-sichere-entwicklung.md)

**Audience:** Apprentices in the four German IT occupations (IT specialist,
IT systems electronics, IT systems management, and digitalisation management)
and developers without specialist security knowledge.

**Example date:** 15 November 2026. The linked reports describe specific
historical revisions. This guide does not claim a repository's current scan
or approval status.

## What this guide is for

Secure code starts with a simple question: **Which data must I treat as
untrusted?** It may be input from a user interface, a repository file,
configuration, a downloaded package, or a path supplied to a script. A
repository can contain harmful content even when its files do not change
during a single review run.

This text explains practical decisions. Binding rules are in the
[secure programming guideline](mitgeltende-dokumente/Leitlinie_Sichere-Programmierung.md),
the [secure development guideline](Richtlinie_Sichere-Entwicklung.md),
and the [checklists](checklisten/). A specific change also follows its
project's `SECURITY.md`, threat model, and tests.

**Next safe action:** Select one data flow in your task. Write down its
input, trust boundary, processing step, and possible impact. Then find the
matching rule and a test with an invalid input.

## Three terms to keep separate

- An **alert** is a signal from a tool such as CodeQL. It points to a
  possible data flow or pattern. By itself, it does not prove an exploitable
  vulnerability.
- A **confirmed defect** has a reproducible cause and a reachable security
  boundary. A fix needs a test and a new scan of the reviewed revision.
- A **false positive** is a reviewed data flow that does not cross a
  security boundary under the recorded threat model. Its rationale must
  match the repository, rule, path, and analysed revision. A merely similar
  file is not enough.

A green CodeQL run shows that its configured analyses ran. It does not prove
that the code has no defects. It also does not establish coverage of Bash,
PowerShell, assembly, or other languages not analysed by CodeQL. Those
languages need suitable tests, review, and sometimes other tools. See the
[assessment of shared CodeQL findings](../maintenance/codeql-shared-security-2026-11-13.md).

## What the documented cases show

### File paths and external targets

A path that appears to be inside a repository can lead outside it through a
symbolic link. On Windows, a reparse point can have a similar effect. This
matters when deleting, overwriting, extracting, or writing evidence. Check
the **physical** target boundary and the type of existing files before a
script writes. A text check for `..` is not enough. If a worktree may change
during validation, the threat model and tests must also cover that race.

Level 0 fixes included removing only a partial learning-package destination
created by the current invocation, physically binding feature evidence, and
atomically replacing CSV files. The [remediation report with alert mapping](../maintenance/level0-codeql-remediation-batch-2026-11-14.md)
records the individual historical findings and test limits.

### Processes, configuration, and CI permissions

When data is executed as shell text, special characters can form an extra
command. Pass a program and its arguments separately. An argument array
does not remove the need to check **whether the selected program and its
target are allowed**. Downloads and configuration also need traceable
origins and valid formats.

CI is a program with permissions. A validation workflow usually needs only
read access. The [Deep Scan remediation report](../security/deep-scan-high-remediation-2026-11-06.md)
documents bounded paths, checked manifest values, and `contents: read` for
a generated validation workflow. These are learning examples, not general
approval for another repository.

### Evidence, scans, and distribution

A fix in a shared source reaches consumers only through their defined
distribution process. Check package version, installed file, and analysed
revision separately. An older alert may concern older code; a new scan
must analyse the revision that was actually delivered. Historical evidence
is not rewritten to make that happen.

A scanner can miss a real defect or flag a harmless path. A **threat model,
focused test, code review, and scan** therefore support each other. None
of them alone replaces the others.

## What memory-safe languages provide

A *memory-safe language* (MSL) prevents or limits common memory access
errors. For example, it checks bounds or ownership rules. It does not
automatically prevent SQL injection, unsafe file paths, missing
authorisation, data leaks, harmful dependencies, or unrestricted network
access. Native extensions and `unsafe` blocks can introduce additional
memory boundaries.

The [sandbox MSL overview](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/security/msl-applicability.md)
lists six supported language families. The following advice also applies
outside that sandbox, but must be adapted to the specific project.

### C# and .NET

- **Common risk:** A web application puts input directly into SQL, HTML,
  or a file path. Garbage collection does not protect these boundaries.
- **Safer approach:** Use database parameters instead of assembled SQL,
  encode output for its HTML context, check access rights before reading
  or writing, and allow only intended file targets.
- **Test:** Try special characters, another user's object ID, and a path
  outside the allowed area. A rejected request must not show a connection
  string or stack trace to the user.

### Java

- **Common risk:** A DTO or JSON document is syntactically valid but
  contains forbidden values or another user's object ID.
- **Safer approach:** Validate input when it enters the application, check
  access to the specific object, parameterise database access, and limit
  deserialisation to expected types.
- **Test:** Try invalid values, foreign IDs, large inputs, and unexpected
  types. Error responses should be clear without exposing internals.

### Go

- **Common risk:** A service fetches a user-supplied URL or waits without
  a limit for an external response.
- **Safer approach:** Check allowed destinations and redirects, set
  timeouts, and pass `context` through to the network call. Use
  `crypto/rand` for security-sensitive random values.
- **Test:** Try internal or forbidden destinations, redirects, and slow
  responses. Cancellation and timeout must end the request.

### Rust

- **Common risk:** Untrusted input causes a `panic`, or a small `unsafe`
  block breaks an undocumented assumption.
- **Safer approach:** Parse bounded formats, handle errors with `Result`,
  and keep `unsafe` small, justified, and reviewable. Review boundaries
  to external libraries and native functions separately.
- **Test:** Try empty, oversized, malformed, and boundary inputs. A parser
  error must not terminate a service unexpectedly.

### Python

- **Common risk:** A script opens a path from JSON or executes input with
  `eval`, `pickle`, or `shell=True`.
- **Safer approach:** Check JSON fields and values, physically bound file
  targets, and start processes with argument arrays. Do not use `pickle`
  or `eval` with unknown data.
- **Test:** Try unknown fields, links escaping the repository, special
  characters in arguments, and failed partial operations. Dry-run must
  not write files.

### Swift

- **Common risk:** A force unwrap terminates the app on malformed data,
  or a file URL or network target leaves the allowed area.
- **Safer approach:** Validate decoded values, handle optionals, and
  restrict file URLs to the intended area. Store secrets in Keychain and
  use suitable platform crypto APIs such as CryptoKit.
- **Test:** Try missing fields, invalid URLs, and expired access rights.
  The application should show a clear error message.

## Scripts also need security review

### Bash

A Bash script can delete files, install tools, or update repositories.
Quote variables such as `"$path"`, end options before a file name with
`--`, avoid `eval` on untrusted data, and verify download sources and
checksums. `set -euo pipefail` helps detect errors but does not replace
input validation or safe deletion boundaries. Test file names with spaces
and a leading `-`, symlinks, missing tools, and a read-only `--dry-run`.

### PowerShell 7

Use validated parameters and `-LiteralPath` for paths. Avoid
`Invoke-Expression` on untrusted text. `-WhatIf` and
`SupportsShouldProcess` show the planned effect before a change; native
programs also need an exit-code check. Test special characters, missing
targets, links, and Windows reparse points. Bash dry-run and PowerShell
WhatIf should reach the same security decision.

The [sandbox rules for Python, Bash, and PowerShell](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/security/secure-coding-language-rules.md)
describe additional boundaries for scripts in that environment.

## How to review a change

1. **Name the asset:** What must not be read, changed, or deleted? Who may
   trigger the action?
2. **Draw the data flow:** Where does input enter, where is it checked, and
   which file, database, URL, or process uses it?
3. **Check the boundary:** Is the physical path bounded? Is the target
   allowed? Are permissions sufficient? Are secrets kept out of logs and
   error messages?
4. **Build a negative test:** It must reject invalid input while preserving
   existing data and intended functions.
5. **Read tool results:** Check the alert, rule, path, data flow, and
   analysed revision. Record `needs_review` when the boundary is unclear.
6. **Check delivery:** After a fix, inspect the exact source and consumer
   revisions. A green scan is partial evidence, not general security approval.

The four occupations have different areas of focus: IT specialists inspect
program flow; IT systems electronics apprentices also examine devices and
network boundaries; IT systems management apprentices examine permissions
and operations; digitalisation management apprentices examine data flows
and responsibility. **All four** can discuss the same data flow and evidence.

## Sandbox and accessibility

A sandbox limits an agent process, but does not make incoming files
trustworthy. Mounts can expose real host files. Credentials do not belong
in prompts, commits, or audit exports. The [sandbox isolation record](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/security/sandbox-isolation.md)
and [threat model](https://github.com/hindermath/absdd-image-sandbox/blob/main/docs/security/threat-model.md)
describe the actual boundaries. An open issue is not implicit risk
acceptance.

Security messages and reports must make sense without colour. State the
status and next action in text, use meaningful link names and a clear
heading order. A command must not ask an important question only through
the mouse or colour. Applicable WCAG 2.2 AA criteria cover user-facing
output and documentation; an automated check cannot prove full
accessibility.

## Further reading

- [Security code review checklist](checklisten/CL_08_Sicherheits-Code-Review.md)
  and [AI code generation checklist](checklisten/CL_09_KI-Codeerzeugung.md)
- [Secure development learning path](Lernpfad_Sichere-Entwicklung_Lehrjahr-1-bis-3.md)
- [Deep Scan remediation report from November 2026](../security/deep-scan-high-remediation-2026-11-06.md)
- [Level 0 CodeQL remediation report from November 2026](../maintenance/level0-codeql-remediation-batch-2026-11-14.md)
- [Assessment of shared CodeQL findings](../maintenance/codeql-shared-security-2026-11-13.md)

These sources are technical evidence and learning material. A specific
security decision remains bound to its project, threat model, and reviewed
revision.
