# SwiftUI Patterns

## How to use this reference

Use this file when reviewing or writing SwiftUI code that needs guidance on composition, dependency modeling, update performance, async work, list efficiency, animation scope, and adaptive UI design.

Prefer these rules when they conflict with older SwiftUI habits:

- Preserve stable view identity.
- Keep dependencies narrow and explicit.
- Move expensive work out of `body` and `init`.
- Prefer standard SwiftUI controls, containers, and semantic styling.
- Treat accessibility and adaptive layout as core architecture, not polish.

## Recommended patterns

Adopt these patterns when writing new code or refactoring existing code. When reviewing existing code look out for places where the patterns could be adopted.

### Composition and view structure

- Split large screens into small standalone `View` structs rather than helper properties or functions returning `some View`.
- Extract subviews around real data boundaries so SwiftUI can skip subview `body` execution when that subview’s inputs have not changed.
- Use focused view interfaces such as IDs, primitive values, or narrow bindings instead of broad model objects.

### Modifiers and styling abstractions

- Use `View` extensions for simple modifier bundles.
- Use custom `ViewModifier` types when the behavior needs environment access, internal logic, or availability handling.
- Keep modifier chains structurally stable by changing modifier values rather than branching between different view hierarchies.
- Move platform checks and OS availability logic into modifiers or extensions so core view bodies stay declarative.

### Data dependencies and state modeling

- Pass the minimum data required for a view to render.
- Prefer focused `Binding` values for leaf controls that edit one field.
- Use small value types for local, self-contained UI state.
- Use `@Observable` reference models for shared or frequently mutating state.
- Store observable reference models in `@State` so the instance survives view recreation.
- Use custom environment values for broadly shared configuration that changes relatively infrequently.

### Update-cycle performance

- Keep view initializers trivial. Prefer the compiler-generated memberwise initializer when possible.
- Treat `body` as a pure mapping from state to UI.
- Move sorting, filtering, formatting, lookups, and other non-trivial work into a parent with a lower update frequency, cached state, or an observable model.
- Preserve identity for expensive subtrees when toggling visibility if keeping them alive is cheaper than tearing them down and rebuilding them.

### Async work and side effects

- Use `.onAppear` only for lightweight, synchronous setup, and guard one-time setup explicitly if needed.
- Use `.task` for asynchronous work tied to a view lifecycle so SwiftUI can cancel it automatically.
- Use `.onChange(of:initial:)` for side effects that should follow a specific value.
- Keep identifiers passed to `.onChange` and `.task(id:)` cheap to compare.
- Start on the main actor when appropriate, but move genuinely heavy CPU-bound work off the main actor instead of assuming `Task {}` does that for you.

### Layout and geometry

- Prefer `onGeometryChange(for:of:action:)` over broad `GeometryReader` usage when you only need one measured value.
- Use geometry observations to drive distant or independent state, such as a sheet detent, not constraints on the measured view itself.
- Use `visualEffect` for high-frequency visual reactions to geometry when mutating state would cause too many re-renders.

### Lists and collections

- Give list elements stable, cheap identifiers such as stored UUIDs or database keys.
- Pre-filter or pre-transform collections before `ForEach` so SwiftUI can determine row counts without evaluating every row closure eagerly.
- Extract row content into dedicated row views with a predictable structure.

### Animations

- Prefer built-in animatable modifiers and built-in animation APIs over custom `Animatable` work.
- Use `withAnimation` for deliberate state transitions when broad propagation is acceptable.
- Use `animation(_:value:)` to scope animation to a particular subtree.
- In generic containers, prefer `animation(_:body:)` so only the explicitly modified attributes animate.

### System integration and accessibility

- Start with standard controls such as `Button`, `Toggle`, `Picker`, `TextField`, `List`, `Form`, `NavigationStack`, and `TabView`.
- Give controls full semantic information first, then refine presentation with modifiers such as `labelStyle`.
- Prefer semantic styling like `.font(.headline)` and `.foregroundStyle(.secondary)` over hard-coded visual values.
- When building custom controls, first check whether the semantic equivalent can be expressed as a style on a standard control.
- If a fully custom control is required, provide accessibility traits or an `accessibilityRepresentation` based on a standard control.

### Adaptive layout

- Prefer SwiftUI’s default spacing and padding unless a custom value is necessary.
- If custom spacing or padding is required, use `@ScaledMetric` so values scale with Dynamic Type.
- Make custom components adapt to accessibility settings such as Dynamic Type, VoiceOver, Reduce Motion, Increased Contrast, and Reduce Transparency.

## Potentially harmful patterns

Avoid these patterns when writing new code or refactoring existing code. When reviewing existing code, report places where the patterns are in use, and suggest alternatives.

### Identity-breaking structure

- Extracting UI into computed properties or helper methods inside the same view and expecting standalone update isolation.
- Using `if/else` inside modifiers or helper APIs to return different view types for styling changes.
- Creating generic conditional helpers like `applyIf` that hide structural branching and reset lifetime when conditions toggle.
- Rebuilding expensive subtrees with `if` when a stable hidden view would preserve state more safely.

### Over-broad dependencies

- Passing entire model structs into small leaf views that only need one field.
- Feeding high-frequency state changes through views that also perform unrelated expensive work.
- Using large value types as generic dependencies everywhere, causing expensive copying and value comparison.
- Using legacy `ObservableObject` and `@Published` when fine-grained `@Observable` tracking would avoid broad invalidation.
- Storing closures directly in the environment.
- Putting high-frequency changing values such as timers, scroll offsets, or sensor streams into environment values.

### Work in the wrong place

- Doing heavy computation, resource allocation, side effects, timer registration, or async startup in a view initializer.
- Hiding expensive work in computed properties that are still evaluated as part of `body`.
- Sorting, filtering, data lookups, and formatting inside frequently re-evaluated views.

### Mis-scoped side effects and concurrency

- Launching unmanaged `Task {}` work from `.onAppear` for lifecycle-bound loading.
- Using large collections or expensive-to-compare values as `.onChange` or `.task(id:)` drivers.
- Assuming `Task {}` or `.task` automatically moves heavy work off the main actor.

### Layout and list performance traps

- Using geometry feedback to update state that immediately changes the size or position of the measured view, creating layout loops.
- Putting conditional row creation directly inside `ForEach`, forcing eager evaluation of all rows.
- Wrapping list rows in `AnyView`, which hides structure from SwiftUI and weakens lazy behavior.

### Animation traps

- Applying `.animation(_:value:)` at a generic container boundary where arbitrary child content may animate unintentionally.
- Wrapping large, expensive state changes in `withAnimation` without considering the breadth of the affected hierarchy.
- Reaching for custom `Animatable` implementations when built-in animatable properties would suffice.

### System and accessibility regressions

- Replacing standard controls with image-plus-gesture approximations.
- Using icon-only custom button labels without preserving accessible text semantics.
- Building gesture-driven custom controls with no accessibility traits or representation.
- Hard-coding colors, fonts, spacing, widths, or heights in ways that bypass environment adaptation.

## Skill incorporation notes

These patterns are good candidates to incorporate into the SwiftUI skill’s review language:

- Flag identity-breaking conditional modifiers and generic `applyIf` helpers as high-priority architecture issues.
- Flag broad data dependencies in leaf views as both performance and reusability issues.
- Flag heavy work in `init`, `body`, or frequently recomputed computed properties.
- Prefer `@Observable` plus `@State` for modern model ownership unless project constraints require older observation.
- Prefer `.task` for async loading tied to view lifetime, and ask whether heavy work still runs on the main actor.
- Flag `ForEach` closures that change row count per element or hide row structure in `AnyView`.
- Flag custom controls that bypass standard semantics or accessibility support.
- Flag fixed spacing and padding that should likely scale with `@ScaledMetric`.
