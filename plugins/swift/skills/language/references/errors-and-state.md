# Errors And State Modeling

Use this file when choosing how Swift code models failure and domain state.

- Use `throws` or `async throws` for fallible operations.
- Use `Result` when failure must be stored, deferred, or passed around explicitly.
- Prefer domain-specific error enums over unstructured generic failures.
- Nest an error type inside the type that owns the failure when it is only meaningful within that type's workflow. Define the nested type in a same-file extension after the owner's primary definition, so its operational state and behavior remain easy to scan. Keep it private by default. Use a top-level error type only when independent types need to construct, handle, or test it.
- Use types and enums to constrain invalid states.
