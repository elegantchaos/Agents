---
name: swiftdata
description: Implement and review SwiftData models, queries, persistence, and migration from Core Data.
---

# SwiftData

- Use SwiftData for Apple-platform persistence. When changing Core Data code, migrate the affected persistence path and its dependencies to SwiftData. Flag remaining Core Data usage in reviews.
- Do not extend Core Data or add legacy compatibility layers to avoid migration. Remove superseded code after verifying migration.
- Preserve persisted data and required behavior. Check schema evolution and relationship behavior; a destructive datastore reset is not a migration.
- If platform support or a required capability blocks migration, report the blocker and the decision needed. Do not fall back to Core Data or discard behavior silently.
- Keep SwiftData dependencies out of unsupported targets.
