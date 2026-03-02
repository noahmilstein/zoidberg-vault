# Listing Stager — Instantly Outreach SSOT

Objective: complete the Listing Stager Instantly outreach workstream end-to-end with durable continuity across CAA tickets.

## Ticket Chain (system of record = CAA)
1. **CAA-0064** — strategy lock
2. **CAA-0065** — 12-email sequence pack
3. **CAA-0066** — wedge proof assets
4. **CAA-0067** — lead sourcing + enrichment
5. **CAA-0068** — campaign architecture (launch-gated)
6. **CAA-0069** — automation staging + governance

Historical ticket details live in CAA/Convex, not repo markdown.

## Execution Assets
- Policy runbook: `docs/listing-stager/LISTING-STAGER-OUTREACH-RUNBOOK.md`
- Execution skill: `skills/listing-stager-outreach-execution/SKILL.md`

## Non-Negotiable Continuity Rules
- Treat this file as SSOT index for campaign implementation continuity.
- Do not invent metrics or performance claims.
- Use repo-sourced pricing only as supporting input.
- Keep wedge alignment strict: agents / brokerages / photographers.
- Every ticket output must produce a file artifact under `docs/listing-stager/`.

## Current Status Snapshot
- CAA-0064: Done
- CAA-0065: Done
- CAA-0066: Done
- CAA-0067: Done
- CAA-0068: Blocked (launch-gated; not complete)
- CAA-0069: Blocked (dependency: CAA-0068 launch gate / warmup)

## Activation Defaults (Locked 2026-03-02)
- Warmed inbox inventory (aliases):
  - agents@listingstagerpro.com
  - brokerages@listingstagerpro.com
  - media@listingstagerpro.com
- Sending timezone baseline: EST / America/New_York.
- Webhook decision rule: no webhook is required to launch outbound. Only configure webhook forwarding when a concrete consumer endpoint is declared and tested.
- Reply-owner decision rule: Instantly assignment settings are the execution source of truth; this file mirrors those settings for continuity.
