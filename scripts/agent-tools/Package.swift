// swift-tools-version: 6.0

import PackageDescription

let package = Package(
    name: "Agents",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .executable(name: "agent-tools", targets: ["AgentTools"])
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser", from: "1.7.0")
    ],
    targets: [
        .executableTarget(
            name: "AgentTools",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser")
            ]
        ),
        .testTarget(
            name: "AgentToolsTests",
            dependencies: [
                "AgentTools"
            ]
        ),
    ]
)
