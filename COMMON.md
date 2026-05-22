# Common Rules

These are the terse shared baseline rules that belong in `Standard Rules`.
Keep detailed cross-language, language-specific, and shared-baseline-maintenance guidance in dedicated skills or focused reference modules rather than expanding this file into a second source of truth.

## Methodology

Always write good, modern, idiomatic code.
Prefer fixing root causes over layered workarounds.
Keep interfaces explicit and intentionally small.
Avoid hidden coupling and surprising side effects.
Do not add compatibility shims, wrappers, aliases, or dependencies unless the user asks.
Write documentation to reflect the current state; don't call back to previous history or behaviour unless the user asks.

## Principles

Always apply the core principles `Don't Repeat Yourself (DRY)`, and `Single Source Of Truth`.

Additional principles to use where relevant:

- KISS (Keep It Simple)
- YAGNI (Build What Is Needed)
- Make Illegal States Unrepresentable
- Dependency Injection
- Composition Over Inheritance
- Command-Query Separation
- Law of Demeter
- Structured Concurrency
- Design by Contract
- Idempotency

## Core Workflow

- Understand request boundaries.
- Inspect relevant code/docs before editing.
- When writing new code or fixing bugs, apply smallest coherent change set.
- For cleanup, review, and modernisation requests, codebase-wide changes are acceptable when they improve consistency; avoid them during focused tasks and note follow-ups instead.
- Add/update tests for behavior changes.
- Run the relevant validation checks.

## Refactoring Scope

Apply a refactoring scope relevant to the task.

For cleanup, review, and modernisation requests, use a wide across the whole code base. For new code and bug fixes, use a narrower scope.

Our preferred policy is to refactor aggressively, and to keep the codebase consistent and modern, even if it risks breaking backwards compatibility.

### Wide Scope

Look for codebase-wide refactors that:

- Modernise the code.
- Make it cleaner.
- Make it more consistent.
- Make it more compliant with our guidelines.
- Make it more idiomatic for the language or platform.
- Improve overall test coverage.

### Narrow Scope

- Prefer minimal, focused changes that solve the requested problem.
- Add or update tests for new behaviour.
- Suggest wide scope refactors for follow-up.

## Communication

- Before working, report planned actions.
- Whilst working, report progress.
- When finished, report changes, validation status, and residual risks.
- Do not repeatedly advertise that the agent is verifying instead of guessing; that should be treated as default competence and only called out when there is real uncertainty or risk

## Testing & Validation

Use red/green TDD for non-UI code.
Create UI previews if the tooling supports it (eg SwiftUI #Preview)
Run the narrowest validation that proves the change first, then broaden to relevant project checks.
Report skipped validation with the reason.
Report validation gaps and residual risk.

## Portability

- Use portable path references in docs and guidance.
- Prefer repository-relative paths for files in the current repository and `~/...` home-relative paths for shared resources outside it.
- Avoid machine-specific absolute paths.

## Safety and Discipline

- Never expose or commit credentials/secrets.
- Never perform irreversible destructive actions without explicit approval.
- Reversible changes inside source control, including deletion of tracked files, are allowed.
- Avoid unrelated refactors during focused tasks, but suggest them as a follow-up if they are needed.
- If unexpected workspace changes appear, pause and confirm direction.

## Research

Prefer trusted primary sources for technical decisions, especially for Apple platform, Swift, package, and API behavior.

Trusted sources can be found in our coding standards and our language and platform specific skills.
