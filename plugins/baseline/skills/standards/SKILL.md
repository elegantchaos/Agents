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

If the task has a language or framework specialist skill, use the guidance here as a baseline. Treat the specialist skill as authoritative for domain-specific detail.

## Checklist

Check every changed file before reporting work complete:

- New behaviour has tests, written first for non-UI code.
- Documentation and comments describe the current behaviour, with no references to past behaviour.
- Every type and member has a documentation comment, including private ones.
- Significant type comments explain concrete responsibilities, owned state and intended use,
  checked against the implementation; a comment's presence alone is insufficient.
- Root problems are fixed rather than worked around, with no shims or compatibility layers unless requested.
- No duplicated code, dead code, or stale comments remain.
- Lint findings in changed files are fixed, even when the linter reports them as warnings.
