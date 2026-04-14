---
name: layering-check
description: Ensure Controller -> Service -> Repository separation without changing application behavior.
---

# 🧩 Skill: Layering Check

## Purpose

Ensure Controller -> Service -> Repository separation without changing application behavior.

## Detect

- Business logic in controllers
- Direct database access from controllers or services
- Repository calls from controllers that bypass service rules
- Service classes acting as transport or presentation layers
- Circular or ambiguous layer dependencies
- Mixed concerns such as validation, orchestration, and persistence in one class

## SAFE FIX

- Suggest moving business logic into services
- Suggest moving persistence logic into repositories or DAOs
- Suggest thin controllers that only handle request/response mapping
- Suggest extracting helper methods when a class has mixed responsibilities
- Preserve existing public APIs, transaction boundaries, and validation behavior

## OUTPUT

- Violations with the specific layer rule that is broken
- Suggested fixes with the smallest safe refactor

## DO NOT

- Move code across layers automatically
- Rewrite controller or service APIs automatically
- Change transaction behavior automatically
- Split classes when the change would require broad mechanical refactoring
