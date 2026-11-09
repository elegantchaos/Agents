# Async tests

Use async test functions and await production operations directly when possible. Use `swift:concurrency` for the code under test's isolation, task lifetime and cancellation rules.

## Serializing tests

- Apply `.serialized` to a parameterized test to run its argument cases serially. It has no effect on an individual non-parameterized test.
- Apply `.serialized` to a suite to run its tests and sub-suites serially, including ordinary tests and the cases of parameterized tests. Other suites can still run concurrently.
- Give tests independent state by default. If unrelated suites must use the same process-wide resource, coordinate all users of that resource. A suite's `.serialized` trait only controls execution within that suite.

See [Swift Testing's parallelization rules](https://github.com/swiftlang/swift-testing/blob/swift-6.2-RELEASE/Sources/Testing/Traits/ParallelizationTrait.swift).

## Synchronizing with the work under test

- **Readiness.** Install a synchronous observer before triggering the event. For an observer started in another task, wait for a signal that it has registered and can receive the event. Starting a task, yielding or sleeping gives the observer a chance to run. Use an observable signal to establish that it has reached the required point.
- **Completion.** Await the operation, its task handle, or the specific event that proves the work finished. For debounce, retry or other time-driven behavior, use a controllable clock where the project supports one. After advancing it, wait for the resulting operation or event before asserting.
- **Teardown.** Cancel or stop tasks and subscriptions owned by the test and await their termination when cleanup is asynchronous. Arrange cleanup to run when a requirement throws or a wait times out. Reuse the project's bounded waits. A timeout makes missing progress a test failure.
- **Cancellation.** Wait for production code to signal it reached the point where cancellation matters, such as a blocked read. Cancel the task, await its result, and verify the promised outcome, such as throwing `CancellationError` or releasing a resource. The assertion must exercise production cancellation behavior.

## Confirming async events

`confirmation(expectedCount:)` checks the number of calls made before its closure returns. Call the confirmation from the actual event handler. Keep the closure open by awaiting the operation or an explicit completion signal. For a callback that runs synchronously, recording the result directly may be simpler.

In this example, `submit` returns after the save and its callback, or immediately after rejecting an empty title. The awaited call defines the observation window for both cases.

```swift
import Testing

/// Saves accepted titles and reports when a save finishes.
struct Importer {
    /// Writes an accepted title to storage.
    let save: (String) async -> Void

    /// Saves a nonempty title and reports completion before returning.
    func submit(_ title: String, didSave: () -> Void) async {
        guard !title.isEmpty else {
            return
        }

        await save(title)
        didSave()
    }
}

/// Reports one event for a saved title and zero for a rejected title.
@Test(arguments: [("A Book", 1), ("", 0)])
func reportsSuccessfulSaves(title: String, expectedCount: Int) async {
    let importer = Importer { _ in }

    await confirmation(expectedCount: expectedCount) { didSave in
        await importer.submit(title) {
            didSave()
        }
    }
}
```

For zero-event assertions, establish that observation is active before the trigger and keep it active through the whole interval being checked. Prefer a producer-owned completion signal that covers all relevant work and event delivery. If the contract is silence over a fixed interval, control time where possible and state the interval the test covers. Cancelling and joining the collector proves that collection ended. To check that the producer stopped emitting, keep observing through the stop and the relevant subsequent work, or await producer-owned completion that guarantees emission has ended.

See [Testing asynchronous code](https://developer.apple.com/documentation/testing/testing-asynchronous-code).

## How to set a time limit for concurrent tests

Time limits are adjusted through the `@Test` macro using `.timeLimit()`. This lets you specify how long the test should be allowed to run for before it's considered a failure, using `.minutes()` as appropriate.

**Important:** Many agents strongly believe that you can `.seconds()` here. You cannot use `.seconds()` here – it’s `.minutes()` or nothing.

For example, we could apply a 1-minute maximum runtime like this:

```swift
@Test("Loading view model names", .timeLimit(.minutes(1)))
func loadNames() async {
    let viewModel = ViewModel()
    await viewModel.loadNames()
    #expect(viewModel.names.isEmpty == false, "Names should be full of values.")
}
```

If you use a time limit with a whole test suite, that limit is applied to all tests inside there individually. If you then use a different time limit for a specific test, the shorter of the two is used.

## How to force concurrent tests to run on a specific actor

By default, Swift Testing will run both synchronous and asynchronous tests on any task it likes, but this can be restricted if you want.

First, we can mark individual tests with `@MainActor` or some other global actor, like this:

```swift
@MainActor
@Test("Loading view model names")
func loadNames() async {
    // test code here
}
```

Second, we can mark whole test suites with the same attribute, like this:

```swift
@MainActor
struct DataHandlingTests {
    @Test("Loading view model names")
    func loadNames() async {
        // test code here
    }
}
```

Third, `confirmation()` and `withKnownIssue()` can specify an actor to use for just that closure, allowing the rest of the test to run elsewhere. This might be the main actor using `MainActor.shared`, or a custom actor:

```swift
@Test("Loading view model names")
func loadNames() async {
    await withKnownIssue("Names can sometimes come back with too few values", isolation: MainActor.shared) {
        // test code here
    }
}
```

Finally, test targets can have default actor isolation enabled, which might force all tests onto a specific actor – check for this carefully.

## Testing pre-concurrency code

Test an existing callback API through its completion handler. Prefer the project's bounded callback bridge so a missing callback fails the test and cleanup can run. A checked continuation fits an API that guarantees exactly one completion. Account for cancellation and missing callbacks explicitly when the API can abandon the operation.

## Mocking networking

Unit tests should never do live networking, because it's far too slow. It is strongly preferable to mock the networking layer.

To do this, create a protocol that knows how to perform a network fetch. As an example, this covers the `data(from:)` method of `URLSession`, but the project might require others too:

```swift
protocol URLSessionProtocol {
    func data(from url: URL) async throws -> (Data, URLResponse)
}

extension URLSession: URLSessionProtocol { }
```

You can then create a mock type conforming to the same protocol, which throws an error if provided or returns the test data otherwise:

```swift
class URLSessionMock: URLSessionProtocol {
    var testData: Data?
    var testError: (any Error)?

    func data(from url: URL) async throws -> (Data, URLResponse) {
        if let testError {
            throw testError
        } else {
            (testData ?? Data(), URLResponse())
        }
    }
}
```

And now you can write tests that inject some test data and verify that it comes back successfully:

```swift
@Test func newsStoriesAreFetched() async throws {
    let url = URL(string: "https://www.apple.com/newsroom/rss-feed.rss")!
    var news = News(url: url)
    let session = URLSessionMock()
    session.testData = Data("Hello, world!".utf8)
    try await news.fetch(using: session)
    #expect(news.stories == "Hello, world!")
}
```

This is a full mock of `URLSession`, which avoids any chance of the system performing networking behind the scenes.
