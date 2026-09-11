# Security and Architecture Disposition

| Topic | Decision | Reason / evidence boundary | Re-evaluation trigger |
|---|---|---|---|
| Memory-safe language (MSL) | Applicable | JavaScript/C#/Python product contexts remain MSL; Bash and PowerShell follow their secure scripting rules | renderer language/runtime changes |
| Bash | Applicable | quoted variables, `--`, no untrusted `eval`, bounded files | Bash logic changes |
| PowerShell 7 | Applicable | Strict Mode, validated parameters, approved Verb-Noun functions, no `Invoke-Expression`, `${Name}` before punctuation | PowerShell logic changes |
| NIST SSDF | Applicable | traceability, input validation, review and exact-head evidence | implementation/evidence workflow changes |
| CWE Top 25 | Applicable | traversal, injection, unsafe command construction and input handling tests | input or process boundary changes |
| STRIDE / CIA | Applicable | spoofed proof, tampered manifest, repudiation via missing evidence, disclosure of paths, denial by invalid input, privilege boundary; integrity/availability/confidentiality | trust boundary changes |
| CAPEC | Applicable | path traversal, command/option injection, malicious file/link patterns | input surface changes |
| OWASP SAMM | Applicable | Requirements and Verification practice evidence | programme/review model changes |
| OWASP ASVS | N/A | no web/API/HTTP/auth/session surface | any such surface enters diff |
| SBOM | N/A | no new package, dependency, release artifact, or image | supply-chain/release scope changes |
| VEX | N/A | no shipped vulnerability disposition is introduced | a known shipped vulnerability is evaluated |
| AI-SBOM | N/A | AI is development tooling only, not product/runtime | model/service/dataset/inference enters product |
| SLSA | N/A | no build provenance or release artifact changes | build/release scope changes |
| OpenSSF Scorecard | N/A | no dependency/project selection or release-governance change | supply-chain selection changes |
| Zero Trust | N/A | no distributed service, remote access, or network trust boundary | network/service boundary changes |
| BSI C3A | N/A | no cloud-service selection or autonomy decision | cloud dependency changes |
| BSI C5 | N/A | no cloud assurance/shared-responsibility scope | cloud provider or hosted service enters scope |
| NIS2 | N/A | private documentation renderer; no operator/entity scope decision | regulated entity/service scope changes |
| CRA | N/A | no product-with-digital-elements market/release decision | market/release scope changes |
| EU AI Act | N/A | no AI product/runtime/system is delivered | AI system enters product scope |
| DORA | N/A | no financial-entity ICT service scope | financial ICT/customer scope changes |
| Secure Development Assurance v0.1.3 | Applicable validator contract; Feature 032 control/image reassessment `N/A / Not Assessed` | exact dated context, exact case-sensitive `contextId`/`mode`, array-typed `acceptedRisks` when present; Home context is `home-baseline-assurance-v013`/`training`, AOC remote context is `aoc-assurance-v013`/`training`; neither context is changed by this feature | context, mode, risk schema, evidence, installed profile, authority, product/runtime/image or scope changes; before each repository slot |

No dependency is added. The architecture remains `canonical manifest and
feature evidence -> repository-local renderer -> generated Markdown ->
validation`. No ADR/S-ADR is required unless a new source owner, component,
external interface, deployment, or trust boundary appears. Owner for the
bounded Assurance disposition is the Feature Orchestrator; residual risk is
misreading structural `Ready` as control implementation or approval. Existing
technical evidence does not grant human-only acceptance, rollout or
certification.

## Home evidence through T066

- [x] The paired Bash and PowerShell suites passed against the real public
  renderer and wrapper interfaces on macOS.
- [x] Synthetic private-root, credential-shaped, control-character, and
  HTML-shaped inputs prove fail-closed validation, contextual output encoding,
  redacted diagnostics, and absence of PowerShell stack details.
- [x] Superseding executable tests preserve ordinary relative context and
  redact credential-shaped relative input across `LIE004` and `LIE007`, with
  separate stdout/stderr assertions and safe remediation for `LIE001`–`LIE012`.
- [x] STRIDE/CIA, CAPEC-126/CAPEC-88, NIST SSDF PW.4/PW.5/RV.1, and relevant
  CWE-20/22/78/79/116/209 controls are proportionately dispositioned in
  `docs/security/linked-intake-evidence.md`.
- [x] Context, data flow, trust boundary, six measurable quality scenarios,
  arc42 Section 8, ADR/S-ADR `N/A`, comment review, and reevaluation triggers
  are recorded in `docs/architecture/linked-intake-evidence.md`.
- [x] PSScriptAnalyzer 1.25.0 passed 107 tracked owned files plus the one
  explicitly checked untracked owned test file; the configured four generated
  upstream exclusions were preserved.
- [x] The fail-on-high secret scan passed with `high=0` and
  `gitleaks_high=0`; dependency surfaces have an exact zero diff.
- [ ] Independent Security/Architecture review remains `Open`; this local
  runner evidence does not claim that human gate.
- [ ] Native Linux and Windows renderer evidence remains `Open` until T071.

Machine evidence:
`.specify/runtime/autonomous-routing/c53e4b5b-74fa-4ff9-ac5e-ce51850a5321/linked-intake-evidence/evidence/v1/repositories/home-baseline/governance-macos.json`.
Human-readable superseding lineage:
`specs/032-linked-intake-evidence/diagnostic-remediation-2026-09-10.md`.
