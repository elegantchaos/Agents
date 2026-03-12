# Common Rules for Rebuilt AGENTS Files

This file contains baseline shared rules that should be included in project `AGENTS.md` files when relevant.

## Methodology & Principles

Always write good code; see `instructions/Good Code.md` for a definition of good code.

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

For detailed guidance, see `instructions/Principles.md`.

## Scope and Change Strategy

- Prefer minimal, focused changes that solve the requested problem.
- Prefer fixing root causes over layered workarounds.
- Preserve existing architecture/style unless change is requested or clearly needed.
- Suggest architectural improvements or follow-up work.

## Core Workflow Expectations

1. Understand request boundaries.
2. Inspect relevant code/docs before editing.
3. Apply the smallest coherent change set.
4. Add/update tests for behavior changes.
5. Run relevant validation checks.
6. Report changes, validation status, and residual risks.

## Engineering Rules

- Prioritize correctness, clarity, and maintainability.
- Keep interfaces explicit and intentionally small.
- Avoid hidden coupling and surprising side effects.
- Do not add dependencies without clear justification.
- Never expose or commit credentials/secrets.

## Testing

Use red/green TDD for non-UI code.
Create previews for UI code.
Follow `instructions/Validation.md` validation workflow and report gaps.

## Research and Source Quality

- Use `instructions/Trusted Sources.md` for source selection and research policy.

## Documentation

- Keep docs factual and aligned with current behavior.
- Update local docs when workflows/commands/architecture change.
- Keep agent docs compact; move explanatory detail to human-facing docs.

## Code Comments

- Add compact documentation comments for each type, method/function, and member/property describing purpose.
- Comments should add intent and context, not restate the symbol name.
- For the primary type in a source file, add a larger top-level documentation comment with design and implementation detail.
- Prefer files to center on one key type when practical.
- Keep inline/block comments sparse; use them for subtle logic, non-obvious constraints, or code that could be misread.
- Favor comments that improve IDE hover/help output while staying concise.

## Safety and Discipline

- Do not perform destructive actions without explicit approval.
- Avoid unrelated refactors during focused tasks.
- If unexpected workspace changes appear, pause and confirm direction.

## Git Command Style

- Do not use `git -C <path> ...` unless explicitly required. Prefer setting `workdir` to the repository path and running plain `git ...` commands.
- The purpose of this instruction is to allow `git` commands to match against the rules in `git.rules`.
- For git operations in Codex.app, use the shared `codex-git` skill checkout (`~/.local/share/skills/codex-git-skill`) so write-side git commands are escalated correctly.
