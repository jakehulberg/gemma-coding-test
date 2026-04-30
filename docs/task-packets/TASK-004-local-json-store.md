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

# TASK-004: Implement local JSON persistence

## Objective
Add server-side helpers to read/write arena data to a local JSON file.

## Source of truth
Follow Task 004 in `docs/TASKS.md`.

## Acceptance criteria
- Default data path is `.arena/data.json`.
- `ARENA_DATA_PATH` overrides data path.
- Missing file initializes from seed data.
- Writes are pretty-printed JSON.
- `.arena/` is gitignored.
- Tests use temp directories only.

## Verification commands
```bash
npm test -- --run lib/server/__tests__/data-store.test.ts
npm run typecheck
```

## Commit message
```bash
git commit -m "feat: add local json data store"
```
