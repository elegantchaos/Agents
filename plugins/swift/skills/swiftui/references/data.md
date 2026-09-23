# Data flow, shared state, and property wrappers

It is important that SwiftUI body code and logic code be kept separate in order to make code easier to read, write, and maintain. That usually means placing code into methods rather than inline in the `body` property, but often also means carving functionality out into separate `@Observable` classes.

These rules help ensure code is efficient and works well in the long term. Treat value-type and reference-type inputs differently: keep large value inputs narrow, but do not split a view merely because it reads several independent properties of the same `@Observable` model.

For baseline observation-model guidance, follow the `swift:language` skill. The rules below cover SwiftUI-specific state ownership, bindings, and view-facing data flow.

## Local state

- `@State` should be marked `private` and only owned by the view that created it.
- If a view stores a class instance that contains expensive-to-recompute data, e.g. `CIContext`, it can be stored using `@State` even though it is not an observable object. This effectively uses `@State` as a cache – storing something persistently, but not doing any change tracking on it since it's not an observable object.

## Observable models

- Prefer `@Observable` to `ObservableObject` for view-facing reference models.
- Mark a UI-facing `@Observable` model `@MainActor` unless the project enables default main-actor isolation. This keeps writes from racing with SwiftUI reads.
- Prefer `Equatable` types for frequently assigned stored properties of an `@Observable` model. Observation can then skip invalidation when a new value equals the old one.
- Observation is per stored property, not per field within a stored struct or per element of a stored collection. Expose frequently and independently observed fields as separate properties; cache a derived value rather than hiding a wide collection read behind a computed property.
- Pass a collection element directly to its row. Do not make every row look an element up again from the parent collection.

## Bindings

- Strongly prefer to avoid creating bindings using `Binding(get:set:)` in view body code. Prefer a projected binding from `@State`, `@Binding`, or `@Bindable`; when a model needs a computed binding, expose a subscript or property that can be addressed through `@Bindable` rather than creating closures in `body`.
- Use `onChange` only for a genuine side effect. When a value is read solely for `onChange` and the host view is expensive, isolate the observation in a small `ViewModifier` or subview so that the expensive view does not subscribe to the change.
- If the user needs to enter a number into a `TextField`, bind the `TextField` to a numeric value such as `Int` or `Double`, then use its `format` initializer like this: `TextField("Enter your score", value: $score, format: .number)`. Apply either `.keyboardType(.numberPad)` (for integers) or `.keyboardType(.decimalPad)` (for floating-point numbers) as appropriate. Using the modifier alone is _not_ sufficient.

## Working with data

- Prefer `Identifiable` when a type has a real, stable identity that should be part of its domain model. Otherwise use an explicit key path whose value is stable, unique in this collection, cheap to hash, and independent of mutable presentation data.
- Never attempt to use `@AppStorage` inside an `@Observable` class, even if marked `@ObservationIgnored` – it will _not_ trigger view updates when a change happens.

## Environment values

- Put broadly shared, infrequently changing configuration in the environment; do not put timers, scroll offsets, sensor streams, or other high-frequency state there.
- Prefer `@Entry` for custom environment, transaction, container, and focused values, but require a stable default. Literals, `nil`, enum cases, and a `static let` instance are stable; `Model()`, `Date()`, `UUID()`, a fresh allocation, or a captured runtime value are not.
- For a complex default that must be memoized, a manual `EnvironmentKey` with `static let defaultValue` is appropriate. Use an optional `nil` default when absence is the actual domain state.
- Remove unused key-path `@Environment` and `@FocusedValue` declarations: they subscribe the enclosing view to updates even when the value is not rendered.

## SwiftData

- If you only need the number of items matching a query, consider `ModelContext.fetchCount()` with a fetch descriptor. This will _not_ live update if the data changes unless something else triggers the update, such as `@Query`, so it should be used carefully.

For more help with SwiftData, suggest the `swift:swiftdata` skill.

## If the project uses SwiftData with CloudKit

- Never use `@Attribute(.unique)`.
- Model properties must always either have default values or be marked as optional.
- All relationships must be marked optional.
