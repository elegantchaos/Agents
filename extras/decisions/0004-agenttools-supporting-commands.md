# 0004 AgentTools Owns Supporting Commands

Status: Accepted

Date: 2026-11-05

## Decision

Operational tooling that supports Agents belongs in AgentTools as `agt` commands. Shared guidance and configuration in this repository invoke those commands instead of adding standalone maintenance scripts.

The `ensure-agt.sh` bootstrap script is an exception: it obtains AgentTools and therefore cannot depend on `agt` already being installed.
