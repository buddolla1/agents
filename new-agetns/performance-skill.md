# Skill: Java Performance Analyzer

## Description
Identifies performance bottlenecks in Spring Boot apps.

---

## Inputs
- files
- scanMode

---

## Checks

### Database
- N+1 queries (Hibernate/JPA)
- Missing pagination (Pageable)
- Eager fetching misuse

### Memory / CPU
- Large loops with object creation
- Inefficient streams
- Repeated computations

### Spring
- Blocking calls in async/reactive flows
- Missing caching (@Cacheable)
- Misuse of @Transactional

---

## Output

### 🔴 Critical
- N+1 queries
- Memory-heavy operations

### 🟠 Warnings
- Inefficient patterns

### 🔵 Suggestions
- Pagination, caching, batching

---

## Rules
- Focus on high-impact bottlenecks only