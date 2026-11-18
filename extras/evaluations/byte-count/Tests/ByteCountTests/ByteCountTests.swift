// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 18/11/2026.
//  Copyright © 2026 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Testing

@testable import ByteCount

/// Protects the fixture's existing unsigned-decimal behavior.
struct ByteCountTests {
  /// Accepts ordinary values, including zero and leading zeroes.
  @Test(arguments: [("0", UInt64(0)), ("42", UInt64(42)), ("0007", UInt64(7))])
  func parsesDecimal(text: String, expected: UInt64) {
    #expect(ByteCount.parse(text) == expected)
  }

  /// The full unsigned range is available to callers.
  @Test func parsesMaximum() {
    #expect(ByteCount.parse("18446744073709551615") == UInt64.max)
  }

  /// Rejects invalid syntax and overflow without trapping.
  @Test(arguments: ["", "-1", "+1", "1.5", "١", "18446744073709551616"])
  func rejectsInvalidDecimal(text: String) {
    #expect(ByteCount.parse(text) == nil)
  }
}
