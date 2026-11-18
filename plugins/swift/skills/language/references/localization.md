# Localization And User Text

Use this file when code introduces or changes user-facing text.

- Localize user-facing strings.
- Use Xcode string catalogs when targeting Apple platforms.
- Keep each catalog with the target whose UI shows its text. Generated symbols are internal to their target, so a package's wording lives in that package's own catalog, not the application's.
- Create symbolic keys using `reverse.dot.notation`, grouped by function or area.
- Add catalog entries by hand, each with its default-language value and a comment for translators.
- Refer to statically known text through the catalog's generated symbols, such as `Text(.settingsTitle)` or `String(localized: .lookupErrorServer(service: name, statusCode: code))`. Do not write `String(localized: "key", defaultValue: …)` or hand-written `LocalizedStringResource` members for text the catalog can generate.
- Match the type to the layer. A type or API used only by UI, such as a view's parameters, takes `LocalizedStringResource`, so callers pass a generated symbol directly and the text resolves where it is shown. A model, service or other non-UI type stores `String`, resolved with `String(localized:)` where the text enters it, since its text may be runtime data and is also logged, sorted and compared.
- A UI API that may also receive dynamic text offers a `String` overload beside the resource one, and both build the stored `Text`, so localised text resolves in the view's environment and dynamic text is shown verbatim. Non-UI APIs take `String` only; their callers resolve catalog text with `String(localized:)` before passing it in.
- Name the placeholders in catalog values, such as `%1$(service)@`, so the generated functions have argument labels.
- A Swift package target gets generated symbols only when its package declares a `defaultLocalization`; with that, both Xcode and `swift build` generate them.
- Use an explicit keyed lookup only for a key that is known at runtime, such as one read from data.
