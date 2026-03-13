# Skill Role Map

This file defines the intended role of shared skills so the control-plane repo, published skill repos, and project guidance do not duplicate one another.

## Principles

- Keep baseline cross-cutting policy in `~/.local/share/agents/instructions/**`.
- Keep workflow and validation orchestration in local/shared skills that encode how we want work to be done.
- Keep deep framework, language-version, and API-specific detail in specialist skill repos.
- Prefer composing a workflow skill with a specialist skill rather than letting one skill absorb the other.

## Current Role Decisions

### `swift-testing-pro`

Use `swift-testing-pro` as the canonical Swift Testing skill.

`swift-testing-pro`
- primary role: specialist Swift Testing reference and review skill
- responsibilities:
  - modern Swift Testing API usage
  - test design and migration from XCTest
  - async test semantics, traits, confirmations, and new features
  - detailed code review findings for test suites
- should avoid:
  - replacing local validation policy or workflow reporting expectations

### `validation-flow`

`validation-flow`
- primary role: shared validation execution policy
- responsibilities:
  - run `rt validate`
  - choose narrow-to-broad validation order
  - report failures, skips, and residual risk
- should not absorb test-framework-specific API or test-design advice

### `swiftui-pro`, `swift-concurrency-pro`, `swiftdata-pro`

These are specialist reference and review skills.

- Keep project-wide policy out of them where possible.
- Use them when code correctness depends on framework-specific rules or modern API nuance.
- Prefer baseline modules to route to them rather than copy their detail.

## Pending Follow-Up

The `*-pro` forks should be reviewed and adjusted where they differ from preferred local advice, especially for:
- source authority and verification language
- version/platform assumptions
- concurrency/GCD nuance
- comment and documentation expectations
- style rules that are too absolute for project baselines
