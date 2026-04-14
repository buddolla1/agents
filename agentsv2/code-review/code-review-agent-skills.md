---
name: code-review-agent-skills
description: Define the skill set used by code-review-agent for static analysis and design review.
---

# Code Review Agent Skills

## Purpose

Define the skill set used by `code-review-agent` for static analysis and design review.

## Skills

- `syntax-check`: validate syntax errors and compilation issues
- `lint-check`: check coding standards and formatting
- `bug-detection`: find logical bugs and edge cases
- `null-pointer-check`: detect null safety issues
- `security-scan`: detect vulnerabilities such as SQL injection, XSS, insecure deserialization, improper auth, and secrets exposure
- `performance-analysis`: analyze inefficient loops, memory issues, blocking calls, and optimization opportunities
- `complexity-analysis`: evaluate cyclomatic complexity and suggest simplifications

## How The Agent Uses Skills

1. Run the lightweight checks first.
2. Load deeper analysis skills when the review type or code path requires it.
3. Use design skills for architecture and abstraction concerns.
4. Report findings with severity and concrete remediation guidance.

## Trigger Points

- Syntax or compilation failures
- Style or lint violations
- Suspected logic bugs
- Null handling risk
- Security-sensitive code
- Performance hot paths
- Overly complex or poorly structured code
