---
name: dependency-analysis
description: Analyze package and module dependencies for coupling hotspots, cycles, and suspicious relationships.
---

# Skill: Dependency Analysis

## Purpose

Analyze package and module dependencies for coupling hotspots, cycles, and suspicious relationships.

## Use When

- Mapping direct dependencies between modules or packages
- Looking for circular or overly dense relationships
- Checking layer boundaries and coupling hot spots
- Reviewing build or module relationships for suspicious changes

## Detect

- Cyclic dependencies
- Tight coupling across layers
- Overused shared or utility modules
- Suspicious direct dependencies between unrelated modules
- Unused, duplicated, or overly broad dependencies

## Output

- Dependency findings with file or module references
- Severity labels such as `low`, `medium`, `high`
- Short explanation of the coupling risk
- Suggested next steps without broad refactoring

## Do Not

- Do not infer dependencies not visible in the repository
- Do not recommend architecture migrations without evidence
- Do not rewrite module boundaries automatically
