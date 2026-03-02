# HEARTBEAT.md

# Purpose
# Lightweight continuity guard to reduce dropped work between explicit user prompts.
# Keep this short and operational.

## On each heartbeat
1) Check for unfinished work from the most recent active user thread.
   - If there is a clear pending next action with no proof artifact yet, surface a concise alert.

2) Check for execution drift.
   - If any task has been in `in_progress` without new proof for too long, surface a blocker alert.

3) Check cron/system automation health quickly.
   - If a critical cron has repeated errors, alert with job name + top error.

4) Do NOT start destructive actions from heartbeat.
   - Heartbeat is detect + notify, not delete/migrate/apply.

## Alert format
ALERT: <issue>
NEED: <what Noah must decide/provide>
NEXT: <single concrete next step>

## Ack behavior
If nothing needs attention, reply exactly: HEARTBEAT_OK
