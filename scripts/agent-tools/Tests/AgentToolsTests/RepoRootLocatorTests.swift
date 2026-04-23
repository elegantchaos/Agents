// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
//  Created by Sam Deane on 23/04/2026.
//  Copyright © 2026 Elegant Chaos Limited. All rights reserved.
// -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

import Foundation
import XCTest

@testable import AgentTools

/// Tests for repository root detection in different runtime layouts.
final class RepoRootLocatorTests: XCTestCase {
  /// Prefers AGENTS_REPO_ROOT when it is set.
  func testLocatesRepoRootFromEnvironmentOverride() throws {
    let root = try RepoRootLocator.locateRepoRoot(
      environment: ["AGENTS_REPO_ROOT": "/tmp/custom-root"],
      currentDirectoryPath: "/tmp/ignored",
      fileExistsAtPath: { _ in false }
    )

    XCTAssertEqual(root.path, "/tmp/custom-root")
  }

  /// Finds the root when marker directories and nested package manifest exist.
  func testLocatesRootUsingNestedAgentToolsPackageMarker() throws {
    let candidateRoot = "/repo"
    let paths = Set([
      "\(candidateRoot)/skills",
      "\(candidateRoot)/codex",
      "\(candidateRoot)/scripts/agent-tools/Package.swift",
    ])

    let root = try RepoRootLocator.locateRepoRoot(
      environment: [:],
      currentDirectoryPath: "/repo/scripts/agent-tools/Sources",
      fileExistsAtPath: { paths.contains($0) }
    )

    XCTAssertEqual(root.path, candidateRoot)
  }

  /// Finds the root when the package manifest is at repository root.
  func testLocatesRootUsingRootPackageMarker() throws {
    let candidateRoot = "/repo"
    let paths = Set([
      "\(candidateRoot)/skills",
      "\(candidateRoot)/codex",
      "\(candidateRoot)/Package.swift",
    ])

    let root = try RepoRootLocator.locateRepoRoot(
      environment: [:],
      currentDirectoryPath: "/repo/subdir",
      fileExistsAtPath: { paths.contains($0) }
    )

    XCTAssertEqual(root.path, candidateRoot)
  }

  /// Throws a clear error when no marker combination is present.
  func testThrowsWhenNoRepositoryRootMarkersFound() {
    XCTAssertThrowsError(
      try RepoRootLocator.locateRepoRoot(
        environment: [:],
        currentDirectoryPath: "/",
        fileExistsAtPath: { _ in false }
      )
    ) { error in
      guard let toolError = error as? ToolError else {
        XCTFail("Expected ToolError")
        return
      }
      XCTAssertEqual(toolError.description, RepoRootLocator.missingRootError)
    }
  }
}
