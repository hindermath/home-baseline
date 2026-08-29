---
name: speckit-secure-development-status
description: Inspect one secure-development evidence context without changing files
compatibility: Requires a Spec Kit project and the secure-development assurance preset
metadata:
  author: github-spec-kit
  source: preset:secure-development-assurance-governance
---

# Secure Development Status

Use for $speckit-secure-development-status [<evidence-dir>].

Read the selected evidence context and validate baseline, delta, closure, and
image-impact. Do not modify files or Git/remote state. Report applicability
and implementation separately. Never infer pilot authorization, project
acceptance, or general sandbox/product/fleet release from technical success.
