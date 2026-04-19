# Skill: backend-security-review

## Purpose
Review backend code for practical security risks in Java and Spring Boot services.

## When To Use
Use this skill when changed files include:
- controllers
- filters
- auth-related code
- service methods with sensitive operations
- configuration or property files
- SQL handling code
- request validation logic

## Instructions
Review the code for backend security weaknesses.

Check for:
1. missing authorization checks
2. missing or weak input validation
3. hardcoded secrets
4. insecure configuration exposure
5. SQL injection risk
6. unsafe deserialization
7. excessive internal error detail exposure
8. trust of unvalidated request headers, params, or payload fields
9. weak access-control patterns

## Output
Return:
- Vulnerability
- Severity
- File
- Security Risk
- Recommended fix