// swift-tools-version: 6.2
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 18/11/2026.
//  Copyright © 2026 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import PackageDescription

/// A dependency-free coding-evaluation fixture, rather than an installed tool.
let package = Package(
  name: "ByteCount",
  platforms: [.macOS(.v26)],
  products: [.library(name: "ByteCount", targets: ["ByteCount"])],
  targets: [
    .target(name: "ByteCount"),
    .testTarget(name: "ByteCountTests", dependencies: ["ByteCount"]),
  ]
)
