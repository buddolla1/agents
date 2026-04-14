---
name: transaction-boundary-check
description: Ensure transactions are defined at the service boundary without changing rollback behavior.
---

# 🧩 Skill: Transaction Boundary Check

## Purpose

Ensure transactions are defined at the service boundary without changing rollback behavior.

## Detect

- @Transactional in controllers
- Missing transactions on service methods that perform write operations
- Repository or DAO methods managing business transaction scope
- Multiple database writes in a service method without a transaction boundary
- Async or background work that assumes an open transaction
- Transaction annotations with unclear propagation or rollback intent

## SAFE FIX

- Suggest moving `@Transactional` to the service layer
- Suggest adding `@Transactional` to write-oriented service methods when the scope is obvious
- Suggest `readOnly = true` for clearly read-only service methods
- Suggest keeping transactional work in a single service method when possible
- Preserve existing propagation, isolation, and rollback rules unless explicitly requested otherwise

## OUTPUT

- Violations with the service-layer rule that is broken
- Suggested fixes with the smallest safe boundary adjustment

## DO NOT AUTO-FIX

- Change propagation, isolation, or rollback semantics automatically
- Transaction propagation changes
- Complex transactional flows
- Move transactional annotations across layers when the method role is ambiguous
- Split large methods if doing so would alter transactional scope
