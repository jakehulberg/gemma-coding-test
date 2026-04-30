# Gemma Workflow

This document explains how Jake should run Gemma against this repo.

## Recommendation

Run **one fresh Gemma session per task**, commit and push after each task, then wait for the push to complete before starting the next task.

Do **not** ask Gemma to implement all tasks in one giant session.

## Overnight asynchronous runner

For the actual overnight workflow, use the included runner script instead of manually restarting Gemma after each task.

```bash
cd ~/projects/gemma-coding-test
HERMES_PROFILE=gemma scripts/run-gemma-tasks.sh
```

The runner automates the manual pattern:

1. Ensure the working tree is clean.
2. Pull latest `main`.
3. Find every `docs/task-packets/TASK-*.md` file in order.
4. Start a **fresh Hermes/Gemma session** for one task packet.
5. Wait for Gemma to finish.
6. Verify Gemma created a commit.
7. Verify the working tree is clean.
8. Push to GitHub.
9. Move to the next task.
10. Stop immediately if any task fails.

This gives Jake asynchronous execution while preserving the clean one-session-per-task evaluation design.

### Dry run

Preview what would run:

```bash
cd ~/projects/gemma-coding-test
DRY_RUN=1 HERMES_PROFILE=gemma scripts/run-gemma-tasks.sh
```

### Resume from a specific task

If the run stops at Task 006, fix the issue and resume at Task 006:

```bash
cd ~/projects/gemma-coding-test
START_AT=TASK-006 HERMES_PROFILE=gemma scripts/run-gemma-tasks.sh
```

### Stop after a specific task

Run only a subset:

```bash
cd ~/projects/gemma-coding-test
STOP_AFTER=TASK-004 HERMES_PROFILE=gemma scripts/run-gemma-tasks.sh
```

### Run detached overnight

If you want to disconnect the terminal, run it detached and redirect output to `.arena/overnight.log`.

```bash
cd ~/projects/gemma-coding-test
mkdir -p .arena
# Run this from your shell:
# HERMES_PROFILE=gemma scripts/run-gemma-tasks.sh > .arena/overnight.log 2>&1 &
```

Then check progress later:

```bash
tail -f .arena/overnight.log
git log --oneline -10
```

### Run in tmux overnight

Recommended if you want to reattach and watch:

```bash
cd ~/projects/gemma-coding-test
tmux new-session -s gemma-arena
HERMES_PROFILE=gemma scripts/run-gemma-tasks.sh
```

Detach with `Ctrl-b`, then `d`.

Reattach later:

```bash
tmux attach -t gemma-arena
```

## Why one session per task?

This repo is a coding-agent evaluation. The goal is not only to build the app; it is also to measure whether Gemma can follow instructions cleanly.

One task per session gives us:

- Smaller context windows
- Cleaner diffs
- Easier rollback
- One commit per task
- Better failure isolation
- Better evaluation data
- A natural rhythm for human review

## Required local assumptions

- Repo is cloned locally.
- GitHub auth is configured.
- Gemma has its own Hermes profile, assumed here to be named `gemma`.
- Gemma can run terminal/file tools.
- Commands are run from the repo root.

If the profile name is different, replace `-p gemma` with the real profile name.

## Initial setup

```bash
cd ~/projects/gemma-coding-test
git pull --ff-only
```

If dependencies do not exist yet, the first implementation task will create them.

## Running one task

Use the relevant task packet from `docs/task-packets/`.

Example for Task 001:

```bash
cd ~/projects/gemma-coding-test
hermes -p gemma chat -q "$(cat docs/task-packets/TASK-001-bootstrap-next-app.md)"
```

After Gemma exits, verify:

```bash
git status --short
git log --oneline -5
git push
```

If Gemma already pushed, `git push` should say everything is up to date.

## Sequential run pattern

For each task:

1. Pull latest main.
2. Start a fresh Gemma session with exactly one task packet.
3. Let Gemma complete that one task.
4. Inspect the diff and test output.
5. Push the commit.
6. Wait for push to succeed.
7. Start the next task.

Template:

```bash
cd ~/projects/gemma-coding-test

git checkout main
git pull --ff-only

hermes -p gemma chat -q "$(cat docs/task-packets/TASK-00N-name.md)"

git status --short
git log --oneline -3
git push
```

## What Gemma must do in every task

Gemma must:

1. Read `docs/PRD.md`.
2. Read `docs/TASKS.md`.
3. Read the specific task packet.
4. Implement only that task.
5. Avoid opportunistic scope creep.
6. Run the verification commands listed in the task packet.
7. Fix failures introduced by the task.
8. Commit with the exact or equivalent commit message in the task packet.
9. Stop after the task is complete.

## What Gemma must not do

Gemma must not:

- Implement future tasks early.
- Rewrite the PRD unless a task asks for docs updates.
- Change unrelated files.
- Skip tests silently.
- Claim success without command output.
- Push broken code unless the task packet explicitly allows it.

## If a task fails

If Gemma cannot complete a task:

1. Commit nothing unless there is a useful partial checkpoint.
2. Leave a clear failure note in the terminal response.
3. Include exact commands that failed.
4. Jake should either rerun the same task in a new session or create a corrective task packet.

## Optional: isolated branches

For stricter review, run each task on its own branch:

```bash
git checkout main
git pull --ff-only
git checkout -b gemma/task-00N
hermes -p gemma chat -q "$(cat docs/task-packets/TASK-00N-name.md)"
git push -u origin gemma/task-00N
```

Then merge manually after review.

For this initial eval, direct commits to `main` are acceptable because the tasks are small and sequential.
