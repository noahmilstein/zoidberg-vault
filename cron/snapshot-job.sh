#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="${SNAPSHOT_REPO_DIR:-/root/.openclaw/workspace}"
REMOTE_NAME="${SNAPSHOT_REMOTE_NAME:-origin}"
BRANCH_NAME="${SNAPSHOT_BRANCH_NAME:-master}"
LOG_DIR="${SNAPSHOT_LOG_DIR:-/root/.openclaw/workspace/cron/logs}"
mkdir -p "$LOG_DIR"
LOG_FILE="$LOG_DIR/snapshot-job.log"

log(){ printf '%s %s\n' "$(date -u +'%Y-%m-%dT%H:%M:%SZ')" "$*" | tee -a "$LOG_FILE"; }

fail(){ log "ERROR: $*"; exit 1; }

command -v git >/dev/null 2>&1 || fail "git is not installed"
[ -d "$REPO_DIR" ] || fail "repo dir missing: $REPO_DIR"

cd "$REPO_DIR"
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "not a git worktree: $REPO_DIR"
git remote get-url "$REMOTE_NAME" >/dev/null 2>&1 || fail "missing git remote: $REMOTE_NAME"

if git diff-index --quiet HEAD --; then
  log "No changes detected. Snapshot no-op."
  exit 0
fi

MSG="Snapshot: $(date -u +'%Y-%m-%d %H:%M:%S UTC')"
git add -A
git commit -m "$MSG" >/dev/null

log "Committed snapshot: $MSG"

if git push "$REMOTE_NAME" "$BRANCH_NAME" >/dev/null 2>&1; then
  log "Pushed snapshot to $REMOTE_NAME/$BRANCH_NAME"
else
  fail "git push failed to $REMOTE_NAME/$BRANCH_NAME"
fi
