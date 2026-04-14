---
name: legacy-compatibility
description: Ensure safe modernization in legacy systems without forcing broad rewrites.
---

# 🧩 Skill: Legacy Compatibility

## Purpose

Ensure safe modernization in legacy systems without forcing broad rewrites.

## Detect

- Field injection in older classes
- Mixed layers or cross-cutting responsibilities in legacy code
- Old-style logging, error handling, or SQL usage that already exists in production code
- Framework or language patterns that are inconsistent with newer standards
- Code paths that would require wide refactoring to modernize safely

## SAFE FIX

- Preserve existing patterns in touched legacy code unless a small safe cleanup is requested
- Apply newer standards only to new code or narrowly scoped edits
- Suggest incremental migration steps instead of full rewrites
- Prefer compatibility-preserving refactors over architectural changes
- Keep behavior, contracts, and deployment assumptions intact

## BEHAVIOR

- Treat legacy patterns as migration candidates, not automatic defects
- Avoid cross-cutting modernization when the change would ripple through multiple modules
- Prefer targeted suggestions over code motion in old codebases

## OUTPUT

- Migration suggestions

## DO NOT

- Rewrite legacy modules automatically
- Force new standards into every existing class
- Change public APIs, transaction behavior, or persistence strategy automatically
- Replace stable legacy patterns when the code is already functioning and the change is not isolated
