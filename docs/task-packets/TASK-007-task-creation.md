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

# TASK-007: Add task creation flow

## Objective
Let users create tasks from the UI.

## Source of truth
Follow Task 007 in `docs/TASKS.md`.

## Acceptance criteria
- New task page exists.
- Form supports title, description, priority, status, labels, acceptance criteria.
- Labels can be comma-separated.
- Acceptance criteria can be one per line.
- Submit calls `POST /api/tasks`.
- User is redirected to the new task detail page.
- Validation errors are visible.

## Verification commands
```bash
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: add task creation flow"
```
