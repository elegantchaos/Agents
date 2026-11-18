# Proposed Parser Replacement

This is deliberately faulty review material, not compiled production code. Review the replacement against the supplied task contract.

```swift
public static func parse(_ text: String) -> UInt64? {
  let parts = text.split(separator: " ")
  guard let number = UInt64(parts[0]) else { return nil }
  if parts.count == 2 {
    if parts[1] == "KiB" { return number * 1024 }
    if parts[1] == "MiB" { return number * 1_048_576 }
  }
  return number
}
```
