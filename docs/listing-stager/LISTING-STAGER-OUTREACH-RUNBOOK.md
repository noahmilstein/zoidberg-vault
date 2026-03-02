# Listing Stager Outreach Runbook (Policy + Controls)

Status: active
Owner: Zappa
Last updated: 2026-03-02

## Purpose
Single policy/control runbook for Listing Stager outreach operations. This file consolidates launch-gate, safety, QA, and status rules so execution can be automated without ambiguity.

## Scope
- Wedges: `agent`, `brokerage`, `photographer`
- Systems: lead sourcing/enrichment inputs, Instantly campaign staging, cron-based monitoring/reminders
- Excludes: go-live activation itself (requires explicit human approval)

## Source hierarchy
1. `docs/listing-stager/INSTANTLY-OUTREACH-SSOT.md` (program index)
2. This runbook (policy + controls)
3. Execution docs:
   - `CAA-0067-lead-sourcing-enrichment-spec.md`
   - `CAA-0068-instantly-campaign-architecture.md`
   - `CAA-0069-cron-automation-staging-sop-sot.md`

## Launch gate (must all pass)
1. Warmup complete for participating inboxes
2. Inbox health baseline acceptable
3. QA test sends verified
4. Lead QA + dedupe checks complete
5. Explicit go-live approval from Noah

If any gate fails: keep campaigns paused and automation non-destructive.

## Lead quality policy
- Enforce required enrichment fields per CAA-0067.
- Reject records that violate any hard QA rule.
- Apply dedupe precedence exactly:
  1. exact email
  2. normalized fullName + websiteDomain
  3. normalized fullName + normalized companyName + city + state
- Winner rule: highest completeness, then newest `lastVerifiedAt`.

## Campaign staging policy
- One campaign per wedge per inbox.
- Campaign naming: `LS-{WEDGE}-{INBOX_ALIAS}-v1`.
- Default state: paused/draft.
- Required send safeguards and stop conditions from CAA-0068 are mandatory.
- No mixed wedge imports.

## Automation policy (staged mode)
- Jobs may check state, sync suppression metadata, and report health.
- Jobs may not activate campaigns or send outbound while gate is not passed.
- Failure behavior: safe-stop + alert.

## Status taxonomy
- `done`: complete, no blocking dependency
- `in_progress`: active now
- `blocked`: dependency prevents completion
- `pending`: queued/not started

## Proof requirements
Every operational update must include:
- `TASK_STATUS`
- `DOC_STATUS`
- `GATE_STATUS`
- concrete artifacts (file path, run output, or commit SHA)

## Cron baseline
- Weekly markdown hygiene audit: enabled
- Daily listing-stager launch-gate check: enabled, non-destructive
- Weekly scorecard reminder: enabled
- Suppression/campaign automation jobs: staged disabled until go-live approval
