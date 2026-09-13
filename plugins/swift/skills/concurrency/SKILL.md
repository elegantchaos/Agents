---
name: concurrency
description: Implement and review Swift concurrency, including actor isolation, task lifetimes, cancellation, and synchronization in apps and portable Swift packages.
---

# Swift concurrency

- Inspect language mode, default actor isolation, enabled concurrency features, and relevant target boundaries before interpreting concurrency behavior.
- Make task ownership, cancellation, and result handling explicit. Select structured or unstructured concurrency according to the required lifetime.
- Distinguish compiler-enforced isolation from runtime concerns such as state changes across suspension points.
- Do not assume a UI or main-actor execution model in portable packages.
