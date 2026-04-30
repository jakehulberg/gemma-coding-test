# Evaluation Rubric

Use this rubric after each Gemma task/session.

Score each category from 1 to 5.

## 1. Spec compliance

- **5**: Fully implements the task and acceptance criteria; no unrelated scope.
- **4**: Implements the task with minor harmless deviations.
- **3**: Mostly works but misses one meaningful requirement.
- **2**: Partially implements the task; substantial gaps.
- **1**: Does not implement the requested task.

## 2. Test behavior

- **5**: Adds/updates appropriate tests and all required checks pass.
- **4**: Checks pass but test coverage could be stronger.
- **3**: Manual verification only or weak tests.
- **2**: Some checks fail without a good explanation.
- **1**: No tests/checks run, or code is obviously broken.

## 3. Code quality

- **5**: Simple, idiomatic, typed, readable, maintainable.
- **4**: Good code with minor cleanup opportunities.
- **3**: Acceptable but includes duplication or awkward structure.
- **2**: Hard to maintain or likely buggy.
- **1**: Unusable or unsafe code.

## 4. Git hygiene

- **5**: One focused commit with a clear message and clean status.
- **4**: Good commit with minor extra noise.
- **3**: Commit exists but includes unrelated changes or vague message.
- **2**: Multiple messy commits or uncommitted files remain.
- **1**: No useful commit.

## 5. Agent discipline

- **5**: Stayed within task, reported commands/results, stopped cleanly.
- **4**: Minor verbosity or small process deviation.
- **3**: Needed correction but completed task.
- **2**: Scope creep or skipped important process steps.
- **1**: Ignored process instructions.

## Decision guide

- Average **4.5+**: Accept
- Average **3.5–4.4**: Accept or revise depending on severity
- Average **2.5–3.4**: Revise
- Average **<2.5**: Reject/rerun

## Review note template

```md
## Task
TASK-00N: <title>

## Session
- Agent: Gemma
- Date:
- Commit:
- Branch:

## Checks run
- `npm run lint`: pass/fail/not run
- `npm run typecheck`: pass/fail/not run
- `npm test`: pass/fail/not run
- Other:

## Scores
- Spec compliance: /5
- Test behavior: /5
- Code quality: /5
- Git hygiene: /5
- Agent discipline: /5

## Decision
accept | revise | reject

## Notes

```
