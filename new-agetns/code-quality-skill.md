# Skill: Java Code Quality Analyzer

## Description
Ensures clean code and architectural discipline.

---

## Inputs
- files

---

## Checks

### Structure
- God classes (large files)
- Long methods
- Deep nesting

### Architecture
- Controller → Service → Repository violations
- Business logic inside controllers

### Best Practices
- Hardcoded values
- Poor naming conventions
- Missing logging

---

## Output

### 🔴 Critical
- Architecture violations

### 🟠 Warnings
- Maintainability issues

### 🔵 Suggestions
- Refactoring guidance

---

## Rules
- Avoid low-value nitpicks
- Focus on maintainability