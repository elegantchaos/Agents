# Testing concurrent code

## Async tests with Swift Testing

Swift Testing supports async test functions natively. No special setup required:

```swift
@Test func userLoads() async throws {
    let user = try await UserService().load(id: "123")
    #expect(user.name == "Alice")
}
```

Await async production APIs directly. If a test needs a separate task, for example to exercise cancellation, keep its handle and await termination.

## Testing actor state

Access actor properties through `await` in tests, just like production code. Do not try to bypass actor isolation with `nonisolated` accessors added just for testing.

```swift
@Test func cachingWorks() async throws {
    let cache = ImageCache()
    let image = try await cache.image(for: testURL)
    let cached = try await cache.image(for: testURL)
    #expect(image == cached)
}
```

## Async test coordination

Use `swift:testing` and its async testing reference for serialization, observer readiness, confirmations, cancellation, timeouts and awaited teardown.

## Actor isolation in tests

By default, Swift Testing runs tests on any executor it chooses. You can constrain this when testing code that requires specific actor isolation.

Mark individual tests or whole suites with `@MainActor` when the code under test requires main-actor isolation:

```swift
@MainActor
@Test func viewModelUpdatesOnMainActor() async {
    let vm = ViewModel()
    await vm.refresh()
    #expect(vm.items.isEmpty == false)
}
```

For finer control, `confirmation()` and `withKnownIssue()` both accept an `isolation` parameter. This runs just that closure on a specific actor while the rest of the test runs elsewhere:

```swift
@Test func loadingUpdatesUI() async {
    await confirmation(isolation: MainActor.shared) { confirmed in
        let vm = ViewModel(onUpdate: { confirmed() })
        await vm.load()
    }
}
```

Also be aware that test targets can have default actor isolation enabled at the module level (e.g., a default main-actor module). When reviewing test failures around isolation, check the target's build settings.

## Test scoping traits with `@TaskLocal`

**Requires Swift 6.1 or later.**

When multiple tests need a shared configuration (e.g., a mock environment or injected dependency), test scoping traits provide a concurrency-safe way to set it up using task-local values rather than shared mutable state.

Create a type conforming to `TestTrait` and `TestScoping`, then set the task-local value inside `provideScope()`:

```swift
struct MockEnvironmentTrait: TestTrait, TestScoping {
    func provideScope(
        for test: Test,
        testCase: Test.Case?,
        performing function: () async throws -> Void
    ) async throws {
        let env = Environment(apiBase: URL(string: "https://test.example.com")!)

        try await Environment.$current.withValue(env) {
            try await function()
        }
    }
}

extension Trait where Self == MockEnvironmentTrait {
    static var mockEnvironment: Self { Self() }
}
```

Then apply it to any test or suite:

```swift
@Test(.mockEnvironment) func fetchUsesTestAPI() async throws {
    // Environment.current is now the mock, scoped to this test's task.
    let users = try await UserService().fetchAll()
    #expect(users.isEmpty == false)
}
```

This avoids the concurrency hazards of a shared `setUp()` mutating global state. Each test's configuration lives in the task-local, so parallel tests get independent values automatically.

## Race detection

It’s a good idea to enable Thread Sanitizer (TSan) in your test scheme to catch data races at runtime. TSan finds races that the compiler's static checks often miss, particularly in code using `@unchecked Sendable` or unsafe pointers.

In Xcode: Product → Scheme Edit Scheme → Diagnostics → Thread Sanitizer.

TSan adds overhead, so consider enabling it for a dedicated CI job rather than every local run.
