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

# TASK-010: Add session data model APIs

## Objective
Add server support for recording agent sessions per task.

## Source of truth
Follow Task 010 in `docs/TASKS.md`.

## Acceptance criteria
- Sessions can be added to a task.
- Sessions can be updated.
- Sessions can be deleted.
- Cannot add session to missing task.
- Service tests cover create/update/delete.

## Verification commands
```bash
npm test -- --run lib/server/__tests__/session-service.test.ts
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: add agent session APIs"
```
