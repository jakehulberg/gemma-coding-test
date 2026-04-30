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

# TASK-005: Add task API route handlers

## Objective
Expose CRUD route handlers for tasks.

## Source of truth
Follow Task 005 in `docs/TASKS.md`.

## Acceptance criteria
- `GET /api/tasks` returns all tasks.
- `POST /api/tasks` creates validated tasks.
- `GET /api/tasks/:id` returns one task or 404.
- `PATCH /api/tasks/:id` updates editable fields.
- `DELETE /api/tasks/:id` deletes the task and related records.
- Service tests cover CRUD behavior.

## Verification commands
```bash
npm test -- --run lib/server/__tests__/task-service.test.ts
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: add task api routes"
```
