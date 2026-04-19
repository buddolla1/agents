# Skill: api-resilience-review

## Purpose
Review backend API and downstream integration code for timeouts, retries, fallbacks, failure propagation, and resilience.

## When To Use
Use this skill when changed files include:
- controllers
- outbound HTTP clients
- RestTemplate or WebClient code
- downstream integration logic
- retry or fallback configuration
- service orchestration code

## Instructions
Review backend API and downstream integration code for resilience.

Check for:
1. explicit timeout configuration
2. retry behavior and retry boundaries
3. fallback handling
4. circuit breaker usage where relevant
5. weak logging or poor traceability
6. poor downstream exception mapping
7. controller validation gaps
8. service orchestration fragility
9. direct propagation of downstream failures to clients

## Output
Return:
- Resilience Issue
- Severity
- File
- Failure Impact
- Recommended fix