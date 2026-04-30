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

# TASK-011: Add session UI

## Objective
Let users record and view agent sessions on task detail pages.

## Source of truth
Follow Task 011 in `docs/TASKS.md`.

## Acceptance criteria
- Sessions display chronologically.
- Session form supports agent name, status, branch, commit SHA, summary, notes, and tests run.
- At least one test command/result entry is supported.
- Empty state exists.

## Verification commands
```bash
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: add session recording UI"
```
