#!/usr/bin/env swift

import Foundation

struct CommandResult {
    let status: Int32
    let stdout: String
    let stderr: String
}

struct SkillRecord {
    var fields: [String]

    init(fields: [String]) {
        self.fields = fields
    }

    subscript(index: Int) -> String {
        get { index < fields.count ? fields[index] : "" }
        set {
            if index >= fields.count {
                fields.append(contentsOf: Array(repeating: "", count: index - fields.count + 1))
            }
            fields[index] = newValue
        }
    }

    var skill: String { self[0] }
    var repoURL: String { self[1] }
    var publicationClass: String { self[2] }
    var status: String { self[4] }
    var lastSyncedRef: String {
        get { self[6] }
        set { self[6] = newValue }
    }
    var linkSubpath: String { self[10] }
}

enum ToolError: Error, CustomStringConvertible {
    case message(String)

    var description: String {
        switch self {
        case .message(let value): return value
        }
    }
}

final class SkillsPublicTool {
    private let fileManager = FileManager.default
    private let repoRoot: URL
    private let registryURL: URL
    private let skillsHome: URL
    private let agentsSkillsDir: URL
    private let codexSkillsDir: URL
    private let localMaintenanceSkill: URL

    init() {
        let scriptURL = URL(fileURLWithPath: #filePath)
        self.repoRoot = scriptURL
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .deletingLastPathComponent()
        self.registryURL = repoRoot.appendingPathComponent("codex/skills/public-skill-registry.tsv")
        let homeDirectory = fileManager.homeDirectoryForCurrentUser
        self.skillsHome = URL(fileURLWithPath: ProcessInfo.processInfo.environment["SKILLS_HOME"] ?? homeDirectory.appendingPathComponent(".local/share/skills").path)
        self.agentsSkillsDir = URL(fileURLWithPath: ProcessInfo.processInfo.environment["AGENTS_SKILLS_DIR"] ?? homeDirectory.appendingPathComponent(".agents/skills").path)
        self.codexSkillsDir = URL(fileURLWithPath: ProcessInfo.processInfo.environment["CODEX_SKILLS_DIR"] ?? homeDirectory.appendingPathComponent(".codex/skills").path)
        self.localMaintenanceSkill = repoRoot.appendingPathComponent("codex/skills/refresh-public-skills")
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
          skills-public.swift sync <skill> [<skill> ...]
          skills-public.swift link [--agents-only] [--codex-only]
          skills-public.swift status
        """
    }

    private func loadRegistry() throws -> (header: [String], rows: [SkillRecord]) {
        guard fileManager.fileExists(atPath: registryURL.path) else {
            throw ToolError.message("Missing registry: \(registryURL.path)")
        }

        let content = try String(contentsOf: registryURL, encoding: .utf8)
        let lines = content.split(whereSeparator: \.isNewline).map(String.init)
        guard let headerLine = lines.first else {
            throw ToolError.message("Registry is empty: \(registryURL.path)")
        }

        let header = headerLine.split(separator: "\t", omittingEmptySubsequences: false).map(String.init)
        let rows = lines.dropFirst().map { line in
            SkillRecord(fields: line.split(separator: "\t", omittingEmptySubsequences: false).map(String.init))
        }
        return (header, rows)
    }

    private func saveRegistry(header: [String], rows: [SkillRecord]) throws {
        let lines = [header.joined(separator: "\t")] + rows.map { $0.fields.joined(separator: "\t") }
        try lines.joined(separator: "\n").appending("\n").write(to: registryURL, atomically: true, encoding: .utf8)
    }

    private func skillRecord(named skill: String) throws -> SkillRecord {
        let registry = try loadRegistry()
        guard let row = registry.rows.first(where: { $0.skill == skill }) else {
            throw ToolError.message("Unknown skill: \(skill)")
        }
        return row
    }

    private func allSkills() throws -> [SkillRecord] {
        try loadRegistry().rows
    }

    private func repoName(for record: SkillRecord) -> String {
        let url = record.repoURL.replacingOccurrences(of: ".git", with: "")
        return url.split(separator: "/").last.map(String.init) ?? record.skill
    }

    private func checkoutDir(for record: SkillRecord) -> URL {
        skillsHome.appendingPathComponent(repoName(for: record))
    }

    private func runtimeDir(for record: SkillRecord) -> URL {
        let base = checkoutDir(for: record)
        guard !record.linkSubpath.isEmpty else { return base }
        return base.appendingPathComponent(record.linkSubpath)
    }

    private func packagedSkillDir(for record: SkillRecord) -> URL {
        repoRoot.appendingPathComponent("codex/skills/\(record.skill)")
    }

    private func skillSourceDir(for record: SkillRecord) -> URL {
        let checkout = checkoutDir(for: record)
        if fileManager.fileExists(atPath: checkout.path) {
            return checkout
        }
        return packagedSkillDir(for: record)
    }

    private func runProcess(_ executable: String, arguments: [String], currentDirectory: URL? = nil) throws -> CommandResult {
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

    private func gh(_ arguments: [String], in directory: URL? = nil) throws -> CommandResult {
        try runProcess("/usr/bin/env", arguments: ["gh"] + arguments, currentDirectory: directory)
    }

    private func readHead(in directory: URL) throws -> String? {
        let result = try git(["rev-parse", "HEAD"], in: directory)
        guard result.status == 0 else { return nil }
        return result.stdout.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    private func updateSyncedRef(skill: String, ref: String) throws {
        var registry = try loadRegistry()
        guard let index = registry.rows.firstIndex(where: { $0.skill == skill }) else {
            throw ToolError.message("Unknown skill: \(skill)")
        }
        registry.rows[index].lastSyncedRef = ref
        try saveRegistry(header: registry.header, rows: registry.rows)
    }

    private func selectedSkills(from arguments: [String], allowAll: Bool = true) throws -> [SkillRecord] {
        if allowAll, arguments == ["--all"] {
            return try allSkills()
        }
        if arguments.isEmpty {
            throw ToolError.message(usage())
        }
        return try arguments.map(skillRecord(named:))
    }

    private func makeDirectory(_ url: URL) throws {
        try fileManager.createDirectory(at: url, withIntermediateDirectories: true)
    }

    private func replaceSymlink(at destination: URL, with target: URL) throws {
        if fileManager.fileExists(atPath: destination.path) || destination.hasDirectoryPath {
            try? fileManager.removeItem(at: destination)
        }
        try fileManager.createSymbolicLink(at: destination, withDestinationURL: target)
    }

    private func isGitCheckout(_ url: URL) -> Bool {
        fileManager.fileExists(atPath: url.appendingPathComponent(".git").path)
    }

    private func runSync(arguments: [String]) throws {
        let skills = try selectedSkills(from: arguments)
        try makeDirectory(skillsHome)

        for record in skills {
            let destination = checkoutDir(for: record)
            if isGitCheckout(destination) {
                let result = try git(["pull", "--ff-only"], in: destination)
                guard result.status == 0 else {
                    throw ToolError.message(result.stderr.isEmpty ? result.stdout : result.stderr)
                }
            } else {
                try? fileManager.removeItem(at: destination)
                let repoPath = record.repoURL.replacingOccurrences(of: "https://github.com/", with: "")
                let result = try gh(["repo", "clone", repoPath, destination.path], in: skillsHome)
                guard result.status == 0 else {
                    throw ToolError.message(result.stderr.isEmpty ? result.stdout : result.stderr)
                }
            }

            if let head = try readHead(in: destination) {
                try updateSyncedRef(skill: record.skill, ref: head)
            }

            print("\(record.skill): \(destination.path)")
        }
    }

    private func runLink(arguments: [String]) throws {
        var linkAgents = true
        var linkCodex = true

        if arguments.count > 1 {
            throw ToolError.message(usage())
        }
        if let flag = arguments.first {
            switch flag {
            case "--agents-only":
                linkCodex = false
            case "--codex-only":
                linkAgents = false
            default:
                throw ToolError.message(usage())
            }
        }

        if linkAgents { try makeDirectory(agentsSkillsDir) }
        if linkCodex { try makeDirectory(codexSkillsDir) }

        for record in try allSkills() {
            let target = runtimeDir(for: record)
            guard fileManager.fileExists(atPath: target.path) else {
                throw ToolError.message("Missing checkout for \(record.skill): \(target.path)")
            }
            if linkAgents {
                try replaceSymlink(at: agentsSkillsDir.appendingPathComponent(record.skill), with: target)
            }
            if linkCodex {
                try replaceSymlink(at: codexSkillsDir.appendingPathComponent(record.skill), with: target)
            }
        }

        if linkAgents, fileManager.fileExists(atPath: localMaintenanceSkill.path) {
            try replaceSymlink(at: agentsSkillsDir.appendingPathComponent("refresh-public-skills"), with: localMaintenanceSkill)
        }
    }

    private func runStatus() throws {
        print("# Skill Repo Status\n")
        print("Checkout root: \(skillsHome.path)\n")
        print("| Skill | Working Tree | Ahead/Behind | Registry Ref | ~/.agents | ~/.codex |")
        print("| --- | --- | --- | --- | --- | --- |")

        for record in try allSkills() {
            let repoDir = checkoutDir(for: record)
            let targetDir = runtimeDir(for: record)
            let agentsLink = agentsSkillsDir.appendingPathComponent(record.skill)
            let codexLink = codexSkillsDir.appendingPathComponent(record.skill)

            guard isGitCheckout(repoDir) else {
                print("| \(record.skill) | missing checkout | - | - | - | - |")
                continue
            }

            let headRef = (try readHead(in: repoDir)) ?? ""
            let dirtyResult = try git(["status", "--short"], in: repoDir)
            let dirty = dirtyResult.stdout.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "clean" : "dirty"

            var aheadBehind = "n/a"
            let upstreamResult = try git(["rev-parse", "--abbrev-ref", "@{upstream}"], in: repoDir)
            if upstreamResult.status == 0 {
                let counts = try git(["rev-list", "--left-right", "--count", "HEAD...@{upstream}"], in: repoDir)
                let summary = counts.stdout.trimmingCharacters(in: .whitespacesAndNewlines)
                if !summary.isEmpty {
                    aheadBehind = summary.replacingOccurrences(of: "\t", with: "/")
                    aheadBehind = aheadBehind.replacingOccurrences(of: " ", with: "/")
                }
            }

            let refStatus = (!record.lastSyncedRef.isEmpty && record.lastSyncedRef != headRef) ? "registry-mismatch" : "ok"
            let agentsStatus = symlinkStatus(link: agentsLink, target: targetDir)
            let codexStatus = symlinkStatus(link: codexLink, target: targetDir)

            print("| \(record.skill) | \(dirty) | \(aheadBehind) | \(refStatus) | \(agentsStatus) | \(codexStatus) |")
        }
    }

    private func symlinkStatus(link: URL, target: URL) -> String {
        guard let destination = try? fileManager.destinationOfSymbolicLink(atPath: link.path) else {
            return "mismatch"
        }
        return destination == target.path ? "ok" : "mismatch"
    }

    private func runAudit(arguments: [String]) throws {
        let skills: [SkillRecord]
        if arguments == ["--all"] {
            skills = try allSkills().filter { record in
                record.status != "planned" && fileManager.fileExists(atPath: skillSourceDir(for: record).path)
            }
        } else {
            skills = try selectedSkills(from: arguments)
        }

        print("# Public Skill Audit\n")
        print("Source root: \(skillsHome.path) (falls back to packaged snapshots in this repository if a checkout is missing)\n")
        print("| Skill | Class | Outcome | Notes |")
        print("| --- | --- | --- | --- |")

        for record in skills {
            let result = try classify(record: record)
            print("| \(record.skill) | \(record.publicationClass) | \(result.outcome) | \(result.notes.joined(separator: "; ")) |")
        }
    }

    private func classify(record: SkillRecord) throws -> (outcome: String, notes: [String]) {
        let source = skillSourceDir(for: record)
        let secretRegex = try NSRegularExpression(pattern: "BEGIN [A-Z ]+PRIVATE KEY|gh[pousr]_[A-Za-z0-9_]{20,}|sk-[A-Za-z0-9]{20,}|xox[baprs]-[A-Za-z0-9-]{20,}|AKIA[0-9A-Z]{12,}|ASIA[0-9A-Z]{12,}|client_secret")
        let portabilityRegex = try NSRegularExpression(pattern: "/Users/sam/")
        let localLinkRegex = try NSRegularExpression(pattern: "file://|/Users/sam|git@github.com:")

        var foundSecrets = false
        var foundPortability = false
        var foundLocalLinks = false

        if let enumerator = fileManager.enumerator(at: source, includingPropertiesForKeys: [.isDirectoryKey], options: [.skipsHiddenFiles]) {
            for case let fileURL as URL in enumerator {
                if fileURL.path.contains("/.git/") {
                    enumerator.skipDescendants()
                    continue
                }
                let values = try fileURL.resourceValues(forKeys: [.isDirectoryKey])
                if values.isDirectory == true { continue }
                guard let data = fileManager.contents(atPath: fileURL.path),
                      let text = String(data: data, encoding: .utf8) else { continue }
                let range = NSRange(text.startIndex..<text.endIndex, in: text)
                if secretRegex.firstMatch(in: text, options: [], range: range) != nil { foundSecrets = true }
                if portabilityRegex.firstMatch(in: text, options: [], range: range) != nil { foundPortability = true }
                if localLinkRegex.firstMatch(in: text, options: [], range: range) != nil { foundLocalLinks = true }
            }
        }

        var notes: [String] = []
        let outcome: String
        if foundSecrets {
            outcome = "not suitable for public extraction"
            notes.append("secret-like material detected")
        } else if foundPortability || foundLocalLinks {
            outcome = "safe after sanitization"
            if foundPortability { notes.append("machine-specific path assumptions detected") }
            if foundLocalLinks { notes.append("local-only links or git transport references detected") }
        } else {
            outcome = "safe as-is"
            notes.append("no obvious secret or machine-local patterns detected")
        }

        return (outcome, notes)
    }
}

do {
    let tool = SkillsPublicTool()
    try tool.run(arguments: Array(CommandLine.arguments.dropFirst()))
} catch {
    fputs("\(error)\n", stderr)
    exit(1)
}
