#!/usr/bin/env swift

#if canImport(Darwin)
import Darwin
#elseif canImport(Glibc)
import Glibc
#endif
import Foundation

struct CommandResult {
    let status: Int32
    let stdout: String
    let stderr: String
}

struct DiscoveredSkill {
    let name: String
    let submodulePath: String
    let skillDirectory: URL
}

struct LinkTarget {
    let name: String
    let directory: URL
}

enum ToolError: Error, CustomStringConvertible {
    case message(String)

    var description: String {
        switch self {
        case .message(let value):
            return value
        }
    }
}

final class SkillsPublicTool {
    private let fileManager = FileManager.default
    private let repoRoot: URL
    private let skillsRoot: URL
    private let agentsSkillsDir: URL
    private let localMaintenanceSkill: URL

    init() {
        let scriptURL = URL(fileURLWithPath: #filePath)
        self.repoRoot = scriptURL
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        self.skillsRoot = repoRoot.appendingPathComponent("skills")

        let homeDirectory = fileManager.homeDirectoryForCurrentUser
        self.agentsSkillsDir = URL(
            fileURLWithPath: ProcessInfo.processInfo.environment["AGENTS_SKILLS_DIR"]
                ?? homeDirectory.appendingPathComponent(".agents/skills").path
        )
        self.localMaintenanceSkill = repoRoot.appendingPathComponent("skills/refresh-public-skills")
    }

    func run(arguments: [String]) throws {
        guard let command = arguments.first else {
            throw ToolError.message(usage())
        }

        let remaining = Array(arguments.dropFirst())
        switch command {
        case "audit":
            try runAudit(arguments: remaining)
        case "sync":
            try runSync(arguments: remaining)
        case "link":
            try runLink(arguments: remaining)
        case "status":
            try runStatus()
        default:
            throw ToolError.message(usage())
        }
    }

    private func usage() -> String {
        """
        Usage:
          skills-public.swift audit --all
          skills-public.swift audit <skill> [<skill> ...]
          skills-public.swift sync --all
          skills-public.swift sync <skill-or-submodule> [<skill-or-submodule> ...]
          skills-public.swift link
          skills-public.swift status
        """
    }

    private func runProcess(
        _ executable: String,
        arguments: [String],
        currentDirectory: URL? = nil
    ) throws -> CommandResult {
        let process = Process()
        process.executableURL = URL(fileURLWithPath: executable)
        process.arguments = arguments
        if let currentDirectory {
            process.currentDirectoryURL = currentDirectory
        }

        let stdoutPipe = Pipe()
        let stderrPipe = Pipe()
        process.standardOutput = stdoutPipe
        process.standardError = stderrPipe

        try process.run()
        process.waitUntilExit()

        let stdout = String(data: stdoutPipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
        let stderr = String(data: stderrPipe.fileHandleForReading.readDataToEndOfFile(), encoding: .utf8) ?? ""
        return CommandResult(status: process.terminationStatus, stdout: stdout, stderr: stderr)
    }

    private func git(_ arguments: [String], in directory: URL) throws -> CommandResult {
        try runProcess("/usr/bin/env", arguments: ["git"] + arguments, currentDirectory: directory)
    }

    private func makeDirectory(_ url: URL) throws {
        try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
    }

    private func pathExistsIncludingBrokenSymlink(_ url: URL) -> Bool {
        var info = stat()
        return lstat(url.path, &info) == 0
    }

    private func replaceSymlink(at destination: URL, with target: URL) throws {
        if pathExistsIncludingBrokenSymlink(destination) {
            try fileManager.removeItem(at: destination)
        }
        try fileManager.createSymbolicLink(at: destination, withDestinationURL: target)
    }

    private func isGitCheckout(_ url: URL) -> Bool {
        fileManager.fileExists(atPath: url.appendingPathComponent(".git").path)
    }

    private func trimmed(_ value: String) -> String {
        value.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func submoduleDirectory(for submodulePath: String) -> URL {
        repoRoot.appendingPathComponent(submodulePath)
    }

    private func relativePath(for url: URL) -> String {
        let repoPath = repoRoot.path + "/"
        let path = url.path
        if path.hasPrefix(repoPath) {
            return String(path.dropFirst(repoPath.count))
        }
        return path
    }

    private func registeredSubmodulePaths() throws -> [String] {
        let gitmodulesURL = repoRoot.appendingPathComponent(".gitmodules")
        guard fileManager.fileExists(atPath: gitmodulesURL.path) else {
            return []
        }

        let result = try git(
            ["config", "-f", ".gitmodules", "--get-regexp", #"^submodule\..*\.path$"#],
            in: repoRoot
        )
        if result.status != 0 && trimmed(result.stdout).isEmpty {
            return []
        }
        if result.status != 0 {
            throw ToolError.message(result.stderr.isEmpty ? result.stdout : result.stderr)
        }

        return result.stdout
            .split(separator: "\n")
            .compactMap { line in
                let columns = line.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
                guard let rawPath = columns.last else { return nil }
                let path = String(rawPath)
                return path.hasPrefix("skills/") ? path : nil
            }
            .sorted()
    }

    private func firstSkillDirectory(in directory: URL) throws -> URL? {
        let skillFile = directory.appendingPathComponent("SKILL.md")
        if fileManager.fileExists(atPath: skillFile.path) {
            return directory
        }

        let children = try fileManager.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        )
        let childDirectories = children
            .filter { child in
                (try? child.resourceValues(forKeys: [.isDirectoryKey]).isDirectory) == true
            }
            .sorted {
                $0.lastPathComponent.localizedStandardCompare($1.lastPathComponent) == .orderedAscending
            }

        for child in childDirectories {
            if let match = try firstSkillDirectory(in: child) {
                return match
            }
        }

        return nil
    }

    private func strippedQuotes(_ value: String) -> String {
        guard value.count >= 2 else { return value }
        let first = value.first
        let last = value.last
        if (first == "\"" && last == "\"") || (first == "'" && last == "'") {
            return String(value.dropFirst().dropLast())
        }
        return value
    }

    private func readSkillName(at skillFile: URL) throws -> String? {
        let data = try Data(contentsOf: skillFile)
        guard let text = String(data: data, encoding: .utf8) else {
            throw ToolError.message("Unreadable UTF-8 text in \(relativePath(for: skillFile))")
        }

        let lines = text.components(separatedBy: .newlines)
        guard lines.first == "---" else {
            return nil
        }

        for line in lines.dropFirst() {
            if line == "---" {
                break
            }
            guard line.hasPrefix("name:") else {
                continue
            }
            return strippedQuotes(trimmed(String(line.dropFirst("name:".count))))
        }

        return nil
    }

    private func discoverSkill(in submodulePath: String) throws -> DiscoveredSkill? {
        let submoduleDir = submoduleDirectory(for: submodulePath)
        guard fileManager.fileExists(atPath: submoduleDir.path), isGitCheckout(submoduleDir) else {
            return nil
        }

        guard let skillDirectory = try firstSkillDirectory(in: submoduleDir) else {
            throw ToolError.message("No SKILL.md found in \(submodulePath)")
        }

        let skillFile = skillDirectory.appendingPathComponent("SKILL.md")
        guard let skillName = try readSkillName(at: skillFile), !skillName.isEmpty else {
            throw ToolError.message("Missing front matter name in \(relativePath(for: skillFile))")
        }

        return DiscoveredSkill(
            name: skillName,
            submodulePath: submodulePath,
            skillDirectory: skillDirectory
        )
    }

    private func ensureUniqueNames(_ pairs: [(name: String, source: String)]) throws {
        var grouped: [String: [String]] = [:]
        for pair in pairs {
            grouped[pair.name, default: []].append(pair.source)
        }

        let duplicates = grouped
            .filter { $0.value.count > 1 }
            .sorted { $0.key.localizedStandardCompare($1.key) == .orderedAscending }

        guard duplicates.isEmpty else {
            let details = duplicates
                .map { key, sources in
                    "\(key): \(sources.joined(separator: ", "))"
                }
                .joined(separator: "; ")
            throw ToolError.message("Duplicate skill names detected: \(details)")
        }
    }

    private func discoveredSkills() throws -> [DiscoveredSkill] {
        var skills: [DiscoveredSkill] = []
        for submodulePath in try registeredSubmodulePaths() {
            if let skill = try discoverSkill(in: submodulePath) {
                skills.append(skill)
            }
        }

        try ensureUniqueNames(
            skills.map { skill in
                (name: skill.name, source: relativePath(for: skill.skillDirectory))
            }
        )

        return skills.sorted {
            $0.name.localizedStandardCompare($1.name) == .orderedAscending
        }
    }

    private func linkTargets() throws -> [LinkTarget] {
        var targets = try discoveredSkills().map { skill in
            LinkTarget(name: skill.name, directory: skill.skillDirectory)
        }

        if fileManager.fileExists(atPath: localMaintenanceSkill.path) {
            targets.append(LinkTarget(name: "refresh-public-skills", directory: localMaintenanceSkill))
        }

        try ensureUniqueNames(
            targets.map { target in
                (name: target.name, source: relativePath(for: target.directory))
            }
        )

        return targets.sorted {
            $0.name.localizedStandardCompare($1.name) == .orderedAscending
        }
    }

    private func readAheadBehind(in directory: URL) throws -> String {
        let upstreamResult = try git(["rev-parse", "--abbrev-ref", "@{upstream}"], in: directory)
        guard upstreamResult.status == 0 else {
            return "n/a"
        }

        let countsResult = try git(["rev-list", "--left-right", "--count", "HEAD...@{upstream}"], in: directory)
        let summary = trimmed(countsResult.stdout)
        guard !summary.isEmpty else {
            return "n/a"
        }

        return summary
            .replacingOccurrences(of: "\t", with: "/")
            .replacingOccurrences(of: " ", with: "/")
    }

    private func symlinkStatus(link: URL, target: URL) -> String {
        guard let destination = try? fileManager.destinationOfSymbolicLink(atPath: link.path) else {
            return "mismatch"
        }
        return destination == target.path ? "ok" : "mismatch"
    }

    private func selectedSyncSubmodulePaths(from arguments: [String]) throws -> [String] {
        let submodulePaths = try registeredSubmodulePaths()
        if arguments == ["--all"] {
            return submodulePaths
        }
        if arguments.isEmpty {
            throw ToolError.message(usage())
        }

        let discoveredByName = Dictionary(
            uniqueKeysWithValues: try discoveredSkills().map { ($0.name, $0.submodulePath) }
        )
        var selected: [String] = []
        var seen: Set<String> = []

        for argument in arguments {
            let match: String?
            if let runtimePath = discoveredByName[argument] {
                match = runtimePath
            } else if submodulePaths.contains(argument) {
                match = argument
            } else {
                match = submodulePaths.first {
                    URL(fileURLWithPath: $0).lastPathComponent == argument
                }
            }

            guard let resolved = match else {
                throw ToolError.message("Unknown skill or submodule: \(argument)")
            }
            if seen.insert(resolved).inserted {
                selected.append(resolved)
            }
        }

        return selected
    }

    private func selectedDiscoveredSkills(from arguments: [String]) throws -> [DiscoveredSkill] {
        let allSkills = try discoveredSkills()
        if arguments == ["--all"] {
            return allSkills
        }
        if arguments.isEmpty {
            throw ToolError.message(usage())
        }

        var selected: [DiscoveredSkill] = []
        var seen: Set<String> = []

        for argument in arguments {
            guard let skill = allSkills.first(where: {
                $0.name == argument
                    || $0.submodulePath == argument
                    || URL(fileURLWithPath: $0.submodulePath).lastPathComponent == argument
            }) else {
                throw ToolError.message("Unknown skill: \(argument)")
            }

            if seen.insert(skill.name).inserted {
                selected.append(skill)
            }
        }

        return selected
    }

    private func runSync(arguments: [String]) throws {
        let submodulePaths = try selectedSyncSubmodulePaths(from: arguments)
        guard !submodulePaths.isEmpty else { return }

        let result = try git(
            ["submodule", "update", "--init", "--recursive", "--"] + submodulePaths,
            in: repoRoot
        )
        guard result.status == 0 else {
            throw ToolError.message(result.stderr.isEmpty ? result.stdout : result.stderr)
        }

        for submodulePath in submodulePaths {
            if let skill = try discoverSkill(in: submodulePath) {
                print("\(skill.name): \(relativePath(for: skill.skillDirectory))")
            } else {
                print("\(submodulePath): initialized")
            }
        }
    }

    private func runLink(arguments: [String]) throws {
        if !arguments.isEmpty {
            throw ToolError.message(usage())
        }

        try makeDirectory(agentsSkillsDir)

        for target in try linkTargets() {
            guard fileManager.fileExists(atPath: target.directory.path) else {
                throw ToolError.message("Missing skill source for \(target.name): \(target.directory.path)")
            }
            try replaceSymlink(
                at: agentsSkillsDir.appendingPathComponent(target.name),
                with: target.directory
            )
            print("\(target.name): \(target.directory.path)")
        }
    }

    private func runStatus() throws {
        let submodulePaths = try registeredSubmodulePaths()

        print("# Skill Repo Status\n")
        print("Skills root: \(skillsRoot.path)\n")
        print("| Skill | Source | Working Tree | Ahead/Behind | ~/.agents |")
        print("| --- | --- | --- | --- | --- |")

        for submodulePath in submodulePaths {
            let submoduleDir = submoduleDirectory(for: submodulePath)
            let discovered = try discoverSkill(in: submodulePath)
            let skillName = discovered?.name ?? URL(fileURLWithPath: submodulePath).lastPathComponent
            let source = discovered.map { relativePath(for: $0.skillDirectory) } ?? submodulePath

            guard isGitCheckout(submoduleDir) else {
                print("| \(skillName) | \(source) | uninitialized | - | - |")
                continue
            }

            let dirtyResult = try git(["status", "--short"], in: submoduleDir)
            let workingTree = trimmed(dirtyResult.stdout).isEmpty ? "clean" : "dirty"
            let aheadBehind = try readAheadBehind(in: submoduleDir)
            let agentsStatus = discovered.map {
                symlinkStatus(
                    link: agentsSkillsDir.appendingPathComponent($0.name),
                    target: $0.skillDirectory
                )
            } ?? "invalid"

            print("| \(skillName) | \(source) | \(workingTree) | \(aheadBehind) | \(agentsStatus) |")
        }

        if fileManager.fileExists(atPath: localMaintenanceSkill.path) {
            let maintenanceStatus = symlinkStatus(
                link: agentsSkillsDir.appendingPathComponent("refresh-public-skills"),
                target: localMaintenanceSkill
            )
            print("| refresh-public-skills | \(relativePath(for: localMaintenanceSkill)) | repo-local | - | \(maintenanceStatus) |")
        }
    }

    private func classify(source: URL) throws -> (outcome: String, notes: [String]) {
        let secretRegex = try NSRegularExpression(
            pattern: "BEGIN [A-Z ]+PRIVATE KEY|gh[pousr]_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{20,}|AKIA[0-9A-Z]{12,}|ASIA[0-9A-Z]{12,}|client_secret"
        )
        let escapedHome = NSRegularExpression.escapedPattern(for: fileManager.homeDirectoryForCurrentUser.path)
        let portabilityRegex = try NSRegularExpression(pattern: escapedHome)
        let localLinkRegex = try NSRegularExpression(pattern: "file://|\(escapedHome)|git@github.com:")

        var foundSecrets = false
        var foundPortability = false
        var foundLocalLinks = false

        if let enumerator = fileManager.enumerator(
            at: source,
            includingPropertiesForKeys: [.isDirectoryKey],
            options: [.skipsHiddenFiles]
        ) {
            for case let fileURL as URL in enumerator {
                if fileURL.path.contains("/.git/") {
                    enumerator.skipDescendants()
                    continue
                }

                let values = try fileURL.resourceValues(forKeys: [.isDirectoryKey])
                if values.isDirectory == true {
                    continue
                }

                guard let data = fileManager.contents(atPath: fileURL.path),
                      let text = String(data: data, encoding: .utf8) else {
                    continue
                }

                let range = NSRange(text.startIndex..<text.endIndex, in: text)
                if secretRegex.firstMatch(in: text, options: [], range: range) != nil {
                    foundSecrets = true
                }
                if portabilityRegex.firstMatch(in: text, options: [], range: range) != nil {
                    foundPortability = true
                }
                if localLinkRegex.firstMatch(in: text, options: [], range: range) != nil {
                    foundLocalLinks = true
                }
            }
        }

        var notes: [String] = []
        let outcome: String
        if foundSecrets {
            outcome = "not suitable for publication"
            notes.append("secret-like material detected")
        } else if foundPortability || foundLocalLinks {
            outcome = "safe after sanitization"
            if foundPortability {
                notes.append("machine-specific path assumptions detected")
            }
            if foundLocalLinks {
                notes.append("local-only links or SSH transport references detected")
            }
        } else {
            outcome = "safe as-is"
            notes.append("no obvious secret or machine-local patterns detected")
        }

        return (outcome, notes)
    }

    private func runAudit(arguments: [String]) throws {
        let skills = try selectedDiscoveredSkills(from: arguments)

        print("# Public Skill Audit\n")
        print("Source root: \(skillsRoot.path)\n")
        print("| Skill | Source | Outcome | Notes |")
        print("| --- | --- | --- | --- |")

        for skill in skills {
            let result = try classify(source: skill.skillDirectory)
            print(
                "| \(skill.name) | \(relativePath(for: skill.skillDirectory)) | \(result.outcome) | \(result.notes.joined(separator: "; ")) |"
            )
        }
    }
}

do {
    let tool = SkillsPublicTool()
    try tool.run(arguments: Array(CommandLine.arguments.dropFirst()))
} catch {
    fputs("\(error)\n", stderr)
    exit(1)
}
