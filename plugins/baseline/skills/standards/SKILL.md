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

Check the changed files and resulting design before reporting work complete. Apply checks relevant to the work performed; editing guidance does not itself require executing the workflows it describes.

- Where a decision log exists, every record has been considered and applicable constraints checked; conflicts and coverage gaps are reported.
- Root problems are fixed, and the resulting design is applied consistently without competing implementations or superficial compliance layers.
- Compatibility support is explicitly requested; data-preservation machinery follows explicit project requirements.
- New external dependencies have explicit permission and clear justification.
- Where applicable, failure, cancellation, partial completion, and resource cleanup follow the operation's contract.
- Changed behavior has meaningful tests. For non-UI behavior, the expected failure was observed before implementation.
- Existing tests affected by the change meet the testing guidance; implementation-mirroring or redundant tests have been removed or rewritten.
- Documentation and comments describe current behavior. Every type and member, including private ones, has a documentation comment; significant type comments explain concrete responsibilities, owned state, and intended use, verified against the implementation.
- No obsolete code, duplicated logic, or stale comments remain from the change.
- Lint findings in changed files are fixed, including warnings.
- Required validation has passed before claiming completion. Report failed or skipped checks and their residual risks explicitly.
