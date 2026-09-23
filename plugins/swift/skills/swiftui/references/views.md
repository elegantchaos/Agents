# SwiftUI Views

- Keep `body` properties compact, by:
  - break long bodies into subviews
  - button actions should call a method using an `action:` parameter, not contain inline code
  - `task()`, `onAppear()` etc should call a method, not contain inline code

- Place view logic into view models or similar, so it can be tested.
- Prefer using `TextField` with `axis: .vertical` to using `TextEditor`, unless full-screen editing experience is required, because it allows placeholder text.
- If a specific minimum height is required for `TextField`, use something like `lineLimit(5...)`.
- If rendering SwiftUI views to images, strongly prefer `ImageRenderer` over `UIGraphicsImageRenderer`.
- Use `#Preview` for previews, not the legacy `PreviewProvider` protocol.
- When using `TabView(selection:)`, use a binding to a property that stores an enum rather than an integer or string. For example, `Tab("Home", systemImage: "house", value: .home)` is better than `Tab("Home", systemImage: "house", value: 0)`.
- Do not write computed properties or methods that return `some View` as a way of breaking up long `body` properties, even if `@ViewBuilder` is used. Create separate `View` structs instead.
- Do not wrap a single concrete child in `Group`; it adds type-checking work without changing layout or identity. A `Group` remains appropriate for multiple siblings or shared modifiers around conditional content.

## Animating views

- Strongly prefer to use the `@Animatable` macro over creating `animatableData` manually – the macro automatically adds conformance to the `Animatable` protocol and creates the correct `animatableData` property. If some properties should not or cannot be animated (e.g. Booleans, integers, etc), mark them `@AnimatableIgnored`.
- Never use `animation(_ animation: Animation?)`; always provide a value to watch, such as `.animation(.bouncy, value: score)`.
- Chaining animations must be done using a `completion` closure passed to `withAnimation()`, rather than trying to execute multiple `withAnimation()` calls using delays.

For example:

```swift
Button("Animate Me") {
    withAnimation {
        scale = 2
    } completion: {
        withAnimation {
            scale = 1
        }
    }
}
```
