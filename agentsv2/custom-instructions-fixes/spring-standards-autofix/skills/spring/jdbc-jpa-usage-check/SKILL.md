---
name: jdbc-jpa-usage-check
description: Ensure JDBC and JPA are used in the right layer without changing persistence behavior.
---

# 🧩 Skill: JDBC vs JPA Usage Check

## Purpose

Ensure JDBC and JPA are used in the right layer without changing persistence behavior.

## Detect

- SQL in controllers or service classes
- String-concatenated SQL or dynamic query fragments
- Manual `ResultSet` handling where a repository abstraction fits
- JPA entities being used as transport objects
- JDBC and JPA mixed in a way that bypasses transaction boundaries

## SAFE FIX

- Parameterize SQL with bind variables
- Prefer `JdbcTemplate` or `NamedParameterJdbcTemplate` for straightforward SQL access
- Prefer Spring Data JPA repositories for entity-centric CRUD and simple queries
- Keep database access inside repository or DAO layers
- Preserve existing transaction annotations and propagation rules

## DO NOT

- Replace JPA with JDBC automatically
- Replace JDBC with JPA automatically
- Rewrite queries blindly
- Move SQL into controllers
- Change entity mappings, fetch strategy, or transaction boundaries automatically
