---
name: language
description: Apply baseline Swift language and API design guidance when writing, changing, or reviewing Swift code, including packages on non-Apple platforms.
---

# Swift language

- Inspect the project's actual Swift compiler, language mode, supported platforms, and deployment constraints before choosing APIs or proposing migrations. Do not infer settings from the installed Xcode version alone.
- Keep portable code independent of Xcode and Apple-only frameworks. Use platform-specific APIs only where the target supports them.
- Load available specialist skills only for relevant framework, concurrency, testing, or validation work.
- Apply changes within the requested scope; a language review does not itself authorize a toolchain or platform migration.
