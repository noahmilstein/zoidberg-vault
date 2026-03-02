# Listing Stager — Instantly Outreach SSOT

Objective: complete the Listing Stager Instantly outreach workstream end-to-end with durable continuity across CAA tickets.

## Ticket Chain
1. **CAA-0064** — lock strategy (positioning, wedges, offers, KPIs)
   - Artifact: `docs/listing-stager/CAA-0064-strategy.md`
2. **CAA-0065** — draft/approve 12-email sequence pack
   - Artifact: `docs/listing-stager/CAA-0065-email-sequences.md`
3. **CAA-0066** — assemble wedge-specific proof assets
   - Artifact: `docs/listing-stager/CAA-0066-proof-pack.md`
4. **CAA-0067** — lead sourcing + enrichment spec
5. **CAA-0068** — Instantly campaign architecture (paused)
6. **CAA-0069** — cron automation staged (disabled until launch)

## Non-Negotiable Continuity Rules
- Treat this file as SSOT index for campaign implementation continuity.
- Do not invent metrics or performance claims.
- Use repo-sourced pricing only as supporting input.
- Keep wedge alignment strict: agents / brokerages / photographers.
- Every ticket output must produce a file artifact under `docs/listing-stager/`.

## Current Status Snapshot
- CAA-0064: Completed (strategy doc present)
- CAA-0065: Completed draft (email pack present)
- CAA-0066: Completed draft v1 (proof pack present)
- CAA-0067+: Pending

## Activation Defaults (Locked 2026-03-02)
- Warmed inbox inventory (aliases):
  - agents@listingstagerpro.com
  - brokerages@listingstagerpro.com
  - media@listingstagerpro.com
- Sending timezone baseline: EST / America/New_York.
- Webhook decision rule: no webhook is required to launch outbound. Only configure webhook forwarding when a concrete consumer endpoint is declared and tested.
- Reply-owner decision rule: Instantly assignment settings are the execution source of truth; this file mirrors those settings for continuity.
