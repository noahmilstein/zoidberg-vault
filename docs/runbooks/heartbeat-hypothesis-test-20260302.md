# HEARTBEAT.md Hypothesis Test Plan

Date: 2026-03-02
Owner: Zappa
Hypothesis: an empty `HEARTBEAT.md` contributes to dropped/unfinished long-running work by reducing continuity checks between explicit user prompts.

## Test design

### Baseline window
- Use prior behavior up to 2026-03-02 with empty `HEARTBEAT.md` as baseline context.
- Known symptom class: dropped follow-through / missing proof-before-done discipline under long-running/multi-step requests.

### Intervention
- Populate `HEARTBEAT.md` with a minimal continuity checklist focused on:
  - unfinished work detection
  - execution drift detection
  - critical cron error detection
  - non-destructive heartbeat behavior
- Keep deterministic long-running operations in cron jobs.

### Observation windows
- T+24h checkpoint: 2026-03-03T21:39:12Z
- T+48h checkpoint: 2026-03-04T21:39:12Z

## Success criteria
1) No silent task drops in active threads (or immediate alert when risk detected)
2) Fewer/no "in_progress without proof" lapses
3) Heartbeat outputs are either `HEARTBEAT_OK` or structured alert with actionable next step

## Failure criteria
- Continued silent drops with no heartbeat alert
- Repeated vague heartbeat chatter without actionable signal
- Increased noise without improved follow-through

## Data collection
- Review heartbeat-triggered outputs in session logs
- Review critical cron error notifications
- Compare incident rate qualitatively against pre-intervention behavior

## Decision at T+48h
- If improved: keep heartbeat checklist and tune wording only
- If no improvement: reduce heartbeat scope and shift more continuity checks to dedicated cron jobs / explicit queue discipline
