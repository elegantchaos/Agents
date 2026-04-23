<p align="center">
    <img src="assets/logo.svg" alt="Refresh Agents - Agent Skill" height="100" />
</p>

# Refresh

This repository contains the `refresh` agent skill.

## Purpose

Refresh shared agent resources and then refresh the current project's `AGENTS.md`.
Use it for regular shared-maintenance passes, public skill sync/link/status checks, optional source research, shared guidance review, and project `AGENTS.md` regeneration.

## Compatibility

- Agent hosts: Codex-compatible skill hosts
- Publication class: `environment-policy`

## Prerequisites

- A shared agents baseline repository
- A Codex-style home directory and shared rules repository for rule maintenance
- The SwiftPM `agent-tools` command-line tool

## Shared Baseline

This skill assumes a shared AGENTS.md or shared-agents baseline and should say so explicitly in its public docs.

## Contents

- `SKILL.md`
- `agents/openai.yaml` when host metadata is needed
- optional support folders such as `references/`, `assets/`, or `scripts/`
