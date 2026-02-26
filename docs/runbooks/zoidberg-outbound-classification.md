# zoidberg_outbound Classification

Date: 2026-02-26

Decision: **Archive (inactive legacy artifact)**.

## Why
- Contains a standalone `webhook.js` + `webhook.log` not wired into current OpenClaw runtime control plane.
- Keeping it in workspace root created ambiguity during architecture audits.

## Action Taken
- Moved from workspace root to timestamped archive path:
  - `archive/<timestamp>/zoidberg_outbound/`

## Restore Procedure
If needed, restore with:

```bash
mv archive/<timestamp>/zoidberg_outbound ./zoidberg_outbound
```
