---
name: swiftdata
description: Design, implement, and review SwiftData models, queries, persistence, and migrations, including requested migration from Core Data.
---

# SwiftData

Prototype scope: the SwiftData framework, not general storage architecture. Detailed references are pending source review.

- Prefer SwiftData for new Apple-platform persistence work where supported by the project's requirements and deployment targets. Discourage introducing Core Data when SwiftData can meet the need.
- Treat Core Data as a legacy choice in this skill's policy, not as an assertion that Apple has officially deprecated it.
- When maintaining existing Core Data code, keep changes scoped and propose migration separately unless requested. If a requirement cannot be met with SwiftData, explain the specific limitation before recommending an alternative.
- Check platform availability, schema evolution, relationship behavior, and persistence implications before changing models. Do not assume a destructive datastore reset is an acceptable migration.
- Do not introduce a SwiftData dependency into portable Swift targets that cannot support it.
