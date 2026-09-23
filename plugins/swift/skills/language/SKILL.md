---
name: language
description: Applies general Swift language guidance outside specialist SwiftUI, SwiftData, Swift Testing, and Swift concurrency skills. Use when reading, writing, or reviewing Swift code.
---

# Swift

Use this skill for baseline Swift language guidance that sits below framework-specific specialist skills.
It covers Swift toolchain expectations, file organization, core language conventions, error handling, state modeling, and localization.

Load only the references that matter for the task:

1. Read `references/toolchain.md` for version and platform expectations.
2. Read `references/organization.md` for file layout, type organization, visibility, and member ordering.
3. Read `references/language.md` for core Swift conventions and API style.
4. Read `references/errors-and-state.md` for error handling and domain modeling guidance.
5. Read `references/localization.md` for user-facing strings and localization guidance.
6. Read `references/sources.md` when Swift or Apple technical decisions depend on external references, API semantics, or platform policy.
7. If concurrency, SwiftUI, SwiftData, or Swift Testing concerns are central to the task, treat the corresponding specialist skill as the source of truth and use this skill only for residual baseline Swift questions.
8. If source selection, policy guidance, or general engineering tradeoffs are central to the task, pair this skill with `baseline:standards`.

## References

- `references/toolchain.md` - Swift and platform version expectations.
- `references/organization.md` - file organization, visibility, and member ordering.
- `references/language.md` - baseline Swift conventions and API preferences.
- `references/errors-and-state.md` - errors, `Result`, value semantics, and domain modeling.
- `references/localization.md` - localization and user-facing text guidance.
- `references/sources.md` - primary Swift and Apple sources for language, tooling, APIs, and policy.
