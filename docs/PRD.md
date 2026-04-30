# Agent Task Arena PRD

## 1. Product summary

**Agent Task Arena** is a local-first web app for managing coding-agent work. It helps a human operator define tasks, run one agent session per task, capture implementation outcomes, and evaluate the quality of each result.

This repo is also a coding-agent evaluation harness. The first implementation agent is **Gemma**, running locally through a separate Hermes profile.

## 2. Problem

When using coding agents for multi-step software work, it is easy to lose control of scope:

- Agents try to complete too many tasks in one session.
- The operator cannot clearly see what changed per task.
- Acceptance criteria are not consistently checked.
- Session notes are scattered across chats, terminal logs, and commits.
- Evaluating model performance is subjective and hard to reproduce.

## 3. Goals

Agent Task Arena should let a user:

1. Create and manage implementation tasks.
2. Store detailed acceptance criteria for each task.
3. Track task status.
4. Record one or more agent sessions for each task.
5. Capture session outputs, commit SHAs, notes, test results, and reviewer decisions.
6. Score outcomes with a simple evaluation rubric.
7. Export task reports as markdown.
8. Run entirely locally with no required external services beyond Git/GitHub.

## 4. Non-goals for v1

Do **not** build these in the initial version:

- Real-time multi-user collaboration
- Authentication
- Cloud database
- Agent process spawning from the UI
- Direct GitHub OAuth integration
- Direct Hermes API integration
- Billing/subscriptions
- Complex analytics dashboards

The v1 app is intentionally local-first and manually operated.

## 5. Primary users

### 5.1 Jake / human operator

Jake wants to run local coding agents task-by-task, review progress, and keep a clean record of what happened.

### 5.2 Coding agent under test

Gemma is not a user of the UI at first, but the product exists to structure Gemma's work. Gemma should be able to read task packets from the repo and update implementation notes if instructed.

## 6. Core user journeys

### Journey A: Create a task

1. User opens the dashboard.
2. User clicks “New Task”.
3. User enters title, description, priority, labels, and acceptance criteria.
4. User saves.
5. Task appears in the backlog.

### Journey B: Run an agent session manually

1. User opens a task detail page.
2. User copies the generated task prompt.
3. User runs Gemma in a fresh terminal/session using that prompt.
4. User records the session result in the task detail page.
5. User adds commit SHA, notes, tests run, and outcome.

### Journey C: Review a task

1. User moves task to review.
2. User checks acceptance criteria.
3. User records rubric scores.
4. User marks task as done or failed.

### Journey D: Export a report

1. User opens a task detail page.
2. User clicks “Export Markdown”.
3. App generates a markdown report containing task metadata, sessions, test results, rubric scores, and final decision.

## 7. Data model

Use TypeScript types from the start. Persist locally to JSON in v1.

### Task

```ts
export type TaskStatus = 'backlog' | 'ready' | 'running' | 'review' | 'done' | 'failed';
export type TaskPriority = 'low' | 'medium' | 'high';

export interface ArenaTask {
  id: string;
  title: string;
  description: string;
  status: TaskStatus;
  priority: TaskPriority;
  labels: string[];
  acceptanceCriteria: string[];
  createdAt: string;
  updatedAt: string;
}
```

### Agent session

```ts
export interface AgentSession {
  id: string;
  taskId: string;
  agentName: string;
  startedAt: string;
  completedAt?: string;
  status: 'planned' | 'running' | 'completed' | 'failed';
  commitSha?: string;
  branchName?: string;
  summary?: string;
  testsRun: TestRun[];
  notes: string;
}
```

### Test run

```ts
export interface TestRun {
  command: string;
  status: 'passed' | 'failed' | 'not_run';
  outputSummary?: string;
}
```

### Evaluation

```ts
export interface TaskEvaluation {
  id: string;
  taskId: string;
  sessionId?: string;
  specCompliance: number; // 1-5
  testQuality: number; // 1-5
  codeQuality: number; // 1-5
  maintainability: number; // 1-5
  notes: string;
  decision: 'accept' | 'revise' | 'reject';
  createdAt: string;
}
```

## 8. Functional requirements

### FR1: Dashboard

- Show all tasks grouped or filterable by status.
- Display title, status, priority, labels, updated date, and session count.
- Provide quick status change controls.
- Provide search by title/description/label.

### FR2: Task creation/editing

- Form fields: title, description, status, priority, labels, acceptance criteria.
- Acceptance criteria should be editable as one item per line or dynamic list inputs.
- Validate required fields.
- Persist changes locally.

### FR3: Task detail page

- Show full task metadata.
- Show acceptance criteria checklist.
- Show linked sessions.
- Show linked evaluations.
- Show generated Gemma prompt for this task.
- Provide edit and delete actions.

### FR4: Session recording

- Add session to a task.
- Record agent name, branch, commit SHA, notes, tests run, status.
- Display sessions chronologically.

### FR5: Evaluation recording

- Add rubric scores to a task/session.
- Compute average score.
- Record accept/revise/reject decision.

### FR6: Markdown export

- Export one task report as markdown.
- Export all tasks as a project report.
- Exports may be downloaded client-side or rendered into a copyable textarea.

### FR7: Local persistence

- For v1, persistence can be file-backed JSON through Next.js route handlers.
- Data file path should be configurable with an env var, defaulting to `.arena/data.json` at repo root.
- Include seed data for development.

## 9. Non-functional requirements

- TypeScript strict mode.
- Clean, accessible UI.
- No secret material in repo.
- Tests for core data utilities.
- Route handlers validate input.
- App should run with `npm run dev`.
- App should pass `npm run lint`, `npm run typecheck`, and `npm test` by the end of the task list.

## 10. UX principles

- Prefer clarity over cleverness.
- Every task should show “what happened last”.
- Make the next action obvious.
- Use plain language.
- Keep destructive actions confirmable.

## 11. Acceptance criteria for v1

The v1 project is complete when:

1. A user can run the app locally.
2. A user can create, edit, delete, search, and filter tasks.
3. A user can view task detail pages.
4. A user can record agent sessions.
5. A user can record evaluations.
6. A user can export markdown reports.
7. Local persistence works across restarts.
8. Tests cover validation, persistence helpers, prompt generation, and markdown export.
9. The README explains setup and operation.
10. The Git history shows one commit per implementation task.
