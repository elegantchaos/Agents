# Common Rules for Rebuilt AGENTS Files

This file contains baseline shared rules that can be included in project `AGENTS.md` files when relevant.

## Principles

Apply these core principles in every project refresh:
- Keep It Simple
- Build What Is Needed
- Avoid Duplication Thoughtfully
- Single Source of Truth
- Make Invalid States Hard to Represent
- Explicit Dependencies
- Composition Over Inheritance
- Separate Commands From Queries
- Least Knowledge
- Concurrency by Design

For detailed guidance, see `instructions/Principles.md`.

## Scope and Change Strategy

- Prefer minimal, focused changes that solve the requested problem.
- Preserve existing architecture/style unless change is requested or clearly needed.
- Prefer fixing root causes over layered workarounds.

## Core Workflow Expectations

1. Understand request boundaries.
2. Inspect relevant code/docs before editing.
3. Apply the smallest coherent change set.
4. Add/update tests for behavior changes where feasible.
5. Run relevant validation checks.
6. Report changes, validation status, and residual risks.

## Engineering Rules

- Prioritize correctness, clarity, and maintainability.
- Keep interfaces explicit and intentionally small.
- Avoid hidden coupling and surprising side effects.
- Do not add dependencies without clear justification.
- Never expose or commit credentials/secrets.

## Testing and Validation

- Use `instructions/Testing.md` for testing and validation policy.

## Research and Source Quality

- Use `instructions/Trusted Sources.md` for source selection and research policy.

## Documentation

- Keep docs factual and aligned with current behavior.
- Update local docs when workflows/commands/architecture change.
- Keep agent docs compact; move explanatory detail to human-facing docs.

## Safety and Discipline

- Do not perform destructive actions without explicit approval.
- Avoid unrelated refactors during focused tasks.
- If unexpected workspace changes appear, pause and confirm direction.
