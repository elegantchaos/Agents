---
name: testing
description: Design, write, and review Swift tests using the Swift Testing framework, including deterministic async tests and requested migration from XCTest.
---

# Swift Testing

Prototype scope: test design and implementation with Swift Testing. Detailed references are pending source review.

- Prefer Swift Testing for new tests supported by the project's toolchain and testing requirements. Discourage new XCTest usage where Swift Testing meets the need.
- Treat XCTest as a legacy choice in this skill's policy, not as an assertion of official Apple deprecation. Retain it for requirements Swift Testing does not cover, such as existing XCTest-based UI automation.
- Keep maintenance of existing XCTest tests scoped. Propose broader migration separately unless requested.
- Design tests around observable behavior, explicit dependencies, and deterministic coordination rather than timing assumptions.
- Inspect isolation and parallel execution assumptions for async tests and shared fixtures.
- Test execution, formatting, linting, build selection, and coverage reporting belong to validation. Do not require Xcode for portable package tests.
