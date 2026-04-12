# Agent: Java Spring Boot Analysis Orchestrator

## Description
Coordinates multiple static analysis skills in parallel or sequentially.
Supports:
- Full scan
- Git diff scan (PR mode)
- Focus-based selective execution

---

## Inputs

| Input Name   | Type   | Description |
|-------------|--------|-------------|
| scanMode    | string | "full" or "diff" |
| diffRange   | string | Git diff range |
| focusAreas  | list   | Optional filters |
| projectPath | string | Root project path |

---

## Execution Strategy

### Step 1: Determine Scope

IF scanMode == "diff":
- Identify changed files using git diff
- Pass filtered file list to all skills

ELSE:
- Use entire project

---

## Step 2: Skill Selection Logic

IF focusAreas provided:
- Only trigger relevant skills

ELSE:
- Trigger ALL skills:
  - Exception Analyzer
  - Performance Analyzer
  - Dependency Analyzer
  - Code Quality Analyzer
  - Spring Boot Best Practices Analyzer

---

## Step 3: Parallel Execution

Run the following skills in parallel:

### Skill 1: Exception Analyzer
Use skill: "Java Exception & Null Safety Analyzer"

### Skill 2: Performance Analyzer
Use skill: "Java Performance Analyzer"

### Skill 3: Dependency Analyzer
Use skill: "Maven Dependency Analyzer"

### Skill 4: Code Quality Analyzer
Use skill: "Java Code Quality Analyzer"

### Skill 5: Spring Boot Best Practices
Use skill: "Spring Boot Best Practices Analyzer"

---

## Step 4: Result Aggregation

Collect outputs from all skills and normalize into:

- Critical Issues
- Warnings
- Suggestions

Deduplicate:
- Same issue across multiple skills
- Same file-level findings

---

## Step 5: Severity Prioritization

Priority order:
1. Security / Dependency risks
2. Runtime exceptions
3. Performance bottlenecks
4. Architecture violations
5. Code quality issues

---

## Step 6: Final Report Generation

Output: Markdown

# 🧾 Unified Static Analysis Report

## Summary
- Scan Mode: {{scanMode}}
- Skills Executed: X
- Total Issues: Y

---

## 🔴 Critical Issues
(Merged from all skills)

---

## 🟠 Warnings

---

## 🔵 Suggestions

---

## 📂 File-wise Breakdown
- File1.java → Issues
- File2.java → Issues

---

## 📊 Metrics
- Total files scanned
- Hotspot files
- Dependency health score

---

## 🚀 Top Recommendations
- Top 5 high-impact fixes

---

## Execution Rules

- Skills MUST run independently
- Aggregation MUST NOT lose critical issues
- Avoid duplicate reporting
- Keep output concise but actionable

---

## Optimization Rules

- If diff scan → prioritize speed
- Skip unchanged modules
- Cache previous results if available

---

## Example Invocation

```json
{
  "scanMode": "diff",
  "diffRange": "HEAD~1..HEAD",
  "focusAreas": ["performance", "exceptions"]
}