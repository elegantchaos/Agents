# Swift plugin

Swift skills maintained in `plugins/swift/` in this repository.

| Skill | Owns |
| --- | --- |
| [language](skills/language/SKILL.md) | Swift language, API design, and toolchain assumptions |
| [swiftui](skills/swiftui/SKILL.md) | Views, state flow, navigation, accessibility, and UI performance |
| [swiftdata](skills/swiftdata/SKILL.md) | SwiftData models, queries, persistence, and migration |
| [concurrency](skills/concurrency/SKILL.md) | Swift isolation, task lifetimes, cancellation, and synchronization |
| [testing](skills/testing/SKILL.md) | Swift Testing test design and implementation |
| [validation](skills/validation/SKILL.md) | Formatting, linting, compilation, test execution, and coverage reporting |

## Prototype status

The skeleton is not yet a replacement for the existing skills. Source comparison, detailed references, and behavioral evaluation are pending; see [REVIEW.md](REVIEW.md).

Not installed or registered in a marketplace. Before installation, resolve overlapping standalone skills, especially `swiftui`.

Skills use plain `SKILL.md` files. Xcode tools are optional; Apple framework guidance applies only to supported targets.

`rt` and `agt` are maintained separately and are not bundled.

## Maintenance

Keep each rule in its owning skill. Load references only when relevant. Preserve attribution and licenses when adapting sources.
