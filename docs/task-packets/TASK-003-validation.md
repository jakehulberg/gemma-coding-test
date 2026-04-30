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

# TASK-003: Add validation utilities

## Objective
Add pure validation helpers for tasks, sessions, and evaluations.

## Source of truth
Follow Task 003 in `docs/TASKS.md`.

## Acceptance criteria
- Required task fields are validated.
- Status and priority are validated.
- Acceptance criteria must be non-empty strings.
- Evaluation scores must be integers from 1 to 5.
- Validation returns structured errors instead of throwing for user input.

## Verification commands
```bash
npm test -- --run lib/domain/__tests__/validation.test.ts
npm run typecheck
```

## Commit message
```bash
git commit -m "feat: add domain validation utilities"
```
