# Listing Stager — Go-Live Checklist

Status: approved plan v1 (awaiting execution)
Owner: Noah (triage), Zappa (ops)
Timezone: America/New_York (EST)

## Launch Gate (all required)
- [ ] Warmup complete for all inboxes
- [ ] Inbox health baseline acceptable
- [ ] Lead QA + dedupe pass complete
- [ ] Copy/compliance review complete (opt-out language + suppression behavior)
- [ ] Monitoring/alerts active
- [ ] Explicit Noah go-live approval recorded

## Campaign Integrity Checks
- [ ] Wedges isolated: `agent` / `brokerage` / `photographer`
- [ ] One inbox per wedge campaign
- [ ] Naming applied: `LS-{WEDGE}-{INBOX_ALIAS}-v1`
- [ ] Campaign state = paused/draft until final switch
- [ ] Sending window: Mon–Fri, 9:00 AM–4:00 PM EST
- [ ] Randomized send timing inside window (no top-of-hour bursts)

## Ramp Plan
- [ ] Day 1–2: 10/day/inbox
- [ ] Day 3–4: 20/day/inbox (only if health checks pass)
- [ ] Day 5–7: 30/day/inbox (only if health checks pass)

## Final Go/No-Go
- GO only if all checks pass.
- If any fail, remain paused and log blocker + owner + next action.
