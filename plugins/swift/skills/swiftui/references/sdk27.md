# SDK 27 SwiftUI

Consult this reference when adopting SDK 27 APIs or resolving source incompatibilities after an SDK update. Do not use an SDK 27 API unconditionally when the deployment target supports earlier OS versions.

## Migration rules

- `@State` is a macro in SDK 27. Do not fix its initializer errors by merely reordering assignments. Avoid composed property wrappers on `@State`; write an explicit memberwise initializer when the synthesized one is unavailable.
- Prefer trailing-closure `overlay` and `background` forms. They avoid SDK 27 `@ContentBuilder` ambiguity with modified `ShapeStyle` expressions.
- Remove `statusBarHidden(_:)` on visionOS 27, where it has no effect.

## New APIs

- `AsyncImage` gains standard HTTP caching by default on 2027 OS releases. Use `AsyncImage(request:)` for a per-request cache policy and `asyncImageURLSession(_:)` for a custom session.
- Use `.reorderable()` with `.reorderContainer(for:)` for drag reordering in supported containers. It is unavailable on tvOS.
- Use `swipeActionsContainer()` to enable swipe actions in scrollable containers other than `List`.
- Use the new toolbar APIs for overflow priority, pinned items, minimization, margins, and status-bar visibility when they meet the design need.
- For document apps on iOS, macOS, and visionOS 27, prefer `ReadableDocument` and `WritableDocument` over new uses of `FileDocument` or `ReferenceFileDocument`.

Check the exact platform availability before implementing any of these APIs. Keep an older-OS fallback when the app's deployment target requires one.
