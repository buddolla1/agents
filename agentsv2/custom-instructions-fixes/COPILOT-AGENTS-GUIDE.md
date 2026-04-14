# 📘 copilot-instructions.md

## 🎯 Purpose

Defines:

* Coding standards
* Architecture rules
* API design conventions
* Security and performance guidelines

---

## 🧠 How Copilot Uses It

### When editing existing code:

👉 Follow local file patterns

### When generating new code:

👉 Follow `copilot-instructions.md`

---

## 🧩 Key Sections

* Architecture rules (Controller → Service → Repository)
* Data access (JPA vs JDBC)
* Transaction boundaries
* API design rules
* Security guidelines
* Testing expectations
* Anti-patterns to avoid

---

## 🧠 How It Works

### 🪜 Priority Order (Very Important)

Copilot follows this order:

1. Existing code in the repository
2. Local file/module patterns
3. `copilot-instructions.md`
4. General AI knowledge

👉 This ensures **existing behavior is preserved**

---

## ⚠️ Will Generic Instructions Break the Project?

### ❌ No — They Will NOT Break the Project

Generic instructions:

* Do NOT automatically refactor existing code
* Do NOT change behavior unless explicitly asked
* Only influence **new code generation**

---

## ⚠️ What Can Happen

The real risk is:

👉 **Inconsistency between old and new code**

| Old Code             | New Code              |
| -------------------- | --------------------- |
| Field injection      | Constructor injection |
| Logic in controllers | Clean layering        |

---

## ✅ Solution

* Follow existing patterns when editing old code
* Apply new standards only for new code
* Gradually improve over time

---

## 🏗️ Advantages

### ✅ Safe Modernization

* No breaking changes
* Gradual improvements
* Works with legacy systems

---

### ✅ Consistency Across Microservices

* Shared standards
* Reusable skills
* Uniform coding style

---

### ✅ Developer Productivity

* Faster code generation
* Built-in best practices

---

### ✅ Enterprise Ready

* Scalable across teams
* Supports CI/CD integration

---

### ✅ JDBC + JPA Balanced Approach

* Uses JPA for domain logic
* Uses JDBC for performance-critical queries
* Prevents misuse of persistence layers

---

## 🏁 Final Takeaway

* Defines **standards for new code**
* Preserves **existing behavior**
* Enables **controlled modernization**

---

---

# 🤖 spring-standards-autofix-agent.md

## 🎯 Purpose

* Improve code quality safely
* Fix small issues automatically
* Suggest larger improvements without breaking code

---

## 🧠 What It Does

### ✅ Safe Auto-Fixes

* Convert simple field injection → constructor injection
* Remove unused imports
* Add `final` where safe
* Fix logging statements
* Replace null collections with empty collections
* Parameterize SQL queries

---

### ⚠️ Suggested Fixes

* Move logic from controller → service
* Add DTO layers
* Improve exception handling
* Fix transaction boundaries

---

### 🚫 Advisory Only

* Architecture changes
* Package restructuring
* API redesign

---

## 🔄 Execution Flow

```text
Scan → Classify → Fix (safe only) → Suggest → Report
```

---

## 🛢️ JDBC Support

The agent also:

* Detects SQL misuse
* Ensures use of `JdbcTemplate`
* Prevents string-concatenated SQL
* Keeps JDBC logic in repository layer

---

## 🚀 How to Use

### 📦 Setup

```text
.copilot/
  agents/
    spring-standards-autofix-agent.md

  skills/
    spring/...

.github/
  copilot-instructions.md
```

---

## 💬 Example Prompts

### Fix current file

```text
@spring-standards-autofix-agent
Fix this file using safe standards
```

---

### Fix only changed files

```text
@spring-standards-autofix-agent
Apply safe fixes only to changed files
```

---

### Review legacy module

```text
@spring-standards-autofix-agent
Analyze this module and suggest safe improvements
```

---

### Generate modernization plan

```text
@spring-standards-autofix-agent
Create phased modernization plan
```

---

## ⚙️ Best Practices

### ✅ Do

* Use agent for **incremental fixes**
* Run on **changed files only**
* Combine with PR reviews

---

### ❌ Don’t

* Run full repo auto-fix blindly
* Force modernization on legacy code
* Mix architecture styles without plan
* Ignore suggested improvements

---

## 🧠 Recommended Workflow

```text
1. Developer writes code
2. Copilot uses instructions for generation
3. Agent reviews changes
4. Safe fixes applied
5. Suggestions reviewed manually
6. Code merged
```

---

## 💡 Future Enhancements

* PR Review Agent
* Compliance scoring dashboard
* Multi-agent orchestration
* Auto-sync across microservices

---

**This agent enables safe, incremental, and automated improvement of Spring Boot codebases without breaking existing systems.**
