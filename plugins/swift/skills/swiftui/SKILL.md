---
name: swiftui
description: Use when reading, writing, refactoring or reviewing SwiftUI.
license: MIT
metadata:
  author: Sam Deane
  version: "1.0"
---

Use this skill for writing, refactoring, reviewing and debugging SwiftUI code.

## Required References

Read these before writing, changing, or reviewing SwiftUI code:

- `references/patterns.md`: recommended and potentially harmful patterns. Adopt the recommended
  patterns, avoid the harmful ones, and flag harmful ones in existing code.
- `references/performance.md`: view identity, update cost and structure. Its rules prevent
  visible glitches as well as slowness, so it applies to every view, not only hot paths.
- `references/views.md`: rules for view structure and bodies.
- `references/data.md`: data flow, state ownership, bindings and environment values.
- `references/api.md`: modern API in place of deprecated API.

## Further References

Read these when the task touches their topic:

- `references/navigation.md`: navigation and presentation, including alerts and dialogs.
- `references/design.md`: design guidelines, adaptability and system styling.
- `references/accessibility.md`: Dynamic Type, VoiceOver, Reduce Motion and accessible controls.
- `references/localization.md`: user-facing strings.
- `references/sdk27.md`: SDK 27 APIs, source incompatibilities after an SDK update, and
  availability-sensitive features.

## Debugging

When tracking down a SwiftUI bug or regression, such as flicker, lost state or a control that
does not update, read every reference above, not only the required ones. Logs and probes such as
`Self._printChanges()` can come first to locate the failing path. Then audit every view in that
path against the references before experimenting with changes: the views the change touched, their
hosts and containers, and reusable controls from dependencies, including code no recent change
touched. Check identity and structure even where a branch never changes. Build any reproduction
by copying the real view code and removing parts, not by re-creating what seems relevant.

## Other Guidelines

- Use the `swift:language` and `baseline:standards` skills to ensure the code is modern, clean,
  and maintainable.
- Avoid UIKit and AppKit unless requested, and use SwiftUI equivalents instead.

## Command Pattern

If `elegantchaos/Commands` is in the project dependencies, use the Command pattern for actions that are triggered by user interaction.
This helps to decouple the view from the business logic and makes it easier to test and maintain.

## Checklist

Check every changed SwiftUI file before reporting work complete:

- Toolbar item content has a fixed outermost view, as `references/performance.md` describes,
  and any container added for it keeps the intended omission and layout; list rows are omitted
  by filtering data.
- Modifier values toggle with expressions, not by branching between view hierarchies.
- No `Binding(get:set:)`, stored escaping view-builder closures or closures passed as view
  inputs where `references/data.md` and `references/performance.md` offer an alternative.
- Views depend only on the data they render.
- No deprecated API from `references/api.md`.
- Previews exist for new views.
