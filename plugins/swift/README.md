# Swift plugin

Prototype Swift development guidance maintained directly in the Agents repository at `plugins/swift/`. This directory is ordinary tracked content, not a submodule.

Names omit redundant prefixes but retain the SwiftUI and SwiftData framework names for clarity outside a plugin-aware host.

| Skill | Owns |
| --- | --- |
| [language](skills/language/SKILL.md) | Swift language, API design, and toolchain assumptions |
| [swiftui](skills/swiftui/SKILL.md) | Views, state flow, navigation, accessibility, and UI performance |
| [swiftdata](skills/swiftdata/SKILL.md) | SwiftData models, queries, persistence, and migration |
| [concurrency](skills/concurrency/SKILL.md) | Swift isolation, task lifetimes, cancellation, and synchronization |
| [testing](skills/testing/SKILL.md) | Swift Testing test design and implementation |
| [validation](skills/validation/SKILL.md) | Formatting, linting, compilation, test execution, and coverage reporting |

## Prototype status

The manifest and skill entry points establish scope and agreed preferences. They are not yet replacements for the existing skills under `skills/` at the repository root. Detailed references, upstream comparisons, and behavioral evaluation remain pending; see [REVIEW.md](REVIEW.md).

No marketplace registration, runtime links, or installation is included. Existing skill installations remain active. Before installing this prototype for evaluation, check for overlapping standalone skills, especially `swiftui`, and select one source of guidance per domain.

Each skill is a plain `SKILL.md` with a Swift-specific description and no dependency on Codex tools or an Xcode installation. Apple framework skills apply only on supported platforms. Plugin namespacing and discovery should be verified during the installation pilot.

`rt` and `agt` remain independently maintained tools. The plugin does not bundle their source, install them, or require them for all Swift work.

## Maintenance

Edit this directory at its source. Keep detailed rules in their owning skill and load future references only when relevant. Preserve source attribution and applicable licenses when adapting upstream material. No upstream or Apple reference text has been imported into this skeleton.
