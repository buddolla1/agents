---
name: api-contract-safety
description: Prevent breaking API changes in public HTTP contracts.
---

# 🧩 Skill: API Contract Safety

## Purpose

Prevent breaking API changes in public HTTP contracts.

## Detect

- Entity exposure in controllers or responses
- Request or response shape changes
- Field renames, removals, or type changes in API payloads
- Status code changes for the same endpoint behavior
- Serialization annotation changes that affect payloads
- Error envelope or exception response changes
- Path, method, or version changes on public endpoints

## SAFE FIX

- Suggest DTOs for controller inputs and outputs
- Suggest mapper methods instead of returning entities directly
- Suggest backward-compatible additions over removals
- Preserve existing status codes, field names, and response envelopes
- Keep validation and error semantics aligned with existing behavior

## RULES

- Never modify API contracts automatically
- Flag risky changes only
- Treat public endpoint behavior as stable unless a breaking change is explicitly requested

## DO NOT

- Rename or remove public fields automatically
- Change request or response schemas automatically
- Replace entity exposure with DTOs automatically when it would alter behavior broadly
- Change HTTP status codes, endpoint paths, or method signatures automatically
- Rewrite error payloads or exception mappings automatically
