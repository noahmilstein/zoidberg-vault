# Listing Stager — Alert Playbook

## Severity Levels
- P1: complaint/spam signal, or compliance failure
- P2: bounce >= 3%, major deliverability degradation
- P3: reply floor breach, quality drift

## Trigger → Action Matrix
1) Complaint/spam signal (P1)
- Action: immediate pause on affected inbox campaign
- Owner: campaign ops + triage owner
- SLA: 15 minutes
- Follow-up: incident note + root cause check

2) Bounce >= 3% (P2)
- Action: pause affected inbox campaign; quarantine latest lead import batch
- SLA: same business hour
- Follow-up: validate leads + domain/inbox health before resume

3) Reply floor breach for 2 windows (P3)
- Action: hold ramp progression; review copy variant + lead quality
- SLA: same day

4) Lead QA failure batch detected (P2)
- Action: stop using batch; rollback/import correction
- SLA: same day

## Containment Strategy
- Default: inbox-level isolation first
- Escalate to global pause only if cross-inbox pattern appears

## Incident Record (required)
- Trigger:
- Timestamp:
- Inbox/Wedge affected:
- Immediate action:
- Root cause:
- Corrective action:
- Resume criteria:
