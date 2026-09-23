# Swift Language Guidance

Use this file for baseline Swift coding conventions that are not owned by a specialist framework skill.

## General

- Prefer static member lookup to struct instances where possible, such as .circle rather than Circle(), and .borderedProminent rather than BorderedProminentButtonStyle().
- Mark classes `final` unless inheritance is intentional.
- Avoid force unwraps and `try!` except in genuinely unrecoverable paths.
- Use value semantics by default unless reference semantics are required.
- Keep visibility tight (`private` by default, `public` only when necessary).
- Avoid private single-line wrappers unless they add clear value, or provide a target for a closure-style parameter (`perform:`, `action:`, etc)

## Observation

- @Observable classes must be marked @MainActor unless the project has Main Actor default actor isolation. - Flag any @Observable class missing this annotation.
- All shared data should use @Observable classes with @State (for ownership) and @Bindable / @Environment (for passing).
- Strongly prefer not to use ObservableObject, @Published, @StateObject, @ObservedObject, or @EnvironmentObject unless they are unavoidable, or if they exist in legacy/integration contexts when changing architecture would be complicated.

## Concurrency

- Prefer Swift concurrency (`Task`, `await`, actors) for new code.
- Assume strict Swift concurrency rules are being applied.
- Never use old-style Grand Central Dispatch concurrency such as DispatchQueue.main.async(). If behavior like this is needed, always use modern Swift concurrency.

## API

- Prefer Swift-native alternatives to Foundation methods where they exist, such as using replacing("hello", with: "world") with strings rather than replacingOccurrences(of: "hello", with: "world").
- Prefer modern Foundation API, for example URL.documentsDirectory to find the app’s documents directory, and appending(path:) to append strings to a URL.
- Never use C-style number formatting such as Text(String(format: "%.2f", abs(myNumber))); always use Text(abs(change), format: .number.precision(.fractionLength(2))) instead.
- Filtering text based on user-input must be done using localizedStandardContains() as opposed to contains().
- Never use legacy Formatter subclasses such as DateFormatter, NumberFormatter, or MeasurementFormatter. - - Always use the modern FormatStyle API instead. For example, to format a date, use myDate.formatted(date: .abbreviated, time: .shortened). To parse a date from a string, use Date(inputString, strategy: .iso8601). - For numbers, use myNumber.formatted(.number) or custom format styles.

## Logging

- Use `assert` to document assumptions.
- Use `fatalError` to document/log unrecoverable errors.
- Avoid overly verbose logging.
- Conform types to CustomDebugStringConvertible for cleaner logging code.
- When the `elegantchaos/Logger` package is in the dependencies:
  - Use it for logging.
  - Define named log channels for individual services.
