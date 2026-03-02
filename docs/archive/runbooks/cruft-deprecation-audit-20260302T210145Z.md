# Comprehensive Cruft / Deprecation Audit

Date: 2026-03-02T21:01:45Z
Owner: Zappa
Scope: `docs/**/*.md` (active docs), plus newly-added listing-stager skill/runbook integration context

## Executive Summary
Short answer: **not all of what you’re seeing is cruft**. Most files are still legitimate artifacts (strategy, sequence pack, proof pack, SOPs, and historical audits). The prior consolidation added a runbook + skill + cron controls, but intentionally did **not** delete or archive historical/authoring docs.

That said, there is real cleanup opportunity. Recommended action is **controlled deprecation** (archive/index/pointer), not blind deletion.

## Current inventory classification

### Keep (active canonical or required)
- `docs/listing-stager/INSTANTLY-OUTREACH-SSOT.md` (program index)
- `docs/listing-stager/LISTING-STAGER-OUTREACH-RUNBOOK.md` (policy/control plane)
- `docs/runbooks/self-audit-sop.md` (active SOP)
- `docs/runbooks/index.md` (navigation)
- `docs/caa-0040-index.md` + linked CAA-0040/0041 stack (active architecture/cadence)

### Keep (historical evidence; not cruft, but archival candidates)
- `docs/runbooks/architecture-audit-20260226T210140Z.md`
- `docs/runbooks/architecture-audit-20260302T150000Z.md`
- `docs/runbooks/content-hygiene-audit-20260302T0316Z.md`

### Keep-for-now (execution source docs now partly superseded by runbook/skill)
- `docs/listing-stager/CAA-0067-lead-sourcing-enrichment-spec.md`
- `docs/listing-stager/CAA-0068-instantly-campaign-architecture.md`
- `docs/listing-stager/CAA-0069-cron-automation-staging-sop-sot.md`

Rationale: these are still referenced by SSOT/runbook/cron payloads and contain durable specifics. They are not dead yet.

## True duplication / drift surface
1. Listing-stager governance text appears in SSOT + 0068 + 0069 + runbook.
2. Runbooks folder has operational SOP + timestamped reports in one flat namespace.
3. Older task artifact docs (0064/0065/0066) remain useful but should be explicitly labeled as ticket artifacts to reduce "active policy" confusion.

## Deprecation plan (safe, minimal-risk)

### Phase 1 — immediate (no destructive deletes)
1. Add deprecation banner to 0067/0068/0069:
   - "Normative policy moved to LISTING-STAGER-OUTREACH-RUNBOOK.md"
   - "Keep for ticket traceability and detailed reference"
2. Add explicit section in SSOT:
   - `Canonical Policy: LISTING-STAGER-OUTREACH-RUNBOOK.md`
   - `Ticket Artifacts: CAA-0064..0069`
3. Keep runbook audits as historical logs; no deletion.

### Phase 2 — archive pass (after 1 week stable)
1. Move timestamped audit reports under `docs/runbooks/archive/2026/`.
2. Keep `docs/runbooks/index.md` as the single entrypoint with links.
3. Keep latest audit report in top-level `runbooks/` only if desired.

### Phase 3 — hard cleanup (explicit approval required)
1. Consolidate 0067/0068/0069 into a single `listing-stager/reference/` doc and replace originals with thin pointers.
2. Delete fully superseded originals only after:
   - SSOT and cron payload references are updated,
   - no active dependencies remain,
   - owner signoff.

## Recommendation
**Do not bulk-delete now.**
Proceed with Phase 1 pointerization/deprecation labels first, then archive historical report clutter in Phase 2.

This preserves traceability and avoids breaking cron or future ticket audits while still cleaning up navigation and reducing confusion.

## Suggested next concrete action
If approved, I will execute Phase 1 immediately in one commit:
- add deprecation headers to 0067/0068/0069,
- tighten SSOT canonicality language,
- update `docs/runbooks/index.md` with active vs historical sections (already started, can harden further).
