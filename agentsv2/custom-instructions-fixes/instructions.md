# 🧩 Spring Boot Project — Engineering Standards & Best Practices

## 1. Project Overview

This project is built using:

* **Language:** Java 21+
* **Framework:** Spring Boot 3.x+
* **Build Tool:** Maven or Gradle
* **Architecture:** Layered / Clean / Hexagonal depending on service needs
* **API Style:** RESTful APIs
* **Packaging:** Docker containers
* **Documentation:** OpenAPI + Markdown + Mermaid diagrams

---

## 2. Standard Project Structure

```text
src/main/java/com/company/project
 ├── config
 ├── controller
 ├── service
 ├── repository
 ├── jdbc
 ├── dto
 ├── entity
 ├── mapper
 ├── exception
 ├── security
 ├── client
 ├── util
 └── ProjectApplication.java

src/main/resources
 ├── application.yml
 ├── application-dev.yml
 ├── application-test.yml
 ├── application-prod.yml
 ├── db/migration
 └── static

src/test/java
```

### Structure Rules

* Controllers handle HTTP transport only.
* Services contain business logic and transaction boundaries.
* Repositories handle persistence concerns only.
* `jdbc` package contains JDBC/JdbcTemplate-based repositories and row mappers.
* DTOs must not be used as JPA entities.
* Entities must not be returned directly from controllers.

---

## 3. Architecture Guidelines

### Follow

* Separation of concerns
* Constructor-based dependency injection
* Interface-driven design where it improves testability and clarity
* SOLID principles
* Clear request flow: `Controller → Service → Repository`
* Domain logic isolated from transport and persistence logic

### Avoid

* Business logic in controllers
* Database access directly from controllers or services without repository abstraction
* Circular dependencies
* Field injection
* Returning entities directly in API responses
* Leaking persistence concerns into API contracts

---

## 4. Coding Standards

### Naming Conventions

| Component | Convention       | Example               |
| --------- | ---------------- | --------------------- |
| Class     | PascalCase       | `OrderService`        |
| Method    | camelCase        | `calculateTotal()`    |
| Variables | camelCase        | `orderAmount`         |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT`     |
| Packages  | lowercase        | `com.company.project` |

### Required Practices

* Prefer constructor injection over field injection.
* Keep methods small and intention-revealing.
* Keep classes focused on a single responsibility.
* Use enums instead of magic strings.
* Avoid static mutable state.
* Prefer immutable DTOs and value objects where practical.
* Use Lombok selectively; do not hide important behavior with excessive annotations.
* Prefer explicit code over clever code.

### Null and Optional Usage

* Do not return `null` from service or repository APIs unless clearly documented.
* Use `Optional<T>` for return types where absence is valid.
* Do not use `Optional` for entity fields, DTO fields, or method parameters.
* Prefer empty collections over `null` collections.

---

## 5. REST API Design Standards

### HTTP Methods

* `GET` — Fetch data
* `POST` — Create
* `PUT` — Full update
* `PATCH` — Partial update
* `DELETE` — Remove

### URI Naming

```text
/api/v1/orders
/api/v1/orders/{id}
/api/v1/users/{userId}/orders
```

### API Rules

* Use nouns, not verbs, in resource paths.
* Keep API versioning explicit where required by the organization.
* Use consistent error response structure.
* Do not expose internal entity structure directly.
* Paginate list endpoints.
* Support filtering and sorting for large collections where applicable.

### Standard Success Response

```json
{
  "timestamp": "2026-03-20T10:15:30Z",
  "status": 200,
  "message": "Success",
  "data": {}
}
```

### Validation

Use Jakarta Bean Validation annotations such as:

* `@Valid`
* `@NotNull`
* `@NotBlank`
* `@Size`
* `@Email`
* `@Pattern`

Validate at the API boundary.

---

## 6. Exception Handling

* Use `@RestControllerAdvice` for centralized exception handling.
* Define domain-specific exceptions.
* Never expose stack traces or internal class names to API consumers.
* Map exceptions to stable, documented error codes.
* Log exceptions with enough context for troubleshooting.
* Wrap low-level persistence or integration exceptions in meaningful business exceptions where appropriate.

### Error Response Standard

```json
{
  "timestamp": "2026-03-20T10:15:30Z",
  "status": 400,
  "error": "VALIDATION_ERROR",
  "message": "Request validation failed",
  "path": "/api/v1/orders"
}
```

---

## 7. Database Standards

### Persistence Strategy

Use the right persistence style for the use case:

* **Spring Data JPA / Hibernate** for aggregate-oriented CRUD and relational mapping
* **Spring JDBC / JdbcTemplate** for performance-sensitive queries, reporting queries, bulk operations, and SQL-heavy use cases

### General Database Rules

* Use database migrations with Flyway or Liquibase.
* Keep schema changes versioned and reversible when feasible.
* Index frequently queried columns.
* Use transactions only where needed.
* Keep write logic consistent and auditable.
* Avoid N+1 query issues.
* Use pagination for large result sets.

---

## 8. JPA / Hibernate Best Practices

* Use Spring Data JPA for standard CRUD and aggregate persistence.
* Use UUIDs or organization-approved identifier strategy.
* Default relationships to `FetchType.LAZY` unless eager loading is justified.
* Avoid bidirectional relationships unless clearly needed.
* Use projections or dedicated read models for read-heavy queries.
* Keep entity lifecycle logic minimal.
* Do not put business workflows inside entities.
* Avoid exposing JPA entities outside the service boundary.
* Be explicit about transaction boundaries in service layer methods.

### JPA Rules

* Repositories should remain persistence-focused.
* Do not place business logic in repository implementations.
* Use `@EntityGraph`, fetch joins, or tailored queries to control loading.
* Keep entity mappings simple and maintainable.

---

## 9. JDBC / JdbcTemplate Standards

Use JDBC or `JdbcTemplate` when:

* SQL needs tight control
* Query performance is critical
* You are building reporting/read-only endpoints
* Bulk updates or batch writes are required
* The mapping is simpler in SQL than in ORM

### JDBC Best Practices

* Prefer `JdbcTemplate` or `NamedParameterJdbcTemplate` over raw JDBC boilerplate.
* Keep SQL in repository or `jdbc` package classes, not in services or controllers.
* Use named parameters for readability and safety.
* Use row mappers or result set extractors for clear mapping.
* Keep SQL explicit and formatted.
* Parameterize all queries; never concatenate user input into SQL.
* Batch inserts/updates where appropriate.
* Handle empty results explicitly.
* Document complex SQL.

### JDBC Package Example

```text
jdbc/
 ├── OrderJdbcRepository.java
 ├── mapper/
 │    └── OrderRowMapper.java
 └── sql/
      └── order-queries.sql
```

### JDBC Rules

* Services may call JDBC repositories the same way they call JPA repositories.
* Do not mix transaction handling inside JDBC repository classes; transaction boundaries belong in services.
* Prefer `NamedParameterJdbcTemplate` for non-trivial SQL.
* Use JDBC for read-optimized flows and JPA for aggregate lifecycle, unless the service explicitly standardizes on JDBC.

---

## 10. Transaction Management

* Define transaction boundaries at the service layer.
* Use `@Transactional` on service methods, not controllers.
* Keep transactions short-lived.
* Use `readOnly = true` for read-only transactions where helpful.
* Avoid remote calls inside active database transactions.
* Be explicit about rollback behavior for checked exceptions if needed.

---

## 11. Security Best Practices

* Use Spring Security.
* Use OAuth2 / JWT where applicable.
* Apply role-based or authority-based authorization.
* Hash passwords with BCrypt or stronger approved algorithm.
* Validate all inputs.
* Enforce HTTPS.
* Store secrets in environment variables or secret managers.
* Implement rate limiting for sensitive/public endpoints.

### Important Note

* Enable CSRF protection for session/cookie-based applications.
* For stateless token-based APIs, configure CSRF according to the security model rather than enabling it blindly.

---

## 12. Performance Optimization

* Use connection pooling.
* Monitor slow queries.
* Avoid N+1 issues.
* Use pagination.
* Use caching only for clearly beneficial paths.
* Use async processing for long-running tasks where appropriate.
* Compress large HTTP responses where useful.
* Profile before optimizing.

---

## 13. Testing Standards

### Test Types

* Unit Tests — JUnit 5
* Mocking — Mockito
* Integration Tests — Spring Boot Test
* API Tests — MockMvc or TestRestTemplate
* Persistence Tests — Testcontainers for database-backed tests

### Testing Rules

* Test business logic thoroughly.
* Mock external systems in unit tests.
* Use integration tests for repository, security, and controller wiring.
* Keep tests deterministic and independent.
* Follow Arrange–Act–Assert.
* Name tests by behavior.

### Coverage

* Aim for meaningful coverage on business-critical paths.
* Do not use a raw percentage target as the only quality gate.

---

## 14. Logging & Monitoring

### Logging

* Use SLF4J with Logback.
* Use parameterized logging.
* Use structured logging where supported.
* Include correlation IDs and request tracing IDs.
* Never log secrets, tokens, passwords, or sensitive personal data.

### Monitoring

* Use Spring Boot Actuator.
* Expose health, metrics, and readiness endpoints appropriately.
* Integrate with Prometheus/Grafana or equivalent tooling.

---

## 15. Build & Dependency Management

* Keep dependency versions explicit or centrally managed.
* Remove unused dependencies.
* Scan dependencies for vulnerabilities.
* Use multi-module builds only when justified by project complexity.
* Align plugin versions with Java and Spring Boot versions.

---

## 16. Containerization

* Use multi-stage Docker builds.
* Use lightweight base images.
* Do not run containers as root.
* Externalize configuration.
* Keep images small and reproducible.

---

## 17. CI/CD Best Practices

* Run tests before packaging.
* Enforce code quality gates.
* Scan for vulnerabilities.
* Automate versioning where appropriate.
* Support zero-downtime rollout patterns when required.

---

## 18. Documentation Standards

* Maintain OpenAPI documentation.
* Keep README setup steps accurate.
* Include architecture diagrams where useful.
* Document integration points, environment variables, and local run instructions.
* Keep docs aligned with code changes.

---

## 19. Java Standards

### Language Level

* Use Java 21+ features where they improve clarity and maintainability.
* Prefer records for immutable DTOs where appropriate.
* Use sealed classes only where they clearly model constrained hierarchies.
* Prefer modern switch expressions where readable.

### Object-Oriented Principles

* Favor composition over inheritance.
* Program to interfaces where it improves design.
* Keep fields private.
* Make invalid states hard to represent.

### Collections and Streams

* Use streams for readable transformations.
* Avoid parallel streams unless performance-tested.
* Choose collection types intentionally.
* Prefer immutable collections for read-only data.

### Exception Handling

* Use runtime exceptions for programming and domain rule violations.
* Use checked exceptions only when the caller is expected to recover explicitly.
* Never swallow exceptions.
* Always log exceptions with context.

### Readability

* Keep methods short.
* Avoid deep nesting.
* Limit method parameters; use parameter objects where appropriate.
* Prefer self-documenting code and meaningful names.

---

## 20. Anti-Patterns

* God classes
* Tight coupling
* Hardcoded configuration
* Ignoring exceptions
* Returning entities directly from controllers
* Field injection
* Database logic in controllers
* Remote calls inside transactions
* String-concatenated SQL
* Blind use of JPA for every data access pattern

---

## 21. Definition of Done

* Code follows project standards
* Unit and integration tests added as appropriate
* API changes documented
* Logs and metrics considered
* No critical vulnerabilities introduced
* Code reviewed
* CI pipeline passed
* Database migrations included where needed
* Docker image builds successfully
* Deployment configuration updated if required

```
```
