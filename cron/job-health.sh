#!/usr/bin/env bash
set -euo pipefail

STATE_DIR="${JOB_HEALTH_DIR:-$HOME/.openclaw/job-health}"
mkdir -p "$STATE_DIR"

usage(){
  cat <<EOF
Usage:
  $0 mark <job> <success|failure> [error]
  $0 monitor <job> <alert_cmd> [failure_threshold] [stale_hours]
EOF
}

now_epoch(){ date +%s; }
json_get(){ jq -r "$1 // empty" "$2" 2>/dev/null || true; }

init_state(){
  local f="$1"
  if [ ! -f "$f" ]; then
    cat >"$f" <<JSON
{"lastSuccess":null,"lastFailure":null,"consecutiveFailures":0,"lastError":"","alerted":false,"updatedAt":$(now_epoch)}
JSON
  fi
}

mark(){
  local job="$1" status="$2" err="${3:-}"
  local f="$STATE_DIR/${job}.json"
  init_state "$f"
  local now; now="$(now_epoch)"

  if [ "$status" = "success" ]; then
    jq --argjson now "$now" '.lastSuccess=$now | .consecutiveFailures=0 | .lastError="" | .updatedAt=$now' "$f" >"$f.tmp"
  else
    jq --argjson now "$now" --arg err "$err" '.lastFailure=$now | .consecutiveFailures=((.consecutiveFailures // 0)+1) | .lastError=$err | .updatedAt=$now' "$f" >"$f.tmp"
  fi
  mv "$f.tmp" "$f"
}

monitor(){
  local job="$1" alert_cmd="$2" threshold="${3:-3}" stale_hours="${4:-6}"
  local f="$STATE_DIR/${job}.json"
  init_state "$f"
  local now; now="$(now_epoch)"

  local consecutive alerted lastSuccess lastFailure lastError
  consecutive=$(json_get '.consecutiveFailures' "$f"); consecutive=${consecutive:-0}
  alerted=$(json_get '.alerted' "$f"); alerted=${alerted:-false}
  lastSuccess=$(json_get '.lastSuccess' "$f")
  lastFailure=$(json_get '.lastFailure' "$f")
  lastError=$(json_get '.lastError' "$f")

  local stale_seconds=$(( stale_hours * 3600 ))
  local should_alert=false reason=""

  if [ "$consecutive" -ge "$threshold" ]; then
    should_alert=true
    reason="consecutive_failures=${consecutive}"
  elif [ -n "$lastSuccess" ] && [ "$lastSuccess" != "null" ]; then
    if [ $(( now - lastSuccess )) -ge "$stale_seconds" ] && [ -n "$lastFailure" ] && [ "$lastFailure" != "null" ]; then
      should_alert=true
      reason="stale_success>${stale_hours}h"
    fi
  fi

  if [ "$should_alert" = true ] && [ "$alerted" != "true" ]; then
    eval "$alert_cmd 'incident' '$job' '$reason' '$lastError'"
    jq '.alerted=true' "$f" >"$f.tmp" && mv "$f.tmp" "$f"
    exit 0
  fi

  if [ "$should_alert" = false ] && [ "$alerted" = "true" ] && [ "$consecutive" -eq 0 ]; then
    eval "$alert_cmd 'recovery' '$job' 'recovered' ''"
    jq '.alerted=false' "$f" >"$f.tmp" && mv "$f.tmp" "$f"
    exit 0
  fi
}

case "${1:-}" in
  mark)
    [ $# -ge 3 ] || { usage; exit 2; }
    mark "$2" "$3" "${4:-}"
    ;;
  monitor)
    [ $# -ge 3 ] || { usage; exit 2; }
    monitor "$2" "$3" "${4:-3}" "${5:-6}"
    ;;
  *) usage; exit 2 ;;
esac
