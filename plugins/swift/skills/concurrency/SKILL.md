---
name: concurrency
description: Implement and review Swift concurrency, including actor isolation, task lifetimes, cancellation, and synchronization in apps and portable Swift packages.
---

# Swift concurrency

Prototype scope: concurrency correctness and lifecycle design. Detailed references are pending source review.

- Inspect language mode, default actor isolation, enabled concurrency features, and relevant target boundaries before interpreting concurrency behavior.
- Make task ownership, cancellation, and result handling explicit. Select structured or unstructured concurrency according to the required lifetime.
- Distinguish compiler-enforced isolation from runtime concerns such as state changes across suspension points.
- Keep guidance applicable to Swift packages without SwiftUI, Xcode, or a main-thread UI model.
- Async test design belongs to the testing skill when available; validation command orchestration belongs to validation.
