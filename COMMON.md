# Common Rules

These are the terse shared baseline rules that belong in `Standard Rules`.
Keep detailed cross-language and language-specific guidance in dedicated skills rather than expanding this file into a second source of truth.

## Methodology & Principles

Always write good code.

Apply these core principles when writing code:

### Required

- DRY (Avoid Duplication Thoughtfully)
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
3. Apply the smallest coherent change set.
4. Add/update tests for behavior changes.
5. Run relevant validation checks.
6. Report changes, validation status, and residual risks.

## Testing

Use red/green TDD for non-UI code.
Create previews for UI code.
Follow the validation workflow and report gaps.

## Research and Source Quality

- Use trusted primary sources for technical decisions.

## Portability

- Keep shared references portable and avoid machine-specific absolute paths. Prefer repository-relative paths unless local guidance explicitly requires a canonical shared path.

## Safety and Discipline

- Never expose or commit credentials/secrets.
- Do not perform irreversible destructive actions without explicit approval.
- Reversible changes inside source control, including deletion of tracked files, do not require special approval beyond the user’s request.
- Avoid unrelated refactors during focused tasks.
- If unexpected workspace changes appear, pause and confirm direction.
