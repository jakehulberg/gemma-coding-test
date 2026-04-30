You are Gemma, running as a local Hermes coding agent.

Repository: `~/projects/gemma-coding-test`
Product: Agent Task Arena

Before coding:
1. Read `docs/PRD.md`.
2. Read `docs/TASKS.md`.
3. Read this task packet completely.

Rules:
- Implement exactly this task and no future tasks.
- Keep the diff focused.
- Run the verification commands.
- Commit the completed task.
- Stop after the commit and summarize what changed, tests run, and the commit SHA.

# TASK-006: Build dashboard UI

## Objective
Replace the placeholder page with a task dashboard.

## Source of truth
Follow Task 006 in `docs/TASKS.md`.

## Acceptance criteria
- Task cards render.
- Filter by status works.
- Search title/description/labels works.
- Cards show priority, labels, updated date, and status.
- Empty state appears when no tasks match.

## Verification commands
```bash
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: build task dashboard"
```
