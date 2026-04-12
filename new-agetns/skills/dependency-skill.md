# Skill: Maven Dependency Analyzer

## Description
Analyzes pom.xml for dependency health and risks.

---

## Inputs
- pom.xml

---

## Checks

### Dependency Issues
- Duplicate dependencies
- Unused dependencies
- Version conflicts

### Security
- Outdated libraries
- Known vulnerable versions (if detectable)

### Compatibility
- Spring Boot version mismatch
- Plugin incompatibility

---

## Output

### 🔴 Critical
- Vulnerable dependencies

### 🟠 Warnings
- Conflicts / duplicates

### 🔵 Suggestions
- Upgrade / cleanup recommendations

---

## Rules
- Highlight exact dependency name + version