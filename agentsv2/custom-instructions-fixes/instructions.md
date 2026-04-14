# 🚀 Copilot Instructions — Spring Boot Project

Use these instructions when generating, reviewing, or refactoring code in this repository.

---

# 🧭 1. Repository Context

* **Language:** Java 21+
* **Framework:** Spring Boot 3.x+
* **Architecture:** Layered / Clean (Controller → Service → Repository)
* **API Style:** REST
* **Persistence:** Spring Data JPA + JDBC (JdbcTemplate)
* **Build Tool:** Maven or Gradle

---

# ▶️ 2. Trigger Points

Use these instructions automatically when:

* Creating a new controller, service, repository, DTO, entity, or exception
* Refactoring code in an existing Spring module
* Reviewing changed files in a PR or commit
* Touching transaction boundaries, SQL, or persistence code
* Changing API contracts, validation, or error handling
* Adding tests for Spring services, controllers, or repositories

When a change hits one of these areas:

* Preserve local patterns in existing files
* Apply the standards below only where they are safe and relevant
* Avoid broad refactors unless the user explicitly asks for them

---

# ⚠️ 3. Important Guidance for Copilot

## How to apply rules

* When modifying **existing code** → follow current patterns in that file/module
* When creating **new code** → follow standards defined in this document
* Do NOT refactor large legacy sections unless explicitly asked
* Prefer consistency over correctness in legacy modules

---

# 🧱 4. Architecture Rules

## Required Flow

```
Controller → Service → Repository
```

## Rules

* Controllers handle HTTP only
* Services contain business logic and transactions
* Repositories handle persistence only
* Do not bypass layers
* Do not place business logic in controllers

---

# 📁 5. File Placement Rules

| Type            | Location     |
| --------------- | ------------ |
| Controller      | `controller` |
| Service         | `service`    |
| JPA Repository  | `repository` |
| JDBC Repository | `jdbc`       |
| DTO             | `dto`        |
| Entity          | `entity`     |
| Mapper          | `mapper`     |
| Exception       | `exception`  |

---

# 🛢️ 6. Data Access Rules (JPA + JDBC)

## When to use JPA

* CRUD operations
* Aggregate-based domain models
* Standard business workflows

## When to use JDBC

* Complex SQL queries
* Performance-critical reads
* Reporting queries
* Batch updates/inserts

## JDBC Rules

* Use `JdbcTemplate` or `NamedParameterJdbcTemplate`
* Never concatenate SQL strings with user input
* Use RowMapper classes for mapping
* Keep SQL inside repository layer only

---

# 🔄 7. Transaction Rules

* Transactions must be defined in **service layer only**
* Do NOT use `@Transactional` in controllers
* Keep transactions short
* Avoid remote calls inside transactions

---

# 🌐 8. API Design Rules

* Use REST conventions
* Use versioned APIs (`/api/v1/...`)
* Never expose entities directly
* Always use DTOs
* Validate inputs using `@Valid`

---

# ⚠️ 9. Exception Handling

* Use `@RestControllerAdvice`
* Never expose stack traces
* Use structured error responses
* Use domain-specific exceptions

---

# 🎯 10. Coding Standards

## Required

* Use constructor injection (avoid field injection)
* Keep methods small and readable
* Use meaningful names
* Avoid static mutable state

## Optional / Context-Based

* Use Lombok carefully
* Use `Optional` only for return types (not fields)

---

# 🔐 11. Security Rules

* Use Spring Security
* Use JWT/OAuth2 if applicable
* Validate all inputs
* Do NOT hardcode secrets
* Use HTTPS

---

# ⚡ 12. Performance Rules

* Avoid N+1 queries
* Use pagination
* Use caching only when necessary
* Use connection pooling

---

# 🧪 13. Testing Rules

* Unit test business logic
* Mock external dependencies
* Use integration tests for DB and APIs
* Keep tests deterministic

---

# 🧠 14. Current vs Target State (Important)

## Current Patterns (may exist)

* Field injection in legacy code
* Mixed layering in older modules
* Inconsistent exception handling

## Target Standards

* Constructor injection
* Clean layering
* Centralized exception handling

## Migration Guidance

* Do NOT refactor legacy code unless asked
* Apply new standards only to new code
* Gradually improve high-impact modules

---

# ❌ 15. Anti-Patterns to Avoid

* Business logic in controllers
* Returning entities in APIs
* Field injection
* String-based SQL concatenation
* Tight coupling between layers
* Large classes and methods

---

# ✅ 16. Definition of Done

* Code follows these instructions
* Tests added where applicable
* API contract maintained
* No security issues introduced
* Code compiles and passes CI

---
# 🧩 Final Instruction to Copilot

Priority Rules:

1. When modifying existing code:
   - Preserve the existing local style, naming, and structure
   - Do not introduce broad formatting or architectural changes unless asked
   - Preserve behavior, public contracts, and transaction boundaries

2. When generating new code:
   - Follow this document as the default standard
   - Use the current repository architecture and package conventions
   - Prefer explicit, maintainable implementations over clever abstractions

3. When the guidance conflicts:

   - New-code standards apply only when they do not conflict with preserved behavior

4. Never:
   - Refactor large sections without instruction
   - Introduce breaking architectural changes
   - Change API contracts, transaction semantics, or persistence strategy unless explicitly requested
