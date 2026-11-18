// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 18/11/2026.
//  Copyright © 2026 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

/// Parses byte counts supplied as unsigned ASCII decimal integers.
public enum ByteCount {
  /// Returns nil for empty input, non-ASCII digits, signs or values exceeding UInt64.
  public static func parse(_ text: String) -> UInt64? {
    guard !text.isEmpty,
      text.utf8.allSatisfy({ $0 >= 48 && $0 <= 57 })
    else { return nil }
    return UInt64(text)
  }
}
