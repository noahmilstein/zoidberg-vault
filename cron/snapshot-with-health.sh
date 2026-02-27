#!/usr/bin/env bash
set -euo pipefail

JOB="hourly-state-backup"
BASE_DIR="/root/.openclaw/workspace/cron"

if "$BASE_DIR/snapshot-job.sh"; then
  "$BASE_DIR/job-health.sh" mark "$JOB" success
else
  err="snapshot job failed"
  "$BASE_DIR/job-health.sh" mark "$JOB" failure "$err"
  exit 1
fi

"$BASE_DIR/job-health.sh" monitor "$JOB" "$BASE_DIR/alert-send.sh" 3 6
