# 0001 Shared Guidance Ownership

Status: Accepted

Date: 2026-11-05

## Decision

The Agents repository is the canonical home for shared agent guidance intended for use across projects. It lives at `~/.local/share/agents`. Changes to shared guidance are made at their source here or in the owning skill repository, rather than maintained as project-local copies.

## Context

Projects retain their own instructions for local concerns and refer to the shared baseline for common guidance.
