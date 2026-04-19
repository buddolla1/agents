# Skill: kafka-integration-review

## Purpose
Review Kafka producers, consumers, and event flows for reliability, retry behavior, offset handling, idempotency, and message safety.

## When To Use
Use this skill when changed files include:
- Kafka producers
- Kafka consumers
- listener classes
- event DTOs
- topic configuration
- retry or dead-letter handling
- serializer or deserializer logic

## Instructions
Review Kafka code for production reliability and message safety.

Check for:
1. producer send reliability
2. consumer exception handling
3. offset commit correctness
4. retry strategy
5. dead-letter handling
6. duplicate event processing risk
7. idempotency concerns
8. schema compatibility
9. serializer or deserializer safety
10. observability for failed message processing

## Output
Return:
- Kafka Issue
- Severity
- File
- Reliability Risk
- Recommended fix