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

# TASK-012: Add evaluation APIs and utilities

## Objective
Add support for scoring task/session outcomes.

## Source of truth
Follow Task 012 in `docs/TASKS.md`.

## Acceptance criteria
- Evaluations can be created, updated, and deleted.
- Scores must be 1-5.
- Average score is computed.
- Decision must be accept/revise/reject.
- Utility and service tests pass.

## Verification commands
```bash
npm test -- --run lib/domain lib/server
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: add evaluation APIs"
```
