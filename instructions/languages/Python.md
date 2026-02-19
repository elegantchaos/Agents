# Python Guidance

Relevance: include this file when the project contains Python code (`.py`, `pyproject.toml`, `requirements*.txt`, or Python tooling).

## Why this file exists

This module defines Python-specific quality and maintainability expectations for shared agent and human workflows.

## Core Expectations

- Prefer explicit, readable code over implicit behavior.
- Add type hints for public functions and non-trivial internal APIs.
- Keep side effects obvious and localized.
- Handle expected exceptions narrowly; avoid broad catch-all swallowing.

## Project Structure

- Keep reusable logic in modules rather than scripts.
- Keep CLI/task scripts thin wrappers around reusable module code.
- Add docstrings when behavior is not obvious from naming and types.

## Dependencies and Environments

- Use the project's standard environment/tooling approach.
- Avoid adding dependencies without clear justification.
- Follow existing version pinning/constraint conventions.

## Validation Expectations

- Run relevant tests, lint checks, and type checks for changed code.
- If checks cannot run, report the exact gap and potential impact.
