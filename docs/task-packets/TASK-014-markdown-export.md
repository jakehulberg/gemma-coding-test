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

# TASK-014: Add markdown export

## Objective
Generate markdown reports for tasks and the whole project.

## Source of truth
Follow Task 014 in `docs/TASKS.md`.

## Acceptance criteria
- Task report includes metadata, acceptance criteria, sessions, tests, evaluations, and decision.
- Project report includes all tasks grouped by status.
- Markdown output structure is tested.
- Export UI exists on task detail pages.

## Verification commands
```bash
npm test -- --run lib/domain/__tests__/markdown-export.test.ts
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: add markdown exports"
```
