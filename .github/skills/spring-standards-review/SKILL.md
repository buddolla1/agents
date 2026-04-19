# Skill: spring-standards-review

## Purpose
Review Spring Boot backend code for framework correctness, clean layering, maintainability, and configuration quality.

## When To Use
Use this skill when changed files include:
- controllers
- services
- repositories
- configuration classes
- bean definitions
- transactional logic
- Spring Boot bootstrap or wiring code

## Instructions
Review the code for Spring Boot best practices and framework correctness.

Check for:
1. constructor injection preferred over field injection
2. thin controllers with business logic in services
3. repositories focused on persistence only
4. proper use of annotations and stereotypes
5. clear transactional boundaries
6. clean separation of controller, service, repository, and config responsibilities
7. configuration clarity and maintainability
8. misuse of Spring-specific patterns or anti-patterns

## Output
Return:
- Issue
- Severity
- File
- Why it matters
- Recommended fix