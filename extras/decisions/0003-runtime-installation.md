# 0003 Runtime Installation

Status: Accepted  
Date: 2026-11-05

## Decision

Canonical plugin and shared rule sources live in this repository. The shared maintenance workflow installs plugins into supported agent runtimes and copies shared Codex rules into its configuration. Installed copies are artifacts, not separate sources to edit.

Standalone skills can be linked into runtimes while they remain independently maintained.

## Context

Runtime installation and updates need to be reproducible from canonical sources. Shared Codex rules are specific to that runtime.
