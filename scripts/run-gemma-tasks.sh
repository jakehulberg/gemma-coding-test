#!/usr/bin/env bash
set -euo pipefail

# Run Gemma through the task packets asynchronously/sequentially.
#
# Default behavior:
# - Uses Hermes profile "gemma"
# - Runs every docs/task-packets/TASK-*.md packet in lexical order
# - Starts a fresh Hermes session for each task using `hermes -p <profile> chat -q ...`
# - Requires the agent to commit during each task
# - Pushes after each successful task
# - Stops immediately on failure so a human can inspect
# - Writes logs to .arena/gemma-runs/<timestamp>/
#
# Usage:
#   scripts/run-gemma-tasks.sh
#   HERMES_PROFILE=gemma scripts/run-gemma-tasks.sh
#   START_AT=TASK-006 scripts/run-gemma-tasks.sh
#   STOP_AFTER=TASK-010 scripts/run-gemma-tasks.sh
#   DRY_RUN=1 scripts/run-gemma-tasks.sh

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT_DIR"

HERMES_PROFILE="${HERMES_PROFILE:-gemma}"
START_AT="${START_AT:-}"
STOP_AFTER="${STOP_AFTER:-}"
DRY_RUN="${DRY_RUN:-0}"
RUN_ID="$(date +%Y%m%d_%H%M%S)"
LOG_DIR=".arena/gemma-runs/$RUN_ID"
mkdir -p "$LOG_DIR"

log() {
  printf '[%s] %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*" | tee -a "$LOG_DIR/runner.log"
}

fail() {
  log "ERROR: $*"
  exit 1
}

command -v git >/dev/null 2>&1 || fail "git is not installed"
command -v hermes >/dev/null 2>&1 || fail "hermes is not installed or not on PATH"

git rev-parse --is-inside-work-tree >/dev/null 2>&1 || fail "not inside a git repo"

if [[ -n "$(git status --short)" ]]; then
  fail "working tree is dirty before starting. Commit/stash changes first."
fi

log "Starting Gemma task run"
log "Repo: $ROOT_DIR"
log "Hermes profile: $HERMES_PROFILE"
log "Run logs: $LOG_DIR"

log "Syncing main"
git checkout main | tee -a "$LOG_DIR/runner.log"
git pull --ff-only | tee -a "$LOG_DIR/runner.log"

mapfile -t PACKETS < <(find docs/task-packets -maxdepth 1 -type f -name 'TASK-*.md' | sort)
[[ "${#PACKETS[@]}" -gt 0 ]] || fail "no task packets found"

started=0
completed=0

for packet in "${PACKETS[@]}"; do
  task_name="$(basename "$packet" .md)"

  if [[ -n "$START_AT" && "$started" -eq 0 ]]; then
    if [[ "$task_name" == "$START_AT"* ]]; then
      started=1
    else
      log "Skipping $task_name before START_AT=$START_AT"
      continue
    fi
  else
    started=1
  fi

  log "========================================"
  log "Starting $task_name from $packet"

  before_sha="$(git rev-parse HEAD)"
  task_log="$LOG_DIR/$task_name.log"

  if [[ "$DRY_RUN" == "1" ]]; then
    log "DRY_RUN=1: would run hermes -p $HERMES_PROFILE chat -q \"\$(cat $packet)\""
    continue
  fi

  set +e
  hermes -p "$HERMES_PROFILE" chat -q "$(cat "$packet")" 2>&1 | tee "$task_log"
  hermes_exit=${PIPESTATUS[0]}
  set -e

  if [[ "$hermes_exit" -ne 0 ]]; then
    fail "$task_name failed: Hermes exited with code $hermes_exit. See $task_log"
  fi

  after_sha="$(git rev-parse HEAD)"
  if [[ "$after_sha" == "$before_sha" ]]; then
    fail "$task_name did not create a commit. See $task_log"
  fi

  if [[ -n "$(git status --short)" ]]; then
    fail "$task_name left uncommitted changes. Inspect with git status. See $task_log"
  fi

  log "Pushing commit(s) for $task_name"
  git push | tee -a "$LOG_DIR/runner.log"

  completed=$((completed + 1))
  log "Completed $task_name at $(git rev-parse --short HEAD)"

  if [[ -n "$STOP_AFTER" && "$task_name" == "$STOP_AFTER"* ]]; then
    log "Reached STOP_AFTER=$STOP_AFTER; stopping successfully."
    break
  fi
done

log "Gemma task run finished. Completed $completed task(s)."
log "Latest commit: $(git log --oneline -1)"
