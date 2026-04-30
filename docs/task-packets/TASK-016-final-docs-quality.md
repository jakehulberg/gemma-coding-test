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

# TASK-016: Final docs and quality gate

## Objective
Update documentation and ensure all checks pass.

## Source of truth
Follow Task 016 in `docs/TASKS.md`.

## Acceptance criteria
- README explains install, dev, test, build, and data path.
- `.env.example` documents `ARENA_DATA_PATH`.
- Operating guide exists or README covers operation clearly.
- Final quality gate passes.

## Verification commands
```bash
npm run lint
npm run typecheck
npm test -- --run
npm run build
```

## Commit message
```bash
git commit -m "docs: add operating guide and final quality gate"
```
