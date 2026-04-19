# Skill: redis-integration-review

## Purpose
Review Redis usage for cache correctness, consistency, serialization safety, TTL design, and resilience.

## When To Use
Use this skill when changed files include:
- RedisTemplate usage
- cache annotations
- Redis config
- serialization classes
- cache eviction logic
- TTL logic
- cache key construction

## Instructions
Review Redis usage for correctness and operational safety.

Check for:
1. cache key naming and uniqueness
2. TTL strategy and expiry correctness
3. stale cache risk
4. invalidation correctness
5. null cache handling
6. serialization and deserialization safety
7. behavior when Redis is unavailable
8. misuse of cache annotations
9. over-caching or incorrect cache scope

## Output
Return:
- Redis Issue
- Severity
- File
- Why it matters
- Recommended fix