---
name: exception-analysis
description: Analyze exception handling for swallowed errors, bad rethrows, weak context, and unsafe logging.
---

# Skill: Exception Analysis

## Purpose

Analyze exception handling for swallowed errors, bad rethrows, weak context, and unsafe logging.

## Use When

- Reviewing error handling paths in services, controllers, or utilities
- Looking for swallowed or overbroad exceptions
- Checking whether errors are rethrown correctly
- Assessing logging and user-facing error behavior

## Detect

- Swallowed exceptions
- Overbroad `catch` blocks
- Missing context in exception messages
- Incorrect rethrow patterns that hide root causes
- Unsafe exposure of stack traces or internal details
- Missing API or user-facing error handling

## Output

- Exception handling findings by file and symbol
- Severity labels such as `low`, `medium`, `high`
- Short explanation of impact
- Recommendations only where supported by repository evidence

## Do Not

- Do not change exception hierarchy automatically
- Do not rewrite global error contracts without request
- Do not suggest logging or error changes without repository evidence
