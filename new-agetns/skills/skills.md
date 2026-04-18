# Skill: Java Spring Boot Static Analyzer

## Description
Performs deep static analysis on Java Spring Boot applications. Trigger this skill for Spring Boot or Java code-review requests involving null safety, exception handling, performance, dependency risks, code quality, or general static analysis.
Supports:
- Full codebase scan
- Incremental scan using git diff

Analyzes:
- Exceptions & null safety
- Performance bottlenecks
- Dependency risks
- Code quality & standards

## Trigger Conditions

Use this skill when the user asks to:
- review or analyze a Java or Spring Boot codebase
- find null-safety or exception-handling issues
- inspect performance, dependency, or code-quality problems
- scan a full repository or git diff for static-analysis findings
- produce a Spring Boot review report

Typical trigger phrases:
- "analyze this Spring Boot project"
- "review for null safety"
- "find performance issues in these Java files"
- "scan this diff for code quality problems"
- "check dependencies and exceptions"

Activation note:
- For automatic skill selection, keep trigger wording in the skill description metadata as well as here.

---

## Inputs

| Input Name        | Type    | Description |
|------------------|--------|-------------|
| scanMode         | string | "full" or "diff" |
| diffRange        | string | Git diff range (e.g., HEAD~1..HEAD) |
| projectPath      | string | Root directory of the project |
| focusAreas       | list   | Optional: ["exceptions", "performance", "dependencies", "code_quality"] |

---

## Execution Flow

### Step 1: Determine Scan Scope
- IF `scanMode == "diff"`
    - Run: `git diff --name-only {{diffRange}}`
    - Filter only `.java`, `.yml`, `.properties`, `pom.xml`
- ELSE
    - Scan entire repository

---

### Step 2: File Classification
Classify files into:
- Controllers (`@RestController`)
- Services (`@Service`)
- Repositories (`@Repository`)
- Config (`@Configuration`)
- DTO / Entities
- Utility classes

---

### Step 3: Exception & Null Safety Analysis

Check for:
- Missing null checks before dereference
- Improper use of `Optional`
- Empty catch blocks
- Catching generic `Exception`
- Missing global exception handler (`@ControllerAdvice`)

Flag:
- ❌ `NullPointerException` risks
- ❌ Silent exception swallowing
- ❌ No fallback logic

Recommend:
- ✅ Use `Optional.orElseThrow`
- ✅ Centralized exception handling
- ✅ Defensive programming patterns

---

### Step 4: Performance Analysis

Detect:
- N+1 query issues in JPA/Hibernate
- Missing pagination in repository calls
- Blocking calls inside async/reactive flows
- Excessive object creation in loops
- Inefficient stream usage

Check:
- `@Transactional` misuse
- Large collection processing in memory
- Missing caching (`@Cacheable`)

Recommend:
- ✅ Pagination (`Pageable`)
- ✅ Batch processing
- ✅ Lazy vs eager loading fixes
- ✅ Introduce caching where needed

---

### Step 5: Dependency Analysis

Inspect:
- `pom.xml` for:
    - Duplicate dependencies
    - Unused dependencies
    - Vulnerable versions
- Spring Boot version compatibility

Flag:
- ❌ Conflicting transitive dependencies
- ❌ Outdated libraries
- ❌ Security vulnerabilities (if detectable)

Recommend:
- ✅ Use dependency management
- ✅ Upgrade to stable versions
- ✅ Remove unused artifacts

---

### Step 6: Code Quality & Standards

Validate:
- Naming conventions
- Layered architecture violations
- God classes / large methods
- Hardcoded values
- Logging practices

Check:
- Proper use of:
    - `@Slf4j`
    - DTO vs Entity separation
    - Interface-driven design

Flag:
- ❌ Tight coupling
- ❌ Business logic inside controllers
- ❌ Missing unit testability patterns

---

### Step 7: Spring Boot Best Practices

Verify:
- Proper use of annotations
- Configuration externalization
- Profile-based configs (`application-dev.yml`, etc.)
- Security configurations

Check for:
- ❌ Hardcoded credentials
- ❌ Missing validation (`@Valid`)
- ❌ No actuator/health checks

---

### Step 8: Generate Report

Output format: `Markdown`

Structure:

# 🧾 Static Analysis Report

## Summary
- Scan Mode: {{scanMode}}
- Files Analyzed: X
- Issues Found: Y

---

## 🔴 Critical Issues
- [File] Issue description
- Recommendation

---

## 🟠 Warnings
- [File] Issue description
- Recommendation

---

## 🔵 Suggestions
- Improvements and optimizations

---

## 📊 Metrics
- Code Complexity (approx)
- Layer Violations
- Dependency Health

---

## ✅ Recommendations Summary
- Top 5 actionable fixes

---

## Execution Rules

- Prioritize **critical issues first**
- Avoid duplicate findings
- Provide **file-level references**
- Keep recommendations **actionable and concise**

---

## Constraints

- Do NOT modify code
- Read-only analysis only
- Focus on Java + Spring Boot ecosystem

---

## Example Invocation

```json
{
  "scanMode": "diff",
  "diffRange": "HEAD~1..HEAD",
  "focusAreas": ["exceptions", "performance"]
}
