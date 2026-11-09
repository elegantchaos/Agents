# File And Type Organization

Use this file when shaping Swift source files and type boundaries.

- Always use a separate source file for each type.
- Name files after the type (`MyType.swift`).
- Use focused extension files for distinct responsibilities (`MyType+Functionality.swift`).
- Prefer declaring compiler-synthesized conformances on the primary type. Keep the conformance in the same file when synthesis requires it, as with synthesized `Equatable` and `Hashable`. Use `MyType+ProtocolName.swift` for a custom conformance that can be implemented in a separate file without widening access.
- Use PascalCase file names.

In each Swift file, prefer this order:

1. imports
2. log channels (if any)
3. main type definition
4. helper types/extensions
5. `#Preview` at the bottom for SwiftUI view files

## Type organization

For classes/structs, prefer this order:

1. stored properties
2. initializers
3. computed properties
4. public methods
5. private methods (often in private extensions)

Declare nested types after the members that give the type its purpose, so the
main type's state and behaviour are what a reader sees first. Prefer a same-file
extension after the primary definition. When a nested type must be declared in
the primary definition, place it at the end of that definition. This applies to
nested protocols, classes, structs, enums, and type aliases, however small.

For enums, prefer:

1. cases
2. static constants/factories
3. computed properties

For protocols, prefer:

1. properties
2. methods

### Reordering existing declarations

Use our preferred order and update affected callers in the same change when we control them. For example, reordering stored properties can change the parameter order of a synthesized memberwise initializer.

Check whether a move changes runtime initialization, persisted values, UI order or an interface used by clients we cannot update together. Preserve the contracts and behavior outside the scope of the change. Move documentation, attributes and conditional guards with the declarations they belong to.

If preserving an external contract is the sole reason you skip part of a requested cleanup or reorder, report the affected declaration, the change you skipped, and what making it would mean for that contract. Give the user enough detail to decide whether to authorize the change.

## Documentation comments

- Add `///` documentation comments to all declarations (types/members/cases etc), including private ones.
- A member that satisfies a protocol requirement may rely on the protocol's documentation when a linter cannot tell protocol members from new ones. Opt out explicitly, for example with a file-level `swift-format-ignore-file` comment, and still document the type and any members the protocol does not declare.
- Don't insert a blank line between the `///` comment and the declaration it is attached to.
- Do insert a blank line between doc+declaration blocks, to visually separate them.
- Explain intent, behavior and intended usage in doc comments, not just the symbol name.
- Document individual parameters or return values if they are not obvious.
- Add inline comments only where intent is not obvious.
- For types that are key to the library or app, apply the significant-type documentation
  criteria in `baseline:standards`' required `references/implementation.md`. Explain the
  concrete responsibility, owned state and how callers use the type; for services, describe
  the roles of any distinct state, operation and access interfaces.

## Log Channels

When the `elegantchaos/Logger` package is in the dependencies:

- Define individual log channels for key services or subsystems.
- Name the channel using natural language: `public let commandChannel = Channel("Commands")`
- The name can contain multiple words separated by spaces if appropriate.
- Do not use the `alwaysEnabled:` flag.
- Define named log channels for individual services.

## Header Comments

Add our standard header comment at the top of all Swift files:

```swift
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 28/01/2026.
//  Copyright © 2026 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

```

Update the dates accordingly. Keep the author as `Sam Deane`, and the copyright
as `Elegant Chaos Limited`. Do not insert the agent name or other names.
