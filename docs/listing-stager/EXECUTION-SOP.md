# Listing Stager — Canonical Execution SOP (Deterministic)

Status: active
Owner: Zappa
Last updated: 2026-03-18

## 0) Scope
Use this SOP for Listing Stager outreach execution only.
Wedges: `agent`, `brokerage`, `photographer`.

## 1) Canonical prerequisites (must be present before run)
- Instantly API key
- Workspace access
- Current date run window (today)

### 1.1 Canonical credentials block (single source for operator + agent)
> Intentionally centralized to prevent key-loss/blocker loops.

- `INSTANTLY_API_KEY`: `PASTE_REAL_KEY_HERE`
- `INSTANTLY_BASE_URL`: `https://api.instantly.ai`

If key rotation occurs, update this section first, then proceed.

## 2) Hard execution rules
1. No guessing endpoints/fields.
2. If a request fails, capture exact request + response and stop after one retry.
3. No status claims without proof artifacts in same update.
4. Default campaign state remains paused/draft unless explicit go-live approval exists.

## 3) Preflight (must pass)
Run in order:

1. Auth sanity
   - `GET /api/v2/lead-lists`
   - Success signal: HTTP 200 + JSON list payload.
2. Write sanity
   - Create one test lead list (or confirm existing canonical test list).
   - Success signal: HTTP 200/201 + returned lead list id.
3. Campaign sanity
   - Create/update test campaign in paused state.
   - Success signal: HTTP 200 + campaign id.

If any fail: output BLOCKER with failing endpoint, status code, and body.

## 4) Deterministic run sequence
1. Pull current wedge lead list state (`agent`, `brokerage`, `photographer`).
2. Validate required lead fields and dedupe policy from runbook.
3. Populate missing leads per wedge (no mixed wedge data).
4. Verify list counts after write.
5. Verify related campaign staging remains paused/draft.
6. Emit proof report.

## 5) Proof report format (mandatory)
Use exactly:

- `TASK_STATUS: <pending|in_progress|blocked|done>`
- `GATE_STATUS: <passed|failed> + failed item(s)`
- `PROOF:`
  - `timestamp_utc: <ISO>`
  - `lead_lists:`
    - `agent: <id> count=<n>`
    - `brokerage: <id> count=<n>`
    - `photographer: <id> count=<n>`
  - `api_checks:`
    - `<endpoint> -> <status>`
- `BLOCKER:` (only if blocked; include exact failing request/response)
- `NEXT_ACTION: <single concrete action>`

## 6) Blocker contract
When blocked, return one line:

`BLOCKER: <exact issue> | NEED: <exact missing input/decision> | UNBLOCKS: <next command or step>`

## 7) Canonical references
- `docs/listing-stager/INSTANTLY-OUTREACH-SSOT.md`
- `docs/listing-stager/LISTING-STAGER-OUTREACH-RUNBOOK.md`
- `skills/listing-stager-outreach-execution/SKILL.md`
