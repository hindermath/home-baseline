# Data Model: Windows Maintenance Hardening

## MaintenanceMode

- `name`: `CheckOnly | Preview | Update`
- `allowsMutation`: boolean
- `nestedParameters`: one mutually exclusive parameter projection

## ResumeEvidence

- `schemaVersion`
- `runId`
- `phase`
- `status`: `Prepared | Applied | Completed | Archived`
- `files[]`: repository-relative `path`, `beforeSha256`, `afterSha256`
- `nextAction`
- `updatedAt`

Invariant: Every current file hash must match the expected after-hash before an
applied phase can resume.

## ProcessResult

- `commandLabel`
- `status`: `Succeeded | Failed | TimedOut | DeferredAdminRequired`
- `exitCode`
- `attempts`
- `durationMs`
- `processTreeCleaned`
- `sanitizedSummary`

## PackageResult

- `canonicalId`
- `observations[]`
- `finalStatus`: `OK | MISSING | DEFERRED_ADMIN_REQUIRED | FAILED | CONFLICT`
- `evidence`

Invariant: Exactly one `PackageResult` exists per case-insensitive canonical
ID.

## RunReport

- existing Feature-009 report fields
- `runId`
- `overallStatus`
- `exitCode`
- `maintenanceMode`
- `prerequisites`
- `retryEvidence`
- `resumeEvidence`
- `packageResults`

Invariant: Top-level process exitcode equals the report exitcode for the same
Run ID.
