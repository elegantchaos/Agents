# Common Rules

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
- Modernise or adopt a new architecture/style if appropriate.
- Avoid creating code bases with mixed architecture/style.
- When modernising, migrate everything (if trivial), or suggest follow-up work.

## Refactoring and Compatibility

- Do not add shims, wrappers, adapters, aliases, or backwards-compatibility layers unless the user explicitly asks for compatibility support.
- When refactoring an API, tool, script, or interface, treat the refactored version as the new source of truth.
- This applies to documentation and tests as well as the primary target of the refactor.
- Update known call sites immediately as part of the same change rather than preserving old entry points by default.
- If compatibility support is genuinely needed, make that an explicit decision and scope it clearly.

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
- Prefer Swift for repository-maintained automation and helper scripts. Use small single-file Swift scripts when they stay simple, and Swift command-line apps when workflows need shared logic or multiple commands.

## Testing

Use red/green TDD for non-UI code.
Create previews for UI code.
Follow `instructions/Validation.md` validation workflow and report gaps.

## Research and Source Quality

- Use `instructions/Trusted Sources.md` for source selection and research policy.

## GitHub Workflows

- For GitHub workflows, use the shared `codex-github` skill (`~/.local/share/skills/codex-github-skill/SKILL.md`).

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

- Do not perform irreversible destructive actions without explicit approval.
- Reversible changes inside source control, including deletion of tracked files, do not require special approval beyond the user’s request.
- Avoid unrelated refactors during focused tasks.
- If unexpected workspace changes appear, pause and confirm direction.

## Git Command Style

- For git operations, use the shared `codex-git` skill (`~/.local/share/skills/codex-git-skill/SKILL.md`).
