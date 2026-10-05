---
name: language
description: Applies general Swift language guidance outside specialist SwiftUI, SwiftData, Swift Testing, and Swift concurrency skills. Use when reading, writing, or reviewing Swift code.
---

# Swift

Use this skill for baseline Swift language guidance that sits below framework-specific specialist skills.
It covers Swift toolchain expectations, file organization, core language conventions, error handling, state modeling, and localization.

## Required References

Read these before writing, changing, or reviewing Swift code:

- `references/organization.md`: file layout, type organization, visibility, member ordering, documentation comments, and headers.
- `references/language.md`: core Swift conventions and API style.
- `references/errors-and-state.md`: error handling and domain modeling.

## Further References

Read these when the task touches their topic:

- `references/toolchain.md`: version and platform expectations.
- `references/localization.md`: user-facing strings and localization.
- `references/sources.md`: Swift or Apple technical decisions that depend on external references, API semantics, or platform policy.

If concurrency, SwiftUI, SwiftData, or Swift Testing concerns are central to the task, treat the corresponding specialist skill as the source of truth and use this skill only for residual baseline Swift questions. If source selection, policy guidance, or general engineering tradeoffs are central to the task, pair this skill with `baseline:standards`.

## Checklist

Check every changed Swift file before reporting work complete:

- The file starts with the standard header comment.
- The file defines one type; extension files carry one focused responsibility. Private helper types may sit beside the type they serve.
- Every declaration has a `///` documentation comment, including private ones, separated from the previous declaration by a blank line.
- Nested types come after the members that give the type its purpose.
- Classes are `final` unless inheritance is intended, and visibility is as tight as possible.
- No force unwraps or `try!` outside genuinely unrecoverable paths.
- No legacy Foundation formatters (`DateFormatter`, `NumberFormatter`) or Grand Central Dispatch.
- Booleans are negated with `!`, not compared with `true` or `false` literals. Test expectations follow `swift:testing` instead.

## References

- `references/toolchain.md` - Swift and platform version expectations.
- `references/organization.md` - file organization, visibility, and member ordering.
- `references/language.md` - baseline Swift conventions and API preferences.
- `references/errors-and-state.md` - errors, `Result`, value semantics, and domain modeling.
- `references/localization.md` - localization and user-facing text guidance.
- `references/sources.md` - primary Swift and Apple sources for language, tooling, APIs, and policy.
