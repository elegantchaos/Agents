# Localization And User Text

Use this file when code introduces or changes user-facing text.

- Localize user-facing strings.
- Use Xcode string catalogs when targeting Apple platforms.
- Keep each catalog with the target whose UI shows its text. Generated symbols are internal to their target, so a package's wording lives in that package's own catalog, not the application's.
- Create symbolic keys using `reverse.dot.notation`, grouped by function or area.
- Add catalog entries by hand, each with its default-language value and a comment for translators.
- Refer to statically known text through the catalog's generated symbols, such as `Text(.settingsTitle)` or `String(localized: .lookupErrorServer(service: name, statusCode: code))`. Do not write `String(localized: "key", defaultValue: …)` or hand-written `LocalizedStringResource` members for text the catalog can generate.
- Choose an API's text parameter by what its callers pass. Take `LocalizedStringResource` for text from a catalog, so callers pass a generated symbol directly; take `String` for text built or read at runtime. Offer both only when both kinds of caller exist; add an overload when a caller needs it, not in case one might.
- Store text in the form the type needs. A type that only displays its text keeps the resource, or a `Text` when it accepts both kinds, so localised text and its interpolated values are resolved and formatted where they are shown. A type that also sorts, compares, logs or saves its text stores `String`; its resource overload, if it has one, resolves with `String(localized:)` and forwards to the `String` one.
- Name the placeholders in catalog values, such as `%1$(service)@`, so the generated functions have argument labels.
- A Swift package target gets generated symbols only when its package declares a `defaultLocalization`; with that, both Xcode and `swift build` generate them.
- Use an explicit keyed lookup only for a key that is known at runtime, such as one read from data.
