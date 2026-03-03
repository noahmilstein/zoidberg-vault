#!/usr/bin/env bash
set -euo pipefail

SESSIONS_JSON="/root/.openclaw/agents/main/sessions/sessions.json"
BACKUP_DIR="/root/.openclaw/workspace/cron/logs/session-backups"
MODE="${1:-report}"

if [[ "$MODE" != "report" && "$MODE" != "apply" ]]; then
  echo "PRUNE_STATUS: error"
  echo "TOP_ERROR: usage: session-cache-prune.sh [report|apply]"
  exit 0
fi

if [[ ! -f "$SESSIONS_JSON" ]]; then
  echo "PRUNE_STATUS: error"
  echo "TOP_ERROR: sessions.json not found at $SESSIONS_JSON"
  exit 0
fi

mkdir -p "$BACKUP_DIR"

python3 - "$MODE" "$SESSIONS_JSON" "$BACKUP_DIR" <<'PY'
import json, sys, time
from pathlib import Path

mode = sys.argv[1]
sessions_path = Path(sys.argv[2])
backup_dir = Path(sys.argv[3])

THRESHOLD_HOURS = 24
MAX_DELETE = 200
now = int(time.time() * 1000)
threshold_ms = THRESHOLD_HOURS * 3600 * 1000

try:
    data = json.loads(sessions_path.read_text())
except Exception as e:
    print('PRUNE_STATUS: error')
    print(f'TOP_ERROR: failed to parse sessions.json ({e.__class__.__name__})')
    raise SystemExit(0)

if not isinstance(data, dict):
    print('PRUNE_STATUS: error')
    print('TOP_ERROR: sessions.json root is not an object')
    raise SystemExit(0)

keys = list(data.keys())
candidates = []
for k in keys:
    if ':run:' not in k:
        continue
    meta = data.get(k, {})
    updated = meta.get('updatedAt') if isinstance(meta, dict) else None
    if not isinstance(updated, (int, float)):
        continue
    age_ms = now - int(updated)
    if age_ms >= threshold_ms:
        candidates.append((k, age_ms))

candidates.sort(key=lambda x: x[1], reverse=True)
planned = candidates[:MAX_DELETE]

if mode == 'report':
    print('PRUNE_STATUS: report-only')
    print(f'SESSIONS_TOTAL: {len(data)}')
    print(f'CANDIDATES_GT_{THRESHOLD_HOURS}H: {len(candidates)}')
    print(f'PLANNED_DELETE_CAP_{MAX_DELETE}: {len(planned)}')
    print('APPLIED_DELETE: 0')
    print('BACKUP_FILE: none')
    raise SystemExit(0)

if not planned:
    print('PRUNE_STATUS: ok')
    print(f'SESSIONS_TOTAL: {len(data)}')
    print(f'CANDIDATES_GT_{THRESHOLD_HOURS}H: 0')
    print(f'PLANNED_DELETE_CAP_{MAX_DELETE}: 0')
    print('APPLIED_DELETE: 0')
    print('BACKUP_FILE: none')
    raise SystemExit(0)

backup_file = backup_dir / f"sessions.json.{int(time.time())}.bak"
backup_file.write_text(json.dumps(data, ensure_ascii=False))

for k, _ in planned:
    data.pop(k, None)

sessions_path.write_text(json.dumps(data, ensure_ascii=False, indent=2) + '\n')

print('PRUNE_STATUS: ok')
print(f'SESSIONS_TOTAL_BEFORE: {len(keys)}')
print(f'CANDIDATES_GT_{THRESHOLD_HOURS}H: {len(candidates)}')
print(f'PLANNED_DELETE_CAP_{MAX_DELETE}: {len(planned)}')
print(f'APPLIED_DELETE: {len(planned)}')
print(f'BACKUP_FILE: {backup_file}')
PY
