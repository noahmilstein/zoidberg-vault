# CAA-0068 — Instantly Campaign Architecture (Paused)

Status: in progress  
Execution mode: preconfigure now, keep sending disabled until warmup + health gate pass.

## Objective
Map warmed inboxes to Listing Stager wedges and define campaign structure, tracking, safeguards, and launch gate so activation is one-step when warmup completes.

## Wedges
1. Agents
2. Brokerages
3. Photographers (partner/overflow)

## Campaign Topology
- One campaign per wedge per inbox (for clean attribution)
- All campaigns created in **paused/draft** state
- No send activation until explicit launch gate

### Naming Convention
`LS-{WEDGE}-{INBOX_ALIAS}-v1`

Examples:
- `LS-AGENT-inbox01-v1`
- `LS-BROKERAGE-inbox01-v1`
- `LS-PHOTO-inbox01-v1`

## Sequence Mapping
- Agent campaign uses CAA-0065 A1–A4
- Brokerage campaign uses CAA-0065 B1–B4
- Photographer campaign uses CAA-0065 C1–C4

## Required Campaign Settings (Template)

### Identity + Sender
- Sender account: warmed inbox only
- Sender name format: consistent human sender identity
- Reply-to: sender inbox (not no-reply)

### Sending Controls
- Campaign status: paused
- Daily cap (initial when enabled): per CAA-0064 policy
- Sending window: business-day local time only
- Randomized send delay: enabled

### Safety
- Stop on:
  - positive reply
  - unsubscribe
  - hard bounce
  - booked call
- Link count minimized (plain text first)
- Compliance footer/unsubscribe handling configured

## Lead Segmentation Rules
- Leads are imported wedge-specific (no mixed wedge leads in same campaign)
- Tags required on import:
  - `wedge:agent|brokerage|photographer`
  - `source:<provider>`
  - `batch:<YYYY-MM-DD>`
- Optional tags:
  - `geo:<market>`
  - `priority:<tier>`

## Tracking + Attribution

### Campaign-level UTM defaults
- `utm_source=instantly`
- `utm_medium=cold_email`
- `utm_campaign=ls_{wedge}_v1`
- `utm_content={step}`

### Event capture (minimum)
- sent
- opened
- replied
- positive reply
- bounce
- unsubscribed
- meeting booked

### Reporting Keys
- campaign name
- wedge
- inbox
- send date
- lead source

## Reply Routing + Workflow
- Replies route to sender inbox owner
- Response SLA target: same business day
- Positive replies tagged `stage:interested`
- Booked meetings tagged `stage:booked`
- Hard no tagged `stage:closed_lost`

## Webhook/Event Integration (staged)
- Configure webhook endpoints but keep automation handlers non-destructive until launch
- Required payload fields:
  - campaign_id/name
  - lead email
  - event type
  - timestamp

## Launch Gate (must pass all)
1. Warmup complete for all participating inboxes
2. Inbox health checks pass (deliverability baseline acceptable)
3. QA test sends verified
4. Lead QA + dedupe checks complete (from CAA-0067)
5. Explicit go-live approval

If any gate fails, campaigns remain paused.

## Dependencies
- CAA-0064 strategy: complete
- CAA-0065 sequence copy: complete
- CAA-0066 proof pack: complete
- CAA-0067 lead sourcing/enrichment spec: required before final lead import

## Open Inputs Needed from Noah (to finalize execution runbook)
1. Exact warmed inbox inventory + aliases
2. Preferred sending timezone/window
3. Webhook destination(s) for event forwarding
4. Reply owner mapping per inbox

## Done Criteria for CAA-0068
- Campaign architecture doc completed
- Naming + mapping + safeguards + launch gate defined
- Inputs checklist documented for final configuration pass
- Ticket updated with proof and moved to done once reviewed/approved
