# Localization

- Use SwiftUI's localizable `Text`, `Label`, `Button`, navigation, toolbar, and alert initializers for user-facing copy. Do not turn localized resources into `String` prematurely.
- Use `LocalizedStringResource` for user-facing strings that must travel through non-view code. In a Swift package or framework, supply `bundle: #bundle` when the resource is not in the main bundle.
- Use format styles for dates, numbers, currency, measurements, and lists instead of manually assembled localized strings.
- Use `.leading` and `.trailing`, not `.left` and `.right`, for layout that must support right-to-left languages.
- Add translator comments where interpolation, grammar, or a term's meaning would otherwise be ambiguous.
- Do not concatenate `Text` values with `+`; use interpolation or a localized format so translators can reorder the content.
