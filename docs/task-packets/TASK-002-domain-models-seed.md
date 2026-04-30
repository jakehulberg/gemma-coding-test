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

# TASK-002: Add domain models and seed data

## Objective
Define core TypeScript types and deterministic seed data.

## Source of truth
Follow Task 002 in `docs/TASKS.md`.

## Acceptance criteria
- `ArenaTask`, `AgentSession`, `TestRun`, and `TaskEvaluation` are defined.
- Status and priority arrays are exported.
- At least 4 realistic seed tasks exist.
- Tests confirm seed task IDs are unique and required fields exist.

## Verification commands
```bash
npm test -- --run
npm run typecheck
```

## Commit message
```bash
git commit -m "feat: add domain models and seed data"
```
