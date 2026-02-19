# SwiftUI Instructions

Use this module only when the project uses SwiftUI.

## Core Expectations

- Prefer SwiftUI-first solutions over UIKit/AppKit unless required.
- Keep views simple; place non-trivial behavior in testable non-view types.
- Use `@Observable`-based state models where appropriate.
- Default UI-facing models/types to `@MainActor` unless intentionally non-main.

## View Construction

- Favor composition with small view types over large monolithic views.
- Avoid `AnyView` unless type erasure is truly needed.
- Prefer explicit, readable data flow over convenience shortcuts.

## Interaction and Navigation

- Use modern navigation APIs (`NavigationStack`, destination-based routing).
- Prefer semantic controls (`Button`, `Toggle`, etc.) over raw gestures when possible.

## Validation

- Ensure previews/builds still compile after edits.
- Run tests for any state or view-model behavior changes.

## Migration

Scan for legacy UIKit/AppKit code which can be replaced with SwiftUI.
Scan code for legacy SwiftUI API.
Suggest migrations whenever possible.