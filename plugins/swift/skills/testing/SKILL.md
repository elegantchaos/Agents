---
name: testing
description: Writes, reviews, and improves Swift Testing code using modern APIs and best practices. Use when reading, writing, or reviewing projects that use Swift Testing.
license: MIT
metadata:
  author: Elegant Chaos, adapted from work by Paul Hudson
  version: "1.0"
---

Write and review Swift Testing code for correctness, modern API usage, and adherence to project conventions. Report only genuine problems - do not nitpick or invent issues.

Review process:

1. Ensure tests follow core Swift Testing conventions using `references/core-rules.md`.
1. Validate test structure, assertions, dependency injection, and other best practices using `references/writing-better-tests.md`.
1. Check async tests, confirmations, time limits, actor isolation, and networking mocks using `references/async-tests.md`.
1. Ensure new features like raw identifiers, test scopes, exit tests, and attachments are used correctly using `references/new-features.md`.
1. If migrating from XCTest, follow the conversion guidance in `references/migrating-from-xctest.md`.

If doing partial work, load only the relevant reference files.


## Local Integration Notes

- This fork is the specialist Swift Testing reference layer. Local workflow, validation order, and reporting conventions belong in baseline instructions or a separate workflow skill.
- Use the `swift:language` skill for baseline Swift language, file-organization, and toolchain guidance.
- Use the shared `coding-standards` skill for cross-language engineering policy and source-selection guidance.
- Swift 6.2 or later with current Swift Testing APIs is the recommended baseline for new projects.
- For older projects, recommend upgrading the toolchain and Swift Testing usage to Swift 6.2-era conventions before falling back to older patterns. If the user chooses not to upgrade, work within the project's current constraints and say so clearly.
- Treat compiler diagnostics, the installed toolchain, and primary-source documentation as authoritative when API behavior or availability is uncertain. Do not assume this skill overrides them.


## Core Instructions

- Prefer current Swift Testing APIs supported by the project toolchain. Use the `swift:language` skill for baseline toolchain expectations.
- As a Swift Testing developer, the user wants all new unit and integration tests to be written using Swift Testing, and they may ask for help migrating existing XCTest code to Swift Testing.
- At the time of writing, Swift Testing does *not* support UI tests, so XCTest remains the correct choice there unless the installed toolchain clearly proves otherwise.

Swift Testing evolves quickly, so some details will vary by toolchain version and existing training data may lag behind. Prefer the Swift 6.2+ model when the project can support it, but treat the installed compiler and toolchain as the first source of truth for availability and diagnostics, and verify uncertain claims against primary sources rather than assuming novelty alone makes them correct.


## Test Strategy

- Inspect the repository's existing test layout and naming style before adding new tests.
- Add or update tests for new behavior and bug fixes, including regression coverage where appropriate.
- Prefer focused unit and integration tests over heavy end-to-end coverage unless the risk clearly requires full-stack validation.
- Test through stable interfaces where possible, and keep tests explicit and readable.
- Cover important edge cases and failure paths touched by the change.


## Output Format

If the user asks for a review, organize findings by file. For each issue:

1. State the file and relevant line(s).
2. Name the rule being violated.
3. Show a brief before/after code fix.

Skip files with no issues. End with a prioritized summary of the most impactful changes to make first.

If the user asks you to write or improve tests, follow the same rules above but make the changes directly instead of returning a findings report.

Example output:

### UserTests.swift

**Line 5: Use struct, not class, for test suites.**

```swift
// Before
class UserTests: XCTestCase {

// After
struct UserTests {
```

**Line 12: Use `#expect` instead of `XCTAssertEqual`.**

```swift
// Before
XCTAssertEqual(user.name, "Taylor")

// After
#expect(user.name == "Taylor")
```

**Line 30: Use `#require` for preconditions, not `#expect`.**

```swift
// Before
#expect(users.isEmpty == false)
let first = users.first!

// After
let first = try #require(users.first)
```

### Summary

1. **Fundamentals (high):** Test suite on line 5 should be a struct, not a class inheriting from `XCTestCase`.
2. **Migration (medium):** `XCTAssertEqual` on line 12 should be migrated to `#expect`.
3. **Assertions (medium):** Force-unwrap on line 30 should use `#require` to unwrap safely and stop the test early on failure.

End of example.


## References

- `references/core-rules.md` - core Swift Testing rules: structs over classes, `init`/`deinit` over setUp/tearDown, parallel execution, parameterized tests, `withKnownIssue`, and tags.
- `references/writing-better-tests.md` - test hygiene, structuring tests, hidden dependencies, `#expect` vs `#require`, `Issue.record()`, `#expect(throws:)`, and verification methods.
- `references/async-tests.md` - serialized tests, `confirmation()`, time limits, actor isolation, testing pre-concurrency code, and mocking networking.
- `references/new-features.md` - raw identifiers, range-based confirmations, test scoping traits, exit tests, attachments, `ConditionTrait.evaluate()`, and the updated `#expect(throws:)` return value.
- `references/migrating-from-xctest.md` - XCTest-to-Swift Testing conversion steps, assertion mappings, and floating-point tolerance via Swift Numerics.
