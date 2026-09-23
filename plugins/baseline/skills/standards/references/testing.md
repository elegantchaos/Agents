# Testing

These are general rules for how to go about testing, and what tooling to use.
Platform-specific rules are allowed to take precedence.

## Non-UI Code

- Use red/green TDD. Write the tests first.
- Ensure that new code has high test coverage.
- Consider adding unit tests for older code to improve coverage.
- Tests should be deterministic.
- Unit tests should not require network access.
- Full end-to-end integration tests can require network access if it is essential.
- Focus testing on changed behavior, important failure paths, and regression risk rather than chasing raw coverage numbers.
- Prefer tests through stable interfaces, and avoid excessive mocking when cheap real collaborators are available.
- Keep fixtures, factories, and test helpers simple and local unless repeated reuse justifies sharing them.
- Avoid sleeps and other time-based synchronization when a more explicit readiness or completion signal is available.
- If relevant tests cannot be run, report the exact gap and the likely risk.

## UI Code

User Interface code may be hard to unit test.

If the platform has a live preview feature (for example, #Preview for SwiftUI), create previews.

If the platform has a UI-testing framework (for example, XCTest UI testing for Swift), use it.
Create UI tests that target important behaviours, state changes, and key navigation.
UI tests can be fragile - avoid creating tests that are sensitive to stylistic or layout changes.

Use previews to support fast iteration, but do not treat them as a full replacement for other relevant UI or integration validation.

## Validation Workflow

How to verify that code changes were successful:

1. Use the project's canonical validation command, running the narrowest check that proves the change first.
2. Run broader project checks next.
3. For Swift projects, use the `swift:validation` skill when it applies.
4. If validation cannot run, report exactly what was not validated and why.

## Reporting Guidance

When summarizing work:

- list what checks were run
- list what checks were skipped
- call out meaningful residual risk from skipped validation

# Tooling

- Prefer idiomatic command entry points for the implementation language.
- Prefer one canonical way to run the test suite and linters in CI and locally.
- Avoid duplicating shell wrappers when checked-in scripts or task runners already exist.
- Use our preferred test framework for the implementation language.
- If a new project has no framework choice yet, bias toward the modern, standard idiomatic choice for the implementation language.
- Keep tests close to behavior, name them around observable outcomes, and avoid over-mocking code that can be exercised directly with cheap real objects.
- Prefer the repo's configured linter/formatter. If the repo has no linter yet, keep style conservative and idiomatic for the language.
- Run project commands to respect local environment settings (`swift run`, `bundle exec`, `penv` etc)
- Add or update executable validation when behavior changes: tests for logic changes, lint or format checks for style-sensitive work, and packaging checks for metadata or executable wiring.
- Don't add external dependencies without explicit permission.
- Keep dependency additions justified. Every new dependency should remove meaningful complexity or supply capability the standard library or existing dependency graph does not already cover.
