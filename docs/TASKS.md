# Agent Task Arena Implementation Plan

> **For Hermes/Gemma:** Implement this plan one task per fresh session. Do not batch tasks.

**Goal:** Build Agent Task Arena, a local-first Next.js app for managing coding-agent tasks, sessions, evaluations, and markdown exports.

**Architecture:** Next.js App Router application with TypeScript domain models, local JSON persistence via route handlers/server utilities, client UI components for task/session/evaluation workflows, and tested pure utilities for validation, prompt generation, and markdown export.

**Tech Stack:** Next.js, TypeScript, Tailwind CSS, Vitest, Testing Library, optional Playwright smoke tests.

---

## Global implementation rules

Every task must:

1. Read this file and `docs/PRD.md`.
2. Implement only the named task.
3. Run the task's verification commands.
4. Commit after verification.
5. Stop after the task.

Commit messages should follow:

```text
feat: ...
fix: ...
docs: ...
test: ...
chore: ...
```

---

## Task 001: Bootstrap Next.js app

**Objective:** Create the initial Next.js TypeScript application skeleton.

**Files:**
- Create/modify: `package.json`
- Create: `next.config.ts`
- Create: `tsconfig.json`
- Create: `app/layout.tsx`
- Create: `app/page.tsx`
- Create: `app/globals.css`
- Create: `.gitignore`

**Requirements:**
- Use Next.js App Router.
- Use TypeScript strict mode.
- Add scripts: `dev`, `build`, `lint`, `typecheck`, `test`.
- The home page should render a simple placeholder: “Agent Task Arena”.

**Verification:**

```bash
npm install
npm run typecheck
npm run build
```

**Commit:**

```bash
git add .
git commit -m "chore: bootstrap next app"
```

---

## Task 002: Add domain models and seed data

**Objective:** Define core TypeScript types and deterministic seed data.

**Files:**
- Create: `lib/domain/types.ts`
- Create: `lib/domain/seed.ts`
- Create: `lib/domain/status.ts`
- Create: `lib/domain/__tests__/seed.test.ts`

**Requirements:**
- Define `ArenaTask`, `AgentSession`, `TestRun`, `TaskEvaluation` types matching `docs/PRD.md`.
- Export status and priority arrays.
- Add at least 4 realistic seed tasks.
- Add tests that confirm seed tasks have unique IDs and required fields.

**Verification:**

```bash
npm test -- --run
npm run typecheck
```

**Commit:**

```bash
git add lib package.json package-lock.json
git commit -m "feat: add domain models and seed data"
```

---

## Task 003: Add validation utilities

**Objective:** Add pure validation helpers for tasks, sessions, and evaluations.

**Files:**
- Create: `lib/domain/validation.ts`
- Create: `lib/domain/__tests__/validation.test.ts`

**Requirements:**
- Validate required task fields.
- Validate task status and priority.
- Validate acceptance criteria are non-empty strings.
- Validate evaluation scores are integers from 1 to 5.
- Return structured errors, not thrown exceptions, for user input validation.

**Verification:**

```bash
npm test -- --run lib/domain/__tests__/validation.test.ts
npm run typecheck
```

**Commit:**

```bash
git add lib/domain
git commit -m "feat: add domain validation utilities"
```

---

## Task 004: Implement local JSON persistence

**Objective:** Add server-side helpers to read/write arena data to a local JSON file.

**Files:**
- Create: `lib/server/data-store.ts`
- Create: `lib/server/__tests__/data-store.test.ts`
- Modify: `.gitignore`

**Requirements:**
- Default data path: `.arena/data.json`.
- Env override: `ARENA_DATA_PATH`.
- If no file exists, initialize from seed data.
- Writes should be pretty-printed JSON.
- `.arena/` should be gitignored.
- Tests should use a temp directory and not write real repo data.

**Verification:**

```bash
npm test -- --run lib/server/__tests__/data-store.test.ts
npm run typecheck
```

**Commit:**

```bash
git add lib/server .gitignore
git commit -m "feat: add local json data store"
```

---

## Task 005: Add task API route handlers

**Objective:** Expose CRUD route handlers for tasks.

**Files:**
- Create: `app/api/tasks/route.ts`
- Create: `app/api/tasks/[id]/route.ts`
- Create: `lib/server/task-service.ts`
- Create: `lib/server/__tests__/task-service.test.ts`

**Requirements:**
- `GET /api/tasks` returns all tasks.
- `POST /api/tasks` creates a task after validation.
- `GET /api/tasks/:id` returns one task or 404.
- `PATCH /api/tasks/:id` updates editable fields.
- `DELETE /api/tasks/:id` deletes task and related sessions/evaluations.
- Use ISO timestamps.

**Verification:**

```bash
npm test -- --run lib/server/__tests__/task-service.test.ts
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app/api lib/server
git commit -m "feat: add task api routes"
```

---

## Task 006: Build dashboard UI

**Objective:** Replace placeholder page with a task dashboard.

**Files:**
- Modify: `app/page.tsx`
- Create: `components/task-card.tsx`
- Create: `components/status-badge.tsx`
- Create: `components/priority-badge.tsx`
- Create: `components/task-filters.tsx`

**Requirements:**
- Show task cards.
- Filter by status.
- Search title/description/labels.
- Display priority, labels, updated date, and status.
- Empty state when no tasks match.

**Verification:**

```bash
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app components
git commit -m "feat: build task dashboard"
```

---

## Task 007: Add task creation flow

**Objective:** Let users create tasks from the UI.

**Files:**
- Create: `app/tasks/new/page.tsx`
- Create: `components/task-form.tsx`
- Create: `lib/client/api.ts`

**Requirements:**
- Form fields: title, description, priority, status, labels, acceptance criteria.
- Labels can be comma-separated.
- Acceptance criteria can be one per line.
- Submit calls `POST /api/tasks`.
- Redirect to new task detail page after create.
- Show validation errors.

**Verification:**

```bash
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app/tasks components lib/client
git commit -m "feat: add task creation flow"
```

---

## Task 008: Add task detail page

**Objective:** Show complete task details and generated Gemma prompt.

**Files:**
- Create: `app/tasks/[id]/page.tsx`
- Create: `components/acceptance-criteria-list.tsx`
- Create: `components/gemma-prompt-panel.tsx`
- Create: `lib/domain/prompt.ts`
- Create: `lib/domain/__tests__/prompt.test.ts`

**Requirements:**
- Show all task fields.
- Show acceptance criteria checklist.
- Generate a copyable Gemma prompt for the specific task.
- Prompt must instruct Gemma to implement only that task and commit.
- Add tests for prompt generation.

**Verification:**

```bash
npm test -- --run lib/domain/__tests__/prompt.test.ts
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app/tasks components lib/domain
git commit -m "feat: add task detail page and prompt generation"
```

---

## Task 009: Add task editing and deletion

**Objective:** Let users edit and delete tasks.

**Files:**
- Create: `app/tasks/[id]/edit/page.tsx`
- Modify: `components/task-form.tsx`
- Modify: `app/tasks/[id]/page.tsx`

**Requirements:**
- Edit page reuses task form.
- Save calls `PATCH /api/tasks/:id`.
- Delete requires confirmation and calls `DELETE /api/tasks/:id`.
- Redirect to dashboard after delete.

**Verification:**

```bash
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app/tasks components
git commit -m "feat: add task editing and deletion"
```

---

## Task 010: Add session data model APIs

**Objective:** Add server support for recording agent sessions per task.

**Files:**
- Create: `app/api/tasks/[id]/sessions/route.ts`
- Create: `app/api/sessions/[sessionId]/route.ts`
- Create/modify: `lib/server/session-service.ts`
- Create: `lib/server/__tests__/session-service.test.ts`

**Requirements:**
- Add session to task.
- Update session fields.
- Delete session.
- Validate task exists before adding session.
- Tests cover create/update/delete.

**Verification:**

```bash
npm test -- --run lib/server/__tests__/session-service.test.ts
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app/api lib/server
git commit -m "feat: add agent session APIs"
```

---

## Task 011: Add session UI

**Objective:** Let users record and view agent sessions on task detail pages.

**Files:**
- Create: `components/session-list.tsx`
- Create: `components/session-form.tsx`
- Modify: `app/tasks/[id]/page.tsx`

**Requirements:**
- Display sessions chronologically.
- Add session form with agent name, status, branch, commit SHA, summary, notes, tests run.
- Support at least one test command/result entry.
- Show empty state.

**Verification:**

```bash
npm run typecheck
npm run build
```

**Commit:**

```bash
git add components app/tasks
git commit -m "feat: add session recording UI"
```

---

## Task 012: Add evaluation APIs and utilities

**Objective:** Add support for scoring task/session outcomes.

**Files:**
- Create: `app/api/tasks/[id]/evaluations/route.ts`
- Create: `app/api/evaluations/[evaluationId]/route.ts`
- Create: `lib/server/evaluation-service.ts`
- Create: `lib/domain/evaluation.ts`
- Create tests for both utility and service.

**Requirements:**
- Create/update/delete evaluations.
- Scores must be 1-5.
- Compute average score.
- Decision must be accept/revise/reject.

**Verification:**

```bash
npm test -- --run lib/domain lib/server
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app/api lib
git commit -m "feat: add evaluation APIs"
```

---

## Task 013: Add evaluation UI

**Objective:** Let users score tasks from the task detail page.

**Files:**
- Create: `components/evaluation-form.tsx`
- Create: `components/evaluation-list.tsx`
- Modify: `app/tasks/[id]/page.tsx`

**Requirements:**
- Add score inputs for the five rubric categories.
- Show average score.
- Show decision.
- Link to `docs/EVALUATION_RUBRIC.md` or summarize rubric in UI.

**Verification:**

```bash
npm run typecheck
npm run build
```

**Commit:**

```bash
git add components app/tasks
git commit -m "feat: add evaluation UI"
```

---

## Task 014: Add markdown export

**Objective:** Generate markdown reports for tasks and the whole project.

**Files:**
- Create: `lib/domain/markdown-export.ts`
- Create: `lib/domain/__tests__/markdown-export.test.ts`
- Create: `app/api/export/tasks/[id]/route.ts`
- Create: `app/api/export/route.ts`
- Create: `components/export-panel.tsx`
- Modify: `app/tasks/[id]/page.tsx`

**Requirements:**
- Task report includes task metadata, acceptance criteria, sessions, tests, evaluations, and decision.
- Project report includes all tasks grouped by status.
- Tests cover markdown output structure.

**Verification:**

```bash
npm test -- --run lib/domain/__tests__/markdown-export.test.ts
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app/api components lib/domain
git commit -m "feat: add markdown exports"
```

---

## Task 015: Add polished layout and accessibility pass

**Objective:** Improve app usability, navigation, and accessible semantics.

**Files:**
- Modify: `app/layout.tsx`
- Modify: `app/globals.css`
- Modify: relevant `components/*.tsx`

**Requirements:**
- Add top navigation.
- Add responsive layout.
- Ensure buttons/links have accessible names.
- Ensure forms have labels.
- Use readable color contrast.
- Add loading and error states where appropriate.

**Verification:**

```bash
npm run typecheck
npm run build
```

**Commit:**

```bash
git add app components
git commit -m "feat: polish layout and accessibility"
```

---

## Task 016: Final docs and quality gate

**Objective:** Update documentation and ensure all checks pass.

**Files:**
- Modify: `README.md`
- Create or modify: `.env.example`
- Optionally create: `docs/OPERATING_GUIDE.md`

**Requirements:**
- README explains install, dev, test, build, and data path.
- Document `ARENA_DATA_PATH`.
- Document the intended Gemma workflow.
- Run final quality gate.

**Verification:**

```bash
npm run lint
npm run typecheck
npm test -- --run
npm run build
```

**Commit:**

```bash
git add README.md .env.example docs
git commit -m "docs: add operating guide and final quality gate"
```
