# Design

## Guidelines

For apps targetting Apple platforms, follow the [Apple Human Interface Guidelines](https://developer.apple.com/design/human-interface-guidelines/).

For apps targetting macOS, follow Mario Guzman's [layout guidelines](https://marioaguzman.github.io/design/layoutguidelines/).

## Adaptability

- Avoid hard-coded values for spacing, padding, opacity, etc:
  - Prefer to use SwiftUI's default values, as they are more adaptive.
  - For example, use: `.padding()` rather than `.padding(10)`.
- Prefer semantic colour, style, font names over explicit ones.

## Consistency

Prefer to place standard fonts, sizes, colors, stack spacing, padding, rounding, animation timings, and more into a shared enum of constants, so they can be used by all views.

Use semantically meaningful names for the constants, indicating their purpose, rather than their value.

For a clean design, minimize the number of variations of font, weight, style, padding, spacing etc. As a consequence, minimise the number of constants required. Aim for consistency across the project.

## Requirements for flexible, accessible design

- Never use `UIScreen.main.bounds` to read available space; prefer alternatives such as `containerRelativeFrame()`, or `visualEffect()` as appropriate, or (if there is no alternative) `GeometryReader`.
- Prefer to avoid fixed frames for views unless content can fit neatly inside; this can cause problems across different device sizes, different Dynamic Type settings, and more. Giving frames some flexibility is usually preferred.
- Apple’s minimum acceptable tap area for interactions on iOS is 44x44. Ensure this is strictly enforced.

## Standard system styling

- Strongly prefer to use `ContentUnavailableView` when data is missing or empty, rather than designing something custom.
- When using `searchable()`, you can show empty results using `ContentUnavailableView.search` and it will include the search term they used automatically – there’s no need to use `ContentUnavailableView.search(text: searchText)` or similar.
- If you need an icon and some text placed horizontally side by side, prefer `Label` over `HStack`.
- Prefer system hierarchical styles (e.g. secondary/tertiary) over manual opacity when possible, so the system can adapt to the correct context automatically.
- When using `Form`, wrap controls such as `Slider` in `LabeledContent` so the title and control are laid out correctly.
- When using `RoundedRectangle`, the default rounding style is `.continuous` – there is no need to specify it explicitly.

## Ensuring designs work for everyone

- Use `bold()` instead of `fontWeight(.bold)`, because using `bold()` allows the system to choose the correct weight for the current context.
- Only use `fontWeight()` for weights other than bold when there's an important reason - scattering around `fontWeight(.medium)` or `fontWeight(.semibold)` is counterproductive.
- Avoid hard-coded values for padding and stack spacing unless specifically requested.
- Avoid `UIColor` / `NSColor` in SwiftUI code; use SwiftUI `Color` or asset catalog colors.
- The font size `.caption2` is extremely small, and is generally best avoided. Even the font size `.caption` is on the small side, and should be used carefully.
