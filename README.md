# Gemma Coding Test: Agent Task Arena

This repository is a deliberately scoped coding-agent evaluation project for **Gemma**, a local Hermes Agent profile.

Gemma's assignment is to build **Agent Task Arena**: a local-first Next.js dashboard for managing coding-agent tasks, sessions, implementation notes, and evaluation outcomes.

## What is in this repo now?

This seed repo contains the planning artifacts Gemma needs before implementation:

- [`docs/PRD.md`](docs/PRD.md) — product requirements document
- [`docs/TASKS.md`](docs/TASKS.md) — sequential implementation plan
- [`docs/GEMMA_WORKFLOW.md`](docs/GEMMA_WORKFLOW.md) — exact instructions for running Gemma one fresh session per task
- [`docs/EVALUATION_RUBRIC.md`](docs/EVALUATION_RUBRIC.md) — scoring criteria for each task/session
- [`docs/task-packets/`](docs/task-packets/) — copy/paste-ready task prompts for Gemma

## Recommended execution model

Use **one fresh Gemma session per task**, commit and push after each task, then start the next task only after verifying the push.

This is intentionally slower than blasting everything in one session, but it produces a cleaner eval:

1. Gemma receives bounded context.
2. Each task has a clear diff.
3. Failures are isolated.
4. GitHub history becomes the audit trail.
5. Jake can stop, inspect, or redirect between tasks.

See [`docs/GEMMA_WORKFLOW.md`](docs/GEMMA_WORKFLOW.md) for exact commands.

## Target application

**Agent Task Arena** will be a local-first taskboard for coding-agent work:

- Create implementation tasks with acceptance criteria
- Track status across backlog/running/review/done/failed
- Record agent sessions and notes per task
- Score task outcomes with a rubric
- Export task/session reports as markdown

## Tech stack target

- Next.js App Router
- TypeScript
- Tailwind CSS
- shadcn/ui-style primitives or simple accessible components
- Local JSON persistence first, SQLite optional later
- Vitest for unit tests
- Playwright for smoke/e2e tests if practical

## Current status

Seed docs only. Gemma should implement the application by following `docs/TASKS.md` in order.
