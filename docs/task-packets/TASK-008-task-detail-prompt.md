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

# TASK-008: Add task detail page and prompt generation

## Objective
Show complete task details and generated Gemma prompt.

## Source of truth
Follow Task 008 in `docs/TASKS.md`.

## Acceptance criteria
- Dynamic task detail page exists.
- Acceptance criteria are displayed as a checklist.
- Generated Gemma prompt is copyable.
- Prompt instructs Gemma to implement only the selected task and commit.
- Prompt generation has tests.

## Verification commands
```bash
npm test -- --run lib/domain/__tests__/prompt.test.ts
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "feat: add task detail page and prompt generation"
```
