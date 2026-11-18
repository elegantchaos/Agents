// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 18/11/2026.
//  Copyright © 2026 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Testing

@testable import ByteCount

/// Evaluator-owned checks added only after a coding run has finished.
struct ByteCountAcceptanceTests {
  /// Covers binary units, permitted spacing and retained decimal syntax.
  @Test(arguments: [
    ("1KiB", UInt64(1024)),
    ("2 MiB", UInt64(2_097_152)),
    (" \t003 KiB\t ", UInt64(3072)),
    ("\t42 ", UInt64(42)),
    ("0MiB", UInt64(0)),
    ("18446744073709551615", UInt64.max),
    ("18014398509481983KiB", UInt64.max - 1023),
  ])
  func parsesValidInput(text: String, expected: UInt64) {
    #expect(ByteCount.parse(text) == expected)
  }

  /// Invalid grammar and multiplication overflow must return nil, without trapping.
  @Test(arguments: [
    "", " \t", "-1KiB", "+1", "1.5MiB", "1KB", "1kib", "KiB",
    "1 KiB junk", "1 2KiB", "1\nKiB", "١KiB", "18446744073709551616",
    "18014398509481984KiB", "17592186044416MiB", "1GiB",
  ])
  func rejectsInvalidInput(text: String) {
    #expect(ByteCount.parse(text) == nil)
  }
}
