# Skill: java-runtime-exception-review

## Purpose
Detect Java runtime risks such as NullPointerException, unsafe assumptions, fragile exception handling, and brittle logic.

## When To Use
Use this skill when changed files include:
- service logic
- utility classes
- repositories
- mappers
- stream or collection-heavy code
- parsing or conversion code
- integration logic

## Instructions
Review the code for runtime stability and defensive coding.

Check for:
1. null dereferences
2. chained method calls without null guards
3. Optional misuse
4. unsafe map, list, or collection access
5. swallowed exceptions
6. broad or weak catch blocks
7. unsafe parsing or casting
8. missing validation for external or downstream data
9. fragile stream or lambda logic

## Output
Return:
- Risk Type
- Severity
- File
- Runtime Failure Explanation
- Recommended fix