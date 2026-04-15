---
name: static-code-analysis
description: Analyze source code for structural issues, smells, convention drift, and maintainability risks.
---

# Skill: Static Code Analysis

## Purpose

Analyze source code for structural issues, smells, convention drift, and maintainability risks.

## Use When

- Reviewing a repository or file for code quality issues
- Looking for obvious bugs, dead paths, or unused code
- Checking local conventions and layering rules
- Producing a risk-oriented analysis report

## Detect

- Syntax or structural problems
- Dead code, unreachable branches, and unused members
- Mixed responsibilities in a single class or module
- Layering or architectural violations
- Naming or style drift from local conventions

## Output

- File-level findings
- Severity labels such as `low`, `medium`, `high`
- Short rationale for why each finding matters
- Clear distinction between confirmed issues and inferred risks

## Do Not

- Do not rewrite code automatically
- Do not invent conventions not visible in the repository
- Do not report generic style advice without evidence
