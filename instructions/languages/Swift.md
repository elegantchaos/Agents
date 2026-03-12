# Swift Guidance

Relevance: include this file when the project contains Swift code (`.swift`, `Package.swift`, Xcode targets, or SwiftPM packages).

## Why this file exists

This module provides Swift-specific coding, organization, concurrency, and validation guidance for both agents and human contributors.

For deeper framework or language-specialist guidance, prefer the dedicated skill checkouts when relevant:
- `~/.local/share/skills/Swift-Concurrency-Agent-Skill/swift-concurrency-pro`
- `~/.local/share/skills/Swift-Testing-Agent-Skill/swift-testing-pro`
- `~/.local/share/skills/SwiftUI-Agent-Skill/swiftui-pro`
- `~/.local/share/skills/SwiftData-Agent-Skill/swiftdata-pro`

Use those skills for specialist detail rather than growing this baseline module into a second copy of their framework guidance.

For Swift test design, migration, and API usage, prefer `swift-testing-pro` rather than introducing separate testing guidance in shared instruction modules.

## Version and Platform Expectations

- Follow the project's current Swift and platform targets.
- For new Swift projects, prefer modern Swift 6 patterns where compatible with project constraints.
- For mixed/legacy codebases, implement changes in a migration-friendly style.

## File and Type Organization

- Prefer one primary type per file.
- Name files after the primary type.
- Use focused extension files for distinct responsibilities.
- Keep visibility tight; broaden access only when needed.

Suggested type member order:
1. stored properties
2. initializers
3. computed properties
4. public/internal methods
5. private helpers

## Coding Conventions

- Prefer Swift-native APIs and modern language features.
- Mark classes `final` unless inheritance is intentional.
- Avoid force unwraps and `try!` except in truly unrecoverable paths.
- Use value semantics by default unless reference semantics are required.

## Concurrency

- Define clear actor/thread ownership for shared mutable state.
- Keep UI-facing logic on the main actor when appropriate.
- Use the Swift concurrency specialist skill for concurrency correctness, migration detail, strict-concurrency guidance, and API-selection decisions.

## Errors and State Modeling

- Use `throws`/`async throws` for fallible operations.
- Use `Result` when failure must be stored or passed around explicitly.
- Prefer domain-specific error enums.
- Use types and enums to constrain invalid states.

## Localization and User Text

- Localize user-facing strings.
- Keep key naming consistent with project conventions.
- Prefer generated localization accessors when available.

## Validation Expectations

- Run Swift-focused validation relevant to changed files (tests, lint, format, build).
- If full validation is not possible, report what was skipped and why.
