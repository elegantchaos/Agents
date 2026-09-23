---
name: swiftui
description: Use when reading, writing, refactoring or reviewing SwiftUI.
license: MIT
metadata:
  author: Sam Deane
  version: "1.0"
---

Adopt the recommended patterns in `references/patterns.md` as the basis for writing, refactoring and reviewing SwiftUI code.

Avoid the potentially harmful patterns. Flag them in existing code.

Other guidelines:

- Use the `swift:language` and `coding-standards` skills to ensure the code is modern, clean, and maintainable.
- Don't use deprecated API - see `references/api.md`.
- Follow the rules in `references/views.md`.
- Implement the data flow using `references/data.md`.
- Read `references/localization.md` when writing or reviewing user-facing strings.
- Ensure navigation is updated and performant using `references/navigation.md`.
- Ensure the code uses designs that are accessible and follow guidelines using `references/design.md`.
- Validate accessibility compliance including Dynamic Type, VoiceOver, and Reduce Motion using `references/accessibility.md`.
- Ensure the code is able to run efficiently using `references/performance.md`.
- Read `references/sdk27.md` when targeting SDK 27 APIs, resolving SwiftUI source incompatibilities after an SDK update, or adding availability-sensitive features.
- Avoid UIKit and AppKit unless requested, and use SwiftUI equivalents instead.

## Command Pattern

If `elegantchaos/Commands` is in the project dependencies, use the Command pattern for actions that are triggered by user interaction.
This helps to decouple the view from the business logic and makes it easier to test and maintain.
