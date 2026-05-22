# Common Rules

These are the terse shared baseline rules that belong in `Standard Rules`.
Keep detailed cross-language, language-specific, and shared-baseline-maintenance guidance in dedicated skills or focused reference modules rather than expanding this file into a second source of truth.

## Methodology

Always write good, modern, idiomatic code.
Prefer fixing root causes over layered workarounds.
Keep interfaces explicit and intentionally small.
Avoid hidden coupling and surprising side effects.
Write documentation to reflect the current state.

## Design Principles

Always apply `Don't Repeat Yourself (DRY)`, and `Single Source Of Truth`.

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
- Match change scope to the request: keep focused fixes small and coherent; use codebase-wide cleanup when the task is cleanup, review, modernisation, or consistency work.
- Add/update tests for behavior changes.
- Run the relevant validation checks.

## Communication

- Keep communication compact by default unless the user explicitly asks for more detail.
- Before working, report planned actions.
- Whilst working, report progress.
- When finished, report changes, validation status, and residual risks.
- Do not repeatedly advertise that the agent is verifying instead of guessing; that should be treated as default competence and only called out when there is real uncertainty or risk.
- Do not repeatedly stop to ask for confirmation when the next verification step is safe and obvious.

## Testing & Validation

Use red/green TDD for non-UI code.
Create UI previews if the tooling supports it (eg SwiftUI #Preview).
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

Prefer trusted primary sources for technical decisions, especially official platform, language, package, API, and dependency documentation.

## Journal

If `Project Specific Rules` enables journalling, keep a journal as a series of Markdown files.

Add dated entries that document current implementation work, research, prototype steps, experiments, approaches tried, findings, open questions, and ideas still to try.

Keep an `index.md` file updated when adding new journal entries; use it as the quick guide to journal contents because filenames only provide rough chronology.

Add or update a journal entry when a work session produces useful context that future work should preserve.

When the repository has a current research summary or implementation plan, keep it aligned with the code and journal rather than simply listing journal entries.

If the repository has a root `Extras/` folder, put the journal in `Extras/Journal/`; otherwise use the repository's configured journal location.
