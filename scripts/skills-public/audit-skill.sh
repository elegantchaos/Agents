#!/usr/bin/env swift

import Foundation

let scriptURL = URL(fileURLWithPath: #filePath)
let toolURL = scriptURL.deletingLastPathComponent().appendingPathComponent("skills-public.swift")

let process = Process()
process.executableURL = URL(fileURLWithPath: "/usr/bin/env")
process.arguments = ["swift", toolURL.path, "audit"] + Array(CommandLine.arguments.dropFirst())
process.environment = ProcessInfo.processInfo.environment
process.standardInput = FileHandle.standardInput
process.standardOutput = FileHandle.standardOutput
process.standardError = FileHandle.standardError

do {
    try process.run()
    process.waitUntilExit()
    exit(process.terminationStatus)
} catch {
    fputs("Failed to run skills-public.swift: \(error)\n", stderr)
    exit(1)
}
