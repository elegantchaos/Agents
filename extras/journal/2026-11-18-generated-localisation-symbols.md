# Generated Localisation Symbols By Default

Sam asked for the Swift localisation guidance to make generated string catalog symbols the default, after Bookish moved its lookup errors and provider strings to them. The reference had only preferred generated accessors "when they are available", and agents had kept writing `String(localized: "key", defaultValue: …, bundle: .module)`.

A scratch package confirmed that `swift build` in Swift 6.4 generates the symbols from a package target's catalog, with no plugin, as long as the package declares a `defaultLocalization`; without one, nothing is generated and every use fails to compile, which is how Bookish's application target first failed. Named placeholders in catalog values, such as `%1$(service)@`, give the generated functions argument labels, following Stack. Because the symbols are internal to their target, each target's wording lives in its own catalog, which also settles where package wording belongs.

The reference now says to use generated symbols for statically known text, keep keyed lookups for runtime keys, name placeholders, and declare `defaultLocalization`. The Swift plugin's version moved to 0.12.0.

A scratch probe checked how `Text` treats a resource, rendering with `ImageRenderer` under `.environment(\.locale, fr)` and reading the result with Vision OCR. `Text(.symbol)` chose the French string and formatted an interpolated `1234.5` as `1234,500000` with the French wording; `Text(String(localized: .symbol))` stayed English, wording and number alike, because the string was resolved before the view saw its environment. A resource's own `locale` was ignored inside `Text`, which used the environment's, though `String(localized:)` honoured it. That is the evidence for storing the resource or a `Text` in display types. Vision returns nothing inside the sandbox, so the probe had to run outside it.

