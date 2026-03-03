#!/usr/bin/env bash
set -euo pipefail

SESSIONS_JSON="/root/.openclaw/agents/main/sessions/sessions.json"

if [[ ! -f "$SESSIONS_JSON" ]]; then
  echo "CACHE_REPORT_STATUS: error"
  echo "TOP_ERROR: sessions.json not found at $SESSIONS_JSON"
  exit 0
fi

python3 - <<'PY'
import json, time
from pathlib import Path

p = Path('/root/.openclaw/agents/main/sessions/sessions.json')
now = int(time.time() * 1000)

try:
    data = json.loads(p.read_text())
except Exception as e:
    print('CACHE_REPORT_STATUS: error')
    print(f'TOP_ERROR: failed to parse sessions.json ({e.__class__.__name__})')
    raise SystemExit(0)

if not isinstance(data, dict):
    print('CACHE_REPORT_STATUS: error')
    print('TOP_ERROR: sessions.json root is not an object')
    raise SystemExit(0)

items = list(data.items())
count = len(items)
if count == 0:
    print('CACHE_REPORT_STATUS: ok')
    print('SESSIONS_TOTAL: 0')
    print('IDLE_GT_24H: 0')
    print('IDLE_GT_72H: 0')
    print('RUN_SESSIONS: 0')
    print('RECOMMENDATION: no-action')
    raise SystemExit(0)

idle24 = idle72 = 0
run_sessions = 0
for key, meta in items:
    updated = meta.get('updatedAt') if isinstance(meta, dict) else None
    if isinstance(updated, (int, float)):
        age_ms = now - int(updated)
        if age_ms > 24*3600*1000:
            idle24 += 1
        if age_ms > 72*3600*1000:
            idle72 += 1
    if ':run:' in key:
        run_sessions += 1

idle24_pct = (idle24 / count) * 100
idle72_pct = (idle72 / count) * 100

if idle72_pct >= 40 or count >= 120:
    rec = 'candidate-for-prune-review'
elif idle24_pct >= 50:
    rec = 'monitor-closely'
else:
    rec = 'no-action'

print('CACHE_REPORT_STATUS: ok')
print(f'SESSIONS_TOTAL: {count}')
print(f'IDLE_GT_24H: {idle24} ({idle24_pct:.1f}%)')
print(f'IDLE_GT_72H: {idle72} ({idle72_pct:.1f}%)')
print(f'RUN_SESSIONS: {run_sessions}')
print(f'RECOMMENDATION: {rec}')
PY
