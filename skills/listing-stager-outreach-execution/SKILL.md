---
name: listing-stager-outreach-execution
description: Execute Listing Stager cold-outreach operations with strict launch-gate controls, lead QA/dedupe enforcement, Instantly staging defaults, and proof-first reporting. Use when preparing leads, staging Instantly campaigns, checking launch readiness, or running non-destructive operational checks for the agents/brokerages/photographers wedges.
---

# Listing Stager Outreach Execution

Use this skill to execute the Listing Stager outreach workflow deterministically and safely.

## Required source files

Read these before acting:
- `/root/.openclaw/workspace/docs/listing-stager/INSTANTLY-OUTREACH-SSOT.md`
- `/root/.openclaw/workspace/docs/listing-stager/LISTING-STAGER-OUTREACH-RUNBOOK.md`

## Operating contract

- Treat `INSTANTLY-OUTREACH-SSOT.md` as index/source priority for ticket continuity.
- Keep campaign activation disabled unless launch gate is explicitly passed and approved.
- Never claim completion without same-message proof artifacts.
- Keep wedges isolated: `agent`, `brokerage`, `photographer`.

## Execution workflow

1. Validate gate state.
   - If any gate item is unmet, stay in staged mode only.
2. Enforce lead quality contract.
   - Required fields must be present.
   - Apply hard rejection rules and dedupe precedence.
3. Stage campaigns in Instantly.
   - Campaigns paused/draft only until approval.
   - Apply naming and tag conventions exactly.
4. Run non-destructive safety checks.
   - Confirm suppression synchronization status.
   - Confirm stop conditions and cap/window settings.
5. Report proof.
   - Include artifact paths, status, and unresolved blockers.

## Standard output format

- `TASK_STATUS: <pending|in_progress|blocked|done>`
- `DOC_STATUS: <what changed in docs/artifacts>`
- `GATE_STATUS: <passed|failed> + failed items`
- `PROOF:`
  - `<artifact path or system evidence>`
  - `<artifact path or system evidence>`
- `NEXT_ACTION: <single next concrete step>`

## Guardrails

- Do not enable send/activation automations by default.
- Do not merge wedge lead pools.
- Do not bypass QA for speed.
- If evidence is missing, return `blocked`, not `done`.
