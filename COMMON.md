# Common Rules

These are the terse shared baseline rules that belong in `Standard Rules`.
Keep detailed cross-language, language-specific, and shared-baseline-maintenance guidance in dedicated skills or focused reference modules rather than expanding this file into a second source of truth.

## Methodology & Principles

Always write good code.
Always write modern, idiomatic code.
Apply these core principles:

### Required

- DRY
- Single Source Of Truth

### Preferred

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

## Core Workflow Expectations

1. Understand request boundaries.
2. Inspect relevant code/docs before editing.
3. When writing new code or fixing bugs, apply smallest coherent change set.
4. When instructed to modernise, clean up or refactor code, a larger change set is allowed; prioritise correctness and consistency across the codebase.
5. Add/update tests for behavior changes.
6. Run relevant validation checks.
7. Report changes, validation status, and residual risks.

## Testing

Use red/green TDD for non-UI code.
Create UI previews if the tooling supports it (eg SwiftUI #Preview)
Follow the validation workflow and report gaps.

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
