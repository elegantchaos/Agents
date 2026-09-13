---
name: language
description: Apply baseline Swift language and API design guidance when writing, changing, or reviewing Swift code, including packages on non-Apple platforms.
---

# Swift language

Prototype scope: baseline language and toolchain guidance. Detailed references are pending source review.

- Inspect the project's actual Swift compiler, language mode, supported platforms, and deployment constraints before choosing APIs or proposing migrations. Do not infer settings from the installed Xcode version alone.
- Keep portable code independent of Xcode and Apple-only frameworks. Use platform-specific APIs only where the target supports them.
- Own language conventions and API design here. SwiftUI, SwiftData, concurrency, test design, and validation mechanics belong to their specialist skills; load those only when the task needs them and they are available.
- Apply changes within the requested scope; a language review does not itself authorize a toolchain or platform migration.
