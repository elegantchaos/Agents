---
name: standards
description: Applies shared coding standards, engineering principles, code-quality guidance, implementation guidance, formatting, scripting and testing rules. Use when reading, creating, refactoring, or reviewing code.
---

# Coding Standards

Use this skill as the baseline for software work.
It covers code quality, engineering principles, change strategy, repository hygiene, interface design, maintainability, and source-selection guidance that should stay consistent across languages.

## Required References

Read these before writing, changing, or reviewing code:

- `references/good-code.md`: quality criteria covering code, tests, docs, and maintainability.
- `references/principles.md`: design, abstraction, and architecture tradeoffs.
- `references/implementation.md`: change scope, precedence, compatibility, interfaces, documentation, comments, formatting, linting, structure, and cleanup.
- `references/testing.md`: unit, integration and UI test coverage, and UI previews.

## Further References

Read these when the task touches their topic:

- `references/scripting.md`: repository-maintained scripts, automation, and task runners.
- `references/external.md`: external references, vendor APIs, language semantics, and policy guidance.

## Debugging

When tracking down a bug or regression, read every reference of every relevant skill, including
the further references, not only the required ones: the deepest context gives the best chance of
recognising the cause. Observation that changes no behaviour, such as logs, view-update probes or
a reproduction that only records what happens, can come first to locate the failing path. Audit
the code in that path against the guidance before experimenting with changes, including code in
dependencies and code no recent change touched. Test first the
hypotheses the guidance flags, and build any reproduction from a copy of the real code, removing
parts until the behaviour changes.

If the task has a language or framework specialist skill, use the guidance here as a baseline. Treat the specialist skill as authoritative for domain-specific detail.

## Checklist

Check every changed file before reporting work complete:

- Where a decision log exists, every record has been considered and applicable constraints checked; conflicts and coverage gaps are reported.
- New behaviour has tests, written first for non-UI code.
- Documentation and comments describe the current behaviour, with no references to past behaviour.
- Every type and member has a documentation comment, including private ones.
- Significant type comments explain concrete responsibilities, owned state and intended use,
  checked against the implementation; a comment's presence alone is insufficient.
- Root problems are fixed rather than worked around, with no shims or compatibility layers unless requested.
- No duplicated code, dead code, or stale comments remain.
- Lint findings in changed files are fixed, even when the linter reports them as warnings.
