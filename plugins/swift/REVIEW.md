# Review plan

## Agreed direction

- Maintain one Swift plugin in this repository with six separately scoped skills.
- Prefer SwiftData over Core Data and Swift Testing over XCTest for new work. Treat the older frameworks as legacy choices in our guidance, not as a claim of official Apple deprecation.
- Keep validation orchestration separate from test design.
- Keep portable Swift guidance useful without Xcode or Apple frameworks.
- Evaluate Apple guidance individually; distinguish technical requirements from architecture and style preferences.

## Work remaining

1. Record exact revisions and ancestry for the existing Swift skill repositories and Paul Hudson's upstream repositories, plus licenses and local changes.
2. Inventory guidance and referenced resources in `/Applications/Xcode-27.0.0-rc.app`. Record the actual bundle version and build. Search supporting locations under `~/Library` only if missing resources or references point there.
3. Compare substantive rules. Record each source, version/platform/build-setting assumptions, existing local rule, recommendation, rationale, destination skill, and decision status. Classify recommendations as adopt, adapt, retain, reject, or investigate. Review preference changes before implementation.
4. Pilot the testing skill, including the upstream serialized-suite correction and the boundary with validation. Adapt accepted material with attribution, then apply the structure to concurrency and SwiftData. Review language and SwiftUI alongside their original sources.
5. Reconcile shared baseline instructions, project overrides, Xcode MCP usage, and `rt` validation. Decide when targeted checks suffice, when broader checks are required, and how blocked verification is handled.
6. Evaluate realistic requests against an Apple app, a portable Swift package, older deployment targets, mixed concurrency settings, async tests, and a blocked build. Check skill selection, correctness, scope control, tool calls, and honest coverage reporting. Compile technical examples where supported.
7. Pilot installation and discovery, including plugin-qualified skill names and duplicate standalone skills. Update `agt` integration and generated guidance only as part of an explicit migration. Keep tools independently released unless a later decision changes that boundary.

## Sources to inventory

- Existing repositories under `../../skills/`: `swift-skill`, `swiftui-skill`, `Swift-Concurrency-Agent-Skill`, `Swift-Testing-Agent-Skill`, `SwiftData-Agent-Skill`, and `validation-flow-skill`.
- Shared baseline at `../../COMMON.md` and applicable project instructions.
- [Paul Hudson's Swift agent skill directory](https://github.com/twostraws/Swift-Agent-Skills), following original repository links and verifying ancestry.
- Xcode's `Contents/PlugIns/IDEIntelligenceChat.framework/Versions/A/Resources/`: specialist `.idechatprompttemplate` files, their references, and `AdditionalDocumentation`.
- Primary Swift and Apple documentation to verify technical claims and availability.

No source comparison or behavioral evaluation is marked complete by creating this skeleton.
