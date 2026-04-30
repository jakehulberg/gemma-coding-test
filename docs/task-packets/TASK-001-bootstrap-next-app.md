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

# TASK-001: Bootstrap Next.js app

## Objective
Create the initial Next.js TypeScript application skeleton.

## Source of truth
Follow Task 001 in `docs/TASKS.md`.

## Acceptance criteria
- Next.js App Router exists.
- TypeScript strict mode is enabled.
- Scripts exist: `dev`, `build`, `lint`, `typecheck`, `test`.
- Home page renders “Agent Task Arena”.
- `npm install`, `npm run typecheck`, and `npm run build` succeed.

## Verification commands
```bash
npm install
npm run typecheck
npm run build
```

## Commit message
```bash
git commit -m "chore: bootstrap next app"
```
