---
name: logging-exception-normalizer
description: Standardize application logging and exception handling without changing behavior.
---

# 🧩 Skill: Logging & Exception Normalizer

## Purpose

Standardize application logging and exception handling without changing behavior.

## Trigger Points

Use this skill when the change touches any of the following:

- Logging statements in controllers, services, repositories, or utilities
- Exception handling in request flows, service flows, or global handlers
- User-facing error responses or API error payloads
- Stack traces, `printStackTrace()`, `System.out`, or `System.err` usage
- Log messages that need parameterization, context, or cleaner severity
- Server-side diagnostics where exception details must be preserved but not exposed

## Detect

- String concatenation in log statements
- `System.out`, `System.err`, or `printStackTrace()` usage
- Missing context in error logs
- Throwable logging without a message
- Exposed stack traces in user-facing responses

## SAFE FIX

- Convert to Log4j2 parameterized logging with `{}` placeholders
- Use a class-scoped Log4j2 logger, typically `private static final Logger log = LogManager.getLogger(...)`
- Log exceptions as the last argument when the stack trace is needed
- Improve log messages with stable identifiers and business context
- Keep full stack traces in server logs, not in API responses

## LOG4J2 STANDARDS

- Prefer `log.info`, `log.warn`, `log.error`, and `log.debug` over ad hoc output
- Avoid eager string building in disabled log levels
- Use `isDebugEnabled()` or similar guards for expensive message construction
- Keep exception objects attached to the log call instead of interpolating stack traces into strings
- Preserve existing logger names and categories unless a targeted refactor is requested

## DO NOT

- Change exception hierarchy automatically
- Replace Log4j2 with another logging framework
- Rewrite public error contracts or response schemas
- Remove diagnostic details that are already needed for server-side troubleshooting
