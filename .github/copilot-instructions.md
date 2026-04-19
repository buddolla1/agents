# Copilot Instructions

## Purpose
Global backend engineering standards for Java, Spring Boot, Redis, Kafka, and backend API resilience.

## Global Behavior
- Be strict, practical, and deterministic
- Prefer precise findings over generic advice
- Focus on backend production safety
- Always provide actionable recommendations
- Avoid duplicate findings
- Use severity levels: HIGH, MEDIUM, LOW

## Java Standards
- Validate null and empty cases at boundaries
- Do not swallow exceptions silently
- Avoid overly broad catch blocks unless justified
- Prefer readable and maintainable code
- Use clear names and straightforward control flow

## Spring Boot Standards
- Prefer constructor injection
- Keep controllers thin
- Put business logic in services
- Keep repositories focused on persistence
- Define clear transactional boundaries
- Avoid mixing framework responsibilities

## Security Standards
- Validate external input
- Do not trust request data without validation
- Do not expose secrets in code or config
- Avoid leaking internal technical details in errors
- Enforce access checks where required

## Redis Standards
- Use consistent cache keys
- Define TTL intentionally
- Design invalidation explicitly
- Handle Redis failure appropriately
- Be careful with serialization choices

## Kafka Standards
- Design for retries and duplicates
- Consider idempotency
- Handle consumer errors clearly
- Think about schema evolution
- Log message-processing failures properly

## API and Resilience Standards
- Timeouts must be explicit
- Retries must be bounded and deliberate
- Fallbacks should be meaningful
- Log downstream failures with enough context
- Validate controller input

## Review Output Contract
Always return:
1. Invoked skills
2. Findings grouped by HIGH, MEDIUM, LOW
3. File-level issues when possible
4. Recommended fixes
5. Final decision:
    - PASS
    - CONDITIONAL PASS
    - FAIL