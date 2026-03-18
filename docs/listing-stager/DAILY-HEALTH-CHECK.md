# Listing Stager — Daily Health Check

Run cadence: daily (business days)
Scope: per inbox + per wedge

## Hard Thresholds (Conservative)
- Bounce rate warning: >= 2.0%
- Bounce rate pause: >= 3.0%
- Spam/complaint signals: 0 tolerated (immediate pause)
- Positive reply floor (initial 7–14 days):
  - Agents: >= 1.5%
  - Brokerages: >= 1.0%
  - Photographers: >= 1.2%

## Ramp Progression Rule
Only increase daily volume when prior window is healthy:
- No complaints/spam events
- Bounce < 2%
- Reply floor not breached

## Freeze/Investigate Rule
Freeze ramp if:
- Reply floor missed for 2 consecutive windows, or
- Any quality/compliance anomaly appears

## Daily Report Template
- Date:
- Inbox:
- Wedge:
- Sent:
- Bounced (%):
- Positive replies (%):
- Negative/unsub replies:
- Complaints/spam events:
- Current ramp tier:
- Action taken:
- Owner:
