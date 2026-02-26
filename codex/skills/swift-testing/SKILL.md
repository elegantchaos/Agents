---
name: swift-testing
description: Create and refine high-quality Swift tests using Apple’s Swift Testing framework. Use when adding tests for new behavior, fixing regressions, improving weak test coverage, or reviewing test quality in Swift packages and apps.
---

# Swift Testing

Build behavior-focused tests with `import Testing` and keep validation/reporting explicit.

## Workflow

1. Inspect existing tests and test style before writing new tests.
2. Identify behavior changes and risk areas from the code diff.
3. Write or update tests first for:
- new behavior
- bug fixes (include regression coverage)
- touched edge and failure paths
4. Prefer Swift Testing (`@Test`, `#expect`) unless the repository clearly standardizes on XCTest.
5. Prefer focused unit/integration coverage over heavy end-to-end tests unless risk requires full-stack coverage.
6. Run narrow checks first, then broader project checks.
7. Report exactly what ran, what was skipped, and residual risk.

## Test Quality Gates

Require these before considering test work complete:

- Correctness: assertions verify the intended behavior.
- Isolation: tests do not depend on global/shared mutable state.
- Determinism: remove timing/network/random flakiness.
- Readability: test names and setup make intent obvious.
- Scope discipline: avoid over-testing internals when public behavior is enough.

If a gate fails, revise the test instead of adding more assertions around fragile setup.

## Swift Testing Style

- Use clear names that describe scenario and expected outcome.
- Test through stable public interfaces where possible.
- Keep tests focused on one behavior each.
- Use parameterized tests where it improves coverage and clarity.
- Prefer small helpers for repeated setup; avoid deep helper abstraction.
- Use async tests for concurrency behavior and validate cancellation/error paths.

## Validation Order

1. Run the narrowest test target first.
2. Run package/app test suite next.
3. Run project validation scripts when available.
4. If validation cannot run, state the exact blocker and impacted risk.

## Output Checklist

In the final response, always include:

- Tests added/updated (with file paths)
- Commands run and result summary
- Commands not run and why
- Remaining risks or coverage gaps
