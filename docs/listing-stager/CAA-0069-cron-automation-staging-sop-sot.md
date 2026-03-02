# CAA-0069 — Cron Automation Staging + SOP/SOT Hardening

Status: blocked (dependency: inbox warmup + launch gate)
Execution mode: planning/hardening complete now; all automation remains disabled until explicit go-live approval.

## Objective
Complete all non-launch work for automation so activation is a controlled one-step action after warmup gate passes.

## Dependency Contract
CAA-0069 depends on CAA-0068 launch gate:
1. Warmup complete for participating inboxes (minimum 14 days)
2. Inbox health baseline acceptable
3. QA test sends pass
4. Lead QA + dedupe checks pass
5. Explicit go-live approval

If any dependency is unmet, all automations stay disabled.

## SOT Hardening (Source of Truth)
- Canonical planning/status docs live in `zoidberg-vault` under `docs/listing-stager/`.
- Task status authority lives in CtrlAltAgnt ticket system.
- Status updates must always include system label:
  - `TASK_STATUS` (CtrlAltAgnt)
  - `DOC_STATUS` (zoidberg-vault)

## SOP Hardening (Execution Rules)
1. **No activation by default**
   - Every cron job for this workstream is created disabled.
2. **Proof-first status updates**
   - Never report done without artifact proof in same message.
   - Required proof fields: artifact path, commit SHA, task ID (if task updated).
3. **Status taxonomy lock**
   - `done` = fully complete with no blocking dependency.
   - `in_progress` = actively being worked now.
   - `blocked` = cannot complete due to explicit dependency.
   - `pending` = queued, not started.
4. **Gate before switch-on**
   - Activation requires explicit go-live command from Noah.
   - Activation step must reference this file + gate checklist.

## Cron Staging Plan (Disabled-Only)
### Job Set (to stage only)
1. `ls-lead-sync` (disabled)
   - Purpose: pull/import approved leads batch metadata.
2. `ls-suppression-sync` (disabled)
   - Purpose: sync bounced/unsubscribed/replied suppression state.
3. `ls-campaign-health-check` (disabled)
   - Purpose: audit campaign safety settings + daily cap drift.
4. `ls-daily-summary` (disabled)
   - Purpose: post non-destructive status summary only.

### Safeguards
- No job may send or activate campaigns while `launch_gate != passed`.
- All jobs must be idempotent and non-destructive in staged mode.
- Any failure path defaults to safe-stop + alert.

## Activation Checklist (Future)
Do not execute until go-live is explicitly approved:
- [ ] Confirm CAA-0068 gate pass
- [ ] Confirm all staged jobs are still disabled
- [ ] Enable jobs one-by-one with verification after each
- [ ] Capture run proof and rollback command per job

## Deliverables Completed in CAA-0069 Scope
- SOP/SOT hardening rules documented
- Dependency + status model documented
- Disabled-only cron staging plan documented
- Activation checklist documented

## Definition of Done for CAA-0069
- This file exists and is approved
- SSOT references this artifact
- Ticket status set to `blocked` until dependency clears
