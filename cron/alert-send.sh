#!/usr/bin/env bash
set -euo pipefail

EVENT_TYPE="$1"
JOB_NAME="$2"
REASON="${3:-}"
DETAILS="${4:-}"

CHANNEL="${OPENCLAW_ALERT_CHANNEL:-slack}"
TARGET="${OPENCLAW_ALERT_TARGET:-#openclaw-project}"

MSG="[$EVENT_TYPE] $JOB_NAME | reason=$REASON"
if [ -n "$DETAILS" ]; then
  MSG="$MSG | details=$DETAILS"
fi

openclaw message send --channel "$CHANNEL" --target "$TARGET" --message "$MSG"
