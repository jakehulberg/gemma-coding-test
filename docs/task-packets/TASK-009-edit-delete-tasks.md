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

# TASK-009: Add task editing and deletion

## Objective
Let users edit and delete tasks.

## Source of truth
Follow Task 009 in `docs/TASKS.md`.

## Acceptance criteria
- Edit page reuses the task form.
- Save calls `PATCH /api/tasks/:id`.
- Delete requires confirmation.
- Delete calls `DELETE /api/tasks/:id`.
- User returns to dashboard after delete.

## Verification commands
```bash
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: add task editing and deletion"
```
