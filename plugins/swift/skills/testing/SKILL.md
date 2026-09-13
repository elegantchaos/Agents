---
name: testing
description: Write and review Swift Testing tests, including deterministic async tests and migration from XCTest.
---

# Swift Testing

- Use Swift Testing. When changing XCTest tests, migrate the affected tests and fixtures to Swift Testing. Flag remaining XCTest usage in reviews.
- Do not extend XCTest or add legacy helpers to avoid migration. Remove superseded tests and helpers after verifying replacement coverage.
- If a required testing capability blocks migration, report the blocker and the decision needed. Do not silently retain XCTest or drop coverage.
- Design tests around observable behavior, explicit dependencies, and deterministic coordination rather than timing assumptions.
- Inspect isolation and parallel execution assumptions for async tests and shared fixtures.
- Use the validation skill, when available, for verification commands and coverage reporting. Portable package tests must not require Xcode.
