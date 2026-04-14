---
name: dependency-injection-modernizer
description: Replace field injection with constructor injection without changing bean behavior.
---

# 🧩 Skill: Dependency Injection Modernizer

## Purpose

Replace field injection with constructor injection without changing bean behavior.

## Detect

- @Autowired on fields
- Non-final dependencies assigned through field injection
- Mixed injection styles in the same class
- Optional dependencies that are safe to express through constructors
- Classes with hidden dependencies that are harder to test

## SAFE FIX

- Convert simple field-injected classes to constructor injection
- Prefer explicit constructors or Lombok `@RequiredArgsConstructor` when already used in the codebase
- Mark required dependencies as `final`
- Keep optional dependencies as optional only when the existing Spring behavior is preserved
- Preserve bean scope, qualifiers, and lifecycle annotations

## DO NOT

- Modify complex inheritance hierarchies
- Convert classes with circular dependencies automatically
- Change bean lifecycle behavior
- Rewrite classes that already use constructor injection correctly
- Introduce Lombok where it is not already part of the project style
